<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/3
  Time: 20:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <link href="/css/validation.css" rel="stylesheet" />
  <link href="/css/common_css.css?cssVersion=1.8801" rel="stylesheet" />
  <script>
    /*<![CDATA[*/
    var ctx='/otn/';
    var globalRepeatSubmitToken = null;
    var global_lang = 'zh_CN';
    var sessionInit = '';
    var isShowNotice = null;
    var CLeftTicketUrl = 'leftTicket/query';
    var isTestFlow = 'N';
    var isMobileCheck = 'N';
    /*]]>*/
  </script>
  <script src="/js/common_js.js?scriptVersion=1.8813" type="text/javascript"></script>
  <!-- js i18n -->
  <!-- jquery validation i18n -->
  <!-- head and footer -->
  <title>车票预订 | 客运服务 | 铁路客户服务中心</title>
  <style>
    .tdclass{
      color:#333;
    }
    .tdh1{
      font-family: "微软雅黑", "黑体";
      font-size: 15px;;
    }
  </style>
  <!-- 双日历 -->
</head>
<body><!--header start-->
<div class="header"><div class="header-bd"><a href="http://www.12306.cn/"><h1 class="logo">中国铁路客户服务中心-客运中心</h1>
</a>
  <div class="login-info"><div class="phone-link"><a href="/otn/appDownload/init" target="true">手机版</a>
  </div>
    <div class="menu">
      <div class="menu-list"><b></b>
      </div>
    </div>
<span class="login-txt" style="color: #666666">
</span>
  </div>
  <div class="nav">
    <ul>
    <li><a href="/index">客运首页</a>
  </li>
    <li id="selectYuding"><a href="/show">车票预订</a>
    </li>
  </ul>
  </div>
</div>
</div>
<!--header end-->
<!--页面主体  开始-->
<div class="content"><div style="display: none">
</div>
  <div id="jplayerId" style="display: none"></div>
  <!--步骤 开始-->
  <!--车票搜索框 开始-->
  <div class="sear-sel" id="sear-sel"><div id="date_range" class="sear-sel-hd clearfix"><ul></ul>
    <div class="clear"></div>
  </div>
    <div class="sear-sel-bd quick-buy-sel quick-buy-open" id="sear-sel-bd" style="height: 17px">
      <div class="pos-top" style="margin-right:20px;">发车时间：
        <select class="select-small" id="cc_start_time"><option value="00002400">00:00--24:00</option>
          <option value="00000600">00:00--06:00</option>
          <option value="06001200">06:00--12:00</option>
          <option value="12001800">12:00--18:00</option>
          <option value="18002400">18:00--24:00</option>
        </select>
      </div>
      <div class="section clearfix"><div class="section-hd">车次类型：</div>
        <div class="section-bd" id="cc_train_type_btn_all"><span class="btn-all" id="train_type_btn_all">全部</span>
          <ul id="_ul_station_train_code"></ul>
        </div>
      </div>

    </div>
    <!--箭头方向修改<a href="#nogo" class="up"></a>-->
  </div>
  <!--车票搜索框 结束-->
  <div class="sear-result" id="sear-result">
    <p><!-- 显示查询统计结果 -->
    </p>
  </div>
  <div class="t-list" id="t-list"><table>
    <thead><tr class="th" id="float">
      <th width="90" colspan="1" rowspan="1">车次</th>
    <th width="100" colspan="1" rowspan="1">出发站</th>
      <th width="100" colspan="1" rowspan="1">出发时间</th>
      <th width="100" colspan="1" rowspan="1">到达站</th>
      <th width="100" colspan="1" rowspan="1">到达时间</th>
    <th width="150" colspan="1" rowspan="1">历时
    </th>
    <th class="last" colspan="1" rowspan="1">备注</th>
  </tr>
  </thead>
    <tbody id="queryLeftTable">
      <tr id="loadimg">
        <td colspan="7" style="background: #f9f9f9">
          <img src="/images/loading.gif" alt=""/>
        </td>
      </tr>
    </tbody>
  </table>

 </div>
</div>
<!--页面主体  结束-->
<!--页面底部  开始-->
<div class="footer"><p><a href="http://www.12306.cn/mormhweb/gljd/gywm" target="true">关于我们</a>
  |<a href="http://www.12306.cn/mormhweb/gljd/wzls/" target="true">网站声明</a>
</p>
  <p>版权所有©2008-2015铁道部信息技术中心&nbsp;&nbsp;中国铁道科学研究院</p>
  <p>京ICP备10009636号</p>
