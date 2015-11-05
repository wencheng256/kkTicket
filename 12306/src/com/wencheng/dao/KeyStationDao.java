package com.wencheng.dao;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Created by Administrator on 2015/11/2.
 */
@Component
public class KeyStationDao {

    @Autowired
    private SessionFactory sf;

    /**
     * 判断一个站点是否为交通枢纽
     * @param name 站点名
     * @return  Boolean
     */
    public boolean isKeyStation(String name){
        Session s = sf.openSession();
        Long b = Long.valueOf(0);
        try{
            Transaction ts = s.beginTransaction();
            String sql = "select count(distinct p) from KeyStation as p where p.name = :name";
            Query q = s.createQuery(sql).setString("name",name);
            b = (Long)q.uniqueResult();
            if(b == 0){
                Query q1 = s.createQuery(sql).setString("name",name.substring(0,name.length() - 1));
                b = (Long) q1.uniqueResult();
            }
            ts.commit();
        }finally{
            s.close();
        }
        return b > 0;
    }
}
