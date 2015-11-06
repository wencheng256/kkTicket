package com.wencheng.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wencheng.dao.StationDao;
import com.wencheng.utils.Util;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 * Created by wencheng on 15/11/4.
 */
@Component("GetCity")
public class GetCity extends ActionSupport{

    private String city;
    private String code;
    private String date;
    private String name;
    @Autowired
    private StationDao dao;

    @Override
    public String execute() throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        city = dao.getCode(name);

        JSONObject jo = Util.getCityTrain(name, code, date, city, session);
        session.setAttribute(city, jo.toString());
        JSONObject j = new JSONObject();

        if(jo.getJSONObject("data").getBoolean("flag")){
            j.put("result", true);
        }else{
            j.put("result", false);
        }

        HttpServletResponse re = ServletActionContext.getResponse();
        re.setContentType("Application/json");
        PrintWriter w = re.getWriter();
        w.write(j.toString());
        return null;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
