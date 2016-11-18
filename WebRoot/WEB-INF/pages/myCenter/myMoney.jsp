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
    
    <title>My JSP 'myInfo.jsp' starting page</title>
    
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
        <h1>你的余额</h1>
         <h2><span title="点击显示">
         <s:i18n name="format">
			<s:text name="struts.percent">
				<s:param value="safe.balance" />
			</s:text>
		</s:i18n>
         	元</span></h2>
    </div>
    <div class="right">
        <p class="rightHead"><b>最近消费纪录</b></p>
        <ul class="recordBox">
        <s:iterator value="#request.logs">
        	<li>
	        	<p>消费日期：<s:date name="currentDate" format="yyyy-MM-dd hh:mm:ss"/></p>
	        	<p>I&nbsp;P地址：${changeIp}</p>
	        	<p>消费金额：
	        	<fmt:formatNumber value="${changeBegin-changeAfter}" pattern="#0.00"/>
	        	元</p>
	        	<p>剩余金额：
	        	<fmt:formatNumber value="${changeAfter}" pattern="#0.00"/>
	        	元</p>
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
