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

<title><s:text name="usernameRegister"/></title>

<!-- Bootstrap core CSS -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="css/admin/dashboard.css" rel="stylesheet">
<link rel="stylesheet" href="css/admin/background.css" type="text/css">
<link href="css/menu.css" rel="stylesheet">
<link href="css/register.css" rel="stylesheet">
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
			<a href="index" class="navbar-brand"><img src="img/logo.png"></a>
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
								href="usernameRegisterUi?request_locale=zh_CN"><s:text
										name="chinese" /></a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="usernameRegisterUi?request_locale=en_US"><s:text
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
								href="usernameRegisterUi?request_locale=zh_CN"><s:text
										name="chinese" /></a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="usernameRegisterUi?request_locale=en_US"><s:text
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

	<div class="container">
		<br />
		<table class="register">
			<caption>
				<s:text name="userRegister" />
			</caption>
			<tr>
				<th>
					<div class="btn-group btn-group-justified" role="group">
						<div class="btn-group " role="group">
							<a type="button" class="btn btn-default btn-lg"
								href="phoneRegisterUi"><s:text name="phoneRegister" /></a>
						</div>
						<div class="btn-group" role="group">
							<a type="button" class="btn btn-default btn-lg active"
								href="usernameRegisterUi"><s:text name="usernameRegister" /></a>
						</div>
						<div class="btn-group" role="group">
							<a type="button" class="btn btn-default btn-lg"
								href="emailRegisterUi"><s:text name="emailRegister" /></a>
						</div>
					</div>
				</th>
				<!--<th><button type="button" class="btn btn-default btn-lg">手机号注册</button></th>
            <th><button type="button" class="btn btn-default btn-lg">用户名注册</button></th>
            <th><button type="button" class="btn btn-default btn-lg">邮箱注册</button></th>-->
			</tr>
		</table>
		<br /> <br />
		<form class="form-horizontal" action="usernameRegisterUser" method="post"
			autocomplete="off" id="registerForm">
			<s:hidden name="registerType" value="username"></s:hidden>
			<div class="form-group">
				<label for="inputUsername"
					class="col-sm-2 control-label col-md-offset-3"><s:text name="username"/></label>
				<div class="col-sm-4">
					<input type="text" name="username" class="form-control" value="${username }"
						id="inputUsername" placeholder="<s:text name="inputUsername"/>"> <span
						class="glyphicon glyphicon-star form-control-feedback"
						aria-hidden="true"></span>
				</div>
				<div class="col-sm-3 errorT1">
					<span id="jsusernameError"></span>
					<s:property value="fieldErrors.usernameError[0]" />
				</div>
			</div>
			<div class="form-group">
				<label for="inputPhone"
					class="col-sm-2 control-label col-md-offset-3"><s:text name="phone"/></label>
				<div class="col-sm-4">
					<input type="text" name="phone" class="form-control" value="${phone }" maxlength="11"
						id="inputPhone" placeholder="<s:text name="inputPhonePrompt"/>">
				</div>
				<div class="col-sm-3 errorT1">
					<span id="jsphoneError"></span>
					<s:property value="fieldErrors.phoneError[0]" />
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail"
					class="col-sm-2 control-label col-md-offset-3"><s:text name="email"/></label>
				<div class="col-sm-4">
					<input type="email" name="email" class="form-control"  value="${email}"
						id="inputEmail" placeholder="<s:text name="inputEmail"/>">
				</div>
				<div class="col-sm-3 errorT1">
					<span id="jsemailError"></span>
					<s:property value="fieldErrors.emailError[0]" />
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword"
					class="col-sm-2 control-label col-md-offset-3"><s:text name="loginPassword"/></label>
				<div class="col-sm-4">
					<input type="password" name="password" class="form-control"
						id="inputPassword" placeholder="<s:text name="inputPassword"/>" onchange="clearError(this)">
					<span class="glyphicon glyphicon-star form-control-feedback"
						aria-hidden="true"></span>
				</div>
				<div class="col-sm-3 errorT1">
					<s:if test="fieldErrors.passwordError!=null">
						<span class="glyphicon glyphicon-remove"></span>
					</s:if>
					<span id="jspasswordError" class="jsError"></span>
					<s:property value="fieldErrors.passwordError[0]" />
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword2"
					class="col-sm-2 control-label col-md-offset-3"><s:text name="password2"/></label>
				<div class="col-sm-4">
					<input type="password" name="password2" class="form-control"
						id="inputPassword2" placeholder="<s:text name="inputPassword2"/>"
						onchange="clearError(this)"> <span
						class="glyphicon glyphicon-star form-control-feedback"
						aria-hidden="true"></span>
				</div>
				<div class="col-sm-3 errorT1">
					<s:if test="fieldErrors.password2Error!=null">
						<span class="glyphicon glyphicon-remove"></span>
					</s:if>
					<span id="jspassword2Error" class="jsError"></span>
					<s:property value="fieldErrors.password2Error[0]" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-offset-5 col-sm-6">
					<div class="checkbox">
						<label> <input type="checkbox" class="isAgree">
							<s:text name="isAgree"/>
						</label>
						<button class="btn btn-default col-md-offset-1" type="button"
							data-toggle="modal" data-target="#myModal"><s:text name="readDeal"/></button>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-5 col-sm-5">
					<button type="submit" class="btn btn-default registerButton"><s:text name="rightAwayRegister"/></button>
					<span class="loginT2"> <a href="loginUi"><s:text name="haveAccountGoLogin"/></a>
					</span>
				</div>

			</div>
		</form>
	</div>

	<footer class="footer">
	<div class="container">
		<p class="text-muted"><s:text name="foot"/></p>
	</div>
	</footer>
	<!-- Button trigger modal -->
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">网站许可协议</h4>
				</div>
				<div class="modal-body">
					一、你至少应该知道ARIA是什么东西！<br />
					WAI-ARIA指无障碍网页应用。主要针对的是视觉缺陷，失聪，行动不便的残疾人以及假装残疾的测试人员。尤其像盲人，眼睛看不到，其浏览网页则需要借助辅助设备，如屏幕阅读器，屏幕阅读机可以大声朗读或者输出盲文。<br />
					而ARIA就是可以让屏幕阅读器准确识别网页中的内容，变化，状态的技术规范，可以让盲人这类用户也能无障碍阅读！<br />
					二、为什么需要ARIA？<br /> 回答标题问题前我先问其他几个问题？<br />
					1.如何让盲人用户知道当前浏览区域就是网站主导航？<br /> 2.如果让盲人用户知道点击某个按钮后出来的是弹框？<br />
					3.如何让盲人用户知道点击某个按钮后页面另外一个区域的文字发生了变化？<br />
					4.如何让盲人用户知道您使用了li标签是用来模拟标准select控件呢？<br />
					5.如何让盲人用户知道您模拟的select控件是单选呢还是可以多选呢？<br />
					在你现有的知识范围内，您有办法解决上面的问题吗？有人会说，我使用HTML5,
					恩，确实，HTML5的出现大大增强了网页的可访问性和无障碍阅读，但是，其不是万能的，例如无法让盲人知道模拟控件的类型等。<br />
					因此，才需要ARIA.<br /> 三、ARIA是个非主流，咱不鸟！<br />
					ARIA是非主流吗？真是睡在冻床上不知冷热啊。ARIA规范一直在更新维护，浏览器方面IE8+以及其他所有现代浏览器都都已支持ARIA,
					几乎可以说是全方位支持。流行的JavaScript库jQuery, 以及衍生的jQuery
					Mobile早早支持了ARIA，国内知名JavaScript库kissy也在去年（我没记错的话）支持了ARIA并在实际项目中使用了（可以在淘宝首页寻觅踪迹）。<br />
					Coach是包包中的主流吗？ARIA就是包包中的Coach.<br />. 四、算了吧，盲人，这么小众，鸟个毛啊！<br />
					嘛，确实，反正你一辈子就照着设计图切几个死页面就够了。<br>
					五、靠，ARIA相关属性茫茫多，老子调戏前台都没时间，鸟这个！<br />
					ARIA相关属性虽然多，哥们，要晓得，时间紧的时候，做前戏就没有必要把每个部位都亲个遍，直接针对敏感部位就行了。ARIA也是一样，知道几个常用的属性就可以了。以后在领导面前吹嘘啊，面试得瑟啊什么的就有料了！<br />
					到现在全是文字，为了提高可阅读性，避免文字阅读吃力的潜在用户关闭本页面，是时候举个实际的例子提提大家的神了，让大家知道ARIA就是个冰激凌（跟屎放在一起只是肤色白了点而已）。<br />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" data-dismiss="modal"><s:text name="iReaded"/></button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var i18n = {
			passwordNull : '<s:text name="passwordNull"/>',
			passwordLenght : '<s:text name="passwordLenght"/>',
			twicePasswordSame : '<s:text name="twicePasswordSame"/>',
			phoneFormatError : '<s:text name="phoneFormatError"/>',
			emailFormatError : '<s:text name="emailFormatError"/>',
			usernameNull : '<s:text name="usernameNull"/>',
			usernameLenght : '<s:text name="usernameLenght"/>',
			phoneAvailable : '<s:text name="phoneAvailable"/>',
			emailAvailable : '<s:text name="emailAvailable"/>',
			usernameAvailable : '<s:text name="usernameAvailable"/>',
			phoneInvalid : '<s:text name="phoneInvalid"/>',
			emailInvalid : '<s:text name="emailInvalid"/>',
			usernameInvalid : '<s:text name="usernameInvalid"/>',
		}
	</script>
	<!--i18n  -->
	<script src="js/admin/map.js"></script>
	<script src="js/jquery/jquery.min.js"></script>
	<script src="js/menu.js"></script>
	<script src="js/register.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<!-- Just to make our placeholder images work. Don't actually copy the next line! -->
	<script src="js/vendor/holder.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
