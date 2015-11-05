package com.wencheng.utils;

import com.wencheng.domain.Person;
import net.sf.json.JSONObject;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;

import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by wencheng on 15/10/30.
 */
public class Util {

    /**
     * 提供日期、始发站、目的地、成员类型获取列车
     * @param date 始发日期
     * @param from 起始站
     * @param to 目的地站
     * @param per 成员类型
     * @return
     * @throws Exception
     */
    public static JSONObject getFromTo(String date,String from,String to,Person per) throws Exception {
           String url = "https://kyfw.12306.cn/otn/leftTicket/query?leftTicketDTO.train_date="+date+"&leftTicketDTO.from_station="+from+"&leftTicketDTO.to_station="+to+"&purpose_codes="+per.name();
            return getJSON(url);
    }

    /**
     *获取列车时刻表
     * @return
     * @throws Exception
     */
    public static JSONObject getTime() throws Exception {
            String url = "https://kyfw.12306.cn/otn/czxx/queryByTrainNo?train_no=240000K4110K&from_station_telecode=BJP&to_station_telecode=WKK&depart_date=2015-10-30";
            return getJSON(url);
    }


    /**
     * 通过请求外网地址获取json信息
     * @param url
     * @return
     * @throws Exception
     */
    public static JSONObject getJSON(String url) throws Exception {
        HttpGet get = new HttpGet(url);
        HttpClient client = new SSLClient();

        get.setHeader("User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0) Gecko/20100101 Firefox/38.0");
        get.setHeader("Referer", "https://kyfw.12306.cn/otn/leftTicket/init");

        org.apache.http.HttpResponse execute = client.execute(get);
        HttpEntity en = execute.getEntity();
        InputStream in = en.getContent();
        int len;
        byte[] b = new byte[1024];
        StringBuilder sb = new StringBuilder();
        while((len = in.read(b))>0){
            sb.append(new String(b, 0, len,"UTF-8"));
        }
        JSONObject jo = JSONObject.fromObject(sb.toString());
        return jo;
    }

    /**
     * 通过请求外网地址获取json信息
     * @param url
     * @return
     * @throws Exception
     */
    public static JSONObject getJSON(String url,HttpSession session) throws Exception {
        HttpGet get = new HttpGet(url);
        HttpClient client = new SSLClient();

        get.setHeader("Connection", "keep-alive");
        get.setHeader("Pragma", "no-cache");
        get.setHeader("Cache-Control", "no-cache");
        get.setHeader("Referer", "https://kyfw.12306.cn/otn/czxx/init");
        get.setHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
        get.setHeader("X-Requested-With", "XMLHttpRequest");
        get.setHeader("Accept", "*/*");
        get.setHeader("Host", "kyfw.12306.cn");

        Object cookie = session.getAttribute("cookie");
        if(cookie != null){
            get.setHeader("Cookie", (String) cookie);
        }

        org.apache.http.HttpResponse execute = client.execute(get);
        HttpEntity en = execute.getEntity();
        InputStream in = en.getContent();
        int len;
        byte[] b = new byte[1024];
        StringBuilder sb = new StringBuilder();
        while((len = in.read(b))>0){
            sb.append(new String(b, 0, len,"UTF-8"));
        }
        JSONObject jo = JSONObject.fromObject(sb.toString());
        return jo;
    }


