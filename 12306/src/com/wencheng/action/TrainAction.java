package com.wencheng.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wencheng.domain.Person;
import com.wencheng.utils.Util;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2015/10/31.
 */
@Component("Train")
public class TrainAction extends ActionSupport{

    private String from_station;
    private String to_station;
    private String train_date;
    private Person purpose_codes;

    public String getFromTo(){
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setContentType("application/json;charset=UTF-8");
        try {
            JSONObject jo = Util.getFromTo(train_date, from_station, to_station, purpose_codes);
            response.getWriter().print(jo.toString());
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jo = new JSONObject();
            jo.put("status", false);
            try {
                response.getWriter().print(jo.toString());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
        return null;
    }


    public String getFrom_station() {
        return from_station;
    }

    public void setFrom_station(String from_station) {
        this.from_station = from_station;
    }

    public String getTo_station() {
        return to_station;
    }

    public void setTo_station(String to_station) {
        this.to_station = to_station;
    }

    public String getTrain_date() {
        return train_date;
    }

    public void setTrain_date(String train_date) {
        this.train_date = train_date;
    }

    public Person getPurpose_codes() {
        return purpose_codes;
    }

    public void setPurpose_codes(Person purpose_codes) {
        this.purpose_codes = purpose_codes;
    }
}
