package com.wencheng.service;

import com.wencheng.dao.KeyStationDao;
import com.wencheng.domain.KeyTrain;
import com.wencheng.utils.Util;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by wencheng on 15/10/30.
 */
public class KeyTrainGetter {

    Object lock;


    public KeyTrainGetter(Object lock){
        this.lock = lock;
    }



    public boolean isComplete(){
        return complete;
    }


    public List<KeyTrain> getKey() {
        return key;
    }


    //线程池
    private volatile  int num = 0;
    private boolean complete = false;
    //保存重点列车的列表
    private List<KeyTrain> key = new LinkedList<KeyTrain>();
    private SimpleDateFormat sTime = new SimpleDateFormat("HH:mm");
    private SimpleDateFormat sDate = new SimpleDateFormat("yyyyMMdd-HH:mm");

    public KeyStationDao getDao() {
        return dao;
    }

    public void setDao(KeyStationDao dao) {
        this.dao = dao;
    }

    private KeyStationDao dao;
    /**
     * 获取从某站点通过的重点列车，主要方法
     * @param jo 站点车辆数据
     */
    public  void getKeyTrain(JSONObject jo,final boolean come) {
        final ExecutorService pools = Executors.newFixedThreadPool(10);
        JSONArray yz = jo.getJSONObject("data").getJSONArray("data");
        for(int i = 0; i<yz.size(); i++){
            final JSONObject o = yz.getJSONObject(i);
            pools.execute(new Runnable() {
                @Override
                public void run() {
                    synchronized (this){
                        num++;
                    }
                    try {
                        isKeyTrain(o,come);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }finally{
                        synchronized (this){
                            num--;
                        }
                        if(num == 0){
                            pools.shutdown();
                            complete = true;
                            synchronized (lock){
                                lock.notifyAll();
                            }
                        }
                    }
                }
            });
        }
    }

