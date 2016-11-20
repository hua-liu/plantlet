<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My Money</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
        .left{
            width:50%;
            height:100%;
            float:left;
            text-align:center;
            padding:50px;
            border-right:1px solid #999;;
        }
        .right{
            width:50%;
            height:100%;
            float:left;
        }
        .left h1{
            padding:20px 0;
        }
        .left h2{
            background:rgba(0,0,0,0.5);
            padding:20px 0;
            color:#A00;
        }
        .left h2 span{
            opacity:0;
        }
        .rightHead{
            width:100%;height:30px;
            background:rgba(0,0,0,0.2);
            text-align:center;
            line-height:30px;
            margin:0;
        }
        .recordBox{
            width:100%;height:360px;
            overflow:auto;
            padding:0;
        }
        .recordBox li{
        	background:rgba(0,0,0,0.1);
        	list-style:none;
        	margin-bottom:1px;
        	padding:5px;
        }
    </style>
</head>
<body>

<div class="container-fluid" style="height:400px">
    <div class="left">
        <h1><s:text name='yourBalance'/></h1>
         <h2><span title="s:text name='clickshow'/>">
         <s:i18n name="format">
			<s:text name="struts.percent">
				<s:param value="safe.balance" />
			</s:text>
		</s:i18n>
         	<s:text name='yuan'/></span></h2>
    </div>
    <div class="right">
        <p class="rightHead"><b><s:text name='recentConsumptionRecord'/></b></p>
        <ul class="recordBox">
        <s:iterator value="#request.logs">
        	<li>
	        	<p><s:text name='theDateOfConsumption'/><s:date name="currentDate" format="yyyy-MM-dd hh:mm:ss"/></p>
	        	<p>I&nbsp;P&nbsp;<s:text name='address'/>：${changeIp}</p>
	        	<p><s:text name='consumptionAmount'/>：
	        	<fmt:formatNumber value="${changeBegin-changeAfter}" pattern="#0.00"/>
	        	<s:text name='yuan'/></p>
	        	<p><s:text name='theRemainingAmount'/>：
	        	<fmt:formatNumber value="${changeAfter}" pattern="#0.00"/>
	        	<s:text name='yuan'/></p>
        	</li>
        </s:iterator>
        </ul>
    </div>
</div>
<script src="js/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
    $(".left h2 span").click(function(){
        this.style.opacity=1;
    })
</script>
</body>
</html>
