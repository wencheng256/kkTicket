package com.wencheng.action;

import com.opensymphony.xwork2.ActionSupport;
import org.springframework.stereotype.Component;

/**
 * Created by Administrator on 2015/11/5.
 */
@Component("ShowJoinWay")
public class ShowJoinWay extends ActionSupport{

    private String from;
    private String to;
    private String date;

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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
