package com.wencheng.dao;

import com.wencheng.domain.Station;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/10/31.
 */
@Repository
public class StationDao {

    @Autowired
    private HibernateTemplate tem;
    @Autowired
    private SessionFactory sf;

    public Station stationFind(int id){
        return tem.get(Station.class,id);
    }

    public String getCode(String name){
        String queryString = "select s.code from Station s where s.name = :name";
        Session s = sf.openSession();
        Query q = s.createQuery(queryString).setString("name", name);
        String re = (String) q.uniqueResult();
        s.close();
        return re;
    }


}
