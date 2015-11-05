<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/3
  Time: 20:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
  <!-- 双日历 -->
  <link href="/css/WdatePicker.css" rel="stylesheet" />
  <script type="text/javascript" src="/js/WdatePicker.js" xml:space="preserve"></script>
<script src="/js/data.jcokies.js" type="text/javascript" xml:space="preserve"></script>
<script src="/js/queryLeftTicket_js.js?scriptVersion=1.8813" type="text/javascript" xml:space="preserve"></script>
  <link href="/css/queryLeftTicket_css.css?cssVersion=1.8801" rel="stylesheet" />
  <script src="/js/jquery.bgiframe.mi.js" type="text/javascript" xml:space="preserve"></script>
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
<div id="dialog_smoker" style="display: none;"><div class="mark"></div>
  <div class="up-box w600"><div class="up-box-hd">温馨提示<a href="javascript:" id="dialog_smoker_close" shape="rect">关闭</a>
  </div>
    <div class="up-box-bd"><div class="up-con clearfix"><span class="icon i-opt"></span>
      <div class="r-txt"><div class="tit" id="dialog_smoker_msg"></div>
      </div>
    </div>
      <div class="lay-btn"><a href="javascript:" id="dialog_smoker_cancel" class="btn92" shape="rect">取消</a>
        <a href="javascript:" id="dialog_smoker_ok" class="btn92s" shape="rect">确定</a>
      </div>
    </div>
  </div>
</div>
<!--header end-->
<div id="608_complain" style="display: none;"><div class="mark"></div>
  <div class="up-box" style="width:640px;"><div class="up-box-hd">举报告知确认书<a href="javascript:" id="608_complain_close" shape="rect">关闭</a>
  </div>
    <div class="up-box-bd" style="padding:15px 10px;border:1px solid #298CCE;"><table class="per-ticket" style="margin-left:0px;"><tr><td rowspan="1" colspan="1">举报人姓名：<strong id="608_name" style="font-size:20px"></strong>
    </td>
      <td rowspan="1" colspan="1">联系电话：<strong id="608_tel" style="font-size:20px"></strong>
      </td>
    </tr>
      <tr><td colspan="2" rowspan="1">身份证件号码：<strong id="608_card" style="font-size:20px"></strong>
      </td>
      </tr>
      <tr></tr>
      <tr><td colspan="2" rowspan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本人确认举报身份信息被他人冒用购买<strong id="ticketInfo" style="font-size:20px"></strong>
        次车票。本人承诺本次举报及购票所提交的身份信息属实，并对虚假举报后果负责。</td>
      </tr>
      <tr><td colspan="2" rowspan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;铁路部门郑重提醒，将在车站和列车对该车票进行重点查验。根据国务院颁布的《铁路安全管理条例》，对该车票所记载身份信息与所持身份证件或者真实身份不符的持票人，铁路部门将拒绝其进站乘车。同时，公安机关将依法调查。</td>
      </tr>
      <tr><td colspan="2" rowspan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;铁路部门将对您的举报信息保密，谢谢您的合作！</td>
      </tr>
    </table>
      <div class="lay-btn"><a href="javascript:" id="608_complain_cancel" class="btn92" shape="rect">取消</a>
        <a href="javascript:" id="608_complain_ok" class="btn92s" shape="rect">确认举报</a>
      </div>
    </div>
  </div>
</div>
<div id="608_check" style="display: none;"><div class="mark"></div>
  <div class="up-box"><div class="up-box-hd">温馨提示<a href="javascript:" id="608_check_close" shape="rect">关闭</a>
  </div>
    <div class="up-box-bd"><div class="up-con clearfix"><span class="icon i-opt"></span>
      <div class="r-txt"><div class="tit" id="608_check_msg"></div>
        <div class="tit" style="color:#FB7403">是否举报？</div>
      </div>
    </div>
      <div class="lay-btn"><a href="javascript:" id="608_check_cancel" class="btn92" shape="rect">取消</a>
        <a href="javascript:" id="608_check_ok" class="btn92s" shape="rect">网上举报</a>
      </div>
    </div>
  </div>
