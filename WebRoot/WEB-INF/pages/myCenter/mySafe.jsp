<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
            手机设置
        </li>
        <li class="col-md-3 menu" data="setEmail">
            <i class="glyphicon glyphicon-envelope"></i><br/>
            邮箱设置
        </li>
        <li class="col-md-3 menu" data="setLoginPassword">
            <i class="glyphicon glyphicon-credit-card"></i><br/>
            登陆密码设置
        </li>
        <li class="col-md-3 menu" data="setPayPassword">
            <i class="glyphicon glyphicon-lock"></i><br/>
            支付密码设置
        </li>
        <li style="clear:both;display:none;"></li>
    </ul>
</div>
  <ul class="setContent">
      <li class="setPhone">
          <div class="left" style="padding:50px 0;">手<br/>机<br/>设<br/>置</div>
          <div class="center">
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon1">原手机号</span>
                  <input type="text" name="oldPhone" class="form-control" placeholder="填写原手机号" aria-describedby="sizing-addon2" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <br/>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon2">新手机号</span>
                  <input type="text" name="newPhone" class="form-control" placeholder="填写新11位手机号" aria-describedby="sizing-addon2" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <button type="button" class="btn btn-primary" data="phone">更改</button>
          </div>
          <div class="right"><h3>更改手机号规范</h3><br/>1、需要提供原手机号，没有则不填<br/>2、需使用合法的11位手机号码　　<br/><i class="glyphicon glyphicon-ok successSign"><br/><small>修改成功</small></i></div>
      </li>
      <li class="setEmail">
          <div class="left" style="padding:50px 0;">邮<br/>箱<br/>设<br/>置</div>
          <div class="center">
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon3">原邮箱</span>
                  <input type="text" name="oldEmail" class="form-control" placeholder="填写原邮箱地址" aria-describedby="sizing-addon4" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <br/>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon4">新邮箱</span>
                  <input type="text" name="newEmail" class="form-control" placeholder="填写新邮箱地址" aria-describedby="sizing-addon4" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <button type="button" class="btn btn-primary" data="email">更改</button>
          </div>
          <div class="right"><h3>更改邮箱规范</h3><br/>1、需要提供原邮箱地址，没有则不填<br/>2、需使用合法的邮箱格式　　　　　<br/><i class="glyphicon glyphicon-ok successSign"><br/><small>修改成功</small></i></div>
      </li>
      <li class="setLoginPassword">
          <div class="left" style="padding:20px 0;">登<br/>陆<br/>密<br/>码<br/>设<br/>置</div>
          <div class="center">
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon6">当前密码</span>
                  <input type="password" name="oldLoginPassword" class="form-control" placeholder="填写当前登陆密码" aria-describedby="sizing-addon6" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <br/>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon7">新的密码</span>
                  <input type="password" name="newLoginPassword" class="form-control" placeholder="填写新的登陆密码" aria-describedby="sizing-sizing" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon8">确认密码</span>
                  <input type="password" name="newLoginPassword2" class="form-control" placeholder="填写新的登陆密码" aria-describedby="sizing-addon8" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <button type="button" class="btn btn-primary" data="loginPassword">更改</button>
          </div>
          <div class="right"><h3>更改密码规范</h3><br/>1、更改密码需要输入原密码<br/>2、密码长度在5-20位　　　<br/>3、请妥善保管你的密码　　<br/><i class="glyphicon glyphicon-ok successSign"><br/><small>修改成功</small></i></div>
      </li>
      <li class="setPayPassword">
          <div class="left" style="padding:20px 0;">支<br/>付<br/>密<br/>码<br/>设<br/>置</div>
          <div class="center" style="padding-top:20px;">
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon12">登陆的密码</span>
                  <input type="password" name="oldLoginPassword" class="form-control" placeholder="填写当前登陆密码" aria-describedby="sizing-addon12" data-toggle="tooltip" data-placement="bottom" title="">
              </div>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon9">旧支付密码</span>
                  <input type="password" name="oldPayPassword" class="form-control" placeholder="填写当前支付密码" aria-describedby="sizing-addon9" data-toggle="tooltip" data-placement="bottom" title="">
              </div>
              <br/>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon10">新支付密码</span>
                  <input type="password" name="newPayPassword" class="form-control" placeholder="填写新的支付密码" aria-describedby="sizing-addon10" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <div class="input-group">
                  <span class="input-group-addon" id="sizing-addon11">新支付密码</span>
                  <input type="password" name="newPayPassword2" class="form-control" placeholder="填写新的支付密码" aria-describedby="sizing-addon11" data-toggle="tooltip" data-placement="top" title="">
              </div>
              <button type="button" class="btn btn-primary" data="payPassword">更改</button>
          </div>
          <div class="right"><h3>更改支付密码规范</h3><br/>1、更改密码需要输入原密码<br/>2、没有原支付密码则不填写<br/>2、密码长度在5-20位　　　<br/>3、请妥善保管你的密码　　<br/><i class="glyphicon glyphicon-ok successSign"><br/><small>修改成功</small></i></div>
      </li>
  </ul>
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
