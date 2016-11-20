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
	<!-- 删除警告  -->
	<s:if test="classify==4&&function==1">
		<div class="alert alert-danger alert-dismissible fade in"
			id="deleteWarning" role="alert" data-id="" style="width:450px">
			<button type="button" class="close closeWin">
				<span aria-hidden="true">×</span>
			</button>
			<h4>
				<strong>踢出管理员警告!</strong>
			</h4>
			确定要将：<span class="deleteWarning-text"></span>直接踢出管理?<br /> <br />

			<button type="button" class="btn btn-danger" id="sureDelete">确认踢出</button>
			<button type="button" class="btn btn-default closeWin"
				style="margin-left:20px;width:100px">取消</button>
		</div>
	</s:if>
	<s:elseif test="classify==4&&function==2">
		<div class="alert alert-danger alert-dismissible fade in"
			id="deleteRoleWarning" role="alert" data-id="">
			<button type="button" class="close closeWin">
				<span aria-hidden="true">×</span>
			</button>
			<h4>
				<strong>删除角色警告!</strong>
			</h4>确认要将：角色名<span class="deleteWarning-text"></span>的删除吗?<br /> <br />

			<button type="button" class="btn btn-danger" id="sureDeleteRole">确认删除</button>
			<button type="button" class="btn btn-default closeWin"
				style="margin-left:20px;width:100px">取消</button>
		</div>
	</s:elseif>
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
								data-toggle="modal" data-target="#addManager">添加管理员</button>
							<div style="float:right">
							<div class="input-group">
								<input name="keywords" class="form-control" type="text"
									source-data="${keywords}" style="width:300px;"
									value="${keywords }" id="inputKeywords"
									placeholder='输入关键字搜索' />
									<span class="input-group-addon" id="keywords-submit" style="max-width:40px;cursor:pointer;"><span class="glyphicon glyphicon-search"></span></span>
							</div>
						</div></th>
					</tr>
					<tr role="row">
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Rendering engine: activate to sort column ascending">序号</th>
						<th class="sorting_desc" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Browser: activate to sort column ascending"
							aria-sort="descending">用户名</th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Platform(s): activate to sort column ascending">昵称</th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Engine version: activate to sort column ascending">手机号</th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="CSS grade: activate to sort column ascending">邮箱</th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="CSS grade: activate to sort column ascending">当前角色</th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="CSS grade: activate to sort column ascending">更多操作</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="#request.list" status="s">
							<tr class="userList" data-id="${id}">
							<td>${s.count}</td>
							<td><s:property value="username" default="-" /></td>
							<td><s:property value="nickname" default="-" /></td>
							<td><s:property value="phone" default="-" /></td>
							<td><s:property value="email" default="-" /></td>
							<td>${role.name}</td>
							<td><div class="btn-group">
									<button type="button" class="btn btn-default dropdown-toggle"
										data-toggle="dropdown" aria-expanded="false">高级选项<span class="caret"></span>
									</button>
									<ul class="dropdown-menu advanced" role="menu" data-id="${id}">
										<li role="presentation" data-toggle="modal"
											data-target="#updateModal"><a role="menuitem"
											tabindex="-1" href="javascript:void(0)">权限变更</a></li>
										<li role="presentation"><a role="menuitem" tabindex="-1"
											href="javascript:void(0)">直接踢出管理</a></li>
										<li role="presentation" data-toggle="modal"
											data-target="#myModal"><a role="menuitem" tabindex="-1"
											href="javascript:void(0)">显示更多</a></li>
									</ul>
								</div></td>
						</tr>
					</s:iterator>
				</tbody>
				<tfoot>
					<tr>
						<th colspan="7"><div class="paging" style="margin:0 auto;">
								<p class="pagingP1">
								总记录<span>&nbsp;${totalNum}&nbsp;</span>条
							</p>
							<p class="pagingP2">
								第<span>&nbsp;${currentPage}&nbsp;</span>页/总<span>&nbsp;${totalPage}&nbsp;</span>页
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
										data-placement="top" title="上一页">
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
										data-placement="top" title="下一页"
										style="margin-right:20px"><span
											class="glyphicon glyphicon-arrow-right"></span></a></li>
								</s:else>
							</ul>
							<div class="selectPage">跳转至<input type="text" maxlength="5" value="${currentPage }"
									id="goto" data-toggle="tooltip" data-placement="top"
									title="回车跳转" />页</div>
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
								data-toggle="modal" data-target="#addRole">添加角色</button>
							<div style="float:right">
							<div class="input-group">
								<input name="keywords" class="form-control" type="text"
									source-data="${keywords}" style="width:300px;"
									value="${keywords }" id="inputKeywords"
									placeholder='输入关键字搜索' />
									<span class="input-group-addon" id="keywords-submit" style="max-width:40px;cursor:pointer;"><span class="glyphicon glyphicon-search"></span></span>
							</div>
						</div></th>
					</tr>
					<tr role="row">
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Rendering engine: activate to sort column ascending">序号</th>
						<th class="sorting_desc" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Browser: activate to sort column ascending"
							aria-sort="descending">角色名</th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Platform(s): activate to sort column ascending">拥有的权限</th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="CSS grade: activate to sort column ascending">更多操作</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="#request.list" status="s">
						<tr class="roleList" data-id="${id}">
							<td>${s.count}</td>
							<td>${name}</td>
							<td><s:iterator value="permissions" status="s">
									<s:if test="#s.count>1">
										<strong>|</strong>
									</s:if>${name}
								</s:iterator></td>
							<td>

								<div class="btn-group">
									<button type="button" class="btn btn-default dropdown-toggle"
										data-toggle="dropdown" aria-expanded="false">高级选项<span class="caret"></span>
									</button>
									<ul class="dropdown-menu advancedRole" role="menu"
										data-id="${id}">
										<li role="presentation" data-toggle="modal"
											data-target="#updateRole"><a role="menuitem"
											tabindex="-1" href="javascript:void(0)">权限变更</a></li>
										<li role="presentation"><a role="menuitem" tabindex="-1"
											href="javascript:void(0)">删除角色</a></li>
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
								总记录
								<span>&nbsp;${totalNum}&nbsp;</span>
								条
							</p>
							<p class="pagingP2">
								第<span>&nbsp;${currentPage}&nbsp;</span>页
								/
								总<span>&nbsp;${totalPage}&nbsp;</span>页
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
										data-placement="top" title="上一页">
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
										data-placement="top" title="下一页"
										style="margin-right:20px"><span
											class="glyphicon glyphicon-arrow-right"></span></a></li>
								</s:else>
							</ul>
							<div class="selectPage">
								跳转至<input type="text" maxlength="5" value="${currentPage }"
									id="goto" data-toggle="tooltip" data-placement="top"
									title="回车跳转" />页
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
									placeholder='输入关键字搜索' />
									<span class="input-group-addon" id="keywords-submit" style="max-width:40px;cursor:pointer;"><span class="glyphicon glyphicon-search"></span></span>
							</div>
						</div>
						</th>
					</tr>
					<tr role="row">
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Rendering engine: activate to sort column ascending">序号</th>
						<th class="sorting_desc" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Browser: activate to sort column ascending"
							aria-sort="descending">权限名</th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="Platform(s): activate to sort column ascending">序号</th>
						<th class="sorting" tabindex="0" aria-controls="example2"
							rowspan="1" colspan="1"
							aria-label="CSS grade: activate to sort column ascending">权限名</th>
					</tr>
				</thead>
				<tbody>
					<tr class="permissionList">
						<s:iterator value="#request.list" status="s">
							<td>${s.count}</td>
							<td>${name}</td>
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
								总记录
								<span>&nbsp;${totalNum}&nbsp;</span>
								条
							</p>
							<p class="pagingP2">
								第<span>&nbsp;${currentPage}&nbsp;</span>页
								/
								总<span>&nbsp;${totalPage}&nbsp;</span>页
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
										data-placement="top" title="上一页">
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
										data-placement="top" title="下一页"
										style="margin-right:20px"><span
											class="glyphicon glyphicon-arrow-right"></span></a></li>
								</s:else>
							</ul>
							<div class="selectPage">
								跳转至
								<input type="text" maxlength="5" value="${currentPage }"
									id="goto" data-toggle="tooltip" data-placement="top"
									title="回车跳转" />
								页
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
						<h4 class="modal-title">更新用户信息(以下为可修改字段)
						</h4>
					</div>
					<div class="modal-body">
						<table class="table">
							<tbody>
								<tr>
									<td><div class="input-group">
											<span class="input-group-addon">用户名：</span> <input id="update.username"
												type="text" class="form-control" data-placement="top"
												data-content="用户名格式错误"
												placeholder="填写用户名">
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group">
											<span class="input-group-addon">邮箱：</span>
											<input id="update.email" type="text" class="form-control"
												data-placement="top"
												data-content="邮箱地址格式错误"
												placeholder="填写邮箱">
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group">
											<span class="input-group-addon">手机号：</span>
											<input id="update.phone" type="text" class="form-control"
												data-placement="top"
												data-content="手机号码格式错误"
												placeholder="填写手机号">
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group">
											<span class="input-group-addon">昵称：</span> <input id="update.nickname"
												type="text" class="form-control" data-placement="top"
												data-content="昵称格式错误"
												placeholder="填写用户昵称">
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group" id="update-role">
											<span class="input-group-addon">角色名：</span>
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
									<td>修改注意事项：以上信息都必需保证其唯一性；
										<button type="button"
											class="btn btn-primary btn-md changeNormButton">阅读修改规范</button> <input type="hidden" id="update.id"></td>
								</tr>
								<tr>
									<td class="changeNorm">
										<div class="alert alert-success" role="alert">
											<strong>用户名！</strong>
											长度需在5-20位,由字母数字组成,不能含有特殊字符,且必须以字母开头
										</div>
										<div class="alert alert-success" role="alert">
											<strong>邮箱！</strong>保证其有效性
										</div>
										<div class="alert alert-success" role="alert">
											<strong>手机号！</strong>保证其有效性
										</div>
										<div class="alert alert-success" role="alert">
											<strong>昵称！</strong>长度在1-20位,可由任意字符组成,不能以空格开头
										</div>
										<div class="alert alert-success" role="alert">
											<strong>注意！</strong>以上信息不是必需的,用户名、邮箱、手机号必须有其一
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="update_submit"
							data-placement="left"
							data-content="信息填写有误，请阅读修改规范">更新信息</button>
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
						<h4 class="modal-title">用户更多信息</h4>
					</div>
					<div class="modal-body" id="printContext">
						<table class="table">
							<tbody id="moreInfor">
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="printUser">打印</button>
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
						<h4 class="modal-title">添加管理员</h4>
					</div>
					<div class="modal-body">
						<table class="table">
							<tbody>
								<tr>
									<td><div class="input-group" id="add-user"
											data-toggle="popover" data-placement="top"
											data-content="必须至少选择一位用户！">
											<span class="input-group-addon">用户：</span>
											<div class="add_username">
												<div>
													<!-- 多加一个div是为了适应bootstrap -->
													<ul id="add_username_ul">
														<li id="add_username_input_li"><input
															id="add_username_input" type="text" source-data=""
															placeholder="输入关键字搜索"></li>
													</ul>
												</div>
												<div class="list-group autoComplate"
													id="autoComplateContext">
													<p>查询结果：总&nbsp;<strong><span id="searcRresult">0</span></strong>&nbsp;条记录</p>
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
											data-content="选择赋予的角色 ！">
											<span class="input-group-addon" style="width:50px">角色：</span>
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
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="suerAddManager"
							data-toggle="popover" data-placement="left"
							data-content="添加管理员失败">添加</button>
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
							<h4 class="modal-title">选择用户</h4>
						</div>
						<div class="modal-body">
							<table class="table">
								<thead>
									<tr>
										<th>序号</th>
										<th>用户名</th>
										<th>邮箱</th>
										<th>手机号</th>
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
								<span class="input-group-addon">查询结果：总&nbsp;<strong><span
										class="showTotalNum">0</span></strong>&nbsp;条 </span>
								<div class="input-group selectUserSearchInput"
									style="width:350px">
									<input type="text" class="form-control"
										id="selectUserSearchContext"
										placeholder="输入关键字搜索"> <span
										class="input-group-addon" id="selectUserListSearch"
										style="width:50px"> <span
										class="glyphicon glyphicon-search"></span>
									</span>
									<!-- /input-group -->
								</div>
								<button type="button" class="btn btn-default addLinManClose">关闭</button>
								<button type="button" class="btn btn-primary addLinManClose">确定</button>
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
						<h4 class="modal-title">添加角色</h4>
					</div>
					<div class="modal-body">
						<table class="table">
							<tbody>
								<tr>
									<td><div class="input-group has-feedback" id="add_role">
											<span class="input-group-addon">角色名：</span> <input type="text"
												class="form-control" id="addRole_input" data-placement="top"
												data-content="角色名格式错误"
												placeholder="填写角色名"> <span
												id="add_role_icon" class="form-control-feedback"
												aria-hidden="true"></span> <span id="inputError2Status"
												class="sr-only">(error)</span>
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group" id="add_permission"
											data-placement="top"
											data-content="必须至少选择一项！">
											<span class="input-group-addon">权限名：</span>
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
											<span class="input-group-addon">控制级别：</span>
											<div class="level">
												<p class="level-control" data-toggle="tooltip"
													data-placement="top" title="150" id="level-control"></p>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td>添加角色注意事项：
										<button type="button"
											class="btn btn-primary btn-md changeNormButton">阅读修改规范</button></td>
								</tr>
								<tr>
									<td class="changeNorm">
										<div class="alert alert-success" role="alert">
											<strong>角色名！</strong>长度需在5-20位,由字母数字组成,不能含有特殊字符,且必须以字母开头
										</div>
										<div class="alert alert-success" role="alert">
											<strong>权限！</strong>必须选择一项，不能赋予当前角色没有的权限
										</div>
										<div class="alert alert-success" role="alert">
											<strong>控制级别！</strong>最终控制级别会在当前操作角色级别加上设置的控制级别,0表示与当前操作角色控制级别一样
										</div>
										<div class="alert alert-success" role="alert">
											<strong>注意！</strong> 控制级别低的不能操作控制级别高的
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="suerAddRole"
							data-placement="left"
							data-content="添加失败！请阅读修改规则...">添加</button>
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
						<h4 class="modal-title">更新角色
						</h4>
					</div>
					<div class="modal-body">
						<table class="table">
							<tbody>
								<tr>
									<td><div class="input-group has-feedback" id="update_role">
											<span class="input-group-addon">角色名：</span> <input type="text"
												class="form-control" id="updateRole_input" disabled>
										</div></td>
								</tr>
								<tr>
									<td><div class="input-group" id="update_permission"
											data-placement="top"
											data-content="必须至少选择一项！">
											<span class="input-group-addon">权限名：</span>
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
											<span class="input-group-addon">控制级别：</span>
											<div class="level">
												<p class="level-control" data-toggle="tooltip"
													data-placement="top" title="150" id="update_level_control"></p>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td>修改角色注意事项：
										<button type="button"
											class="btn btn-primary btn-md changeNormButton">阅读修改规范</button></td>
								</tr>
								<tr>
									<td class="changeNorm">
										<div class="alert alert-success" role="alert">
											<strong>权限！</strong>必须至少选择一项
										</div>
										<div class="alert alert-success" role="alert">
											<strong>控制级别！</strong>最终控制级别会在当前操作角色级别加上设置的控制级别,0表示与当前操作角色控制级别一样
										</div>
										<div class="alert alert-success" role="alert">
											<strong>注意！</strong>控制级别低的不能操作控制级别高的
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="suerUpdateRole"
							data-placement="left"
							data-content="更新失败！请阅读修改规则...">更新</button>
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
