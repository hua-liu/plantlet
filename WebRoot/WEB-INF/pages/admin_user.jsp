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
			<strong><s:text name="userDeleteWarning" />!</strong>
		</h4>
		<s:text name="sureWantDelete" />
		<span class="deleteWarning-text"></span>]
		<s:text name="ofuser" />
		<br /> <br />

		<button type="button" class="btn btn-danger" id="sureDelete">
			<s:text name="sureDelete" />
		</button>
		<button type="button" class="btn btn-default closeWin"
			style="margin-left:20px;width:100px">
			<s:text name="cancel" />
		</button>
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
							name="accountState" /></th>
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
						<td><s:text name="%{getText(state.name)}" /></td>
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
												name="update" /></a></li>
									<li role="presentation"><a role="menuitem" tabindex="-1"
										href="javascript:void(0)"><s:text name="delete" /></a></li>
									<li role="presentation" data-toggle="modal"
										data-target="#myModal"><a role="menuitem" tabindex="-1"
										href="javascript:void(0)"><s:text name="showMore" /></a></li>
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
										<span class="input-group-addon"><s:text name="username" />：</span>
										<input id="update.username" type="text" class="form-control"
											data-placement="top"
											data-content='<s:text name="usernameFormatError"/>'
											placeholder='<s:text name="inputUsername"/>' />
									</div></td>
							</tr>
							<tr>
								<td><div class="input-group">
										<span class="input-group-addon"><s:text name="email" />：</span>
										<input id="update.email" type="text" class="form-control"
											data-placement="top"
											data-content="<s:text name="errorFormatError"/>"
											placeholder='<s:text name="inputEmail"/>'>
									</div></td>
							</tr>
							<tr>
								<td><div class="input-group">
										<span class="input-group-addon"><s:text name="phone" />：</span>
										<input id="update.phone" type="text" class="form-control"
											data-placement="top"
											data-content="<s:text name="phoneFormatError"/>"
											placeholder='<s:text name="inputPhone"/>'>
									</div></td>
							</tr>
							<tr>
								<td><div class="input-group">
										<span class="input-group-addon"><s:text name="nickname" />：</span>
										<input id="update.nickname" type="text" class="form-control"
											data-placement="top"
											data-content="<s:text name="nicknameFormatError"/>"
											placeholder='<s:text name="inputNickname"/>'>
									</div></td>
							</tr>
							<tr>
								<td><div class="input-group" id="update-state">
										<span class="input-group-addon"><s:text name="state" />：</span>
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
								<td><s:text name="changeWarningItems" />
									<button type="button" class="btn btn-primary btn-md"
										id="changeNorm">
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
										<s:text name="emailNorm" />
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
					<button type="button" class="btn btn-primary" id="update.submit"
						data-placement="left"
						data-content='<s:text name="formErrorPleaseReadNorm"/>'>
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
	<%-- <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script src="js/jquery.PrintArea.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/multipleChoice.js"></script>
	<script src="js/admin-menu.js"></script>
	<script src="js/admin-user.js"></script>
	<!-- Just to make our placeholder images work. Don't actually copy the next line! -->
	<script src="js/vendor/holder.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="js/ie10-viewport-bug-workaround.js"></script> --%>
</body>
</html>