</div>
<!--页面主体  开始-->
<div class="content"><div style="display: none">
</div>
  <div id="jplayerId" style="display: none"></div>
  <!--步骤 开始-->
  <!--车票搜索框 开始-->
  <div class="sear-box quick-sear-box"><form id="queryLeftForm" method="get" enctype="application/x-www-form-urlencoded"><div class="dfc" id="dfc"><ul>
  </ul>
  </div>
    <div class="s-info" id="place_area"><ul><li><span class="label"><label id="fromStationText_label">出发地</label>
</span>
      <div class="inp-w"><input id="fromStation" type="hidden" value="SHH" name="leftTicketDTO.from_station" />
        <input type="text" id="fromStationText" class="inp-txt" value="上海" name="leftTicketDTO.from_station_name" />
        <span class="i-city" id="fromStation_icon_image"></span>
      </div>
    </li>
      <li class="i-change i-change2" id="change_station" style="background-position:-67px -96px"></li>
      <li><span class="label"><label id="toStationText_label"> 目的地</label>
</span>
        <div class="inp-w"><input id="toStation" type="hidden" value="TJP" name="leftTicketDTO.to_station" />
          <input type="text" id="toStationText" class="inp-txt" value="天津" name="leftTicketDTO.to_station_name" />
          <span class="i-city" id="toStation_icon_image"></span>
        </div>
      </li>
      <li><span class="label"> 出发日</span>
        <div class="inp-w" style="z-index:1200"><input type="text" class="inp-txt" name="leftTicketDTO.train_date" id="train_date" value="2013-06-07 周五" readonly="readonly" />
          <!--	<div id="train_date_" style="position: absolute; height: 250px;z-index:1200;left:0; top:30px;"></div>-->
          <span id="date_icon_1" class="i-date"></span>
        </div>
        <!--<div class="inp-w">
								<input th:value="${train_date}" type="text" class="inp-txt" name="leftTicketDTO.train_date" id="train_date"
									value="2013-06-07 周五" readonly="readonly"></input> <span id="date_icon_1" class="i-date"></span>
							</div>-->
      </li>

    </ul>
    </div>
    <div class="quick-s"><ul>
    </ul>
      <div class="btn-area" style="margin-top: 15px;height: 30px;"><a href="javascript:load()" id="query_ticket" class="btn92s btn-disabled" shape="rect">查询</a>
        <div>
        </div>
      </div>
    </div>
  </form>
  </div>
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
  <div class="sear-result" id="sear-result"><span class="fr"><input type="checkbox" class="check" id="avail_ticket" />
