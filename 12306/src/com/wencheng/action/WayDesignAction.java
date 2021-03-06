package com.wencheng.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wencheng.dao.StationDao;
import com.wencheng.domain.Plan;
import com.wencheng.service.WayDesigner;
import net.sf.json.JSONArray;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Collection;
import java.util.Map;

/**
 * Created by Administrator on 2015/11/2.
 */
@Component("WayDesignAction")
@Scope(value = "prototype")
public class WayDesignAction extends ActionSupport{

    private String from;
    private String to;
    private String date;

    @Autowired
    private WayDesigner wd;
    @Autowired
    private StationDao dao;
    private Collection<Plan> map;

    public String execute() throws Exception{

        String key = from+to+date;
        HttpSession session = ServletActionContext.getRequest().getSession();
        Object o = session.getAttribute(key);
        Map<String, Plan> map = null;

        if(o == null){
            wd.getKetTrainList(from,to, session).analyze();
            map = wd.getMap();
            session.setAttribute(key,map);
        }else{
            map = (Map<String, Plan>) o;
        }


        this.map = map.values();
        HttpServletResponse r = ServletActionContext.getResponse();
        r.setContentType("application/json; charset=UTF-8");
        r.getWriter().write(JSONArray.fromObject(map).toString());

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

    public Collection<Plan> getMap() {
        return map;
    }

    public void setMap(Collection<Plan> map) {
        this.map = map;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
