package com.wencheng.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wencheng.dao.StationDao;
import com.wencheng.domain.Person;
import com.wencheng.utils.Util;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;

/**
 * Created by wencheng on 15/11/3.
 */
@Component("SingleWay")
public class SingleWay extends ActionSupport {

    private String from;
    private String to;
    private String date;
    @Autowired
    private StationDao dao;

    @Override
    public String execute() throws Exception {
        JSONObject jo = Util.getFromTo(date, dao.getCode(from), dao.getCode(to), Person.ADULT);
        JSONArray data = jo.getJSONArray("data");
        JSONObject jo1 = new JSONObject();
        if(data.size()>0){
            jo1.put("result",true);
        }else{
            jo1.put("result", false);
        }
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setContentType("application/json");
        response.getWriter().write(jo1.toString());
        return null;
    }

    public String loadTrain() throws Exception {
        JSONObject jo = Util.getFromTo(date, from, to, Person.ADULT);
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(jo.toString());
        return null;
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