<label for="">显示全部可预订车次
</label>
</span>
    <p><!-- 显示查询统计结果 -->
    </p>
  </div>
  <div class="t-list" id="t-list"><table>
    <thead><tr class="th" id="float"><th width="90" colspan="1" rowspan="1">车次</th>
    <th width="100" colspan="1" rowspan="1">出发站<br clear="none" />
      到达站</th>
    <th width="82" colspan="1" rowspan="1" id="startendtime"></th>
    <th width="82" colspan="1" rowspan="1"><span class="b3" id="l_s">历时</span>
    </th>
    <th width="49" colspan="1" rowspan="1">商务座</th>
    <th width="49" colspan="1" rowspan="1">特等座</th>
    <th width="49" colspan="1" rowspan="1">一等座</th>
    <th width="49" colspan="1" rowspan="1">二等座</th>
    <th width="49" colspan="1" rowspan="1">高级<br clear="none" />
      软卧</th>
    <th width="49" colspan="1" rowspan="1">软卧</th>
    <th width="49" colspan="1" rowspan="1">硬卧</th>
    <th width="49" colspan="1" rowspan="1">软座</th>
    <th width="49" colspan="1" rowspan="1">硬座</th>
    <th width="49" colspan="1" rowspan="1">无座</th>
    <th width="49" colspan="1" rowspan="1">其他</th>
    <th class="last" colspan="1" rowspan="1">备注</th>
  </tr>
  </thead>
    <tbody id="queryLeftTable">
    </tbody>
  </table>

    <div class="t-list-bd" id="t-list-bd"><div class="no-ticket" id="no_filter_ticket" style="display: none"><span class="i-no"></span>
      <p><!-- 没有符合筛选条件的车次，请修改筛选条件！<br />您可以<a href="#" id="show_all_query_result">显示全部</a>或<a href="/otsweb/zzzcx/init">使用中转查询功能</a>查询换乘车次。-->


        没有符合筛选条件的车次，请修改筛选条件<br clear="none" />
        或<a href="#" id="show_all_query_result" shape="rect">显示全部车次</a>
        ！
      </p>
    </div>
      <div class="no-ticket" id="no_filter_ticket_3" style="display: none"><span class="i-no"></span>
        <p>
          没有查询到符合条件的车次，5秒后继续查询，请稍后！
        </p>
      </div>
      <div class="no-ticket" id="no_filter_ticket_4" style="display: none"><span class="i-no"></span>
        <p>
          没有符合筛选条件的车次，5秒后开始查询备选日期，请稍后！
        </p>
      </div>
    </div>
  </div>
  <div class="no-ticket" id="no_filter_ticket_2" style="display: none"><span class="i-no"></span>
    <p>
      很抱歉，按您的查询条件，当前未找到从<span id="no_filter_ticket_fromstation"></span>
      到<span id="no_filter_ticket_tostation"></span>
      的列车。您可以使用出行向导中的<a href="/otn/zzzcx/init" shape="rect">中转查询功能</a>
      查询换乘车次。
    </p>
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
<!-- 检索车站下拉框 -->
<div id="search_div" style="z-index: 1000; position: absolute;"><div id="form_cities"><div id="top_cities">操作提示</div>
  <div id="panel_cities"></div>
  <div id="flip_cities">翻页控制区</div>
</div>
</div>
<!-- 选择车站下拉框 -->
<div id="choice_div" style="z-index: 2000; position: absolute;"><div id="form_cities2"><div id="panel_cities2"></div>
</div>
</div>
<!--页面底部  结束-->
<!-- 选择乘车人 -->
<div class="quick-box sel-buyer" id="sel-buyer" style="display:none;"><div class="quick-box-hd"><a href="javascript:" onclick="$.closeSelectBuyer()" shape="rect">关闭</a>
  常用联系人</div>
  <div class="quick-box-bd" id="pContent"><div class="sel-buyer-top"><div class="s-box"><input type="text" value="输入乘客姓名" class="txt" id="searchPassenger" />
    <input type="submit" class="sub" />
  </div>
    <span class="red">（您可以从下表中选择乘车人，最多5人）</span>
    <a href="javascript:" class="fr" id="reloadPassenger" shape="rect">刷新</a>
  </div>
    <div class="sel-buyer-con"><ul id="buyer-list"></ul>
    </div>
  </div>
</div>
<!-- 选择乘车人结束 -->
<!-- 选择优先席别 -->
<div class="quick-box sel-rank" id="sel-seat" style="display:none;width:350px;"><div class="quick-box-hd"><a href="javascript:" onclick="$.closeSelectSeat()" shape="rect">关闭</a>
  选择席别（最多选择五个优先席别）</div>
  <div class="quick-box-bd" id="seat-list"><ul style="float:left; width:330px;"><li class="color333"><input type="checkbox" class="check" value="SWZ" name="商务座" />
    <label for="">商务座</label>
  </li>
    <li class="color333"><input type="checkbox" class="check" value="TZ" name="特等座" />
      <label for="">特等座</label>
    </li>
    <li class="color333"><input type="checkbox" class="check" value="ZY" name="一等座" />
      <label for="">一等座</label>
    </li>
    <li class="color333"><input type="checkbox" class="check" value="ZE" name="二等座" />
      <label for="">二等座</label>
    </li>
  </ul>
    <ul style="float:left; width:330px;"><li class="color333"><input type="checkbox" class="check" value="GR" name="高级软卧" />
      <label for="">高级软卧</label>
    </li>
      <li class="color333"><input type="checkbox" class="check" value="RW" name="软卧" />
        <label for="">软卧</label>
      </li>
      <li class="color333"><input type="checkbox" class="check" value="YW" name="硬卧" />
        <label for="">硬卧</label>
      </li>
      <li class="color333"><input type="checkbox" class="check" value="SRRB" name="动卧" />
        <label for="">动卧</label>
      </li>
    </ul>
    <ul style="float:left; width:330px;"><li class="color333"><input type="checkbox" class="check" value="YYRW" name="高级动卧" />
      <label for="">高级动卧</label>
    </li>
      <li class="color333"><input type="checkbox" class="check" value="RZ" name="软座" />
        <label for="">软座</label>
      </li>
      <li class="color333"><input type="checkbox" class="check" value="YZ" name="硬座" />
        <label for="">硬座</label>
      </li>
      <li class="color333"><input type="checkbox" class="check" value="WZ" name="无座" />
        <label for="">无座</label>
      </li>
    </ul>
  </div>