    /**
     * 判断本列车是否为重点列车
     * @param o 列车信息JSON
     * @throws Exception
     */
    private  void isKeyTrain(JSONObject o,boolean come) throws Exception {
        //获取列车相关信息
        String from = (String) o.get("start_station_telecode");
        String to = (String) o.get("end_station_telecode");
        String date = (String) o.get("start_train_date");
        String num = (String) o.get("train_no");
        String no = (String) o.get("station_no");
        String code = (String) o.get("station_train_code");
        String class_name = (String) o.get("train_class_name");
        String arrive_time = (String) o.get("arrive_time");
        String start_time = (String) o.get("start_time");
        String station_train_date = (String) o.get("station_train_date");

        String fromn = o.getString("station_no");
        String seat = o.getString("seat_types");


        long timestamp = Long.parseLong(date);
        Date lastTime = null;

        int start = Integer.parseInt(no);
        date = date.substring(0,4)+"-"+date.substring(4,6)+"-"+date.substring(6,8);

        //请求服务器获取列车站点信息
        JSONObject t = Util.getTrainStation(date, num, from, to);
        JSONArray data = t.getJSONObject("data").getJSONArray("data");

        //判断是出发还是到达
        synchronized (this) {
            if (come) {
                //找出站点中的交通枢纽
                for (int j = 0; j < data.size(); j++) {
                    JSONObject sta = data.getJSONObject(j);
                    if (lastTime == null) {
                        lastTime = sTime.parse((String) sta.get("start_time"));
                    } else {
                        Date d1 = sTime.parse((String) sta.get("arrive_time"));
                        if (d1.before(lastTime)) {
                            timestamp++;
                        }
                        lastTime = d1;
                    }

                    String sn = (String) sta.get("station_no");
                    if (Integer.parseInt(sn) <= start) {
                        continue;
                    }

                    //如果是交通枢纽则本列列车是keyTrain
                    if (dao.isKeyStation((String) sta.get("station_name"))) {
                        KeyTrain kt = new KeyTrain();

                        kt.setFromn(fromn);
                        kt.setTon(sn);
                        kt.setSeat(seat);
                        kt.setTd(station_train_date);

                        kt.setTrainnum(num);
                        kt.setTraincode(code);
                        kt.setDescribe(class_name);
                        kt.setKeyStation((String) sta.get("station_name"));

                        //时间相关
                        kt.setMyArriveTime(arrive_time);
                        kt.setMyStartTime(start_time);

                        kt.setStartTime((String) sta.get("start_time"));
                        kt.setArriveTime((String) sta.get("arrive_time"));

                        try {
                            kt.setMyArriveDate(sDate.parse(station_train_date + "-" + kt.getMyArriveTime()));

                        } catch (Exception e) {
                            kt.setMyArriveDate(null);
                        }
                        try {
                            kt.setArriveDate(sDate.parse(timestamp + "-" + kt.getArriveTime()));
                        } catch (Exception e) {
                            kt.setArriveDate(null);
                        }

                        try {
                            if (sTime.parse(kt.getMyArriveTime()).after(sTime.parse(kt.getMyStartTime()))) {
                                kt.setMyStartDate(sDate.parse((Long.parseLong(station_train_date) + 1) + "-" + kt.getMyStartTime()));
                            } else {
                                kt.setMyStartDate(sDate.parse((station_train_date) + "-" + kt.getMyStartTime()));
                            }
                        } catch (Exception e) {
                            String s = station_train_date + "-" + kt.getMyStartTime();
                            try {
                                kt.setMyStartDate(sDate.parse(s));
                            } catch (Exception e1) {
                                e1.printStackTrace();
                                System.out.println(s);
                            }
                        }

                        try {
                            if (sTime.parse(kt.getArriveTime()).after(sTime.parse(kt.getStartTime()))) {
                                kt.setStartDate(sDate.parse((((Long)timestamp) + 1) + "-" + kt.getStartTime()));
                            } else {
                                kt.setStartDate(sDate.parse(timestamp+ "-" + kt.getStartTime()));
                            }
                        } catch (Exception e) {
                            try {
                                kt.setStartDate(sDate.parse(timestamp + "-" + kt.getStartTime()));
                            } catch (Exception e1) {

                            }
                        }
                        this.key.add(kt);

                    }
                }
            } else {
                //找出站点中的交通枢纽
                for (int j = 0; j < data.size(); j++) {

                    JSONObject sta = data.getJSONObject(j);

                    if (lastTime == null) {
                        lastTime = sTime.parse((String) sta.get("start_time"));
                    } else {
                        Date d1 = sTime.parse((String) sta.get("arrive_time"));
                        if (d1.before(lastTime)) {
                            timestamp++;
                        }
                        lastTime = d1;
                    }

                    String sn = (String) sta.get("station_no");
                    if (Integer.parseInt(sn) >= start) {
                        continue;
                    }

                    //如果是交通枢纽则本列列车是keyTrain
                    if (dao.isKeyStation((String) sta.get("station_name"))) {
                        KeyTrain kt = new KeyTrain();

                        kt.setFromn(fromn);
                        kt.setTon(sn);
                        kt.setSeat(seat);
                        kt.setTd(station_train_date);

                        kt.setTrainnum(num);
                        kt.setTraincode(code);
                        kt.setDescribe(class_name);
                        kt.setKeyStation((String) sta.get("station_name"));

                        //时间相关
                        kt.setMyArriveTime(arrive_time);
                        kt.setMyStartTime(start_time);

                        kt.setStartTime((String) sta.get("start_time"));
                        kt.setArriveTime((String) sta.get("arrive_time"));

                        try {
                            kt.setMyArriveDate(sDate.parse(station_train_date + "-" + kt.getMyArriveTime()));

                        } catch (Exception e) {
                            kt.setMyArriveDate(null);
                        }
                        try {
                            kt.setArriveDate(sDate.parse(timestamp + "-" + kt.getArriveTime()));
                        } catch (Exception e) {
                            kt.setArriveDate(null);
                        }

                        try {
                            if (sTime.parse(kt.getMyArriveTime()).after(sTime.parse(kt.getMyStartTime()))) {
                                kt.setMyStartDate(sDate.parse((Long.parseLong(station_train_date) + 1) + "-" + kt.getMyStartTime()));
                            } else {
                                kt.setMyStartDate(sDate.parse((station_train_date) + "-" + kt.getMyStartTime()));
                            }
                        } catch (Exception e) {
                            String s = station_train_date + "-" + kt.getMyStartTime();
                            try {
                                kt.setMyStartDate(sDate.parse(s));
                            } catch (Exception e1) {
                                e1.printStackTrace();
                                System.out.println(s);
                            }
                        }

                        try {
                            if (sTime.parse(kt.getArriveTime()).after(sTime.parse(kt.getStartTime()))) {
                                kt.setStartDate(sDate.parse((((Long)timestamp) + 1) + "-" + kt.getStartTime()));
                            } else {
                                kt.setStartDate(sDate.parse(timestamp+ "-" + kt.getStartTime()));
                            }
                        } catch (Exception e) {
                            try {
                                kt.setStartDate(sDate.parse(timestamp + "-" + kt.getStartTime()));
                            } catch (Exception e1) {

                            }
                        }
                        this.key.add(kt);
                    }
                }
            }
        }
    }

}

