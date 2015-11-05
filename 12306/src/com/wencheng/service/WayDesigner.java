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

        Object lock = new Object();
        Object lock2 = new Object();

        KeyTrainGetter k = new KeyTrainGetter(lock);
        KeyTrainGetter k2 = new KeyTrainGetter(lock2);
        k.setDao(dao);
        k2.setDao(dao);
        k.getKeyTrain(from, true);
        k2.getKeyTrain(to, false);


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
        Iterator<KeyTrain> to = toKey.iterator();
        int i = 0;
        while(to.hasNext()){
            KeyTrain tn = to.next();
            Iterator<KeyTrain> from = fromKey.iterator();
            while(from.hasNext()){
                i++;
                KeyTrain fn = from.next();
                try{
                    ProcessWay(tn, fn);
                }catch(Exception e){
                    e.printStackTrace();
                }

            }
        }
        System.out.println(i);
        return this;
    }

    /**
     *
     * @param tn
     * @param fn
     */
    private void ProcessWay(KeyTrain tn, KeyTrain fn) {
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

        if((tn.getKeyStation().contains(fn.getKeyStation())||fn.getKeyStation().contains(tn.getKeyStation())) && nfn.getStartDate().after(tn.getArriveDate())){
            Plan p = new Plan();
            p.setFrom(from);
            p.setTo(to);
            p.setStartDate(tn.getMyStartDate());
            p.setArriveDate(nfn.getMyArriveDate());
            p.getList().add(tn);
            p.getList().add(nfn);
            p.setUsedMinute(com.wencheng.utils.Util.getMinute(tn.getMyStartDate(), nfn.getMyArriveDate()));
            p.setUsedTime(com.wencheng.utils.Util.getHours(tn.getMyStartDate(), nfn.getMyArriveDate()));
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

    public Map<String, Plan> getMap() {
        return map;
    }

    public void setMap(Map<String, Plan> map) {
        this.map = map;
    }
}
