<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
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
	 <link href="bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet">
	 <link href="css/myCenter/myMessage.css" type="text/css" rel="stylesheet">
</head>
<body>
<div class="left">
<div class="menu_th">
    <p class="selectCase allCase"><i class="glyphicon glyphicon-ok"></i></p>
    <button class="deleteMany"><s:text name='checkMarkAsRead'/></button><button class="signMany"><s:text name="checkMarkAsRead"/></button>
</div>
<table class="mytable">
	<s:iterator value="#request.messages">
		<tr data-id="${id}" isNew="${isNew}">
	        <td>
	            <p class="selectCase"><i class="glyphicon glyphicon-ok"></i></p>
	        </td>
	        <td>
	        	[<span class="sendNameTD">${sendName}</span>]
	        </td>
	        <td>
	       		<p class="contentTD">${content }</p>
	       		<s:if test="isNew==1">
	       			<span class="isnew">new</span>
	       		</s:if>
	        </td>
	    </tr>
	</s:iterator>
    
</table>
</div>
<div class="right sendState">
    <div class="input-group">
        <span class="input-group-addon" id="basic-addon1"><b><s:text name='toReceiveA1'/></b></span>
        <span class="form-control selectReceiveUser"></span>
        <input type="text" class="form-control receiveUser" placeholder="<s:text name='messageSend_placeHolder'/>" aria-describedby="basic-addon1" data-toggle="tooltip" data-placement="bottom" title="">
    </div>
    <div style="border:1px solid #CCC">
        <p  id="basic-addon2" style="width:100%;height:30px;background:#EEEEEE;text-align: center;line-height:30px;margin:0;"><b><s:text name='content'/></b></p>
        <p class="form-control selectTextContent"></p>
        <textarea class="form-control textContent" placeholder="<s:text name='messageContent'/>" aria-describedby="basic-addon2" data-toggle="tooltip" data-placement="bottom" title=""></textarea>
    </div>
    <button class="btn btn-default reply" style="float:right;"><s:text name='reply'/></button>
    <button class="btn btn-default send" style="float:right;"><s:text name='send'/></button>
</div>
<!--i18n  -->
	<script src="js/admin/map.js"></script>
	<script type="text/javascript">
		try{
		var i18nConfig = eval("(" + "${sessionScope.i18nConfig}" + ")");
		var i18n = new Map();
		for ( var key in i18nConfig) {
			i18n.put(key, i18nConfig[key]);
		}
	}catch(e){
		alert(e);
	}
	</script>
	<!--/i18n  -->
<script src="js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/myCenter/myMessage.js" type="text/javascript"></script>
</body>
</html>