</div>
<!-- 选择优先席别结束 -->
<!-- 选择优先日期-->
<div class="quick-box sel-rank" id="sel-date" style="display:none;"><div class="quick-box-hd"><a href="javascript:" onclick="$.closeSelectDate()" shape="rect">关闭</a>
  选择日期（最多选择5个备选日期）</div>
  <div class="quick-box-bd">
  </div>
</div>
<!-- 选择优先席别结束 -->
<!-- 快捷购票提示信息 -->
<div class="quick-tips" id="showquick1" style="display: none;width:200px;z-index:4000;"><span style="line-height:22px; color:#666;">选中后，在点击“查询”按钮时，系统将按您设置的查询条件自动、持续查询车票。当查询到满足条件的车票时，查询将自动停止。</span>
</div>
<div class="quick-tips" id="showquick2" style="display: none"><!--<span style="line-height:22px; color:#666;">闪购高级选项。选中后，“自动提交”默认选中，当系统查询到满足闪购选项的车票但票额少于选定的乘车人时，允许系统按票额数量忽略排在后面的乘车人，自动提交订单。</span> -->
  <span style="line-height:22px; color:#666;">如果网站查询同一车次只有部分符合您设定条件的车票时，将按您设定的乘车人和席别优先顺序进行提交。</span>
</div>
<div class="quick-tips" id="showquick3" style="display: none;"><!-- <span style="line-height:22px; color:#666;">闪购高级选项。选中后，在点击“查询”按钮时系统将自动、持续查询车票，并在查询到满足闪购选项的车票时自动提交订单。</span>-->
  <span style="line-height:22px; color:#666;">勾选本选项并点击查询后，网站将自动查询符合设定条件的车票信息，如有符合条件的车次，将自动提交订单信息。</span>
</div>
<div class="quick-tips" id="showquick4" style="display: none"><span style="line-height:22px; color:#666;">您可以从常用联系人中选择最多5个乘车人，网站将按您设定的先后顺序自动选择。</span>
</div>
<div class="quick-tips" id="showquick6" style="display: none"><span style="line-height:22px; color:#666;">您可以设定最多5个席别，网站将根据您设定的席别先后顺序和同一车次的余票情况自动选择。</span>
</div>
<div class="quick-tips" id="showquick5" style="display: none"><span style="line-height:22px; color:#666;">您可以设定最多5个车次，网站将根据您设定的车次先后顺序和同一车次的余票情况自动选择。</span>
</div>
<div class="quick-tips" id="showquick8" style="display: none"><span style="line-height:22px; color:#666;">您可以在当前日期外另行设定最多5个出发日，网站将根据您设定的先后顺序和余票情况自动选择。</span>
</div>
<div id="getTicket" style="display: none;margin-right: 1px;margin-bottom: 1px;height: 140px"><div class="mark" style="height: 20px"></div>
  <div class="up-box" style="height: 140px"><div class="up-box-hd">恭喜您，查到有票车次了<a href="javascript:$jpopup.startOrHiden()" shape="rect">关闭</a>
  </div>
    <div class="up-box-bd" style="height: 140px"><div class="tit" id="filterRes"></div>
      <div class="lay-btn" style="margin-left: -245px"><a href="javascript:" class="btn92s" id="showOnlyTicA" shape="rect">仅显示选定车次</a>
        <a href="javascript:$jpopup.startOrHiden()" class="btn92" shape="rect">关闭</a>
      </div>
    </div>
  </div>