</div>
<script type="text/javascript">
  /*<![CDATA[*/
  var from = "${from}";
  var to  = "${to}";
  var data;
  var tb = document.getElementById("queryLeftTable");
  var sl = [];
  var load = document.getElementById("loadimg");
  window.onload = function(){
    getway();
  }
  function sortByTime(){
    sl = sl.sort(function(a,b){
      if(a == b){
        return 0;
      }
      if(a.usedMinute> b.usedMinute){
        return 1;
      }else{
        return -1;
      }
    });
  }
  function start(){
    var i = 0;
    for(var key in data) {
      if (!data.hasOwnProperty(key)) {
        continue;
      }
      sl[i] = data[key];
      i++;
    }
  }
  function init(){
    sl.forEach(function(e){
      var tr = document.createElement("tr");
      var td1 = document.createElement("td");
      tr.setAttribute("style","background:#fff9a0");
      td1.setAttribute("colspan","7");

      var inner = "<h1 class='tdh1'>从" + e.from + "  &gt;&gt;&gt;  " + e.to;
      var list = e.list;
      inner+="共耗时"+e["usedTime"]+" 预计费用"+ e.cost+"元  等待"+ e.wait+"</h1>";


      var tr1 = document.createElement("tr");
      var td2 = document.createElement("td");
      td2.setAttribute("class","tdclass");
      td2.innerHTML = list[0].traincode;
      tr1.appendChild(td2);
      var td3 = document.createElement("td");
      td3.setAttribute("class","tdclass");
      td3.innerHTML = e.from;
      tr1.appendChild(td3);
      var td4 = document.createElement("td");
      td4.setAttribute("class","tdclass");
      td4.innerHTML = list[0].myStartDate.month+"-"+list[0].myStartDate.date+"   "+list[0].myStartTime;
      tr1.appendChild(td4);
      var td5 = document.createElement("td");
      td5.setAttribute("class","tdclass");
      td5.innerHTML = list[0].keyStation;
      tr1.appendChild(td5);
      var td6 = document.createElement("td");
      td6.setAttribute("class","tdclass");
      td6.innerHTML = list[0].arriveDate.month+"-"+list[0].arriveDate.date+"   "+list[0].arriveTime;
      tr1.appendChild(td6);
      var td6 = document.createElement("td");
      td6.setAttribute("class","tdclass");
      td6.innerHTML = list[0].usedTimeT;
      tr1.appendChild(td6);
      var td7 = document.createElement("td");
      td7.setAttribute("class","tdclass");
      td7.innerHTML = "前往购买";
      tr1.appendChild(td7);


      var tr11 = document.createElement("tr");
      var td21 = document.createElement("td");
      td21.setAttribute("class","tdclass");
      td21.innerHTML = list[1].traincode;
      tr11.appendChild(td21);
      var td31 = document.createElement("td");
      td31.setAttribute("class","tdclass");
      td31.innerHTML = list[1].keyStation;
      tr11.appendChild(td31);
      var td41 = document.createElement("td");
      td41.setAttribute("class","tdclass");
      td41.innerHTML = list[1].startDate.month+"-"+list[1].startDate.date+"   "+list[1].startTime;
      tr11.appendChild(td41);
      var td51 = document.createElement("td");
      td51.setAttribute("class","tdclass");
      td51.innerHTML = e.to;
      tr11.appendChild(td51);
      var td61 = document.createElement("td");
      td61.setAttribute("class","tdclass");
      td61.innerHTML = list[1].myArriveDate.month+"-"+list[1].myArriveDate.date+"   "+list[1].myArriveTime;
      tr11.appendChild(td61);
      var td61 = document.createElement("td");
      td61.setAttribute("class","tdclass");
      td61.innerHTML = list[1].usedTimeF;
      tr11.appendChild(td61);

      var td71= document.createElement("td");
      td71.setAttribute("class","tdclass");
      td71.innerHTML = "前往购买";
      tr11.appendChild(td71);

      td1.innerHTML = inner;
      tr.appendChild(td1);
      tb.appendChild(tr);
      tb.appendChild(tr1);
      tb.appendChild(tr11);
    });
  }
  function getway(){
    $.post("/getway",{"from":from,"to":to},function(v){
      data = v[0];
      start();
      load.style.display = "none";
      sortByTime();
      init();
    },"json");
  }
  /*]]>*/
</script>
</body>
</html>

