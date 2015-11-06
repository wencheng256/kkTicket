package com.wencheng.domain;

import com.wencheng.utils.Util;
import net.sf.json.JSONObject;
import sun.tools.jconsole.inspector.Utils;

import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by wencheng on 15/11/4.
 */
public class Plan {

    private String from;
    private String to;
    private Date startDate;
    private Date arriveDate;
    private Long usedMinute;
    private String usedTime;
    private double cost = 0;
    private String[] code = {"A1","O","A3","A4","M"};
    private String wait;

    private List<KeyTrain> list = new LinkedList<KeyTrain>();

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getArriveDate() {
        return arriveDate;
    }

    public void setArriveDate(Date arriveDate) {
        this.arriveDate = arriveDate;
    }

    public Long getUsedMinute() {
        return usedMinute;
    }

    public void setUsedMinute(Long usedMinute) {
        this.usedMinute = usedMinute;
    }

    public String getUsedTime() {
        return usedTime;
    }

    public void setUsedTime(String userTime) {
        this.usedTime = userTime;
    }

    public List<KeyTrain> getList() {
        return list;
    }

    public void setList(List<KeyTrain> list) {
        this.list = list;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public String getWait() {
        return wait;
    }

    public void setWait(String wait) {
        this.wait = wait;
    }

    public String toString(){
        String ret =  "从"+from+"至"+to+"耗时"+usedTime;
        Iterator<KeyTrain> it = list.iterator();
        while(it.hasNext()){
            KeyTrain n = it.next();
            ret+="|"+n.getTraincode();
            System.out.println(n);
            System.out.println(n.toString1());
        }
        return ret;
    }

    public void build(){
        Iterator<KeyTrain> it = list.iterator();
        Date s = null;
        Date e = null;
        while(it.hasNext()){
            KeyTrain n = it.next();
            JSONObject co = n.getCost();
            JSONObject d = co.getJSONObject("data");
            if(s == null){
                s = n.getArriveDate();
            }else{
                e = n.getStartDate();
                wait = Util.getHours(s,e);
                s = n.getMyArriveDate();
            }
            for(int i = 0; i<code.length; i++){
                Object o = d.get(code[i]);
                if(o != null){
                    cost+= Double.valueOf(o.toString().substring(1));
                    break;
                }
            }
        }
    }
}
