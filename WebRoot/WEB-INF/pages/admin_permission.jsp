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

<title>六六后台管理中心</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面,任何其他内容都*必须*跟随其后！ -->
<meta name="description" content="">
<meta name="author" content="">

<title>Dashboard Template for Bootstrap</title>

<link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
<!-- Bootstrap core CSS -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="css/admin/dashboard.css" rel="stylesheet">
<link rel="stylesheet" href="css/admin/background.css" type="text/css">
<!-- <link href="css/menu.css" rel="stylesheet"> -->
<link rel="stylesheet" href="css/admin/dataTables.bootstrap.css">
<link href="css/admin/admin.css" rel="stylesheet">
<!-- <link href="css/multipleChoice.css" rel="stylesheet"> -->
<link href="css/admin/levelControl.css" rel="stylesheet">
<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]><script src="js/ie8-responsive-file-warning.js" ></script><![endif]-->
<%-- <script src="js/ie-emulation-modes-warning.js"></script> --%>
<style>
li {
	list-style: none;
}
</style>
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js" ></script>
    <![endif]-->
</head>

<body style="padding-top:0px;">
	<%-- 	<nav class="navbar navbar-inverse navbar-fixed-top mynav"
			role="navigation">
		<div class="navbar-header">
			<a href="admin" class="navbar-brand"><img src="img/logo.png"></a>
			<ul class="nav-pills pull-left bgtext">
				<li><s:text name="manageCenter"/></li>
			</ul>
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
				<li class="showUser"><s:text name="welcome"/>：<span><s:property
							value="#session.user.username" /></span></li>
				<li role="presentation">
					<div class="dropdown">
						<button class="btn btn-default dropdown-toggle" type="button"
							data-toggle="dropdown" aria-expanded="true">
							<s:text name="logoutAndQuit"/><span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu"
							aria-labelledby="dropdownMenu1">
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="#" id="logout"><s:text name="logout"/>/<s:text name="switchUser"/></a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="#" id="quit"><s:text name="logoutAndQuit"/></a></li>
						</ul>
					</div>
				</li>
				<li role="presentation">
					<div class="dropdown">
						<button class="btn btn-default dropdown-toggle" type="button"
							data-toggle="dropdown" aria-expanded="true">
							<s:text name="set"/> <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu"
							aria-labelledby="dropdownMenu1">
							<li role="presentation" data-toggle="modal"
								data-target="#personalizeSet"><a role="menuitem"
								tabindex="-1" href="javascript:void(0)"><s:text name="showSet"/></a></li>
						</ul>
					</div>
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
								href="admin?request_locale=zh_CN"><s:text name="chinese" /></a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="admin?request_locale=en_US"><s:text name="english" /></a></li>
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
		</nav> --%>
	<!-- 删除警告  -->
	<s:if test="classify==4&&function==1">
		<div class="alert alert-danger alert-dismissible fade in"
			id="deleteWarning" role="alert" data-id="" style="width:450px">
			<button type="button" class="close closeWin">
				<span aria-hidden="true">×</span>
			</button>
			<h4>
				<strong><s:text name="kickedOutWarningManagement" />!</strong>
			</h4>
			<s:text name="sureWill" />
			：<span class="deleteWarning-text"></span>
			<s:text name="directKickOutManage" />
			?<br /> <br />

			<button type="button" class="btn btn-danger" id="sureDelete">
				<s:text name="sureKickOut" />
			</button>
			<button type="button" class="btn btn-default closeWin"
				style="margin-left:20px;width:100px">
				<s:text name="cancel" />
			</button>
		</div>
	</s:if>
	<s:elseif test="classify==4&&function==2">
		<div class="alert alert-danger alert-dismissible fade in"
			id="deleteRoleWarning" role="alert" data-id="">
			<button type="button" class="close closeWin">
				<span aria-hidden="true">×</span>
			</button>
			<h4>
				<strong><s:text name="deleteRoleWarning" />!</strong>
			</h4>
			<s:text name="sureWill" />
			：
			<s:text name="roleName" />
			<span class="deleteWarning-text"></span>
			<s:text name="delete?" />
			?<br /> <br />

			<button type="button" class="btn btn-danger" id="sureDeleteRole">
				<s:text name="sureDelete" />
			</button>
			<button type="button" class="btn btn-default closeWin"
				style="margin-left:20px;width:100px">
				<s:text name="cancel" />
			</button>
		</div>
	</s:elseif>
	</div>
	<%-- <div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<form action="ScopeSearch" method="post" id="ScopeSearchCenter">
					<s:hidden name="size" />
					<s:hidden name="isShowChart" />
					<s:hidden name="classify"/>
					<s:hidden name="function"/>
					<s:hidden name="putawayGoods"/>
					<ul class="nav nav-sidebar manageMenu">
						<h4>
							<s:text name="管理菜单" />
						</h4>
						<li data="1"><a>用户管理<span
								class="glyphicon glyphicon-chevron-right"></span></a>
							<ul class="nav userManageUl" style="margin-left:15px;">
								<li class="userManageLi"><a><s:text name="state" />
										<s:select name="state" list="#request.state" listKey="id"
											listValue="name" /></a></li>
								<li class="userManageLi"><a><s:text name="role" />
										<s:select name="role" list="#request.role" listKey="id"
											listValue="name" /></a></li>
								<li><button class="btn btn-default col-md-10" type="submit"
										id="userManageSubmit">
										<span class="glyphicon glyphicon-search"></span>
									</button></li>
							</ul></li>
						<li data="2"><a>商品管理<span
								class="glyphicon glyphicon-chevron-right"></span></a>
							<ul class="nav goodsManageUl" style="margin-left:15px;">
								<li data-index="1" class="goodsManageLi"><a>上架商品</a></li>
								<li data-index="0" class="goodsManageLi"><a>查询商品<span
										class="glyphicon glyphicon-chevron-right"></span></a>
									<ul class="nav goodsKinidUl" style="margin-left:15px;">
										<li><a>商品分类 <s:select name="goodsKind"
													list="#request.goodsKind" listKey="id" listValue="name"
													id="goodsKind" /></a></li>
										<li class="moreKind" style="display:none"><a>详细分类 <s:select
													name="moreKind" list="#{0:'全部'}" listKey="key"
													listValue="value" id="moreKind" /></a></li>
										<li><button class="btn btn-default col-md-10"
												type="submit" id="userManageSubmit">
												<span class="glyphicon glyphicon-search"></span>
											</button></li>
									</ul></li>
							</ul></li>
						<li data="3"><a>订单管理<span
								class="glyphicon glyphicon-chevron-right"></span></a></li>
						<li data="4"><a>权限管理<span
								class="glyphicon glyphicon-chevron-right"></span></a>
							<ul class="nav permissionUl" style="margin-left:15px;">
								<s:iterator value="#request.MaintenanceMenu">
									<li class="permissionLi" data-id="<s:property value='key'/>"><a><s:property
												value="value" /></a></li>
								</s:iterator>
							</ul></li>
					</ul>
					<ul class="nav nav-sidebar">
						<h4>
							<s:text name="模糊搜索" />
						</h4>
						<li style="margin-left:15px;"><input name="keywords"
							type="text" style="width:70%;" value="${keywords }"
							placeholder='<s:text name="inputKeywordsSearch"></s:text>' />
							<button class="btn btn-success" type="submit">
								<span class="glyphicon glyphicon-search"></span>
							</button></li>
						<li style="text-align:center"></li>

					</ul>
				</form>

				
				<!-- <ul class="nav nav-sidebar">
                <li><a href="">Nav item again</a></li>
                <li><a href="">One more nav</a></li>
                <li><a href="">Another nav item</a></li>
            </ul>-->
			</div> --%>
	<!-- 	<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="table-responsive"> -->

	<!-- /.box-header -->
	<form action="ScopeSearch" method="post" id="ScopeSearch">
		<s:hidden name="classify" />
		<s:hidden name="state" />
		<s:hidden name="keywords" />
		<s:hidden name="size" />
		<s:hidden name="isShowChart" />
		<s:hidden name="function" />
		<s:hidden name="currentPage" id="currentPage" />
	</form>
	<div class="box-body"
		style="padding:5px;padding-bottom:35px;min-height:650px;">
		<s:if test="classify==4&&function==1">
			<table id="example2" class="table table-bordered table-hover"
				role="grid" aria-describedby="example2_info">
				<thead>
					<tr>
						<th colspan="7"><button
								class="btn btn-default col-md-2"
								data-toggle="modal" data-target="#addManager">
								<s:text name="addManager" />
							</button>
							<div style="float:right">
							<div class="input-group">
								<input name="keywords" class="form-control" type="text"
									source-data="${keywords}" style="width:300px;"
									value="${keywords }" id="inputKeywords"
									placeholder='<s:text name="inputKeywordsSearch"></s:text>' />
									<span class="input-group-addon" id="keywords-submit" style="max-width:40px;cursor:pointer;"><span class="glyphicon glyphicon-search"></span></span>
							</div>
						</div></th>
					</tr>
					<tr role="row">
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Rendering engine: activate to sort column ascending"><s:text
								name="sequence" /></th>
						<th class="sorting_desc" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Browser: activate to sort column ascending"
							aria-sort="descending"><s:text name="username" /></th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Platform(s): activate to sort column ascending"><s:text
								name="nickname" /></th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Engine version: activate to sort column ascending"><s:text
								name="phone" /></th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="CSS grade: activate to sort column ascending"><s:text
								name="email" /></th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="CSS grade: activate to sort column ascending"><s:text
								name="currentRole" /></th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="CSS grade: activate to sort column ascending"><s:text
								name="moreOperation" /></th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="#request.list" status="s">
						<s:if test="#s.count%2==0"></s:if>
						<tr class="userList even" data-id="${id}">
							<s:else>
								<tr class="userList odd" data-id="${id}">
							</s:else>
							<td>${s.count}</td>
							<td><s:property value="username" default="-" /></td>
							<td><s:property value="nickname" default="-" /></td>
							<td><s:property value="phone" default="-" /></td>
							<td><s:property value="email" default="-" /></td>
							<td><s:text name="%{getText(role.name)}" /></td>
							<td><div class="btn-group">
									<button type="button" class="btn btn-default dropdown-toggle"
										data-toggle="dropdown" aria-expanded="false">
										<s:text name="advancedOptions" />
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu advanced" role="menu" data-id="${id}">
										<li role="presentation" data-toggle="modal"
											data-target="#updateModal"><a role="menuitem"
											tabindex="-1" href="javascript:void(0)"><s:text
													name="jurisdictionChange" /></a></li>
										<li role="presentation"><a role="menuitem" tabindex="-1"
											href="javascript:void(0)"><s:text
													name="directKickOutManage" /></a></li>
										<li role="presentation" data-toggle="modal"
											data-target="#myModal"><a role="menuitem" tabindex="-1"
											href="javascript:void(0)"><s:text name="showMore" /></a></li>
									</ul>
								</div></td>
						</tr>
					</s:iterator>
				</tbody>
				<tfoot>
					<tr>
						<th colspan="7"><div class="paging" style="margin:0 auto;">
								<p class="pagingP1">
									<s:text name="totalRecord" />
									<span>&nbsp;${totalNum}&nbsp;</span>
									<s:text name="item" />
								</p>
								<p class="pagingP2">
									<s:text name="the" />
									<span>&nbsp;${currentPage}&nbsp;</span>
									<s:text name="page" />
									/
									<s:text name="total" />
									<span>&nbsp;${totalPage}&nbsp;</span>
									<s:text name="page" />
								</p>
								<ul class="pagination">
									<s:if test="currentPage<2">
										<li class="disabled"><a href="javascript:void(0)"
											aria-label="Previous"> <span
												class="glyphicon glyphicon-arrow-left"></span>
										</a></li>
									</s:if>
									<s:else>
										<li><a href="javascript:void(0)" aria-label="Previous"
											paging-data="${currentPage-1 }" data-toggle="tooltip"
											data-placement="top" title="<s:text name='previousPage'/>">
												<span class="glyphicon glyphicon-arrow-left"></span>
										</a></li>
									</s:else>
									<s:if test="totalPage==0">
										<li class="disabled"><a href="javascript:void(0)">0</a></li>
									</s:if>
									<s:elseif test="totalPage<11">
										<s:iterator begin="1" end="totalPage" status="s">
											<s:if test="#s.count==currentPage">
												<li class="active"><a href="javascript:void(0)"
													paging-data="${s.count}">${s.count}</a></li>
											</s:if>
											<s:else>
												<li><a href="javascript:void(0)"
													paging-data="${s.count}">${s.count}</a></li>
											</s:else>
										</s:iterator>
									</s:elseif>
									<s:else>
										<s:if test="currentPage<6">
											<s:iterator begin="1" end="10" status="s">
												<s:if test="#s.count==currentPage">
													<li class="active"><a href="javascript:void(0)"
														paging-data="${s.count}">${s.count}</a></li>
												</s:if>
												<s:else>
													<li><a href="javascript:void(0)"
														paging-data="${s.count}">${s.count}</a></li>
												</s:else>
											</s:iterator>
										</s:if>
										<s:else>
											<s:iterator begin="currentPage-5"
												end="currentPage+5>totalPage?totalPage:currentPage+5"
												status="s" var="cur">
												<s:if test="#cur==currentPage">
													<li class="active"><a href="javascript:void(0)"
														paging-data="${cur}">${cur }</a></li>
												</s:if>
												<s:else>
													<li><a href="javascript:void(0)" paging-data="${cur}">${cur}</a></li>
												</s:else>
											</s:iterator>
										</s:else>
									</s:else>
									<s:if test="currentPage>=totalPage">
										<li class="disabled"><a href="javascript:void(0)"
											aria-label="Next"><span
												class="glyphicon glyphicon-arrow-right"></span> </a></li>
									</s:if>
									<s:else>
										<li><a href="javascript:void(0)" aria-label="Next"
											paging-data="${currentPage+1}" data-toggle="tooltip"
											data-placement="top" title="<s:text name='nextPage'/>"
											style="margin-right:20px"><span
												class="glyphicon glyphicon-arrow-right"></span></a></li>
									</s:else>
								</ul>
								<div class="selectPage">
									<s:text name="jumpTo" />
									<input type="text" maxlength="5" value="${currentPage }"
										id="goto" data-toggle="tooltip" data-placement="top"
										title="<s:text name='enterJump'/>" />
									<s:text name="page" />
								</div>
							</div></th>
					</tr>
				</tfoot>
			</table>
		</s:if>
		<s:elseif test="classify==4&&function==2">
			<table id="example2" class="table table-bordered table-hover"
				role="grid" aria-describedby="example2_info">
				<thead>
					<tr>
						<th colspan="4"><button
								class="btn btn-default col-md-2"
								data-toggle="modal" data-target="#addRole">
								<s:text name="addRole" />
							</button>
							<div style="float:right">
							<div class="input-group">
								<input name="keywords" class="form-control" type="text"
									source-data="${keywords}" style="width:300px;"
									value="${keywords }" id="inputKeywords"
									placeholder='<s:text name="inputKeywordsSearch"></s:text>' />
									<span class="input-group-addon" id="keywords-submit" style="max-width:40px;cursor:pointer;"><span class="glyphicon glyphicon-search"></span></span>
							</div>
						</div></th>
					</tr>
					<tr role="row">
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Rendering engine: activate to sort column ascending"><s:text
								name="sequence" /></th>
						<th class="sorting_desc" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Browser: activate to sort column ascending"
							aria-sort="descending"><s:text name="roleName" /></th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Platform(s): activate to sort column ascending"><s:text
								name="ownedJurisdiction" /></th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="CSS grade: activate to sort column ascending"><s:text
								name="moreOperation" /></th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="#request.list" status="s">
						<tr class="roleList" data-id="${id}">
							<td>${s.count}</td>
							<td><s:text name="%{getText(name)}" /></td>
							<td><s:iterator value="permissions" status="s">
									<s:if test="#s.count>1">
										<strong>|</strong>
									</s:if>
									<%-- <s:property value="id" />= --%>
									<s:text name="%{getText(name)}" />
								</s:iterator></td>
							<td>

								<div class="btn-group">
									<button type="button" class="btn btn-default dropdown-toggle"
										data-toggle="dropdown" aria-expanded="false">
										<s:text name="advancedOptions" />
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu advancedRole" role="menu"
										data-id="${id}">
										<li role="presentation" data-toggle="modal"
											data-target="#updateRole"><a role="menuitem"
											tabindex="-1" href="javascript:void(0)"><s:text
													name="jurisdictionChange" /></a></li>
										<li role="presentation"><a role="menuitem" tabindex="-1"
											href="javascript:void(0)"><s:text name="deleteRole" /></a></li>
									</ul>
								</div>
							</td>
						</tr>
					</s:iterator>
				</tbody>
				<tfoot>
					<tr>
						<th colspan="4"><div class="paging" style="margin:0 auto;">
								<p class="pagingP1">
									<s:text name="totalRecord" />
									<span>&nbsp;${totalNum}&nbsp;</span>
									<s:text name="item" />
								</p>
								<p class="pagingP2">
									<s:text name="the" />
									<span>&nbsp;${currentPage}&nbsp;</span>
									<s:text name="page" />
									/
									<s:text name="total" />
									<span>&nbsp;${totalPage}&nbsp;</span>
									<s:text name="page" />
								</p>
								<ul class="pagination">
									<s:if test="currentPage<2">
										<li class="disabled"><a href="javascript:void(0)"
											aria-label="Previous"> <span
												class="glyphicon glyphicon-arrow-left"></span>
										</a></li>
									</s:if>
									<s:else>
										<li><a href="javascript:void(0)" aria-label="Previous"
											paging-data="${currentPage-1 }" data-toggle="tooltip"
											data-placement="top" title="<s:text name='previousPage'/>">
												<span class="glyphicon glyphicon-arrow-left"></span>
										</a></li>
									</s:else>
									<s:if test="totalPage==0">
										<li class="disabled"><a href="javascript:void(0)">0</a></li>
									</s:if>
									<s:elseif test="totalPage<11">
										<s:iterator begin="1" end="totalPage" status="s">
											<s:if test="#s.count==currentPage">
												<li class="active"><a href="javascript:void(0)"
													paging-data="${s.count}">${s.count}</a></li>
											</s:if>
											<s:else>
												<li><a href="javascript:void(0)"
													paging-data="${s.count}">${s.count}</a></li>
											</s:else>
										</s:iterator>
									</s:elseif>
									<s:else>
										<s:if test="currentPage<6">
											<s:iterator begin="1" end="10" status="s">
												<s:if test="#s.count==currentPage">
													<li class="active"><a href="javascript:void(0)"
														paging-data="${s.count}">${s.count}</a></li>
												</s:if>
												<s:else>
													<li><a href="javascript:void(0)"
														paging-data="${s.count}">${s.count}</a></li>
												</s:else>
											</s:iterator>
										</s:if>
										<s:else>
											<s:iterator begin="currentPage-5"
												end="currentPage+5>totalPage?totalPage:currentPage+5"
												status="s" var="cur">
												<s:if test="#cur==currentPage">
													<li class="active"><a href="javascript:void(0)"
														paging-data="${cur}">${cur }</a></li>
												</s:if>
												<s:else>
													<li><a href="javascript:void(0)" paging-data="${cur}">${cur}</a></li>
												</s:else>
											</s:iterator>
										</s:else>
									</s:else>
									<s:if test="currentPage>=totalPage">
										<li class="disabled"><a href="javascript:void(0)"
											aria-label="Next"><span
												class="glyphicon glyphicon-arrow-right"></span> </a></li>
									</s:if>
									<s:else>
										<li><a href="javascript:void(0)" aria-label="Next"
											paging-data="${currentPage+1}" data-toggle="tooltip"
											data-placement="top" title="<s:text name='nextPage'/>"
											style="margin-right:20px"><span
												class="glyphicon glyphicon-arrow-right"></span></a></li>
									</s:else>
								</ul>
								<div class="selectPage">
									<s:text name="jumpTo" />
									<input type="text" maxlength="5" value="${currentPage }"
										id="goto" data-toggle="tooltip" data-placement="top"
										title="<s:text name='enterJump'/>" />
									<s:text name="page" />
								</div>
							</div></th>
					</tr>
				</tfoot>
			</table>
		</s:elseif>
		<s:else>
			<table id="example2" class="table table-bordered table-hover"
				role="grid" aria-describedby="example2_info">
				<thead>
					<tr>
						<th colspan="4">
							<div style="float:right">
							<div class="input-group">
								<input name="keywords" class="form-control" type="text"
									source-data="${keywords}" style="width:300px;"
									value="${keywords }" id="inputKeywords"
									placeholder='<s:text name="inputKeywordsSearch"></s:text>' />
									<span class="input-group-addon" id="keywords-submit" style="max-width:40px;cursor:pointer;"><span class="glyphicon glyphicon-search"></span></span>
							</div>
						</div>
						</th>
					</tr>
					<tr role="row">
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Rendering engine: activate to sort column ascending"><s:text
								name="sequence" /></th>
						<th class="sorting_desc" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Browser: activate to sort column ascending"
							aria-sort="descending"><s:text name="jurisdiction" /></th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Platform(s): activate to sort column ascending"><s:text
								name="sequence" /></th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="CSS grade: activate to sort column ascending"><s:text
								name="jurisdiction" /></th>
					</tr>
				</thead>
				<tbody>
					<tr class="permissionList">
						<s:iterator value="#request.list" status="s">
							<td>${s.count}</td>
							<td><s:text name="%{getText(name)}" /></td>
							<s:if test="#s.count%2==0">
					</tr>
					<tr>
						</s:if>
						</s:iterator>
				</tbody>
				<tfoot>
					<tr>
						<th colspan="7"><div class="paging" style="margin:0 auto;">
								<p class="pagingP1">
									<s:text name="totalRecord" />
									<span>&nbsp;${totalNum}&nbsp;</span>
									<s:text name="item" />
								</p>
								<p class="pagingP2">
									<s:text name="the" />
									<span>&nbsp;${currentPage}&nbsp;</span>
									<s:text name="page" />
									/
									<s:text name="total" />
									<span>&nbsp;${totalPage}&nbsp;</span>
									<s:text name="page" />
								</p>
								<ul class="pagination">
									<s:if test="currentPage<2">
										<li class="disabled"><a href="javascript:void(0)"
											aria-label="Previous"> <span
												class="glyphicon glyphicon-arrow-left"></span>
										</a></li>
									</s:if>
									<s:else>
										<li><a href="javascript:void(0)" aria-label="Previous"
											paging-data="${currentPage-1 }" data-toggle="tooltip"
											data-placement="top" title="<s:text name='previousPage'/>">
												<span class="glyphicon glyphicon-arrow-left"></span>
										</a></li>
									</s:else>
									<s:if test="totalPage==0">
										<li class="disabled"><a href="javascript:void(0)">0</a></li>
									</s:if>
									<s:elseif test="totalPage<11">
										<s:iterator begin="1" end="totalPage" status="s">
											<s:if test="#s.count==currentPage">
												<li class="active"><a href="javascript:void(0)"
													paging-data="${s.count}">${s.count}</a></li>
											</s:if>
											<s:else>
												<li><a href="javascript:void(0)"
													paging-data="${s.count}">${s.count}</a></li>
											</s:else>
										</s:iterator>
									</s:elseif>
									<s:else>
										<s:if test="currentPage<6">
											<s:iterator begin="1" end="10" status="s">
												<s:if test="#s.count==currentPage">
													<li class="active"><a href="javascript:void(0)"
														paging-data="${s.count}">${s.count}</a></li>
												</s:if>
												<s:else>
													<li><a href="javascript:void(0)"
														paging-data="${s.count}">${s.count}</a></li>
												</s:else>
											</s:iterator>
										</s:if>
										<s:else>
											<s:iterator begin="currentPage-5"
												end="currentPage+5>totalPage?totalPage:currentPage+5"
												status="s" var="cur">
												<s:if test="#cur==currentPage">
													<li class="active"><a href="javascript:void(0)"
														paging-data="${cur}">${cur }</a></li>
												</s:if>
												<s:else>
													<li><a href="javascript:void(0)" paging-data="${cur}">${cur}</a></li>
												</s:else>
											</s:iterator>
										</s:else>
									</s:else>
									<s:if test="currentPage>=totalPage">
										<li class="disabled"><a href="javascript:void(0)"
											aria-label="Next"><span
												class="glyphicon glyphicon-arrow-right"></span> </a></li>
									</s:if>
									<s:else>
										<li><a href="javascript:void(0)" aria-label="Next"
											paging-data="${currentPage+1}" data-toggle="tooltip"
											data-placement="top" title="<s:text name='nextPage'/>"
											style="margin-right:20px"><span
												class="glyphicon glyphicon-arrow-right"></span></a></li>
									</s:else>
								</ul>
								<div class="selectPage">
									<s:text name="jumpTo" />
									<input type="text" maxlength="5" value="${currentPage }"
										id="goto" data-toggle="tooltip" data-placement="top"
										title="<s:text name='enterJump'/>" />
									<s:text name="page" />
								</div>
							</div></th>
					</tr>
				</tfoot>
				</table>
		</s:else>
	</div>

	<!-- /.box-body -->

	<s:if test="classify==4&&function==1">
		<div class="modal fade" id="updateModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">
							<s:text name="updateUserInformation" />
							(
							<s:text name="followingMayChangeFields" />
							)
						</h4>
					</div>
					<div class="modal-body">
						<table class="table">
							<tbody>
								<tr>
									<td><div class="input-group">
											<span class="input-group-addon"><s:text
													name="username" />：</span> <input id="update.username"
												type="text" class="form-control" data-placement="top"
												data-content="<s:text name='usernameFormatError'/>"
												placeholder="<s:text name="inputUsername"/>">
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group">
											<span class="input-group-addon"><s:text name="email" />：</span>
											<input id="update.email" type="text" class="form-control"
												data-placement="top"
												data-content="<s:text name='emailFormatError'/>"
												placeholder="<s:text name='inputEmail'/>">
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group">
											<span class="input-group-addon"><s:text name="phone" />：</span>
											<input id="update.phone" type="text" class="form-control"
												data-placement="top"
												data-content="<s:text name='phoneFormatError'/>"
												placeholder="<s:text name="inputPhone"/>">
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group">
											<span class="input-group-addon"><s:text
													name="nickname" />：</span> <input id="update.nickname"
												type="text" class="form-control" data-placement="top"
												data-content="<s:text name='nicknameFormatError'/>"
												placeholder="<s:text name='inputNickname'/>">
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group" id="update-role">
											<span class="input-group-addon"><s:text
													name="roleName" />：</span>
											<div style="margin-left:10px;">
												<s:iterator value="#session.allRoles">
													<label class="radio-inline"> <input type="radio"
														name="updateRadioOptions" id="inlineRadio${id}"
														data-id="${id}" value="${id}"><span>${name}</span>
													</label>
												</s:iterator>
											</div>
										</div></td>
								</tr>
								<tr>
									<td><s:text name="changeWarningItems" />
										<button type="button"
											class="btn btn-primary btn-md changeNormButton">
											<s:text name="readChangeNorm" />
										</button> <input type="hidden" id="update.id"></td>
								</tr>
								<tr>
									<td class="changeNorm">
										<div class="alert alert-success" role="alert">
											<strong><s:text name="username" />！</strong>
											<s:text name="usernameNorm" />
										</div>
										<div class="alert alert-success" role="alert">
											<strong><s:text name="email" />！</strong>
											<s:text name="emailNorm" />
										</div>
										<div class="alert alert-success" role="alert">
											<strong><s:text name="phone" />！</strong>
											<s:text name="emailNorm" />
										</div>
										<div class="alert alert-success" role="alert">
											<strong><s:text name="nickname" />！</strong>
											<s:text name="nicknameNorm" />
										</div>
										<div class="alert alert-success" role="alert">
											<strong><s:text name="warning" />！</strong>
											<s:text name="normWarning" />
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<s:text name="close" />
						</button>
						<button type="button" class="btn btn-primary" id="update_submit"
							data-placement="left"
							data-content="<s:text name='formErrorPleaseReadNorm'/>">
							<s:text name="updateInformation" />
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabelMoreData" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">
							<s:text name="userMoreInformation" />
						</h4>
					</div>
					<div class="modal-body" id="printContext">
						<table class="table">
							<tbody id="moreInfor">
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<s:text name="close" />
						</button>
						<button type="button" class="btn btn-primary" id="printUser">
							<s:text name="print" />
						</button>
					</div>
				</div>
			</div>
		</div>
		<!--添加管理员开始-->
		<div class="modal fade" id="addManager" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabelMoreData" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content" id="addManagerArea">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">
							<s:text name="addManager" />
						</h4>
					</div>
					<div class="modal-body">
						<table class="table">
							<tbody>
								<tr>
									<td><div class="input-group" id="add-user"
											data-toggle="popover" data-placement="top"
											data-content="<s:text name='mustChooseOneUser'/>！">
											<span class="input-group-addon"><s:text name="user" />：</span>
											<div class="add_username">
												<div>
													<!-- 多加一个div是为了适应bootstrap -->
													<ul id="add_username_ul">
														<li id="add_username_input_li"><input
															id="add_username_input" type="text" source-data=""
															placeholder="<s:text name="inputKeywordsSearch"/>"></li>
													</ul>
												</div>
												<div class="list-group autoComplate"
													id="autoComplateContext">
													<p>
														<s:text name="selectResult" />
														：
														<s:text name="total" />
														&nbsp;<strong><span id="searcRresult">0</span></strong>&nbsp;
														<s:text name="itemRecord" />
													</p>
												</div>
											</div>
											<span class="input-group-addon" id="add-user-linkman"
												data-toggle="modal" data-target="#addLinkMan"> <span
												class="glyphicon glyphicon-user"></span>
											</span>
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group" id="add-role"
											data-toggle="popover" data-placement="top"
											data-content="<s:text name='chooseGiveRole'/>！">
											<span class="input-group-addon" style="width:50px"><s:text
													name="role" />：</span>
											<div style="margin-left:10px;">
												<s:iterator var="s" value="#session.allRoles">
													<label class="radio-inline"> <input type="radio"
														name="addRadioOptions" id="inlineRadio${s.id}"
														data-id="${s.id}" value="${s.id}">${s.name}
													</label>
												</s:iterator>
											</div>
										</div></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<s:text name="close" />
						</button>
						<button type="button" class="btn btn-primary" id="suerAddManager"
							data-toggle="popover" data-placement="left"
							data-content="<s:text name='addManagerLoseCause'/>">
							<s:text name="add" />
						</button>
					</div>
				</div>
			</div>
			<div class="modal fade" id="addLinkMan" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabelMoreData" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close addLinManClose"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">
								<s:text name="chooseUser" />
							</h4>
						</div>
						<div class="modal-body">
							<table class="table">
								<thead>
									<tr>
										<th><s:text name="sequence" /></th>
										<th><s:text name="username" /></th>
										<th><s:text name="email" /></th>
										<th><s:text name="phone" /></th>
									</tr>
								</thead>
							</table>
							<div id="selectUserTable" data-spy="scroll"
								data-target="#myScrollspy" data-offset="0">
								<table class="table">
									<tbody id="selectUserListBox"
										style="height:300px;position: relative;" data-page="1"
										total-page="1"></tbody>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<div class="col-lg-12">
								<span class="input-group-addon"><s:text
										name="selectResult" />：<s:text name="total" />&nbsp;<strong><span
										class="showTotalNum">0</span></strong>&nbsp;<s:text name="item" /> </span>
								<div class="input-group selectUserSearchInput"
									style="width:350px">
									<input type="text" class="form-control"
										id="selectUserSearchContext"
										placeholder="<s:text name="inputKeywordsSearch"/>"> <span
										class="input-group-addon" id="selectUserListSearch"
										style="width:50px"> <span
										class="glyphicon glyphicon-search"></span>
									</span>
									<!-- /input-group -->
								</div>
								<button type="button" class="btn btn-default addLinManClose">
									<s:text name="close" />
								</button>
								<button type="button" class="btn btn-primary addLinManClose">
									<s:text name="sure" />
								</button>
							</div>
						</div>
						<!-- /.row -->
					</div>
				</div>
			</div>
		</div>
		<!-- 添加管理员结束 -->
	</s:if>
	<s:elseif test="classify==4&&function==2">
		<div class="modal fade" id="addRole" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabeladdRole" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content" id="addRoleArea">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">
							<s:text name="addRole" />
						</h4>
					</div>
					<div class="modal-body">
						<table class="table">
							<tbody>
								<tr>
									<td><div class="input-group has-feedback" id="add_role">
											<span class="input-group-addon"><s:text
													name="roleName" />：</span> <input type="text"
												class="form-control" id="addRole_input" data-placement="top"
												data-content="<s:text name='roleNameFormatError'/>"
												placeholder="<s:text name='inputRoleName'/>"> <span
												id="add_role_icon" class="form-control-feedback"
												aria-hidden="true"></span> <span id="inputError2Status"
												class="sr-only">(error)</span>
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group" id="add_permission"
											data-placement="top"
											data-content="<s:text name='jurisdictionExplain'/>！">
											<span class="input-group-addon"><s:text
													name="jurisdictionName" />：</span>
											<div class="add_role_permissions">
												<s:iterator var="s" value="#session.allPermissions">
													<label class="checkbox-inline"><input
														type="checkbox" name="addcheckboxOptions"
														id="inlineCheckbox${s.id}" value="${s.id}">
														${s.name} </label>
												</s:iterator>
											</div>
										</div></td>
								</tr>
								<tr>
									<td>
										<div class="input-group has-feedback" id="role_level">
											<span class="input-group-addon"><s:text
													name="controlLevel" />：</span>
											<div class="level">
												<p class="level-control" data-toggle="tooltip"
													data-placement="top" title="150" id="level-control"></p>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td><s:text name="addRoleWarningItems" />：
										<button type="button"
											class="btn btn-primary btn-md changeNormButton">
											<s:text name="readChangeNorm" />
										</button></td>
								</tr>
								<tr>
									<td class="changeNorm">
										<div class="alert alert-success" role="alert">
											<strong><s:text name="username" />！</strong>
											<s:text name="usernameNorm" />
										</div>
										<div class="alert alert-success" role="alert">
											<strong><s:text name="jurisdiction" />！</strong>
											<s:text name="emailNorm" />
										</div>
										<div class="alert alert-success" role="alert">
											<strong><s:text name="controlLevel" />！</strong>
											<s:text name="updateRoleControlLevelWarning" />
										</div>
										<div class="alert alert-success" role="alert">
											<strong><s:text name="warning" />！</strong>
											<s:text name="controlLevelExplain1" />
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<s:text name="close" />
						</button>
						<button type="button" class="btn btn-primary" id="suerAddRole"
							data-placement="left"
							data-content="<s:text name='addLose'/>！<s:text name='pleaseReadChangeNorm'/>...">
							<s:text name="add" />
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="updateRole" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabelupdateRole" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content" id="updateRoleArea">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">
							<s:text name="updateRole" />
						</h4>
					</div>
					<div class="modal-body">
						<table class="table">
							<tbody>
								<tr>
									<td><div class="input-group has-feedback" id="update_role">
											<span class="input-group-addon"><s:text
													name="roleName" />：</span> <input type="text"
												class="form-control" id="updateRole_input" disabled>
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group" id="update_permission"
											data-placement="top"
											data-content="<s:text name="jurisdictionExplain"/>！">
											<span class="input-group-addon"><s:text
													name="jurisdictionExplain" />：</span>
											<div class="add_role_permissions">
												<s:iterator var="s" value="#session.allPermissions">
													<label class="checkbox-inline"><input
														type="checkbox" name="addcheckboxOptions"
														id="inlineCheckbox${s.id}" value="${s.id}"> <span>${s.name}</span>
													</label>
												</s:iterator>
											</div>
										</div></td>
								</tr>
								<tr>
									<td>
										<div class="input-group has-feedback" id="update_role_level">
											<span class="input-group-addon"><s:text
													name="controlLevel" />：</span>
											<div class="level">
												<p class="level-control" data-toggle="tooltip"
													data-placement="top" title="150" id="update_level_control"></p>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td><s:text name="changeRoleWarningItems" />：
										<button type="button"
											class="btn btn-primary btn-md changeNormButton">
											<s:text name="readChangeNorm" />
										</button></td>
								</tr>
								<tr>
									<td class="changeNorm">
										<div class="alert alert-success" role="alert">
											<strong><s:text name="jurisdiction" />！</strong>
											<s:text name="jurisdictionExplain" />
										</div>
										<div class="alert alert-success" role="alert">
											<strong><s:text name="control" />！</strong>
											<s:text name="controlLevelExplain" />
										</div>
										<div class="alert alert-success" role="alert">
											<strong><s:text name="warning" />！</strong>
											<s:text name="controlLevelExplain1" />
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<s:text name="close" />
						</button>
						<button type="button" class="btn btn-primary" id="suerUpdateRole"
							data-placement="left"
							data-content="<s:text name='chanageLose'/>！<s:text name='pleaseReadChangeNorm'/>...">
							<s:text name="update" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</s:elseif>
	<script src="js/admin/map.js"></script>
	<script type="text/javascript">
		var totalPage = ${totalPage};
		var currentPage = ${currentPage};
		var rowsize = ${size};
		/* var isShowChart = ${isShowChart}; */
		var classify = ${classify};
		var functionVal = ${function};
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
		var myRole = ${sessionScope.user.role.level};
	</script>
	<!-- Bootstrap core JavaScript
