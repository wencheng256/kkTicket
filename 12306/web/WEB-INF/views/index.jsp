<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <link href="/css/validation.css" rel="stylesheet" />
  <link href="/css/common_css.css?cssVersion=1.8700" rel="stylesheet" />


  <%--模态框开始--%>
  <!-- Load local jQuery -->
  <script src="/js/libs/jquery-loader.js"></script>

  <!-- Load local QUnit -->
  <link rel="stylesheet" href="/js/libs/qunit/qunit/qunit.css" media="screen">
  <script src="/js/libs/qunit/qunit/qunit.js"></script>

  <!-- Load local lib and tests -->
  <link rel="stylesheet" href="/js/src/remodal.css">
  <link rel="stylesheet" href="/js/src/remodal-default-theme.css">
  <script src="/js/src/remodal.js"></script>
  <style>
    .remodal-overlay.without-animation.remodal-is-opening,
    .remodal-overlay.without-animation.remodal-is-closing,
    .remodal.without-animation.remodal-is-opening,
    .remodal.without-animation.remodal-is-closing,
    .remodal-bg.without-animation.remodal-is-opening,
    .remodal-bg.without-animation.remodal-is-closing {
      animation: none;
    }
    .yanzheng{
      float: left;
      height: 50px;
      margin-left: 20px;
    }
  </style>
  <%--模态框结束--%>


  <script>
    /*<![CDATA[*/
    var ctx='/otn/';
    var globalRepeatSubmitToken = null;
    var global_lang = 'zh_CN';
    var sessionInit = '';
    var isShowNotice = null;
    var CLeftTicketUrl = null;
    var isTestFlow = null;
    var isMobileCheck = null;
    /*]]>*/
  </script>
  <script src="/js/common_js.js?scriptVersion=1.8707" type="text/javascript"></script>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>客运服务 | 铁路客户服务中心</title>
  <!-- 双日历 -->
  <link href="/css/WdatePicker.css" rel="stylesheet" />
  <script type="text/javascript" src="js/WdatePicker.js" xml:space="preserve"></script>
<script src="/js/index_js.js?scriptVersion=1.8707" type="text/javascript" xml:space="preserve"></script>
  <link href="/css/common.css" rel="stylesheet" />
  <link />
  <link href="/css/index_css.css?cssVersion=1.8700" rel="stylesheet" />
