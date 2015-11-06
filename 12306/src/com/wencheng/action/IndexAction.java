package com.wencheng.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wencheng.dao.StationDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by Administrator on 2015/10/30.
 */
@Component("IndexAction")
public class IndexAction extends ActionSupport {

    private String test;
    @Autowired
    private StationDao dao;

    private String otherMindate;
    private String otherMaxdate;
    private String initTrainDate;
    private String initToDate;
    private String init_from_date;


    @Override
    public String execute(){
        Calendar c = Calendar.getInstance();
        c.setTime(new Date());
        SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");

        otherMindate = sm.format(c.getTime());
        init_from_date = sm.format(c.getTime());
        initTrainDate = sm.format(c.getTime());
        c.add(Calendar.MONTH,2);
        otherMaxdate = sm.format(c.getTime());
        initToDate = sm.format(c.getTime());
        return SUCCESS;
    }

    public String getTest() {
        return test;
    }

    public void setTest(String test) {
        this.test = test;
    }


    public String getOtherMindate() {
        return otherMindate;
    }

    public void setOtherMindate(String otherMindate) {
        this.otherMindate = otherMindate;
    }

    public String getOtherMaxdate() {
        return otherMaxdate;
    }

    public void setOtherMaxdate(String otherMaxdate) {
        this.otherMaxdate = otherMaxdate;
    }

    public String getInitTrainDate() {
        return initTrainDate;
    }

    public void setInitTrainDate(String initTrainDate) {
        this.initTrainDate = initTrainDate;
    }

    public String getInitToDate() {
        return initToDate;
    }

    public void setInitToDate(String initToDate) {
        this.initToDate = initToDate;
    }

    public String getInit_from_date() {
        return init_from_date;
    }

    public void setInit_from_date(String init_from_date) {
        this.init_from_date = init_from_date;
    }
}
