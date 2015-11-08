package com.wencheng.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wencheng.dao.StationDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Created by Administrator on 2015/11/7.
 */
@Component("BuyAction")
public class BuyAction extends ActionSupport {

    private String from;
    private String to;
    private String date;
    private boolean multi;
    private int index;
    private String train;
    @Autowired
    private StationDao dao;


    public String getFrom() {
        return from;
    }
    public String getFromCode() {
        return dao.getCode(from);
    }
    public String getToCode() {
        return dao.getCode(to);
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public boolean isMulti() {
        return multi;
    }

    public void setMulti(boolean multi) {
        this.multi = multi;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

    public String getTrain() {
        return train;
    }

    public void setTrain(String train) {
        this.train = train;
    }
}
