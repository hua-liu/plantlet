
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>AdminLTE 2 | Starter</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="bootstrap/css/font-awesome.min.css">
<link rel="stylesheet" href="bootstrap/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="css/admin/AdminLTE.min.css">
<link rel="stylesheet" href="css/admin/animation.css">
<style type="text/css">
a {
	cursor: pointer;
}

#iframepage {
	overflow-x: hidden;
	overflow-y: hidden;
}

#warning {
	position: absolute;
	width: 100%;
	display: none;
	text-align: center;
	font-size: 15px;
	z-index: 1000;
}

.search-sidebar-menu {
	margin: 0;
}

.search-sidebar-menu li {
	width: 100%;
	height: 30px;
}

.search-sidebar-menu li:hover {
	color: #fff;
	background: #1e282c;
	border-left-color: #3c8dbc;
	cursor: pointer;
}
</style>
<link rel="stylesheet" href="css/admin/skin-blue.min.css">

<!-- HTML5 Shim and R
espond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<%-- <script src="js/ie/html5shiv.min.js"></script>
<script src="js/ie/respond.min.js"></script> --%>
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<!-- Main Header -->
		<header class="main-header"> <!-- Logo --> <a href="admin"
			class="logo"> <!-- mini logo for sidebar mini 50x50 pixels --> <span
			class="logo-mini"><img src="img/logo-min.png" width="50px;"></span>
			<!-- logo for regular state and mobile devices --> <span
			class="logo-lg"><img src="img/logo.png"></span>
		</a> <!-- Header Navbar --> <nav class="navbar navbar-static-top"
			role="navigation"> <!-- Sidebar toggle button--> <a
			class="sidebar-toggle" data-toggle="offcanvas" role="button"> <span
			class="sr-only">Toggle navigation</span>
		</a> <!-- Navbar Right Menu -->
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<!-- Messages: style can be found in dropdown.less-->
				<li class="dropdown messages-menu">
					<!-- Menu toggle button --> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <i class="fa fa-envelope-o"></i> <span
						class="label label-success">4</span>
				</a>
					<ul class="dropdown-menu">
						<li class="header">You have 4 messages</li>
						<li>
							<!-- inner menu: contains the messages -->
							<ul class="menu">
								<li>
									<!-- start message --> <a href="#">
										<div class="pull-left">
											<!-- User Image160x160 -->

											<img src="img/duola-a-meng_41.png" class="img-circle"
												alt="User Image">
										</div> <!-- Message title and timestamp -->
										<h4>
											Support Team <small><i class="fa fa-clock-o"></i> 5
												mins</small>
										</h4> <!-- The message -->
										<p>Why not buy a new awesome theme?</p>
								</a>
								</li>
								<!-- end message -->
							</ul> <!-- /.menu -->
						</li>
						<li class="footer"><a href="#">See All Messages</a></li>
					</ul>
				</li>
				<!-- /.messages-menu -->

				<!-- Notifications Menu -->
				<li class="dropdown notifications-menu">
					<!-- Menu toggle button --> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <i class="fa fa-bell-o"></i> <span
						class="label label-warning">10</span>
				</a>
					<ul class="dropdown-menu">
						<li class="header">You have 10 notifications</li>
						<li>
							<!-- Inner Menu: contains the notifications -->
							<ul class="menu">
								<li>
									<!-- start notification --> <a href="#"> <i
										class="fa fa-users text-aqua"></i> 5 new members joined today
								</a>
								</li>
								<!-- end notification -->
							</ul>
						</li>
						<li class="footer"><a href="#">View all</a></li>
					</ul>
				</li>
				<!-- Tasks Menu -->
				<li class="dropdown tasks-menu">
					<!-- Menu Toggle Button --> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <i class="fa fa-flag-o"></i> <span
						class="label label-danger">9</span>
				</a>
					<ul class="dropdown-menu">
						<li class="header">You have 9 tasks</li>
						<li>
							<!-- Inner menu: contains the tasks -->
							<ul class="menu">
								<li>
									<!-- Task item --> <a href="#"> <!-- Task title and progress text -->
										<h3>
											Design some buttons <small class="pull-right">20%</small>
										</h3> <!-- The progress bar -->
										<div class="progress xs">
											<!-- Change the css width attribute to simulate progress -->
											<div class="progress-bar progress-bar-aqua"
												style="width: 20%" role="progressbar" aria-valuenow="20"
												aria-valuemin="0" aria-valuemax="100">
												<span class="sr-only">20% Complete</span>
											</div>
										</div>
								</a>
								</li>
								<!-- end task item -->
							</ul>
						</li>
						<li class="footer"><a href="#">View all tasks</a></li>
					</ul>
				</li>
				<!-- User Account Menu -->
				<li class="dropdown user user-menu">
					<!-- Menu Toggle Button --> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <!-- The user image in the navbar--> <img
						src="img/duola-a-meng_41.png" class="user-image" alt="User Image">
						<!-- hidden-xs hides the username on small devices so only the image appears. -->
						<span class="hidden-xs"> <s:if
								test="#session.user.username=='liuhua'">
					系统管理员
				</s:if> <b><s:property value="#session.user.username" /></b></span>
				</a>
					<ul class="dropdown-menu">
						<!-- The user image in the menu -->
						<li class="user-header"><img src="img/duola-a-meng_41.png"
							class="img-circle" alt="User Image">

							<p>
								Alexander Pierce - Web Developer <small>Member since
									Nov. 2012</small>
							</p></li>
						<!-- Menu Body -->
						<li class="user-body">
							<div class="row">
								<div class="col-xs-4 text-center">
									<a href="#">Followers</a>
								</div>
								<div class="col-xs-4 text-center">
									<a href="#">Sales</a>
								</div>
								<div class="col-xs-4 text-center">
									<a href="#">Friends</a>
								</div>
							</div> <!-- /.row -->
						</li>
						<!-- Menu Footer-->
						<li class="user-footer">
							<div class="pull-left">
								<a href="#" class="btn btn-default btn-flat">Profile</a>
							</div>
							<div class="pull-right">
								<a href="javascript:void(0)" id="logout"
									class="btn btn-default btn-flat">退出</a>
							</div>
						</li>
					</ul>
				</li>
				<!-- Control Sidebar Toggle Button -->
				<li><a href="#" data-toggle="control-sidebar"><i
						class="fa fa-gears"></i></a></li>
			</ul>
		</div>
		</nav> </header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar"> <!-- sidebar: style can be found in sidebar.less -->
		<section class="sidebar"> <!-- Sidebar user panel (optional) -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="img/duola-a-meng_41.png" class="img-circle"
					alt="User Image">
			</div>
			<div class="pull-left info">
				<p>
					<s:if test="#session.user.username=='liuhua'">
					系统管理员
				</s:if>
					<b><s:property value="#session.user.username" /></b>
				</p>
				<!-- Status -->
				<a href="javascript:void(0)"><i
					class="fa fa-circle text-success"></i> Online</a>
			</div>
		</div>

		<!-- search form (Optional) -->
		<div class="sidebar-form">
			<div class="input-group">
				<input type="text" name="q" class="form-control" id="menuSearch"
					placeholder="菜单搜索"> <span class="input-group-btn">
					<button type="submit" name="search" id="menuSearchButton"
						class="btn btn-flat">
						<i class="fa fa-search"></i>
					</button>
				</span>
			</div>
		</div>
		<!-- /.search form --> <!-- Sidebar Menu -->
		<ul class="search-sidebar-menu"></ul>
		<ul class="sidebar-menu">
			<li class="header">操作菜单</li>
			<!-- Optionally, you can add icons to the links -->
			<li class="active homeMenu liMenu"><a href="go_admin_home"
				target="admin_content"><i class="fa fa-home"></i> <span>首页</span></a></li>
			<li class="userMenu liMenu"><a href="admin_user"
				target="admin_content"><i class="fa fa-user"></i> <span>用户管理</span></a></li>
			<li class="treeview "><a><i class="fa  fa-paw"></i> <span>商品管理</span>
					<span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li class="addProduct liMenu"><a href="admin_addGoods"
						target="admin_content"><i class="fa  fa-hand-o-right"></i><span>添加商品</span></a></li>
					<li class="manageProduct liMenu"><a href="admin_manageGoods"
						target="admin_content"><i class="fa  fa-hand-o-right"></i><span>管理商品</span></a></li>
					<li class="statisticsProduct liMenu"><a
						href="admin_statisticsGoods" target="admin_content"><i
							class="fa  fa-hand-o-right"></i><span>商品统计</span></a></li>
				</ul></li>
			<li class="treeview"><a><i class="fa fa-gavel"></i> <span>订单管理</span>
					<span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span></a>
				<ul class="treeview-menu">
					<li class="paidOrderForm liMenu"><a
						href="admin_orderForm?function=9" target="admin_content"><i
							class="fa  fa-hand-o-right"></i><span>已付款订单</span></a></li>
					<li class="noPayOrderForm liMenu"><a
						href="admin_orderForm?function=8" target="admin_content"><i
							class="fa  fa-hand-o-right"></i><span>未付款订单</span></a></li>
					<li class="cartOrderForm liMenu"><a
						href="admin_orderForm?function=10" target="admin_content"><i
							class="fa  fa-hand-o-right"></i><span>购物车订单</span></a></li>
					<li class="completedOrderForm liMenu"><a
						href="admin_orderForm?function=12" target="admin_content"><i
							class="fa  fa-hand-o-right"></i><span>交易完成订单</span></a></li>
					<li class="failureOrderForm liMenu"><a
						href="admin_orderForm?function=13" target="admin_content"><i
							class="fa  fa-hand-o-right"></i><span>交易失败订单</span></a></li>
					<li class="allOrderForm liMenu"><a
						href="admin_orderForm?function=0" target="admin_content"><i
							class="fa  fa-hand-o-right"></i><span>所有订单</span></a></li>
				</ul>
				</li>
			<li class="treeview "><a><i class="fa fa-lock"></i> <span>权限管理</span>
					<span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li class="userJurisdiction liMenu"><a
						href="admin_permission?function=1" target="admin_content"><i
							class="fa  fa-hand-o-right"></i><span>管理员维护</span></a></li>
					<li class="roleManage liMenu"><a
						href="admin_permission?function=2" target="admin_content"><i
							class="fa  fa-hand-o-right"></i><span>角色维护</span></a></li>
					<li class="selectJurisdiction liMenu"><a
						href="admin_permission?function=3" target="admin_content"><i
							class="fa  fa-hand-o-right"></i><span>查看权限</span></a></li>
				</ul></li>

			<li class="treeview "><a><i class="fa fa-key"></i> <span>安全中心</span>
					<span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li class="changePassword liMenu"><a href="admin_addGoods"
						target="admin_content"><i class="fa  fa-hand-o-right"></i><span>密码修改</span></a></li>
				</ul></li>
		</ul>
		<!-- /.sidebar-menu --> </section> <!-- /.sidebar --> </aside>

		<!-- Content Wrapper. Contains page content -->
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" style="min-height:0;">
			<!-- 警告框 -->
			<div class="alert alert-warning alert-dismissible fade in"
				id="warning" role="alert">
				<h4>
					<i class="icon fa fa-check"></i> <span id="warning-text"></span>
				</h4>
			</div>
			<!--警告框结束  -->
			<!-- Content Header (Page header) -->
			<section class="content-header">
			<h1>
				当前位置:<span>统计数据</span> <small>welcome</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="admin_home" target="admin_content"><i
						class="fa fa-dashboard"></i> <span>统计数据</span></a></li>
			</ol>
			</section>
			<s:debug></s:debug>
			<section class="content"> <!-- Main content --> <s:if
				test="classify==0">
				<s:url var="goUrl" value="go_admin_home" />
			</s:if> <s:elseif test="classify==1">
				<s:url var="goUrl" value="admin_user" />
			</s:elseif> <s:elseif test="classify==2&&putawayGoods==1">
				<s:url var="goUrl" value="admin_addGoods" />
			</s:elseif> <s:elseif test="classify==2&&putawayGoods==0">
				<s:url var="goUrl" value="admin_manageGoods" />
			</s:elseif> <s:elseif test="classify==4">
				<s:url var="goUrl" value="admin_permission?function=%{function}" />
			</s:elseif> <iframe src="${goUrl}" width="100%" frameBorder=0
				style="overflow-y : hidden;" name="admin_content" height="80%"
				seamless="seamless" onload="removeLoader()" id="iframepage"></iframe>
			<script type="text/javascript">
				function removeLoader() {
					$(".loaderMenuBox").remove();
				}
			</script> </section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%-- <footer class="main-footer" style="position:fixed; bottom:0;width:100%;background=#000"> <!-- To the right -->
		<div class="pull-right hidden-xs " style="background=#000">Anything you want</div>
		<!-- Default to the left --> <strong>Copyright &copy; 2016 <a
			href="#">Company</a>.
		</strong> All rights reserved. </footer> --%>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark"> <!-- Create the tabs -->
		<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
			<li class="active"><a href="#control-sidebar-home-tab"
				data-toggle="tab"><i class="fa fa-home"></i></a></li>
			<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i
					class="fa fa-gears"></i></a></li>
		</ul>
		<!-- Tab panes -->
		<div class="tab-content">
			<!-- Home tab content -->
			<div class="tab-pane active" id="control-sidebar-home-tab">
				<h3 class="control-sidebar-heading">Recent Activity</h3>
				<ul class="control-sidebar-menu">
					<li><a href="javascript::;"> <i
							class="menu-icon fa fa-birthday-cake bg-red"></i>

							<div class="menu-info">
								<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

								<p>Will be 23 on April 24th</p>
							</div>
					</a></li>
				</ul>
				<!-- /.control-sidebar-menu -->

				<h3 class="control-sidebar-heading">Tasks Progress</h3>
				<ul class="control-sidebar-menu">
					<li><a href="javascript::;">
							<h4 class="control-sidebar-subheading">
								Custom Template Design <span class="pull-right-container">
									<span class="label label-danger pull-right">70%</span>
								</span>
							</h4>

							<div class="progress progress-xxs">
								<div class="progress-bar progress-bar-danger" style="width: 70%"></div>
							</div>
					</a></li>
				</ul>
				<!-- /.control-sidebar-menu -->

			</div>
			<!-- /.tab-pane -->
			<!-- Stats tab content -->
			<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab
				Content</div>
			<!-- /.tab-pane -->
			<!-- Settings tab content -->
			<!-- Settings tab content -->
			<div class="tab-pane" id="control-sidebar-settings-tab">
				<h3 class="control-sidebar-heading">显示设置</h3>
				<div class="form-group">
					<div class="input-group">
						<span class="input-group-addon"><s:text
								name="eachPageShowsNumber" />：</span>
						<s:select id="rowNum" list="#{10:'10',15:'15',20:'20',25:'25' }"
							listKey="key" listValue="value" class="form-control"
							source-data="${size}" data-content='<s:text name="onlySupport"/>'
							placeholder='<s:text name="inputNumberOf"/>'></s:select>
						<%-- 	<input type="number"
							value="${size}" maxlength=2 class="form-control" id="rowNum"
							source-data="${size}" data-placement="top"
							data-content='<s:text name="onlySupport"/>'
							placeholder='<s:text name="inputNumberOf"/>' /> --%>
					</div>
				</div>
			</div>
			<!-- /.tab-pane -->
			<!-- /.tab-pane -->
		</div>
		</aside>
		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->
	<script src="js/admin/map.js"></script>
	<script type="text/javascript">
		var totalPage = ${totalPage};
		var currentPage = ${currentPage};
		var rowsize = ${size};
		var classify = ${classify};
		var i18nConfig = eval("(" + "${sessionScope.i18nConfig}" + ")");
		var i18n = new Map();
		for ( var key in i18nConfig) {
			i18n.put(key, i18nConfig[key]);
		}
		var nameArr = eval("("
				+ "{'id':'ID','state':'<s:text name='accountState'/>','phone':'<s:text name='phone'/>','credit':'<s:text name='credit'/>',"
				+ "'email':'<s:text name='email'/>','username':'<s:text name='username'/>','phoneState':'<s:text name='phone'/><s:text name='state'/>',"
				+ "'emailState':'<s:text name='email'/><s:text name='state'/>','identityState':'<s:text name='authentication'/><s:text name='state'/>',"
				+ "'nickname':'<s:text name='nickname'/>','roleName':'<s:text name='roleName'/>'}"
				+ ")");
		var permissions = "${requestScope.permissions}";
	</script>

	<!-- jQuery 2.2.3 -->
	<script src="js/jquery/jquery.min.js"></script>
	<script src="js/admin/admin.js"></script>
	<!-- Bootstrap 3.3.6 -->
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<!-- AdminLTE App -->
	<script src="js/admin/app.min.js"></script>
	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. Slimscroll is required when using the
     fixed layout. -->
</body>
</html>