================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery/jquery.min.js"></script>
	<script src="js/jquery/jquery-ui.min.js"></script>
	<script src="js/admin/jquery.dataTables.min.js"></script>
	<script src="js/admin/dataTables.bootstrap.min.js"></script>
	<script src="js/jquery/jquery.mousewheel.min.js"></script>
	<script src="js/jquery/jquery.PrintArea.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<%-- <script src="js/multipleChoice.js"></script> --%>
	<script src="js/admin/levelControl.js"></script>
	<%-- <script src="js/admin-menu.js"></script> --%>
	<script src="js/admin/admin-permission.js"></script>
	<script src="js/admin/sub_admin.js"></script>
	<script>
		$(function() {
			$('#example2').DataTable({
				paging : false,
				lengthChange : false,
				searching : false,
				ordering : true,
				info : false,
				autoWidth : false,
				serverSide : false
			});
		});
	</script>
	<script type="text/javascript">
		window.onresize = function() {
			var pagination = document.getElementsByClassName("pagination")[0];
			var pagingP1 = document.getElementsByClassName("pagingP1")[0];
			var pagingP2 = document.getElementsByClassName("pagingP2")[0];
			console.log(pagination.offsetLeft, pagingP2.offsetLeft,
					pagingP2.offsetWidth);
			if (pagination.offsetLeft <= pagingP2.offsetLeft
					+ pagingP2.offsetWidth
					&& pagination.offsetLeft != 0) {
				$(".pagination").hide();
			} else if (pagination.offsetLeft > pagingP2.offsetLeft
					+ pagingP2.offsetWidth) {
				$(".pagination").show();
			} else if (pagination.offsetLeft == 0) {
				$(".pagination").show();
				if (pagination.offsetLeft > pagingP2.offsetLeft
						+ pagingP2.offsetWidth) {
					$(".pagination").show();
				} else {
					$(".pagination").hide();
				}
			}
		}
	</script>
	<!-- Just to make our placeholder images work. Don't actually copy the next line! -->
	<%-- <script src="js/vendor/holder.js"></script> --%>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<%-- <script src="js/ie10-viewport-bug-workaround.js"></script> --%>
</body>
</html>