</head>
<body><!--header start-->
<div class="remodal-bg">
<div class="header"><div class="header-bd"><a href="http://www.12306.cn/"><h1 class="logo">中国铁路客户服务中心-客运中心</h1>
</a>
  <div class="login-info"><div class="phone-link"><a href="/otn/appDownload/init" target="true">手机版</a>
  </div>
    <div class="menu">
      <div class="menu-list">
      </div>
    </div>
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
<!--公告 开始-->
<!--公告 结束-->
<!--页面主体  开始-->
<div class="content clearfix pt10"><div class="index-side"><!--车票查询框 开始-->
  <div class="layout booking"><div class="lay-hd">车票查询</div>
    <div class="lay-bd"><div class="booking-in"><div class="booking-hd">
    </div>
      <div class="booking-bd"><ul class="clearfix"><li><span class="label">出发地</span>
        <div class="inp-w"><input id="fromStation" type="hidden" value="" name="leftTicketDTO.from_station" />
          <input name="leftTicketDTO.from_station_name" maxlength="15" type="text" id="fromStationText" class="inp-txt" value="" />
          <span id="from_station_imageB" class="i-city"></span>
        </div>
      </li>
        <li><span class="label">目的地</span>
          <div class="inp-w"><input id="toStation" type="hidden" value="" name="leftTicketDTO.to_station" />
            <input name="leftTicketDTO.to_station_name" maxlength="15" type="text" id="toStationText" class="inp-txt" value="" />
            <span id="to_station_imageB" class="i-city"></span>
          </div>
        </li>
        <li class="mt10"><span class="label">出发日</span>
          <div class="inp-w"><input readonly="readonly" maxlength="10" autocomplete="off" type="text" class="inp-txt" name="leftTicketDTO.train_date" id="train_date" value="" />
            <span id="from_imageClick" class="i-date"></span>
          </div>
        </li>
        <li>
        </li>
        <li style="padding-left:80px;">
        </li>
      </ul>
        <span class="i-change" id="change_station"></span>
        <div class="tc"><a href="javascript:testSingle()" class="btn-login" shape="rect">查&nbsp;&nbsp;&nbsp;&nbsp;询</a>
        </div>
      </div>
    </div>
    </div>
  </div>
  <!--车票查询框 结束-->
  <!--出行向导 开始-->
  <div class="layout guide" style="margin-top: 34px;"><div class="lay-hd">出行向导</div>
    <div class="lay-bd"><ul><li><a href="/otn/czxx/init" title="可查询车站经过车次、列车等级、始发站、终到站、区间运行时刻等列车信息。" shape="rect"><span class="img tgcz"></span>
      <span>车站查询</span>
    </a>
    </li>
      <li><a href="/otn/zzzcx/init" title="支持自动搜索中转站或手工输入中转站方式查询，可查询中转站列表，站间车次、区间运行时刻、票价等列车信息。" shape="rect"><span class="img czxx"></span>
        <span>中转查询</span>
      </a>
      </li>
      <li><a title="可查询两站间列车的票价信息。" shape="rect" href="/otn/leftTicketPrice/init"><span class="img zzcx"></span>
        <span>票价查询</span>
      </a>
      </li>
      <li><a href="/otn/zwdch/init" title="可查询未来3小时内列车正晚点信息。" shape="rect"><span class="img zwd"></span>
        <span>正晚点查询</span>
      </a>
      </li>
      <li><a href="/otn/queryAgencySellTicket/init" title="选择省、市、区并点击查询，可查询代售点名称、地址、电话、营业时间等信息。" shape="rect"><span class="img dsd"></span>
        <span>客票代售点</span>
      </a>
      </li>
    </ul>
    </div>
  </div>
  <!--出行向导 结束-->
