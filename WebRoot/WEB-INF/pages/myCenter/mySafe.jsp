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
    <style type="text/css">
        li{
            list-style: none;
            float:left;
        }
        .menu{
            width:130px;
            padding:0;
            text-align:center;
            cursor:pointer;
            border:2px solid #CCC;
            margin:0 35px;
            border-radius:10px;
            opacity: 0.7;
        }
        .active{
            border-color:#0A0;
            opacity: 1;
        }
        .menu:hover{
            border-color:#0A0;
        }
        .menu i{
            font-size:100px;
        }
        @media(max-width:600px){
            .menu i{
                font-size:50px;
            }
            .menu{
                width:100px;
                margin:0 15px;
            }
        }
        .setContent{
            width:100%;height:250px;
            border:1px solid #CCC;
            position:absolute;
            bottom:0;
            padding:0;
            overflow:hidden;
        }
        .setContent li{
            width:100%;height:100%;
            display:none;
        }
        .setContent li:first-child{
            display:block;
        }
       .setContent li .left{
            width:10%;height:100%;
           float:left;
            border-rihgt:1px solid #CCC;
           font-size:25px;
           text-align:center;
           background:rgba(0,0,0,0.2);
           font-weight:bold;
        }
        .setContent li .center{
            width:60%;height:100%;
            float:left;
            font-size:20px;
            padding:50px;
        }
        .setContent li .right{
            width:30%;height:100%;
            float:left;
            border-left:1px solid #CCC;
            text-align:center;
        }
        .setContent li button{
            float:right;
            margin-top:10px;
        }
        .successSign{
        	font-size:50px;color:#5CB85C;
        	display:none;
        }
        .successSign small{
        	font-size:20px;
        }
    </style>
</head>
<body>
<div>
    <ul class="col-md-12">
        <li class="col-md-3 menu active" data="setPhone">
            <i class="glyphicon glyphicon-phone"></i><br/>
           <s:text name='phoneSettings'/>
        </li>
        <li class="col-md-3 menu" data="setEmail">
            <i class="glyphicon glyphicon-envelope"></i><br/>
          <s:text name='emailSettings'/>
        </li>
        <li class="col-md-3 menu" data="setLoginPassword">
            <i class="glyphicon glyphicon-credit-card"></i><br/>
          <s:text name='loginPasswordSettings'/>
        </li>
        <li class="col-md-3 menu" data="setPayPassword">
            <i class="glyphicon glyphicon-lock"></i><br/>
            <s:text name='payPasswordSettings'/>
        </li>
        <li style="clear:both;display:none;"></li>
    </ul>