</div>
<!-- 快捷购票提示信息结束 -->
<!-- 提交订单核对车票信息弹出层 start -->
<div id="autosubmitcheckticketinfo" style="display: none; top:600px;left:200px;"><div class="mark"></div>
  <div class="up-box w664" id="content_autosubmitcheckticketinfo"><div class="up-box-hd">
    已查到车票，请核对以下信息
  </div>
    <div class="up-box-bd ticket-check"><h3>车次信息</h3>
      <div class="info2" id="autosubmit_check_ticket_tit"></div>
      <h3>乘车人信息</h3>
      <table class="table-a"><tr><th width="28" rowspan="1" colspan="1">序号</th>
        <th rowspan="1" colspan="1">席别</th>
        <th rowspan="1" colspan="1">票种</th>
        <th rowspan="1" colspan="1">姓名</th>
        <th rowspan="1" colspan="1">证件类型</th>
        <th rowspan="1" colspan="1">证件号码</th>
        <th rowspan="1" colspan="1">手机号码</th>
      </tr>
        <tbody id="autosubmit_check_ticketInfo"></tbody>
      </table>
      <p id="sy_ticket_num_id"><!--  尊敬的旅客，本次列车您选择的席别尚有余票<strong>1135</strong>张，无座<strong>840</strong>张。特此提醒。<br /> 请确认信息是否正确。如正确请点击“确定”，系统将为您分配席位。-->
      </p>
      <p><span id="leftTicketOrderNote" class="colorA">输入验证码后自动提交</span>
      </p>
      <ul><li id="mypasscode2" data-code_type="passenger" data-touclick-type="float" data-sucess-callback="sucessCallback" style="display: none"><!--要引入的验证码标签 -->
      </li>
      </ul>
      <!--
                      //inside: class="lay-btn  captchaButton leftTicket-autoSubmit-button-inside"
                      //float: class="lay-btn captchaButton captchaFloatButton leftTicket-autoSubmit-button-float"
                      -->
      <div class="lay-btn captchaButton captchaFloatButton leftTicket-autoSubmit-button-float" data-touclick-name="other"><a id="back_edit" href="javascript:" class="btn92" shape="rect">返回修改</a>
        <a href="javascript:" class="btn92s captchaFloatTargetButton" data-touclick-name="other" id="qr_submit" shape="rect">确认</a>
      </div>
    </div>
  </div>
</div>
<!-- 提交订单核对车票信息弹出层 end -->
<!-- 交易提示框 start  -->
<div id="transforNotice_id" style="display: none; margin-left: 30%; margin-top: 30%;"><div class="mark"></div>
  <div class="up-box" id="content_transforNotice_id"><div class="up-box-hd" id="up-box-hd_id"><!--  <a id="closeTranforDialog_id" style="display: none;" href="javascript:">关闭</a>-->


    提示



  </div>
    <div class="up-box-bd"><div class="up-con clearfix"><span class="icon i-work" id="iamge_status_id"></span>
      <div class="r-txt" id="orderResultInfo_id"><!--  信息提示 -->
      </div>
    </div>
      <div class="lay-btn" id="lay-btn_id"><!-- <a href="javascript:" id="qr_closeTranforDialog_id" style="display: none;" class="btn92s">确认</a> -->
      </div>
    </div>
  </div>
</div>
<!-- 用户未登录弹出登录层 -->
<div id="relogin" style="display: none; z-index: 100px;margin: 0px auto 110px;"><div class="mark"></div>
  <div class="up-box up-box-login" id="content"><div class="up-box-hd">请登录<a id="relogin_close" href="javascript:" shape="rect">关闭</a>
  </div>
    <form id="loginForm" method="get" enctype="application/x-www-form-urlencoded"><div class="up-box-bd"><div class="login"><ul><li><span class="formCont" style="float: left;"><span class="label">登录名：</span>