</div>
  <!--新闻选项卡 开始-->
  <div class="slideTxt"><div class="hd"><ul><li><span>高铁动卧</span>
  </li>
    <li><span>最新动态</span>
    </li>
    <li><a href="/otn/gonggao/help.html" style="color:white" shape="rect"><span>购票常见问题</span>
    </a>
    </li>
    <li><span>使用须知</span>
    </li>
    <li class="end"><span>相关规章</span>
    </li>
  </ul>
  </div>
    <div class="bd"><div id="item_pic" class="item-pic" style="display: block;"><div class="pic-bd"><ul><li style="display: list-item;"><img src="images/new-ad3.png" />
    </li>
    </ul>
    </div>
      <div class="pic-hd"><ul><li class="on">1</li>
      </ul>
      </div>
    </div>
      <ul class="item-txt"><li><span class="num">1</span>
        <div class="info"><a shape="rect" href="/otn/gonggao/t20151030_3844.html">沈阳铁路局关于调整部分旅客列车运行图的公告</a>
        </div>
        <div class="time">
          2015-10-30
        </div>
      </li>
        <li class="bgc"><span class="num">2</span>
          <div class="info"><a shape="rect" href="/otn/gonggao/t20151029_3843.html">广铁集团公司关于2015年11月1日深圳北至广州南间增开部分旅客列车的公告</a>
          </div>
          <div class="time">
            2015-10-29
          </div>
        </li>
        <li><span class="num">3</span>
          <div class="info"><a shape="rect" href="/otn/gonggao/t20151029_3842.html">济南铁路局关于增开周末线旅客列车的公告</a>
          </div>
          <div class="time">
            2015-10-29
          </div>
        </li>
        <li class="bgc"><span class="num">4</span>
          <div class="info"><a shape="rect" href="/otn/gonggao/t20151028_3838.html">昆明铁路局关于调整部分管内旅客列车开行及运行时刻的公告</a>
          </div>
          <div class="time">
            2015-10-28
          </div>
        </li>
        <li><span class="num">5</span>
          <div class="info"><a shape="rect" href="/otn/gonggao/t20151028_3840.html">成都铁路局关于2015年10月29日-11月2日加开部分动车组列车的公告</a>
          </div>
          <div class="time">
            2015-10-28
          </div>
        </li>
        <li class="bgc"><span class="num">6</span>
          <div class="info"><a shape="rect" href="/otn/gonggao/t20151028_3841.html">成都铁路局关于2015年11月3日起加开部分动车组列车及重联运行的公告</a>
          </div>
          <div class="time">
            2015-10-28
          </div>
        </li>
        <li><span class="num">7</span>
          <div class="info"><a shape="rect" href="/otn/gonggao/t20151028_3839.html">成都铁路局关于2015年11月5-23日成都、重庆至西北方向加开部分旅客列车的公告</a>
          </div>
          <div class="time">
            2015-10-28
          </div>
        </li>
        <li class="bgc"><span class="num">8</span>
          <div class="info"><a shape="rect" href="/otn/gonggao/t20151028_3837.html">广铁集团公司关于2015年10月30日至11月9日期间增开部分旅客列车的公告</a>
          </div>
          <div class="time">
            2015-10-28
          </div>
        </li>
        <li><span class="num">9</span>
          <div class="info"><a shape="rect" href="/otn/gonggao/t20151028_3836.html">西安铁路局关于加开杨凌农高会客车的公告</a>
          </div>
          <div class="time">
            2015-10-28
          </div>
        </li>
        <li class="bgc"><span class="num">10</span>
          <div class="info"><a shape="rect" href="/otn/gonggao/t20151027_3835.html">广铁集团公司关于2015年11月2日至11月12日期间广州东至深圳间C7171次、C7172次旅客列车临时停运的公告</a>
          </div>
          <div class="time">
            2015-10-27
          </div>
        </li>
      </ul>
      <ul class="cjwt item-txt"><li><span class="num">1</span>
        <a id="checkIdentity" shape="rect" href="/otn/gonggao/checkIdentity.html?no=1">身份核验结果有哪几种状态？</a>
        <img src="/images/icon_new.png" />
      </li>
        <li class="bgc"><span class="num">2</span>
          <a id="checkIdentity" shape="rect" href="/otn/gonggao/checkIdentity.html?no=2">如何了解自己的身份信息核验结果？</a>
          <img src="/images/icon_new.png" />
        </li>
        <li><span class="num">3</span>
          <a id="checkIdentity" shape="rect" href="/otn/gonggao/checkIdentity.html?no=3">“已通过”的二代身份证注册用户如何添加常用联系人（乘车人）？</a>
          <img src="/images/icon_new.png" />
        </li>
        <li class="bgc"><span class="num">4</span>
          <a id="ticketLost" shape="rect" href="/otn/gonggao/ticketLost.html">购买实名制车票后丢失了怎么办？</a>
        </li>
        <li><span class="num">5</span>
          <a id="onlinePay" shape="rect" href="/otn/gonggao/onlinePay.html?no=16">我在网站购票时，扣款成功但购票不成功怎么办？</a>
        </li>
        <li class="bgc"><span class="num">6</span>
          <a id="onlinePay" shape="rect" href="/otn/gonggao/onlinePay.html?no=17">我在网站购票时不小心重复支付了，重复扣的票款没有及时到帐，怎么办？</a>
        </li>
        <li><span class="num">7</span>
          <a shape="rect" href="/otn/gonggao/endorseAndRefund.html?no=7">我在网站购票又退票后，为什么钱没有及时退还给我的银行卡？</a>
        </li>
        <li class="bgc"><span class="num">8</span>
          <a id="endorseAndRefund" shape="rect" href="/otn/gonggao/endorseAndRefund.html?no=7">我在网站购票又在车站售票窗口改签或退票后，为什么钱没有及时退还给我的银行卡?</a>
        </li>
        <li><span class="num">9</span>
          <a id="changeToPaperTicket" shape="rect" href="/otn/gonggao/changeToPaperTicket.html?no=5">旅客在12306网站购票成功，在窗口取票时为何系统提示错误？</a>
        </li>
        <li class="bgc"><span class="num">10</span>
          <div class="info"><a id="register" shape="rect" href="/otn/gonggao/register.html?no=6">注册时，网站提示“身份信息重复”，怎么办？</a>
          </div>
          <div class="time"><a href="/otn/gonggao/help.html" style="color:#0077FF" shape="rect">更多&gt;</a>
          </div>
        </li>
      </ul>
      <ul class="item-txt"><li><span class="num">1</span>
        <a shape="rect" href="/otn/gonggao/usersNeedToKnow.html?linktypeid=reg">注册新用户</a>
      </li>
        <li class="bgc"><span class="num">2</span>
          <a shape="rect" href="/otn/gonggao/usersNeedToKnow.html?linktypeid=buy">网上购票流程</a>
        </li>
        <li><span class="num">3</span>
          <a shape="rect" href="/otn/gonggao/usersNeedToKnow.html?linktypeid=txt">铁路电子客票</a>
        </li>
        <li class="bgc"><span class="num">4</span>
          <a shape="rect" href="/otn/gonggao/saleTicketMeans.html?linktypeid=means5">身份核验</a>
          <img src="/images/icon_new.png" />
        </li>
        <li><span class="num">5</span>
          <a shape="rect" href="/otn/gonggao/usersNeedToKnow.html?linktypeid=express">铁路车票快递服务须知</a>
          <img src="/images/icon_new.png" />
        </li>
      </ul>
      <ul class="item-txt"><li><span class="num">1</span>
        <a shape="rect" href="/otn/gonggao/saleTicketMeans.html?linktypeid=means1">《铁路互联网售票暂行办法》</a>
      </li>
        <li class="bgc"><span class="num">2</span>
          <a shape="rect" href="/otn/gonggao/saleTicketMeans.html?linktypeid=means2">《铁路旅客运输规程》</a>
        </li>
        <li><span class="num">3</span>
          <a shape="rect" href="/otn/gonggao/saleTicketMeans.html?linktypeid=means3">《铁路互联网购票须知》</a>
        </li>
        <li class="bgc"><span class="num">4</span>
          <a shape="rect" href="/otn/gonggao/saleTicketMeans.html?linktypeid=means4">《铁路旅客运输办理细则》</a>
        </li>
        <li><span class="num">5</span>
          <a shape="rect" href="/otn/gonggao/saleTicketMeans.html?linktypeid=means5">《铁路互联网购票身份核验须知》</a>
          <img src="/images/icon_new.png" />
        </li>
      </ul>
    </div>
  </div>
  <script type="text/javascript" xml:space="preserve">
    jQuery(".slideTxt").slide();
    </script>
  <!--新闻选项卡 结束-->
