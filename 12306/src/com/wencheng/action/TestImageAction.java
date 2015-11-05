package com.wencheng.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wencheng.utils.Util;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;

/**
 * Created by wencheng on 15/11/3.
 */
@Component("TestImageAction")
public class TestImageAction extends ActionSupport{

    private String random;
    private String from;

    public String execute() throws Exception {
        System.out.println(Util.testRandom(random, ServletActionContext.getRequest().getSession()));
        return null;
    }


    public String getRandom() {
        return random;
    }

    public void setRandom(String random) {
        this.random = random;
    }

}
