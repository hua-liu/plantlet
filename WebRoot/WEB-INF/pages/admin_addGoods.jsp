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
<link href="css/admin/admin-putaway.css" rel="stylesheet">
<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]><script src="js/ie8-responsive-file-warning.js" ></script><![endif]-->
<%-- <script src="js/ie-emulation-modes-warning.js"></script> --%>
<script src="js/jquery/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js" ></script>
    <![endif]-->
</head>
<body style="padding-top:0">
		<div class="putawayGoodsBox">
		<s:debug></s:debug>
			<!-- 产品开始 -->
			<div class="products" id="products">
			<s:if test="goodsId==null">
				<div class="alert alert-success alert-dismissible">
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<strong>添加商品流程:</strong>先提交商品基本信息-->再添加商品图片/网页/详细描述<br />
				</div>
				</s:if>
				<div class="col-md-6">
					<table class="goodsPicture">
						<tr>
							<td>
							<div>
							<s:if test="goodsId==null||breviaryPicture1==null">
								<img src="img/clickUploadGoodsPictrue.png" alt="点击上传商品缩略图"
									class="img-thumbnail goodsBreviary">
							</s:if>
							<s:else>
								<img src="json/download_file?isBreviary=1&id=<s:property value='breviaryPicture1'/>" alt="点击上传商品缩略图" class="img-thumbnail goodsBreviary">
							</s:else>
							</div>
							</td>
							<td rowspan="20" class="bigPictureTd">
							<s:if test="goodsId==null">
								<img src="img/clickUploadPicture.png" alt="点击上传商品图"
									class="img-thumbnail bigPicture">
							</s:if>
							<s:else>
								<img src="json/download_file?id=<s:property value='#request.goodsPictures[0].id'/>" alt="点击上传商品图"
									class="img-thumbnail bigPicture">
							</s:else>
								<div class="fileBox">
									<input type="file" id="file" name="file"
										accept="image/png,image/gif,image/jpeg">
								</div></td>
						</tr>
						<s:iterator value="#request.goodsPictures" status="c">
							<tr>
								<td><div><img src="json/download_file?id=${id}" alt="点击上传商品图"
									class="img-thumbnail <s:property value="#c.count==1?'checked':''"/>"><span class="deleteImg glyphicon glyphicon-remove"></span></div></td>
							</tr>
						</s:iterator>
						<s:if test="#request.goodsPictures==null">
						<tr>
							<td><div><img src="img/clickUploadPicture.png" alt="点击上传商品图"
								class="img-thumbnail checked"><span class="deleteImg glyphicon glyphicon-remove"></span></div></td>
						</tr>
						<tr>
							<td><div><img src="img/clickUploadPicture.png" alt="点击上传商品图"
								class="img-thumbnail"><span class="deleteImg glyphicon glyphicon-remove"></span></div></td>
						</tr>
						<tr>
							<td><div><img src="img/clickUploadPicture.png" alt="点击上传商品图"
								class="img-thumbnail"><span class="deleteImg glyphicon glyphicon-remove"></span></div></td>
						</tr>
						<tr>
							<td><div><img src="img/clickUploadPicture.png" alt="点击上传商品图"
								class="img-thumbnail"><span class="deleteImg glyphicon glyphicon-remove"></span></div></td>
						</tr>
						<tr>
							<td><div><img src="img/clickUploadPicture.png" alt="点击上传商品图"
								class="img-thumbnail"><span class="deleteImg glyphicon glyphicon-remove"></span></div></td>
						</tr>
						</s:if>
						<tr>
							<td><button class="btn btn-default" id="add-img">
									<h1 style="padding:0;margin:0;">+</h1>
								</button></td>
						</tr>
					</table>
				</div>
				<div class="col-md-6">
					<form action="addGoods" method="post" id="addGoodsForm">
						<table class="table goodsInformation">
							<tr class="goodsKindTr">
								<td style="max-width:50px">选择商品分类</td>
								<td><s:select name="goodsKindTemp"
										list="#request.goodsKind" listKey="id" class="form-control"
										listValue="name" theme="simple" data-toggle="popover"
										data-placement="top" data-content="必须选择一项分类"/></td>
							</tr>
							<%-- <tr class="moreKindTr">
							<s:if test="#request.moreKindAllChild==null">
								<script>
									$(".moreKindTr").hide();
								</script>
							</s:if>
								<td>选择详细分类</td>
								<td class="moreKindTd" data-toggle="popover"
									data-placement="top" data-content="至少选择一项分类">
									<s:iterator value="#request.moreKindAllChild">
										<label class="checkbox-inline"><input name="moreKindTemp" type="checkbox" value="${id}" <s:property value="%{id in moreKindTemp ? 'checked' : ''}"/>  >${name}</label>
									</s:iterator>
									</td>
							</tr> --%>
							<tr>
								<td>商品名称</td>
								<td><input type="text" name="name" class="form-control" value="${name}"
									placeholder="输入商品名称" data-toggle="popover" data-placement="top"
									data-content="商品名称不能为空"></td>
							</tr>
							<tr>
								<td>商品简述</td>
								<td><input type="text" name="simpleDescript" value="${simpleDescript}"
									placeholder="输入商品简述" class="form-control" data-toggle="popover"
									data-placement="top" data-content="商品简述不能为空"></td>
							</tr>
							<tr>
								<td>商品价格</td>
								<td>
									<div class="input-group" style="width:50%">
										<input type="number" class="form-control" name="price" value="${price}"
											id="exampleInputAmount" placeholder="Amount"
											data-toggle="popover" data-placement="top"
											data-content="商品价格不能为空">
										<div class="input-group-addon" style="width:20px;">¥</div>
									</div>

								</td>
							</tr>
							<tr>
								<td>库存数量</td>
								<td><input type="number" name="inventory" style="width:50%" value="${inventory}"
									placeholder="输入库存数量" class="form-control" data-toggle="popover"
									data-placement="top" data-content="库存数量不能为空"></td>
							</tr>
							<tr class="isSaleControl">
								<td>是否打折</td>
								<td><div class="mc">
										<p class="on">ON</p>
										<p class="control"></p>
										<p class="off">OFF</p>
										<input type="hidden" value="${isSale}" class="mcControl" name="isSale">
									</div></td>
							</tr>
							<tr class="isSale">
								<td>打折后价格</td>
								<td><div class="input-group" style="width:50%">
										<input type="number" class="form-control" name="salePrice" value="${salePrice}"
											placeholder="Amount" data-toggle="popover"
											data-placement="top" data-content="商品价格不能为空">
										<div class="input-group-addon" style="width:20px;">¥</div>
									</div></td>
							</tr>
							<tr class="isSale">
								<td>打折结束时间</td>
								<td><input type="date" placeholder="格式：yyyy/mm/dd"  value='<s:date name="saleTime" format="yyyy-MM-dd"/>'
									name="saleTime" class="form-control" style="width:50%"
									data-toggle="popover" data-placement="top"
									data-content="打折时间不能为空"></td>
							</tr>
							<s:if test="isSale==0">
								<script>
									$(".isSale").hide();
								</script>
							</s:if>
							<tr class="goodsSizeTr" style="display:none;">
								<td>商品尺寸</td>
								<td>&nbsp;
									<div>
										<s:iterator var="n" begin="35" end="50">
											<label class="checkbox-inline"> <input
												name="goodsSize" type="checkbox"
												id="inlineCheckbox<s:property value='n'/>"
												value="<s:property value='n'/>"> <s:property
													value='n' />
											</label>
										</s:iterator>
										<input type="text" name="goodsSize" placeholder="输入其它尺寸[空格割开]"
											style="width:50%;margin-left:5px;">
								</td>
							</tr>
							<tr>
								<td>商品颜色</td>
								<td>
								<s:iterator value="colors" var="c">
									<input type='color' name='color' value="${c}">
								</s:iterator>
									<button class="addColor" type="button">+</button>
								</td>
							</tr>
							<tr>
								<td style="width:100px;"><input type="text" value="${otherName }"
									name="otherName" placeholder="规格名称" class="form-control"
									style="width:100px;"></td>
								<td><input type="text" placeholder="输入商品规格[空格割开]" value="${otherValue }"
									class="form-control" name="otherValue"></td>
							</tr>
							<tr>
								<s:hidden name="goodsId"></s:hidden>
								<td colspan="4">
									<button class="btn btn-default" type="button"
										onclick="clearErrorPrompt()">清除所有错误提示</button>
										<s:if test="goodsId==null">
									<button class="btn btn-default" type="reset"
										onclick="clearAllForm()">添加新商品</button>
										</s:if>
									<button class="btn btn-primary" type="button"
										id="addGoodsButton" data-toggle="popover" data-placement="top"
										data-content="信息填写有误">提交商品基本信息</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<!-- collapse-tabs -->
				<div class="collpse tabs">
					<h3 class="w3ls-title">　</h3>
					<div class="panel panel-default" style="margin-top:50px;">
					<button class="btn btn-default clickUploadHtml">上传商品展示网页</button>
						<div class="panel-heading" role="tab">
							<h4 class="panel-title">
								<a class="collapsed pa_italic" role="button"
									data-toggle="collapse" data-parent="#accordion"
									href="#collapseTwo" aria-expanded="false"
									aria-controls="collapseTwo"> <i
									class="fa fa-info-circle fa-icon" aria-hidden="true"></i> 商品展示页
									<span class="fa fa-angle-down fa-arrow" aria-hidden="true"></span>
									<i class="fa fa-angle-up fa-arrow" aria-hidden="true"></i>
								</a>
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse in"
							role="tabpanel" aria-labelledby="headingTwo">
							<div class="panel-body">
								<s:hidden name="goodsExplainId"></s:hidden>
								<div class="goodsExplainBox">
									<div class="htmlfileBox">
										<input type="file" id="htmlfile" name="htmlfile"
											multiple="multiple"
											accept="text/html,image/jpeg,image/png,image/gif,text/css">
									</div>
									<div class="alert alert-warning alert-dismissible">
										<button type="button" class="close" data-dismiss="alert"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<strong>温馨提示!</strong>上传文件中必须有一个名为“index.html”的主页，所有图片，css文件需入在同一级文件夹<br />
										<strong>规格如下图：</strong><br /> <img alt="模板"
											src="img/goodsExplain.png" />
									</div>
								</div>
								<s:if test="#request.explain!=null">
									<iframe src='<s:property value="#request.explain"/>' id="iframepage" name="iframepage" frameBorder=0 scrolling=no width="100%"></iframe>
									<script>
									$(".goodsExplainBox").hide();
								</script>
								</s:if>
							</div>
						</div>
					</div>
				</div>
				<!-- //collapse -->
			</div>
			<!--//products-->
		</div>
	<script src="js/fileUpload/ajaxfileupload.js"></script>
	<script src="js/admin/admin-addGoods.js"></script>
	<script src="js/admin/map.js"></script>
	<script type="text/javascript">
		/* var totalPage = ${totalPage};
		var currentPage = ${currentPage};
		var rowsize = ${size};
		var isShowChart = ${isShowChart}; */
	/* 	var classify = ${classify}; */
		/* var putawayGoods = ${putawayGoods}; */
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
	<%-- <script src="js/jquery-ui.min.js"></script> --%>
	<%-- 	<script src="js/jquery/jquery.PrintArea.js"></script> --%>

	<script src="js/admin/multipleChoice.js"></script>
	<!-- Just to make our placeholder images work. Don't actually copy the next line! -->
	<%-- 	<script src="js/vendor/holder.js"></script> --%>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<%-- <script src="js/ie10-viewport-bug-workaround.js"></script> --%>
</body>
</html>