</div>
  <ul class="setContent">
      <li class="setPhone">
          <div class="left" style="padding:50px 0;"><s:text name='shou'/><br/><s:text name='ji'/><br/><s:text name='she'/><br/><s:text name='zhi'/></div>
          <div class="center">
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon1"><s:text name='oldPhoneNo.'/></span>
                  <input type="text" name="oldPhone" class="form-control" placeholder="<s:text name='fillInTheOldPhoneNumber'/>" aria-describedby="sizing-addon2" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <br/>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon2"><s:text name='newPhoneNo.'/></span>
                  <input type="text" name="newPhone" class="form-control" placeholder="<s:text name='fillInTheNew11PhoneNumber'/>" aria-describedby="sizing-addon2" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <button type="button" class="btn btn-primary" data="phone"><s:text name="update"/></button>
          </div>
          <div class="right"><h3><s:text name="changePhoneNo.Norm"/></h3>1、<s:text name="phoneNorm_1"/><br/>2、<s:text name="phoneNorm_2"/>　　<br/><i class="glyphicon glyphicon-ok successSign"><br/><small><s:text name="updateSuccess"/></small></i></div>
      </li>
      <li class="setEmail">
          <div class="left" style="padding:50px 0;"><s:text name='you'/><br/><s:text name='xiang'/><br/><s:text name='she'/><br/><s:text name='zhi'/></div>
          <div class="center">
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon3"><s:text name="oldEmail"/></span>
                  <input type="text" name="oldEmail" class="form-control" placeholder="<s:text name='fillInTheOriginalEmailAddress'/>" aria-describedby="sizing-addon4" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <br/>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon4"><s:text name="newEmail"/></span>
                  <input type="text" name="newEmail" class="form-control" placeholder="<s:text name='fillInTheNewEmailAddress'/>" aria-describedby="sizing-addon4" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <button type="button" class="btn btn-primary" data="email"><s:text name="update"/></button>
          </div>
          <div class="right"><h3><s:text name="changeEmailNorm"/></h3>1、<s:text name="emailNorm_1"/><br/>2、<s:text name="emailNorm_2"/>　　　　　<br/><i class="glyphicon glyphicon-ok successSign"><br/><small><s:text name="updateSuccess"/></small></i></div>
      </li>
      <li class="setLoginPassword">
          <div class="left" style="padding:20px 0;"><s:text name='deng'/><br/><s:text name='lu'/><br/><s:text name='mi'/><br/><s:text name='ma'/><br/><s:text name='she'/><br/><s:text name='zhi'/></div>
          <div class="center">
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon6"><s:text name="currentPassword"/></span>
                  <input type="password" name="oldLoginPassword" class="form-control" placeholder="<s:text name='fillInTheCurrentPassword'/>" aria-describedby="sizing-addon6" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <br/>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon7"><s:text name="newPassword"/></span>
                  <input type="password" name="newLoginPassword" class="form-control" placeholder="<s:text name='fillInTheNewPassword'/>" aria-describedby="sizing-sizing" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon8"><s:text name='confirmPassword'/></span>
                  <input type="password" name="newLoginPassword2" class="form-control" placeholder="<s:text name='fillInTheNewPassword'/>" aria-describedby="sizing-addon8" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <button type="button" class="btn btn-primary" data="loginPassword"><s:text name='update'/></button>
          </div>
          <div class="right"><h3><s:text name='changeLoginPasswordNorm'/></h3>1、<s:text name='loginPasswordNorm_1'/><br/>2、<s:text name='loginPasswordNorm_2'/>　　　<br/>3、<s:text name='passwordNorm_3'/>　　<br/><i class="glyphicon glyphicon-ok successSign"><br/><small><s:text name="updateSuccess"/></small></i></div>
      </li>
      <li class="setPayPassword">
          <div class="left" style="padding:20px 0;"><s:text name='_zhi'/><br/><s:text name='fu'/><br/><s:text name='mi'/><br/><s:text name='ma'/><br/><s:text name='she'/><br/><s:text name='zhi'/></div>
          <div class="center" style="padding-top:20px;">
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon12"><s:text name="currentPassword"/></span>
                  <input type="password" name="oldLoginPassword" class="form-control" placeholder="<s:text name='fillInTheCurrentPassword'/>" aria-describedby="sizing-addon12" data-toggle="tooltip" data-placement="bottom" title="">
              </div>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon9"><s:text name='payTheOldPassword'/></span>
                  <input type="password" name="oldPayPassword" class="form-control" placeholder="<s:text name='fillInTheCurrentPaymentPassword'/>" aria-describedby="sizing-addon9" data-toggle="tooltip" data-placement="bottom" title="">
              </div>
              <br/>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon10"><s:text name='newPaymentPassword'/></span>
                  <input type="password" name="newPayPassword" class="form-control" placeholder="<s:text name='fillOutTheNewPaymentPassword'/>" aria-describedby="sizing-addon10" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon11"><s:text name='newPaymentPassword'/></span>
                  <input type="password" name="newPayPassword2" class="form-control" placeholder="<s:text name='fillOutTheNewPaymentPassword'/>" aria-describedby="sizing-addon11" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <button type="button" class="btn btn-primary" data="payPassword"><s:text name='update'/></button>
          </div>
          <div class="right"><h3><s:text name='changePayPasswordNorm'/></h3>1、<s:text name='payPasswordNorm_1'/><br/>2、<s:text name='payPasswordNorm_2'/><br/>3、<s:text name='loginPasswordNorm_2'/>　　　<br/>4、<s:text name='passwordNorm_3'/>　　<br/><i class="glyphicon glyphicon-ok successSign"><br/><small>修改成功</small></i></div>
      </li>
  </ul>
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
<script src="js/myCenter/safe.js" type="text/javascript"></script>
<script type="text/javascript">
    $(".menu").click(function(){
        $(this).addClass("active");
        $(this).siblings().removeClass("active");
        $(".setContent li").hide();
        $(".setContent ."+$(this).attr("data")).show();
        $(".successSign").hide();
    })
</script>
</body>
</html>
