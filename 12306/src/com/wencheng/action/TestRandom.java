package com.wencheng.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wencheng.utils.Util;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2015/11/1.
 */
@Component("TestRandom")
public class TestRandom extends ActionSupport {


    private String randCode;

    public String getRandCode() {
        return randCode;
    }

    public void setRandCode(String randCode) {
        this.randCode = randCode;
    }

    public String execute(){

        try {
            JSONObject jo = Util.testRandom(randCode, ServletActionContext.getRequest().getSession()) ;
            HttpServletResponse re = ServletActionContext.getResponse();
            re.setContentType("application/json");
            re.getWriter().print(jo.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
