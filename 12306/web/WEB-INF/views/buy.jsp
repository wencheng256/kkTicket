<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/7
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
    <title></title>
  <script src="/js/jquery.min.js"></script>
  <style>
    *{
      border: 0px;
      margin: 0;
      padding: 0;
    }
    #head{
      height: 75px;
      background: rgba(44, 54, 172, 0.69);
      border-bottom: 5px solid rgba(21, 30, 78, 0.74);
      padding: 20px;
    }
    .buy{
      font-family: "微软雅黑", "黑体";
      font-size: 23px;
      color: #fff;
      margin-left: 20px;
      display: block;
    }
    .select{
      font-size: 15px;
      float: left;
    }
    .sbox{
      float: left;
      margin-left: 10px;;
    }
    .but{
      float: left;
      margin-left: 10px;
    }
  </style>
</head>
<body>
<div id="head">
  <span class="buy">
<c:if test="${multi}">
    购买车次 <span id="traincode"></span>
</c:if>
    从 ${from} 到 ${to} </span>
  <br/>
<c:if test="${multi}">
  <span class="buy select">购买本方案其他列车：</span><select name="" id="selectindex" class="sbox">
</select>
  <button class="but" onclick="changeIndex()">确定</button>
  <span class="buy select">选择其他方案：</span><select name="" id="selectplan" class="sbox">
  </select>
  <button class="but" onclick="changePlan()">确定</button>
</c:if>
</div>
<iframe frameborder="0" height="100%" width="100%" style="" name="frame">

</iframe>

<form action="https://kyfw.12306.cn/otn/leftTicket/init" id="form1" target="frame">
  <input type="hidden" name="flag" value="dc"/>
  <input type="hidden" name="leftTicketDTO.from_station_name" value=""/>
  <input type="hidden" name="leftTicketDTO.to_station_name" value=""/>
  <input type="hidden" name="leftTicketDTO.from_station" value=""/>
  <input type="hidden" name="leftTicketDTO.to_station" value=""/>
  <input type="hidden" name="leftTicketDTO.train_date" value=""/>
  <input type="hidden" name="pre_step_flag" value="index"/>
  <input type="hidden" name="purpose_code" value="ADULT"/>
</form>

<script type="application/javascript">
  var from = "${from}";
  var to = "${to}"
  var train = "${train}";
  var date = "${date}";
  var index = ${index};
  var multi = ${multi};
  var fc = "${fromCode}";
  var tc = "${toCode}";
  var s = document.getElementById("traincode");
  var si = document.getElementById("selectindex");
  var sp = document.getElementById("selectplan");
  var f1 = document.getElementById("form1");

  var da;

  var gf;
  var gt;
  var gfc;
  var gtc;
  var gdate;

  function getPage(){

    f1["leftTicketDTO.train_date"].value = gdate;
    f1["leftTicketDTO.from_station_name"].value = gf;
    f1["leftTicketDTO.to_station_name"].value = gt;
    f1["leftTicketDTO.from_station"].value = gfc;
    f1["leftTicketDTO.to_station"].value = gtc;
    f1.submit();
  }

  function getStationCode(station){
    var re = null;
    $.ajax({
      method:"post",
      url:"/getstationcode",
      data:{"station":station},
      success:function(data){
        re = data["result"];
      },
      async:false,
      dataType:"json"
    });
    return re;
  }

  function load(){



    if(multi){
      sp.innerHTML = "";
      si.innerHTML = "";
      $.post("/getway",{from:from,to:to,date:date},function(data){
        da = data;
        s.innerHTML = data[0][train].list[index].traincode;
        for(key in data[0]){
          if(data[0].hasOwnProperty(key)){
            var e = data[0][key];
            var op = document.createElement("option");
            op.innerHTML = key+"共耗时"+e["usedTime"]+" 预计费用"+ e.cost+"元  等待"+ e.wait;
            op.value = key;
            if(train == key){
              op.selected = true;
            }
            sp.appendChild(op);
          }
        }
        data[0][train].list.forEach(function(data,i){
          var op1 = document.createElement("option");
          op1.innerHTML = data.traincode;
          op1.value = i;
          if(index == i){
            op1.selected = true;
          }
          si.appendChild(op1);
        });
        if(index == 0){
          gf = from;
          gfc = fc;
          gt =   data[0][train].list[0].keyStation;
          gtc = getStationCode(gt);
          var d = data[0][train].list[0].startDate;
          gdate = (1900+d.year)+"-"+(d.month+1)+"-"+d.date;
        }else{
          gf = data[0][train].list[1].keyStation;;
          gfc =  getStationCode(gf);;
          gt =   to;
          gtc = tc;
          var d = data[0][train].list[0].startDate;
          gdate = (1900+d.year)+"-"+(d.month+1)+"-"+d.date;
        }
        getPage();

      },"json")
    }else{
      gf = from;
      gt = to;
      gfc = getStationCode(from);
      gtc = getStationCode(to);
      gdate = date;
      getPage();
    }
  }
  function changeIndex(){
    index = $("#selectindex").val();
    load();
  }
  function changePlan(){
    train = $("#selectplan").val();
    index = 0;
    load();
  }
  window.onload = function(){
    load();
  }
</script>
</body>
</html>
