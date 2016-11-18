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
<meta http-equiv="Refresh" content="10;url=loginUi?account=${user.phone }">
<title><s:text name="registerSuccess" /></title>
<!-- Bootstrap core CSS -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="css/admin/dashboard.css" rel="stylesheet">
<link rel="stylesheet" href="css/admin/background.css" type="text/css">
<link href="css/menu.css" rel="stylesheet">
<link href="css/registerSuccess.css" rel="stylesheet">
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
					<li class="dropdown">
						<button class="btn btn-default dropdown-toggle" type="button"
							data-toggle="dropdown" aria-expanded="true">
							<s:text name="language" />
							<span class="caret"></span>
						</button>
						<ul class="nav" role="menu" aria-labelledby="dropdownMenu1">
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="phoneSuccess?request_locale=zh_CN"><s:text
										name="chinese" /></a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="phoneSuccess?request_locale=en_US"><s:text
										name="english" /></a></li>
						</ul> </li>
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
								href="phoneSuccess?request_locale=zh_CN"><s:text
										name="chinese" /></a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="phoneSuccess?request_locale=en_US"><s:text
										name="english" /></a></li>
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

	<br />
	<br />
	<div class="box">
		<span><s:text name="accountRegisterSuccess"/></span><s:text name="pleaseSaveAccount"/>
			<p>
				10<s:text name="autoGoLogin"/>
			</p>
			<p><s:text name="manualGoLogin"/><a href="loginUi?account=${user.phone}"><s:text name="thereLogin"/></a></p>
	</div>
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
	<!-- Just to make our placeholder images work. Don't actually copy the next line! -->
	<script src="js/vendor/holder.js"></script>
</body>
</html>
