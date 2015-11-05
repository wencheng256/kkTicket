package com.wencheng.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wencheng.dao.StationDao;
import com.wencheng.domain.Plan;
import com.wencheng.service.WayDesigner;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.util.Iterator;
import java.util.Map;

/**
 * Created by Administrator on 2015/11/2.
 */
@Component("WayDesignAction")
@Scope(value = "prototype")
public class WayDesignAction extends ActionSupport{

    private String from;
    private String to;

    @Autowired
    private WayDesigner wd;
    @Autowired
    private StationDao dao;

    public String execute() throws Exception{
        wd.getKetTrainList(from,to, ServletActionContext.getRequest().getSession()).analyze();
        Map<String, Plan> map = wd.getMap();
        Iterator<Plan> it = map.values().iterator();
        while(it.hasNext()){
            System.out.println(it.next());
        }
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
}