<input id="username" name="loginUserDTO.user_name" type="text" class="inptxt w200" tabindex="1" />
</span>
    </li>
      <li><span class="formCont" style="float: left;"><span class="label">密码：</span>
<input id="password" name="userDTO.password" type="password" class="inptxt w200" tabindex="2" />
<a href="javascript:" id="forget_my_password_id" shape="rect">忘记用户名/密码？</a>
</span>
      </li>
      <li id="mypasscode1" data-code_type="login" data-touclick-type="inside" data-page-identity="leftTicket-login" style="display: none"><!--要引入的验证码标签 -->
        <script>var targettype=['Z','Z'];var targetdiv=['mypasscode1','mypasscode2'];var targetelement=['','other'];</script>
        <script src="/js/new.js" xml:space="preserve"></script>
      </li>
      <!--
                              //inside: class="dl  captchaButton leftTicket-login-button-inside"
                              //float: class="dl  captchaButton captchaFloatButton leftTicket-login-button-float"
                              -->
      <li class="dl  captchaButton leftTicket-login-button-float" data-touclick-name="" style="margin-top:6px"><a href="javascript:" class="btn200s" id="loginSubAsyn" tabindex="4" shape="rect">登录</a>
      </li>
      <li class="zc"><a href="/otn/regist/init" class="btn200" shape="rect">快速注册</a>
      </li>
      <li class="txt" style="height:4px"></li>
      <li style="margin-top: -4px;"><span><h2 style="height: 25px;line-height: 25px;font-size: 14px;">温馨提示：</h2>
</span>
      </li>
      <li style="margin-top: -12px;line-height: 20px;color: #666666"><span>1、12306.cn网站每日07:00~23:00提供服务</span>
      </li>
      <li style="margin-top: -12px;line-height: 20px;color: #666666"><span>2、在12306.cn网站购票、改签和退票须不晚于开车前30分钟；办理“变更到站”业务时，请不晚于开车前48小时。</span>
      </li>
    </ul>
    </div>
    </div>
    </form>
  </div>
</div>
<!-- 用户未登录弹出层 end -->
<form id="_es_hiddenform" method="post" enctype="application/x-www-form-urlencoded"><input type="hidden" name="_json_att" value="" />
</form>
<div class="station" style="display:none;" id="train_stop"><b></b>
  <div class="station-info" id="stationinfo"></div>
  <div class="station-hd"><span class="zx">站序</span>
    <span class="zm">站名</span>
    <span class="dzsj">到站时间</span>
    <span class="cfsj">出发时间</span>
    <span class="tlsj">停留时间</span>
    <a class="close" title="关闭" href="##" onclick="closeTrainStop()" shape="rect"></a>
  </div>
  <div class="station-bd"><table><tbody id="train_table"></tbody>
  </table>
  </div>
</div>
<div id="floatTable" class="t-list" style="display: none;width: 978px;">
  <table>
    <tr class="th">
      <th width="90" rowspan="1" colspan="1">车次</th>
  <th width="100" rowspan="1" colspan="1"><div class="two-line"><span>出发站</span>
    <br clear="none" />
    <span>到达站</span>
  </div>
  </th>
  <th width="82" rowspan="1" colspan="1"><div class="two-line" id="floatstartendtime"></div>
  </th>
  <th width="82" rowspan="1" colspan="1"><span class="b3" id="other_span_lishi">历时</span>
  </th>
  <th width="49" rowspan="1" colspan="1">商务座</th>
  <th width="49" rowspan="1" colspan="1">特等座</th>
  <th width="49" rowspan="1" colspan="1">一等座</th>
  <th width="49" rowspan="1" colspan="1">二等座</th>
  <th width="49" rowspan="1" colspan="1">高级<br clear="none" />
    软卧</th>
  <th width="49" rowspan="1" colspan="1">软卧</th>
  <th width="49" rowspan="1" colspan="1">硬卧</th>
  <th width="49" rowspan="1" colspan="1">软座</th>
  <th width="49" rowspan="1" colspan="1">硬座</th>
  <th width="49" rowspan="1" colspan="1">无座</th>
  <th width="49" rowspan="1" colspan="1">其它</th>
  <th class="last" rowspan="1" colspan="1">备注</th>