    /**
     * 远程获取验证码图片，并且将cookie储存在session中
     * @param session
     * @return
     */
    public static byte[] getImage(HttpSession session){
        try {
            SSLClient client = new SSLClient();

            HttpGet get = new HttpGet("https://kyfw.12306.cn/otn/passcodeNew/getPassCodeNew?module=other&rand=sjrand");

            //设置请求header
            get.setHeader("Host","kyfw.12306.cn");
            get.setHeader("Accept-Language","zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3");
            get.setHeader("Accept","image/png,image/*;q=0.8,*/*;q=0.5");
            get.setHeader("Connection","keep-alive");
            get.setHeader("Accept-Encoding","gzip, deflate");
            get.setHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.2; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0");

            //测试此前是否已经储存过cookie
            Object cookie = session.getAttribute("cookie");
            if(cookie != null){
                get.setHeader("Cookie",(String)cookie);
            }
            HttpResponse execute = client.execute(get);


            Header[] scookie = execute.getHeaders("Set-Cookie");
            //如果此前保存了cookie而且还有setHeader头的话说明cookie有问题，需要重新替换
            for(int i = 0; i<scookie.length; i++){
                if(cookie != null){
                    if(scookie[i].getValue().contains("JSESSIONID")||scookie[i].getValue().contains("BIGipServerotn")){
                        session.setAttribute("cookie",null);
                        getImage(session);
                    }
                }
            }


            //如果此前并没有保存过cookie，则保存cookie到session
            if(cookie == null){
                StringBuilder bs = new StringBuilder();
                for(int i = 0; i<scookie.length; i++){
                    bs.append(scookie[i].getValue().split(";")[0]);
                    if(i<scookie.length-1){
                        bs.append("; ");
                    }
                }
                session.setAttribute("cookie", bs.toString());
            }
            //获取请求响应
            HttpEntity entity = execute.getEntity();
            InputStream in = entity.getContent();
            ByteArrayOutputStream bo = new ByteArrayOutputStream();
            byte[] b = new byte[1024];
            int len;
            while((len = in.read(b))>0){
                bo.write(b,0,len);
            }
            return bo.toByteArray();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new byte[0];
    }

    /**
     * 测试验证码是有效
     * @param random
     * @param session
     * @return
     * @throws Exception
     */
    public static JSONObject testRandom(String random,HttpSession session) throws Exception {
        HttpPost get = new HttpPost("https://kyfw.12306.cn/otn/passcodeNew/checkRandCodeAnsyn");
        HttpClient client = new SSLClient();
        BasicHttpParams params = new BasicHttpParams();

        get.setHeader("Connection", "keep-alive");
        get.setHeader("Pragma", "no-cache");
        get.setHeader("Cache-Control", "no-cache");
        get.setHeader("Referer", "https://kyfw.12306.cn/otn/czxx/init");
        get.setHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
        get.setHeader("X-Requested-With", "XMLHttpRequest");
        get.setHeader("Accept", "*/*");
        get.setHeader("Host", "kyfw.12306.cn");

        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
        nvps.add(new BasicNameValuePair("randCode",random));
        nvps.add(new BasicNameValuePair("rand","sjrand"));
        get.setEntity(new UrlEncodedFormEntity(nvps));

        Object cookie = session.getAttribute("cookie");
        if(cookie != null){
            get.setHeader("Cookie", (String) cookie);
        }

        org.apache.http.HttpResponse execute = client.execute(get);
        HttpEntity en = execute.getEntity();
        InputStream in = en.getContent();
        int len;
        byte[] b = new byte[1024];
        StringBuilder sb = new StringBuilder();
        while((len = in.read(b))>0){
            sb.append(new String(b, 0, len,"UTF-8"));
        }
        JSONObject jo = JSONObject.fromObject(sb.toString());
        return jo;
    }

    /**
     * 获取某列车的站点和停靠信息
     * @param date 列车出发日期
     * @param trainnum 列车标号
     * @param from 列车出发城市
     * @param to 列车终点站城市
     * @return 列车经过站点和停靠信息
     * @throws Exception
     */
    public static JSONObject getTrainStation(String date,String trainnum,String from,String to) throws Exception {
        SSLClient c = new SSLClient();
        HttpGet get = new HttpGet("https://kyfw.12306.cn/otn/czxx/queryByTrainNo?train_no="+trainnum+"&from_station_telecode="+from+"&to_station_telecode="+to+"&depart_date="+date);
        get.setHeader("User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0) Gecko/20100101 Firefox/38.0");
        get.setHeader("Referer", "https://kyfw.12306.cn/otn/leftTicket/init");
        HttpResponse response = c.execute(get);
        HttpEntity e = response.getEntity();
        InputStream in = e.getContent();
        StringBuilder sb = new StringBuilder();
        int len;
        byte[] buffer = new byte[1024];

        while((len = in.read(buffer))>0){
            sb.append(new String(buffer,0,len,"UTF8"));
        }
        return  JSONObject.fromObject(sb.toString());
    }

    static public void main(String[] agrs) throws ParseException {
        SimpleDateFormat sm = new SimpleDateFormat("yyyyMMdd-HH:mm");
        System.out.println(sm.parse("20151102-08:53"));
    }

    public static String getHours(Date start,Date arrive){
        Calendar c = Calendar.getInstance();
        c.setTime(start);
        long s = c.getTimeInMillis();
        c.setTime(arrive);
        long a = c.getTimeInMillis();
        long hour =  (a - s)/(1000*3600);
        long minute =  (a - s-(1000*3600*hour))/(1000*60);

        return hour+"小时"+minute+"分钟";
    }

    public static long getMinute(Date start,Date arrive){
        Calendar c = Calendar.getInstance();
        c.setTime(start);
        long s = c.getTimeInMillis();
        c.setTime(arrive);
        long a = c.getTimeInMillis();
        return (a-s)/(1000*60);
    }

    /**
     * 获取通过某个城市的列车
     */
    public static JSONObject getCityTrain(String name,String code,String date,String city,HttpSession session) throws Exception {
            String url = "https://kyfw.12306.cn/otn/czxx/query?train_start_date="+date+"&train_station_name="+name+"&train_station_code="+city+"&randCode="+code;
            System.out.println(url);
            return getJSON(url,session);
    }




}
