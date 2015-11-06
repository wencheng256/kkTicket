package com.wencheng.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wencheng.dao.StationDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Created by Administrator on 2015/11/3.
 */
@Component("ShowAction")
public class ShowAction extends ActionSupport {

    private String from;
    private String to;
    private String date;
    @Autowired
    private StationDao dao;

    @Override
    public String execute() throws Exception {
        from = dao.getCode(from);
        to = dao.getCode(to);
        return SUCCESS;
    }

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

    public StationDao getDao() {
        return dao;
    }

    public void setDao(StationDao dao) {
        this.dao = dao;
    }
}
