package com.wencheng.domain;

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
}
