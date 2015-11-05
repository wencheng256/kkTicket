package com.wencheng.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wencheng.utils.Util;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2015/10/31.
 */
@Component("image")
public class Image extends ActionSupport{

    public String execute(){

        byte[] image = Util.getImage(ServletActionContext.getRequest().getSession());
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setContentType("image/jpeg;charset=UTF-8");
        response.setHeader("Content-Length", String.valueOf(image.length));
        ServletOutputStream o = null;
        try {
            o = response.getOutputStream();
            o.write(image);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

}
