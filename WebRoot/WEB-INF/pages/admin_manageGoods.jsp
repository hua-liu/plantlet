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
<link href="css/admin/animation.css" rel="stylesheet">
<link href="css/admin/admin.css" rel="stylesheet">
<link href="css/admin/multipleChoice.css" rel="stylesheet">
<link rel="stylesheet" href="css/admin/dataTables.bootstrap.css">
<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]><script src="js/ie8-responsive-file-warning.js" ></script><![endif]-->
<%-- <script src="js/ie-emulation-modes-warning.js"></script> --%>
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js" ></script>
    <![endif]-->
</head>

<body style="padding-top:0">
	<form action="ScopeSearch" method="post" id="ScopeSearch">
		<s:hidden name="classify" />
		<s:hidden name="state" />
		<s:hidden name="keywords" />
		<s:hidden name="size" />
		<s:hidden name="isShowChart" />
		<s:hidden name="currentPage"/>
	</form>
	<!-- <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
	<!-- <link href="css/menu.css" rel="stylesheet"> -->
	<div class="table-responsive">
		<table class="table table-hover" class="table table-bordered table-hover"
			role="grid" aria-describedby="example2_info">
			<thead>
				<tr>
					<th colspan="8">
						<div style="float:right">
							<div class="input-group">
								<input name="keywords" class="form-control" type="text"
									source-data="${keywords}" style="width:300px;"
									value="${keywords }" id="inputKeywords"
									placeholder='输入关键字搜索'/>
								<span class="input-group-addon" id="keywords-submit"
									style="max-width:40px;cursor:pointer;"><span
									class="glyphicon glyphicon-search"></span></span>
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
						aria-sort="descending">商品名字</th>
					<th class="sorting" tabindex="0" aria-controls="example2"
						rowspan="1" colspan="1"
						aria-label="Platform(s): activate to sort column ascending">库存</th>
					<th class="sorting" tabindex="0" aria-controls="example2"
						rowspan="1" colspan="1"
						aria-label="Platform(s): activate to sort column ascending">价格</th>
					<th class="sorting" tabindex="0" aria-controls="example2"
						rowspan="1" colspan="1"
						aria-label="Platform(s): activate to sort column ascending">销量</th>
					<th class="sorting" tabindex="0" aria-controls="example2"
						rowspan="1" colspan="1"
						aria-label="Platform(s): activate to sort column ascending">状态</th>
					<th class="sorting" tabindex="0" aria-controls="example2"
						rowspan="1" colspan="1"
						aria-label="Platform(s): activate to sort column ascending">所属分类</th>
					<th class="sorting" tabindex="0" aria-controls="example2"
						rowspan="1" colspan="1"
						aria-label="CSS grade: activate to sort column ascending">更多操作</th>
				</tr>
			</thead>
			<tbody class="tableContext">
				<s:iterator value="#request.list" status="s">
					<tr class="goodsList" data-id="${goodsId}">
						<td>${s.count}</td>
						<td><s:property value="name" default="-" /></td>
						<td><s:property value="inventory" default="-" /></td>
						<td><s:property value="price" default="-" /></td>
						<td><s:property value="sellsum" default="-" /></td>
						<td class="productState">
							<div class="mc">
								<p class="on">已上架</p>
								<p class="control"></p>
								<p class="off">未上架</p>
								<input type="hidden" value="${state.id==7?1:0}"
									class="mcControl" source-data="${state.id==7?1:0}">
							</div>
						</td>
						<td><s:property value="goodsKind.name" default="-" /></td>
						<td>
							<div class="btn-group">
								<button type="button" class="btn btn-default"
									data-toggle="dropdown" aria-expanded="false">高级选项<span class="caret"></span>
								</button>
								<ul class="dropdown-menu advanced" role="menu"
									data-id="${goodsId}">
									<s:if test="state.id==6">
										<li role="product" class="putawayProductLi"><a
											role="menuitem" tabindex="-1" href="javascript:void(0)">上架商品</a></li>
									</s:if>
									<s:elseif test="state.id==7">
										<li role="product" class="soldOutProductLi"><a
											role="menuitem" tabindex="-1" href="javascript:void(0)">下架商品</a></li>
									</s:elseif>
									<li role="product" class="updateProductLi"><a
										role="menuitem" tabindex="-1" href="javascript:void(0)">更新商品</a></li>
									<li role="product" class="deleteProductLi"><a
										role="menuitem" tabindex="-1" href="javascript:void(0)">删除商品</a></li>
									<li role="product" class="showProductLi"><a
										role="menuitem" tabindex="-1" href="javascript:void(0)">更多<span class="glyphicon glyphicon-option-horizontal"></span></a></li>

								</ul>
							</div>
						</td>
					</tr>
					<tr style="display:none">
						<td colspan="7" style="padding:0;margin:0">
							<div class="moreInformation" style="display:none;" data-id="${goodsId}">
							<table class="table table-bordered table-condensed" >
								<tr>
									<td style="width:50px;">商品上架时间</td><td>${shelfTime}</td>
									<td>商品颜色</td><td>${color}</td>
								</tr>
								<tr>
									<td>商品其它规格</td><td>${otherName}:${otherValue }</td>
								<td>商品网页ID</td><td>${explain.id}</td>
								</tr>
								<tr>
									<td>商品简述</td><td>${simpleDescript}</td>
									<td>商品分类详细</td><td><s:iterator value="moreKind">${name} </s:iterator></td>
								
								</tr>
							</table>
							</div>
							</td>
					</tr>
				</s:iterator>
			</tbody>
			<tfoot>
				<tr>
					<th colspan="7">
						<div class="paging" style="margin:0 auto;">
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
						</div>
					</th>
				</tr>
			</tfoot>
		</table>


	</div>

	<!--删除警告  -->
	<div class="alert alert-danger alert-dismissible fade in"
		id="deleteWarning" role="alert" data-id="">
		<button type="button" class="close closeWin">
			<span aria-hidden="true">×</span>
		</button>
		<h4>
			<strong>商品删除警告!</strong>
		</h4>确认要删除[<span class="deleteWarning-text"></span>]的商品吗？
		<br /> <br />

		<button type="button" class="btn btn-danger" id="sureDelete">确认删除</button>
		<button type="button" class="btn btn-default closeWin"
			style="margin-left:20px;width:100px">取消</button>
	</div>
	<script src="js/admin/map.js"></script>
	<script type="text/javascript">
		var totalPage = ${totalPage};
		var currentPage = ${currentPage};
		var rowsize = ${size};
		/* var isShowChart = ${isShowChart}; */
		var classify = ${classify};
		var putawayGoods = ${putawayGoods};
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
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/admin/admin-manageGoods.js"></script>
	<%-- <script src="js/jquery/jquery-ui.min.js"></script> --%>
	<script src="js/admin/jquery.dataTables.min.js"></script>
	<script src="js/admin/dataTables.bootstrap.min.js"></script>
	<script src="js/jquery/jquery.mousewheel.min.js"></script>
	<script src="js/jquery/jquery.PrintArea.js"></script>
	<%-- <script src="js/multipleChoice.js"></script> --%>
	<%-- 	<script src="js/admin/levelControl.js"></script> --%>
	<%-- <script src="js/admin-menu.js"></script> --%>
	<script src="js/admin/sub_admin.js"></script>
	<script src="js/admin/multipleChoice.js"></script>
	<%-- <script type="text/javascript">
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
	</script> --%>
	<!-- Just to make our placeholder images work. Don't actually copy the next line! -->
	<%-- 	<script src="js/vendor/holder.js"></script> --%>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<%-- <script src="js/ie10-viewport-bug-workaround.js"></script> --%>
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
