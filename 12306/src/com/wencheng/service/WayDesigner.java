package com.wencheng.service;

import com.wencheng.dao.KeyStationDao;
import com.wencheng.dao.StationDao;
import com.wencheng.domain.KeyTrain;
import com.wencheng.domain.Plan;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;


/**
 * Created by wencheng on 15/11/2.
 */
@Component
@Scope(value = "prototype")
public class WayDesigner {

    private JSONArray ja;
    private List<KeyTrain> fromKey;
    private List<KeyTrain> toKey;

    private Map<String,Plan> map = new HashMap<String,Plan>();

    @Autowired
    private KeyStationDao dao;
    @Autowired
    private StationDao d;
    private String from;
    private String to;
    private int i = 0;

    private JSONObject jof;
    private JSONObject jot;

    public WayDesigner(){
        ja = new JSONArray();
    }
    /**
     * 获取通向关键站的列车和从关键站出发的列车
     * @throws InterruptedException
     */
    public  WayDesigner getKetTrainList(String fromn,String ton,HttpSession session) throws InterruptedException {
        this.from = fromn;
        this.to = ton;
        JSONObject from = JSONObject.fromObject(session.getAttribute(d.getCode(fromn)));
        JSONObject to = JSONObject.fromObject(session.getAttribute(d.getCode(ton)));

        this. jof = from;
        this.jot = to;

        Object lock = new Object();
        Object lock2 = new Object();

        KeyTrainGetter k = new KeyTrainGetter(lock);
        KeyTrainGetter k2 = new KeyTrainGetter(lock2);
        k.setDao(dao);
        k2.setDao(dao);
        k.getKeyTrain(from, true,fromn);
        k2.getKeyTrain(to, false,ton);


        while(!k.isComplete()){
            synchronized (lock){
                lock.wait();
            }
        }
        System.out.println("lock over");
        while(!k2.isComplete()){
            synchronized (lock2){
                lock2.wait();
            }
        }
        System.out.println("lock2 over");
        fromKey = k2.getKey();
        toKey = k.getKey();
        return this;
    }

