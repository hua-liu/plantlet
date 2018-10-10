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
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面,任何其他内容都*必须*跟随其后！ -->
<meta name="description" content="">
<meta name="author" content="">
<title>UserManage</title>
<link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="bootstrap/css/ionicons.min.css">
<link rel="stylesheet" href="css/admin/AdminLTE.min.css">
<link rel="stylesheet" href="css/admin/dataTables.bootstrap.css">
<link rel="stylesheet" href="css/admin/background.css">
<link rel="stylesheet" href="css/admin/admin.css">
<script src="js/ie/respond.min.js"></script>
</head>
<body style="padding:0;">
	<!-- <div class="container-fluid "> -->
	<!--删除警告  -->
	<div class="alert alert-danger alert-dismissible fade in"
		id="deleteWarning" role="alert" data-id="">
		<button type="button" class="close closeWin">
			<span aria-hidden="true">×</span>
		</button>
		<h4>
			<strong>删除用户警告!</strong>
		</h4>
		确定要删除：[<span class="deleteWarning-text"></span>]的用户吗？
		<br /> <br />

		<button type="button" class="btn btn-danger" id="sureDelete">确认删除</button>
		<button type="button" class="btn btn-default closeWin"
			style="margin-left:20px;width:100px">取消</button>
	</div>
	<!--删除警告结束  -->

	<!-- 数据内容开始 -->
	<!-- <h2 class="sub-header">Section title</h2> -->
	<!-- <div class="row"> -->
	<!-- <div class="col-xs-12"> -->
	<!-- /.box-header -->
	<form action="ScopeSearch" method="post" id="ScopeSearch">
		<s:hidden name="classify" />
		<s:hidden name="state" />
		<s:hidden name="keywords" />
		<s:hidden name="size" />
		<s:hidden name="isShowChart" />
		<s:hidden name="currentPage" id="currentPage" />
	</form>
	<div class="box-body"
		style="min-height:520px;padding:5px;padding-bottom:35px;">
		<table id="example2" class="table table-bordered table-hover"
			role="grid" aria-describedby="example2_info">
			<thead>
				<tr>
					<th colspan="7">
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
						aria-label="CSS grade: activate to sort column ascending">账户状态</th>
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
						<td>${state.name=="inactive"?'未激活':state.name=="normal"?'正常':'已锁定'}</td>
						<td><div class="btn-group">
								<button type="button" class="btn btn-default dropdown-toggle"
									data-toggle="dropdown" aria-expanded="false">高级选项<span class="caret"></span>
								</button>
								<ul class="dropdown-menu advanced" role="menu" data-id="${id}">
									<li role="presentation" data-toggle="modal"
										data-target="#updateModal"><a role="menuitem"
										tabindex="-1" href="javascript:void(0)">更新</a></li>
									<li role="presentation"><a role="menuitem" tabindex="-1"
										href="javascript:void(0)">删除</a></li>
									<li role="presentation" data-toggle="modal"
										data-target="#myModal"><a role="menuitem" tabindex="-1"
										href="javascript:void(0)">显示更多</a></li>
								</ul>
							</div></td>
					</tr>
				</s:iterator>
			</tbody>
			<%-- <s:if test="#request.list.size>9">
						
							</s:if> --%>
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
	</div>

	<!-- /.box-body -->

	<div class="modal fade" id="updateModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">
						更新用户信息(以下为可修改字段)
					</h4>
				</div>
				<div class="modal-body">
					<table class="table">
						<tbody>
							<tr>
								<td><div class="input-group">
										<span class="input-group-addon">用户名：</span>
										<input id="update.username" type="text" class="form-control"
											data-placement="top"
											data-content='用户名格式错误'
											placeholder='填写用户名' />
									</div></td>
							</tr>
							<tr>
								<td><div class="input-group">
										<span class="input-group-addon">邮箱：</span>
										<input id="update.email" type="text" class="form-control"
											data-placement="top"
											data-content="邮箱地址格式错误"
											placeholder='填写邮箱地址'>
									</div></td>
							</tr>
							<tr>
								<td><div class="input-group">
										<span class="input-group-addon">手机号：</span>
										<input id="update.phone" type="text" class="form-control"
											data-placement="top"
											data-content="手机号码格式错误"
											placeholder='填写手机号'>
									</div></td>
							</tr>
							<tr>
								<td><div class="input-group">
										<span class="input-group-addon">昵称：</span>
										<input id="update.nickname" type="text" class="form-control"
											data-placement="top"
											data-content="昵称格式错误"
											placeholder='填写用户昵称'>
									</div></td>
							</tr>
							<tr>
								<td><div class="input-group" id="update-state">
										<span class="input-group-addon">账户状态：</span>
										<div style="margin-left:10px;">
											<s:iterator var="s" value="#request.userAllState">
												<label class="radio-inline"> <input type="radio"
													name="inlineRadioOptions" id="inlineRadio${s.id}"
													data-id="${s.id }" value="${s.id}"> ${s.name}
												</label>
											</s:iterator>
										</div>
									</div></td>
							</tr>
							<tr>
								<td>修改注意事项：以上信息都必需保证其唯一性；
									<button type="button" class="btn btn-primary btn-md"
										id="changeNorm">阅读修改规范
									</button> <input type="hidden" id="update.id"></td>
							</tr>
							<tr>
								<td class="changeNorm">
									<div class="alert alert-success" role="alert">
										<strong>用户名！</strong>长度需在5-20位,由字母数字组成,不能含有特殊字符,且必须以字母开头</div>
									<div class="alert alert-success" role="alert">
										<strong>邮箱！</strong>保证其有效性</div>
									<div class="alert alert-success" role="alert">
										<strong>手机号！</strong>保证其有效性</div>
									<div class="alert alert-success" role="alert">
										<strong>昵称！</strong>长度在1-20位,可由任意字符组成,不能以空格开头</div>
									<div class="alert alert-success" role="alert">
										<strong>警告！</strong>以上信息不是必需的,用户名、邮箱、手机号必须有其一</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="update.submit"
						data-placement="left"
						data-content='表单填写有误，请阅读修改规范'>更新信息</button>
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
					<h4 class="modal-title">用户详细信息</h4>
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
	<script src="js/admin/map.js"></script>
	<script type="text/javascript">
		var totalPage = ${totalPage};
		var currentPage = ${currentPage};
		var rowsize = ${size};
		/* var isShowChart = ${isShowChart}; */
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
	<!-- Bootstrap core JavaScript
================================================== -->
	<!-- jQuery 2.2.3 -->
	<script src="js/jquery/jquery.min.js"></script>
	<script src="js/jquery/jquery.PrintArea.js"></script>
	<!-- Bootstrap 3.3.6 -->
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/admin/jquery.dataTables.min.js"></script>
	<script src="js/admin/dataTables.bootstrap.min.js"></script>
	<!-- FastClick -->
	<script src="js/admin/fastclick.min.js"></script>
	<!-- AdminLTE App -->
	<script src="js/admin/app.min.js"></script>
	<script src="js/admin/admin-user.js"></script>
	<script src="js/admin/sub_admin.js"></script>
	<!-- SlimScroll 1.3.0 -->
	<script src="js/admin/jquery.slimscroll.min.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
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
</body>
</html>