</div>

<div id="search_div" style="z-index: 1000; position: absolute;"><div id="form_cities"><div id="top_cities">
  操作提示
</div>
  <div id="panel_cities"></div>
  <div id="flip_cities">
    翻页控制区
  </div>
</div>
</div>
<!-- 选择车站下拉框 -->
<div id="choice_div" style="z-index: 2000; position: absolute;"><div id="form_cities2"><div id="panel_cities2"></div>
</div>
</div>
<!--页面底部  开始-->
<div class="footer"><p><a href="http://www.12306.cn/mormhweb/gljd/gywm" target="true">关于我们</a>
  |<a href="http://www.12306.cn/mormhweb/gljd/wzls/" target="true">网站声明</a>
</p>
  <p>版权所有?2008-2015铁道部信息技术中心&nbsp;&nbsp;中国铁道科学研究院</p>
  <p>京ICP备10009636号</p>
</div>
</div>

<!--页面底部  结束-->


<div class="remodal" data-remodal-id="modal">
    <a data-remodal-action="close" class="remodal-close"></a>
  <ul style="margin-left: 100px;">
  <li class="yanzheng"><img src="/randomimage" id="randomimage" alt="验证码"/></li>
  <li class="yanzheng" style="line-height: 30px;"><a href="javascript:changeImage()">看不清</a></li>
  <li class="yanzheng" ><input type="text" id="randinput" style="height: 30px;"/></li>
  <li class="yanzheng"><a class="remodal-confirm" style="height:20px;padding:5px;line-height: 20px;" href="javascript:testRandom()">OK</a></li>
  </ul>
