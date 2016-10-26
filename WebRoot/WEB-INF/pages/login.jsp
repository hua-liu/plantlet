<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/html">
<head>
<base href="<%=basePath%>">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<meta name="description" content="">
<meta name="author" content="">

<title><s:text name="login" /></title>

<!-- Bootstrap core CSS -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="css/admin/dashboard.css" rel="stylesheet">
<link rel="stylesheet" href="css/admin/background.css" type="text/css">
<link href="css/menu.css" rel="stylesheet">
<link href="css/login.css" rel="stylesheet">
<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]>
    <script src="js/ie8-responsive-file-warning.js"></script><![endif]-->
<script src="js/ie-emulation-modes-warning.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body>
	<div class="container-fluid ">
		<nav class="navbar navbar-inverse navbar-fixed-top mynav"
			role="navigation">
		<div class="navbar-header">
			<a href="index.html" class="navbar-brand"><img src="img/logo.png"></a>
			<div class="minMenu">
				<span class="glyphicon glyphicon-menu-hamburger dropdown-toggle"
					data-toggle="dropdown"></span>
				<ul class="dropdown-menu">
					<li class="dropdown">
						<button class="btn btn-default dropdown-toggle" type="button"
							data-toggle="dropdown" aria-expanded="true" id="loginButton2">
							<s:text name="login" />
						</button>
					</li>
					<li class="dropdown">
						<button class="btn btn-default dropdown-toggle" type="button"
							data-toggle="dropdown" aria-expanded="true" id="registerButton2">
							<s:text name="register" />
						</button>
					</li>
					<li class="dropdown">
						<button class="btn btn-default dropdown-toggle" type="button"
							data-toggle="dropdown" aria-expanded="true">
							<s:text name="language" />
							<span class="caret"></span>
						</button>
						<ul class="nav" role="menu" aria-labelledby="dropdownMenu1">
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="loginUi?request_locale=zh_CN"><s:text name="chinese" /></a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="loginUi?request_locale=en_US"><s:text name="english" /></a></li>
						</ul>
					</li>
					<li class="dropdown">
						<button class="btn btn-default dropdown-toggle" type="button"
							data-toggle="dropdown" aria-expanded="true">
							<s:text name="help" />
							<span class="caret"></span>
						</button>
						<ul class="nav" role="menu" aria-labelledby="dropdownMenu1">
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="#"><s:text name="makeGuide" /></a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="#"><s:text name="customerService" /></a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="#"><s:text name="about" /></a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<div class="container-fluid">
			<ul class="nav navbar-nav navbar-right mynav-right">
				<li class="dropdown">
					<button class="btn btn-default dropdown-toggle" type="button"
						data-toggle="dropdown" aria-expanded="true" id="loginButton">
						<s:text name="login" />
					</button>
				</li>
				<li class="dropdown">
					<button class="btn btn-default dropdown-toggle" type="button"
						data-toggle="dropdown" aria-expanded="true" id="registerButton">
						<s:text name="register" />
					</button>
				</li>
				<li role="presentation">
					<div class="dropdown">
						<button class="btn btn-default dropdown-toggle" type="button"
							data-toggle="dropdown" aria-expanded="true">
							<s:text name="language" />
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu"
							aria-labelledby="dropdownMenu1">
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="loginUi?request_locale=zh_CN"><s:text name="chinese" /></a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="loginUi?request_locale=en_US"><s:text name="english" /></a></li>
						</ul>
					</div>
				</li>
				<li role="presentation">
					<div class="dropdown">
						<button class="btn btn-default dropdown-toggle" type="button"
							data-toggle="dropdown" aria-expanded="true">
							<s:text name="help" />
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu"
							aria-labelledby="dropdownMenu1">
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="#"><s:text name="makeGuide" /></a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="#"><s:text name="customerService" /></a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="#"><s:text name="about" /></a></li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
		</nav>
	</div>
	<div class="container box">
		<img src="img/login.jpg" class="col-md-8 loginImg">
		<div class="col-md-4">
			<img src="img/logo2.png" class="col-md-8 col-md-offset-2 logoImg"><br />
			<div class="col-md-12 errorT1 ">
				<s:if test="actionErrors!=null&&actionErrors.size>0&&actionErrors[0]!=null">
					<div class="alert alert-danger alert-dismissible fade in"
						role="alert">
						<button class="close" aria-label="Close" type="button"
							data-dismiss="alert">
							<span aria-hidden="true">×</span>
						</button>
						<p>
							<s:actionerror />
						</p>
					</div>
					<script type="text/javascript">
						window.setTimeout(function() {
							$(".errorT1").text("");
						}, 5000);
					</script>
				</s:if>
			</div>
			<br /> <br />
			<form class="form-horizontal" action="userLogin" method="post"
				id="loginForm">
				<div class="form-group">
					<label for="inputAccount" class="col-sm-2 control-label"><s:text
							name="account" /></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="inputAccount"
							name="account" value="${account}" data-placement="top"
							data-content="账号不能为空" placeholder="<s:text name="inputAccount"/>">
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="col-sm-2 control-label"><s:text
							name="password" /></label>
					<div class="col-sm-9">
						<input type="password" class="form-control" id="inputPassword"
							data-placement="top" data-content="密码不能为空" name="password"
							placeholder="<s:text name="inputPassword"/>">
					</div>
				</div>
				<div class="form-group col-sm-10">
					<div class="checkbox col-md-offset-3 col-sm-5">
						<label> <input type="checkbox" class="remember"
							name="isRemember"> <s:text name="rememberMe" />
						</label>
					</div>
					<div class="col-sm-2">
						<button type="submit" class="btn btn-default loginButton">
							<s:text name="login" />
						</button>
					</div>
				</div>
				<br/><br/><br/>
				<div class="form-group">
					<span class="col-md-offset-3 loginT2"> <a href="#"><s:text
								name="forgetPassword" /></a> <a href="phoneRegisterUi"><s:text
								name="noAccount" /></a>
					</span>
				</div>
			</form>
			<br />
			<div class="form-group col-md-offset-3 otherLogin">
				<s:text name="otherLogin" />
				<a href="#"><img src="img/qq.png"></a><a href="#"><img
					src="img/qqwibo.png"></a><a href="#"><img src="img/sina.png"></a>
			</div>
		</div>
	</div>
	<s:debug></s:debug>
	<footer class="footer">
	<div class="container">
		<p class="text-muted">
			<s:text name="foot" />
		</p>
	</div>
	</footer>
		<script src="js/jquery/jquery.min.js"></script>
	<script src="js/menu.js"></script>
	<script src="js/admin/map.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/login.js"></script>
	<!-- Just to make our placeholder images work. Don't actually copy the next line! -->
	<script src="js/vendor/holder.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
