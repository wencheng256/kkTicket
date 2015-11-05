package com.wencheng.domain;

import com.wencheng.utils.Util;
import net.sf.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by wencheng on 15/11/2.
 */
public class KeyTrain {

    private String trainnum;
    private String arriveTime;
    private String keyStation;
    private String describe;
    private String startTime;
    private String traincode;
    private String myStartTime;
    private String myArriveTime;
    private Date arriveDate;
    private Date startDate;
    private Date myArriveDate;
    private Date myStartDate;
    private String fromn;
    private String td;
    private String ton;
    private String seat;
    private JSONObject cost;

    public Date getArriveDate() {
        return arriveDate;
    }

    public void setArriveDate(Date arriveDate) {
        this.arriveDate = arriveDate;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getMyArriveDate() {
        return myArriveDate;
    }

    public void setMyArriveDate(Date myArriveDate) {
        this.myArriveDate = myArriveDate;
    }

    public Date getMyStartDate() {
        return myStartDate;
    }

    public void setMyStartDate(Date myStartDate) {
        this.myStartDate = myStartDate;
    }

    public String getTrainnum() {
        return trainnum;
    }

    public void setTrainnum(String trainnum) {
        this.trainnum = trainnum;
    }

    public String getArriveTime() {
        return arriveTime;
    }

    public void setArriveTime(String arriveTime) {
        this.arriveTime = arriveTime;
    }

    public String getKeyStation() {
        return keyStation;
    }

    public void setKeyStation(String keyStation) {
        this.keyStation = keyStation;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getTraincode() {
        return traincode;
    }

    public void setTraincode(String traincode) {
        this.traincode = traincode;
    }

    public String getTd() {
        return td;
    }

    public void setTd(String td) {
        this.td = td;
    }

    public String toString(){
        return getTraincode()+"|"+getKeyStation()+"|"+getStartDate()+"|"+getArriveDate()+"|"+getMyArriveDate()+"|"+getMyStartDate();
    }
    public String toString1(){
        return getTraincode()+"|"+getKeyStation()+"|"+getStartTime()+"|"+getArriveTime()+"|"+getMyArriveTime()+"|"+getMyStartTime();
    }

    public String getMyStartTime() {
        return myStartTime;
    }

    public String getFromn() {
        return fromn;
    }

    public void setFromn(String fromn) {
        this.fromn = fromn;
    }

    public String getTon() {
        return ton;
    }

    public void setTon(String ton) {
        this.ton = ton;
    }

    public String getSeat() {
        return seat;
    }

    public void setSeat(String seat) {
        this.seat = seat;
    }

    public void setMyStartTime(String myStartTime) {
        this.myStartTime = myStartTime;
    }

    public String getMyArriveTime() {
        return myArriveTime;
    }

    public void setMyArriveTime(String myArriveTime) {
        this.myArriveTime = myArriveTime;
    }

    public JSONObject getCost() {
        return cost;
    }
    public void build() throws Exception {
        this.cost = Util.getPrice(trainnum,fromn,ton,td,seat);
    }

    public void setCost(JSONObject cost) {
        this.cost = cost;
    }
}