</div>

<div class="remodal" data-remodal-id="modal2"
     data-remodal-options="hashTracking: false,
    closeOnConfirm:false,closeOnCancel:  false, closeOnEscape: false , closeOnOutsideClick: false,
    modifier : without-animation with-test-class">

    <a data-remodal-action="close" class="remodal-close"></a>
    <a data-remodal-action="cancel" class="remodal-cancel" href="#">Cancel</a>
    <a data-remodal-action="confirm" class="remodal-confirm" href="#">OK</a>
</div>

<div  class="remodal" data-remodal-id="modal3">
    <a data-remodal-action="close" class="remodal-close"></a>
</div>

<div class="remodal" data-remodal-id="wait">
    加载时间可能较长，请耐心等待……
</div>
<form action="/show" id="form1" method="post">
  <input type="hidden" name="from" value=""/>
  <input type="hidden" name="to" value=""/>
  <input type="hidden" name="date" value=""/>
</form>


<form action="/way" id="form2" method="post">
  <input type="hidden" name="from" value=""/>
  <input type="hidden" name="to" value=""/>
</form>


<script>
    var send = 0 ;
    function testSingle(){
      window.location.hash = "wait";
        $.post("/issingle",{"from":$("#fromStationText").val(),to:$("#toStationText").val(),date:$("#train_date").val()},function(data){
            if(data.result){
                window.location.hash = "";
                send();
            }else{
                window.location.hash = "modal";
            }
        },"json");
    }

    function send(){
      var f1 = document.getElementById("form1");
      f1.from.value = $("#fromStationText").val();
      console.log(f1.from.value);
      f1.to.value = $("#toStationText").val();
      f1.date.value = $("#train_date").val();
      f1.submit();
    }

    function changeImage(){
        var img = document.getElementById("randomimage");
        img.src="/randomimage?id="+Math.random();
    }
    function testRandom(){
      window.location.hash="wait";
      var i = document.getElementById("randinput");
      $.post("/testRandom",{"randCode": i.value},function(data){
        console.log(data);
        if(data.data.result == 1){
          getCity();
        }else{
          alert("验证码错误，请重新输入");
          window.location.hash = "modal";
        }
      },"json");
    }

    function getCity(){
        if(send >= 2){
          send = 0;
        }
        var cname;
        if(send == 0){
          cname = $("#fromStationText").val();
        }else{
          cname = $("#toStationText").val();
        }
        var i = document.getElementById("randinput");
        $.post("/getcity",{"code": i.value,name:cname,date:$("#train_date").val()},function(data){
          window.location.hash = "";
          if(data.result){
            changeImage();
            send++;
            if(send <2){
              window.location.hash = "modal";
            }else{
              var f2 = document.getElementById("form2");
              f2.from.value = $("#fromStationText").val();
              f2.to.value = $("#toStationText").val();
              f2.submit();
            }
          }
        },"json");
    }
</script>
<script xml:space="preserve">

    var date = new Date();
    var vYear = date.getFullYear();
    var vMon = date.getMonth() + 1;
    var vDay = date.getDate();
    var today=vYear+"-"+vMon+"-"+vDay;
    var studentMindate = '${otherMindate}';
    var studentMaxdate = '${otherMaxdate}';
    var otherMindate = '${otherMindate}';
    var otherMaxdate = '${otherMaxdate}';
    var initTrainDate = '${initTrainDate}';
    var initToDate = '${initToDate}';
    var init_from_date = '${init_from_date}';
    var noticeContent = null;
    var notify_SESSION=null;
</script>
<script type="text/javascript" src="/js/favorite_name.js" xml:space="preserve"></script>
<script type="text/javascript" src="/js/station_name.js" xml:space="preserve"></script>
<script type="text/javascript" src="/js/index_end_js.js" xml:space="preserve"></script>
</body>
</html>