</tr>

</table>
</div>



</body>
</html>
<script type="text/javascript" src="/js/station_name.js?station_version=1.8801" xml:space="preserve"></script>
<script type="text/javascript" src="/js/favorite_name.js" xml:space="preserve"></script>
<script type="text/javascript" src="/js/queryLeftTicket_end_js.js?scriptVersion=1.8813" xml:space="preserve"></script>

<script xml:space="preserve">
    /*<![CDATA[*/

    var from_station = '${from}';
    var from_station_name = '\u4E0A\u6D77';
    var to_station = '${to}';
    var to_station_name = '\u5929\u6D25';
    var trainDate = '2015-11-03';
    var tb = document.getElementById("queryLeftTable");

    window.onload = function(){
      load();
    };
    function cload(){

    }
    function load(){
      $.post("/loadway",{"from":from_station,"to":to_station,"date":"2015-11-04"},function(data){
        data = data.data;
        console.log(data);

        for(var i = 0; i<data.length; i++){
          var tr = document.createElement("tr");

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.station_train_code;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.from_station_name+"<br/>"+data[i].queryLeftNewDTO.to_station_name;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.start_time+"<br/>"+data[i].queryLeftNewDTO.arrive_time;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.lishi;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.swz_num;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.tz_num;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.zy_num;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.ze_num;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.gr_num;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.rw_num;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.yw_num;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.rz_num;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.yz_num;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.wz_num;
          console.log(data[i]);
          tr.appendChild(td1);

          var td1 = document.createElement("td");
          td1.innerHTML = data[i].queryLeftNewDTO.qt_num;
          console.log(data[i]);
          tr.appendChild(td1);

          tb.appendChild(tr);
        }
      },"json");
    }
    //为了国际化，需要定义后台获取的字符串
    $.views.helpers({
      buttonText : function() {
        return '\u9884\u8BA2';
      }
    });
    $.views.helpers({
      isNum : function(value) {
        //alert(value);
        return parseInt(value);
      }
    });
    $.views.helpers({
      changeLiShi : function(value) {
        if (value.substring(0,1) == "0") {
          if (value.substring(1,2) == "0") {
            if (value.substring(3,4) == "0") {
              value = value.substring(4,5) + "分";
            } else {
              value = value.substring(3,5) + "分";
            }
          } else {
            value = value.substring(1,2) + "小时" + value.substring(3,5) + "分";
          }
        } else {
          if (value.substring(3,5) == "00") {
            value = value.substring(0,2) + "小时";
          } else {
            value = value.substring(0,2) + "小时" + value.substring(3,5) + "分";;
          }
        }
        return value;
      }
    });
    $.views.helpers({
      changeArriveDate : function(value1, value2) {
        value1 = value1.replace(":", "");
        value2 = value2.replace(":", "");
        hour_value = Number(value1.substring(0,2)) + Number(value2.substring(0,2));
        min_value = Number(value1.substring(2,4)) + Number(value2.substring(2,4));
        if (min_value >= 60) {
          hour_value = hour_value + 1;
        }
        if (hour_value >= 24 && hour_value < 48) {
          return "次日";
        } else if(hour_value >= 48 && hour_value < 72) {
          return "两日";
        } else if(hour_value >= 72) {
          return "三日";
        } else {
          return "当日";
        }
      }
    });

    var backTrainDate = '2015-11-03';
    var page_show_flag = 'index';
    var purposeCodeFromIndex = 'ADULT';
    var roundReferTime = null;
    var studentMindate='2015-11-03';
    var studentMaxdate='2016-01-01';
    var otherMindate = '2015-11-03';
    var otherMaxdate = '2016-01-01';
    // 日期范围传参

    var init_minPeriod = '2015-11-03';
    var init_maxPeriod = '2016-01-01';

    var back_train_date = null;
    // 客运首页进入传参

    var index_to_station = null;

    var index_train_date = null;

    // 学生票传参，用于判断
    var stu_start_train_date = '2015-06-01 00:00:00&2015-12-01 00:00:00&2016-01-02 00:00:00';
    var stu_end_tain_date = '2015-09-30 00:00:00&2015-12-31 00:00:00&2016-03-31 00:00:00';
    var stu_buy_date = '2015-11-03&2016-01-01';
    var other_buy_date = '2015-11-03&2016-01-01';

    // 旅程类型传参，用于判断跳转
    var train_tour_flag = 'index';
    var tour_flag='dc';
    var dateArr =['11-03','11-04','11-05','11-06','11-07','11-08','11-09','11-10','11-11','11-12','11-13','11-14','11-15','11-16','11-17','11-18','11-19','11-20','11-21','11-22','11-23','11-24','11-25','11-26','11-27','11-28','11-29','11-30','12-01','12-02','12-03','12-04','12-05','12-06','12-07','12-08','12-09','12-10','12-11','12-12','12-13','12-14','12-15','12-16','12-17','12-18','12-19','12-20','12-21','12-22','12-23','12-24','12-25','12-26','12-27','12-28','12-29','12-30','12-31','01-01'];
    var fullDateArr =['2015-11-03','2015-11-04','2015-11-05','2015-11-06','2015-11-07','2015-11-08','2015-11-09','2015-11-10','2015-11-11','2015-11-12','2015-11-13','2015-11-14','2015-11-15','2015-11-16','2015-11-17','2015-11-18','2015-11-19','2015-11-20','2015-11-21','2015-11-22','2015-11-23','2015-11-24','2015-11-25','2015-11-26','2015-11-27','2015-11-28','2015-11-29','2015-11-30','2015-12-01','2015-12-02','2015-12-03','2015-12-04','2015-12-05','2015-12-06','2015-12-07','2015-12-08','2015-12-09','2015-12-10','2015-12-11','2015-12-12','2015-12-13','2015-12-14','2015-12-15','2015-12-16','2015-12-17','2015-12-18','2015-12-19','2015-12-20','2015-12-21','2015-12-22','2015-12-23','2015-12-24','2015-12-25','2015-12-26','2015-12-27','2015-12-28','2015-12-29','2015-12-30','2015-12-31','2016-01-01'];
    var otherDateArr = ['2015-11-03','2015-11-04','2015-11-05','2015-11-06','2015-11-07','2015-11-08','2015-11-09','2015-11-10','2015-11-11','2015-11-12','2015-11-13','2015-11-14','2015-11-15','2015-11-16','2015-11-17','2015-11-18','2015-11-19','2015-11-20','2015-11-21','2015-11-22','2015-11-23','2015-11-24','2015-11-25','2015-11-26','2015-11-27','2015-11-28','2015-11-29','2015-11-30','2015-12-01','2015-12-02','2015-12-03','2015-12-04','2015-12-05','2015-12-06','2015-12-07','2015-12-08','2015-12-09','2015-12-10','2015-12-11','2015-12-12','2015-12-13','2015-12-14','2015-12-15','2015-12-16','2015-12-17','2015-12-18','2015-12-19','2015-12-20','2015-12-21','2015-12-22','2015-12-23','2015-12-24','2015-12-25','2015-12-26','2015-12-27','2015-12-28','2015-12-29','2015-12-30','2015-12-31','2016-01-01'];
    var ClickWho =''
    var isstudentDate=true
    var isInMaintenanceHours = false;
    //快捷购票添加
    var passengerAll=null;
    var passengerChecked=[];//已选常用联系人
    var xbChecked=[];//已选席别
    var rqChecked=[];//已选日期
    var ccSelected=[];//已选车次

    var autoSearchTime=5000;
    var noticeContent = null;

    var isSaveQueryLog='Y';

    var other_control=60;
    var stu_control=60;
    var isDwTicketResign='N';
    var canChangeToStation=null;
    /*]]>*/
</script>