    public WayDesigner analyze(){
        System.out.println("ok");
        final Iterator<KeyTrain> to = toKey.iterator();
        final ExecutorService pool = Executors.newFixedThreadPool(5);
        final WayDesigner o = this;

        while(to.hasNext()){
            final KeyTrain tn = to.next();
            final Iterator<KeyTrain> from = fromKey.iterator();
            while(from.hasNext()){
               final  KeyTrain fn = from.next();
                try{
                    Runnable r = new Runnable() {
                        @Override
                        public void run() {
                            try {
                                synchronized (o) {
                                    i++;
                                }
                                ProcessWay(tn, fn);
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                synchronized (o) {
                                    i--;
                                }
                            }

                        }
                    };
                    pool.execute(r);

                }catch(Exception e){
                    e.printStackTrace();
                }
            }
        }
        pool.shutdown();
        try {
            pool.awaitTermination(50, TimeUnit.SECONDS);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return this;
    }

    /**
     *
     * @param tn
     * @param fn
     */
    private void ProcessWay(KeyTrain tn, KeyTrain fn) throws Exception {
        if(!(tn.getKeyStation().contains(fn.getKeyStation())||fn.getKeyStation().contains(tn.getKeyStation()))){
            return;
        }

        KeyTrain nfn = new KeyTrain();
        nfn.setMyArriveDate(fn.getMyArriveDate());
        nfn.setStartDate(fn.getStartDate());
        nfn.setTraincode(fn.getTraincode());
        nfn.setTrainnum(fn.getTrainnum());
        nfn.setArriveDate(fn.getArriveDate());
        nfn.setArriveTime(fn.getArriveTime());
        nfn.setKeyStation(fn.getKeyStation());
        nfn.setMyArriveTime(fn.getMyArriveTime());
        nfn.setMyStartTime(fn.getMyStartTime());
        nfn.setStartTime(fn.getStartTime());
        nfn.setFromn(fn.getFromn());
        nfn.setTon(fn.getTon());
        nfn.setTd(fn.getTd());
        nfn.setCost(fn.getCost());
        nfn.setBuild(fn.isBuild());
        nfn.setUsedTimeF(fn.getUsedTimeF());
        nfn.setUsedTimeT(fn.getUsedTimeT());

        Calendar cb = Calendar.getInstance();
        cb.set(2000, 1, 1, 0, 0, 0);
        Calendar ca = Calendar.getInstance();
        ca.setTime(tn.getArriveDate());
        Long daya = (ca.getTimeInMillis()-cb.getTimeInMillis())/(24*3600*1000);

        Calendar cs = Calendar.getInstance();
        cs.setTime(fn.getStartDate());
        Long days = (cs.getTimeInMillis()-cb.getTimeInMillis())/(24*3600*1000);


        if(daya>days){
            Calendar c = Calendar.getInstance();
            Calendar c1 = Calendar.getInstance();
            c.setTime(nfn.getStartDate());
            c.add(Calendar.DATE, (int) (daya - days));
            nfn.setStartDate(c.getTime());
            c1.clear();
            c1.setTime(fn.getMyArriveDate());
            c1.add(Calendar.DATE, (int) (daya - days));
            nfn.setMyArriveDate(c1.getTime());
        }


        if( nfn.getStartDate().after(tn.getArriveDate())){

            tn.build();
            fn.build();
            nfn.build();

            Plan p = new Plan();
            p.setFrom(from);
            p.setTo(to);
            p.setStartDate(tn.getMyStartDate());
            p.setArriveDate(nfn.getMyArriveDate());
            p.getList().add(tn);
            p.getList().add(nfn);
            p.setUsedMinute(com.wencheng.utils.Util.getMinute(tn.getMyStartDate(), nfn.getMyArriveDate()));
            p.setUsedTime(com.wencheng.utils.Util.getHours(tn.getMyStartDate(), nfn.getMyArriveDate()));

            p.build();
            String key = tn.getTraincode()+fn.getTraincode();
            Plan p1 = map.get(key);
            if(p1!=null){
                if(fn.getKeyStation().equals(nfn.getKeyStation())){
                    if(p.getUsedMinute()<p1.getUsedMinute()){
                        map.put(key,p);
                    }
                }else{
                    if((p.getUsedMinute()+60)<p1.getUsedMinute()){
                        map.put(key,p);
                    }
                }
            }else{
                map.put(key,p);
            }


        }else{
            Calendar c = Calendar.getInstance();
            Calendar c1 = Calendar.getInstance();
            c.setTime(nfn.getStartDate());
            c.add(Calendar.DATE, 1);
            nfn.setStartDate(c.getTime());
            c1.setTime(nfn.getMyArriveDate());
            c1.add(Calendar.DATE,1);
            nfn.setMyArriveDate(c1.getTime());

            if(nfn.getStartDate().after(tn.getArriveDate())){

                tn.build();
                nfn.build();
                fn.build();

                Plan p = new Plan();
                p.setFrom(from);
                p.setTo(to);
                p.setStartDate(tn.getMyStartDate());
                p.setArriveDate(nfn.getMyArriveDate());
                p.getList().add(tn);
                p.getList().add(nfn);
                p.setUsedMinute(com.wencheng.utils.Util.getMinute(tn.getMyStartDate(), nfn.getMyArriveDate()));
                p.setUsedTime(com.wencheng.utils.Util.getHours(tn.getMyStartDate(), nfn.getMyArriveDate()));

                p.build();
                String key = tn.getTraincode()+fn.getTraincode();
                Plan p1 = map.get(key);
                if(p1!=null){
                    if(fn.getKeyStation().equals(nfn.getKeyStation())){
                        if(p.getUsedMinute()<p1.getUsedMinute()){
                            map.put(key,p);
                        }
                    }else{
                        if((p.getUsedMinute()+60)<p1.getUsedMinute()){
                            map.put(key,p);
                        }
                    }
                }else{
                    map.put(key,p);
                }

            }


        }

    }

    public Map<String, Plan> getMap() {
        return map;
    }

    public void setMap(Map<String, Plan> map) {
        this.map = map;
    }
}
