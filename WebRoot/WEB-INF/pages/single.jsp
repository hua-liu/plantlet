<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//聊天服务头
	String serverPath="ws://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<title>SinglePage</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/cart.css" rel="stylesheet" type="text/css" media="all" />
<!-- font-awesome icons -->
<link href="css/font-awesome.css" rel="stylesheet">
<!-- <link href="css/sidebar/component.css" rel="stylesheet"> -->
<link href="css/sidebar/components-right.css" rel="stylesheet">
<!-- //font-awesome icons -->
<!-- js -->
<script src="js/jquery/jquery.min.js"></script>
<%-- <script src="js/owl.carousel.js"></script> --%>
<script src="bootstrap/js/bootstrap.min.js"></script>
<link href="css/admin/animation.css" rel="stylesheet">
<!--聊天-->
<link rel="stylesheet" href="css/admin/AdminLTE.min.css">
<link href="css/chat.css" rel="stylesheet">
<link href="css/colorpicker/bootstrap-colorpicker.min.css" rel="stylesheet" type="text/css" />
<!--/聊天-->
<script src="js/MagicZoom.js"></script>
<!-- //js -->
<!-- scroll to fixed-->
<script src="js/jquery-scrolltofixed-min.js" type="text/javascript"></script>
<!-- //scroll to fixed-->
<!-- start-smooth-scrolling -->
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event) {
			event.preventDefault();
			$('html,body').animate({
				scrollTop : $(this.hash).offset().top
			}, 1000);
		});
	});
</script>
<!-- //end-smooth-scrolling -->
<!-- smooth-scrolling-of-move-up -->
<script type="text/javascript">
	$(document).ready(function() {

		var defaults = {
			containerID : 'toTop', // fading element id
			containerHoverID : 'toTopHover', // fading element hover id
			scrollSpeed : 1200,
			easingType : 'linear'
		};

		$().UItoTop({
			easingType : 'easeOutQuart'
		});

	});
</script>
<!-- //smooth-scrolling-of-move-up -->
<style type="text/css">
body {
	background: #FAFAFA;
}
.single-page {
	border: 1px solid #E0E0E0;
}

li {
	list-style: none;
}

.flexslider .slides {
	margin: 10px 5px;
	width: 450px;
	height: 80px;
}

.flexslider .slides li {
	width: 80px;
	height: 80px;
	float: left;
	margin: 0 2px;
}

.flexslider .slides li:hover {
	cursor: pointer;
}

.flexslider .slides li img {
	width: 100%;
	height: 100%;
}

.big-img>a>img {
	width: 100%;
	height: 100%;
}

.single-rating li {
	float: left;
}

.priceTd {
	font-family: 宋体;
	font-size: 20px;
	font-weight: bold;
}

.table tr td:first-child {
	color: #aaa;
	font-size: 10px;
}

#buyNumMade span {
	cursor: pointer;
}

a:hover {
	cursor: pointer;
}
.popover-content{
	color:#000;
}
.color{
	width:30px;height:30px;float:left;
	border:1px solid #CCC;margin:0 2px;
}
.color:hover{
	cursor:pointer;
}
.color.checked{
	border:4px solid #555;
}
</style>
</head>
<body>
<div class="bodyLoader" style="width:100%;height:100%;position:absolute;top:0;left:0;background:rgba(0,0,0,0.4);z-index:1500"><div class="loader-inner square-spin" style="top:48%;left:48%;position:absolute;"><div style="border:none;background:#1E90FF"></div></div></div>
	<!-- 购物车开始  -->
	<div id="st-container" class="st-container">
	<s:if test="#session.user!=null">
		<nav class="st-menu st-effect-13" id="menu-13"> 
		<div class="toolbar-main toolbar-mini-cart-main">
			<div class="toolbar-hd">
				<div class="toolbar-hd-title"><s:text name="shoppingCart"/></div>
			</div>
			<div class="toolbar-bd">
				<div class="mini-cart-list">
					<div class="mini-cart-list-hd">
						<div class="mini-cart-list-title"><s:text name="newestBaby"/></div>
					</div>
					<div class="mini-cart-list-bd">
						<ul class="mini-cart-items-list">
							<s:if test="#session.user!=null">
								<s:iterator value="#session.orderForms">
									<li data-id="${id}"><div class="mini-cart-item">
									<div class="mini-cart-item-pic"><img src="json/download_file?isBreviary=1&id=${goods.breviaryPicture.id}"></div>
									<div class="mini-cart-item-info"><div class="mini-cart-item-title">${goods.name}</div>
									<div class="mini-cart-item-price"><i class="fa fa-rmb"></i><span class="cart-price">
									<s:i18n name="format">
										<s:text name="struts.percent">
											<s:param value="goods.price*buyNum"/>
										</s:text>
									</s:i18n>
									</span></div>
									<a class="mini-cart-item-del" href="#"><i class="fa fa-times"></i></a></div></div></li>
								</s:iterator>
							</s:if>
						</ul>
					</div>
					<button class="goBuy btn btn-danger"><s:text name="goToTheShoppingCartAndSettlement"/></button>
					<script type="text/javascript">
							if($(".mini-cart-item").length<1){
								$(".goBuy").css("display","none");
							}
						</script>
				</div>
			</div>
		</div>
		</nav>
			</s:if>
		<!--购物车影响的内容  -->
		<div class="st-pusher">
			<div class="st-content" style="background: none">
			<!-- 购物车图标 -->
			<s:if test="#session.user!=null">
			<div class="cartButton" id="st-trigger-effects">
				<button data-effect="st-effect-13" class="btn btn-danger st-effect" style="width:30px;height:150px;text-align:center;padding:0;"><span class="badge" id="cart-item-num">
				<s:property value="#session.orderForms.size"></s:property>
				</span><br/><s:text name="my"/><br/><s:text name="de"/><br/><s:text name="gou"/><br/><s:text name="wu"/><br/><s:text name="che"/></button>
			</div>
			</s:if>
			<!-- 购物车图标  -->
				<!-- header -->
				<div class="header">
					<div class="w3ls-header">
						<!--header-one-->
						<div class="w3ls-header-left">
							<p>
								<a href="index"><img src="img/logo.png" class="logo" /></a>
							</p>
						</div>
						<div class="w3ls-header-right">
							<ul>
								<li class="dropdown head-dpdn"><a href="#"
									class="dropdown-toggle" data-toggle="dropdown"><i
										class="fa fa-user" aria-hidden="true"></i><s:text name="myAccount"/><span
										class="caret"></span></a>
									<ul class="dropdown-menu">
										<s:if test="#session.user!=null">
											<li><a href="myCenter"><s:property
														value="#session.user.nickname!=null?#session.user.nickname:#session.user.username!=null?#session.user.username:#session.user.email!=null?#session.user.email:#session.user.phone"/></a></li>
											<li><a href="userLogout"><s:text name="logout"/></a></li>
											<li><a href="myCenter?function=2"><s:text name="myOrder"/></a></li>
											<li><a href="myCenter?function=3"><s:text name="wallet"/></a></li>
										</s:if>
										<s:else>
											<li><a href="loginUi"><s:text name="login"/></a></li>
										</s:else>
									</ul></li>
								<s:if test="#session.user!=null">
									<li class="dropdown head-dpdn"><a href="#"
										class="dropdown-toggle" data-toggle="dropdown"><i
											class="fa fa-cart-plus" aria-hidden="true"></i><s:text name="shoppingCart"/><span
											class="caret"></span></a>
										<ul class="dropdown-menu">
											<li id="st-trigger-effects" class="column"><a
												href="javascript:" data-effect="st-effect-13"
												class="st-effect"><s:text name="toViewTheShoppingCart"/></a></li>
											<li class="clearCart"><a href="javascript:"><s:text name="emptyTheShoppingCart"/></a></li>
										</ul></li>
								</s:if>
								<li class="dropdown head-dpdn linkService"><a
									href="javascript:void(0)" class="dropdown-toggle"><i
										class="fa  fa-smile-o" aria-hidden="true"></i><s:text name="contactCustomerService"/></a></li>
										<li class="dropdown head-dpdn"><a href="javascript:void(0)"
									class="dropdown-toggle" data-toggle="dropdown"><i
										class="fa fa-eye" aria-hidden="true"></i> <s:text name="language"/><span
										class="caret"></span></a>
									<ul class="dropdown-menu">
										<li id="st-trigger-effects" class="column"><a
											href="single?goodsId=${goodsId}&request_locale=zh_CN"><s:text name="chinese"/></a></li>
										<li><a href="single?goodsId=${goodsId}&request_locale=en_US"><s:text name="english"/></a></li>
								</ul></li>
							</ul>
						</div>
						<div class="clearfix"></div>
					</div>
					<!-- 客服聊天 -->
					<div class="chatWinBox" onmouseover="move(this)">
						<div class="chatWin">
							<div class="head">
								<span><s:text name='LiuhuaService'/>&ensp;<span class="serverName"><s:text name='system'/></span>&ensp;<s:text name='forYouService'/>--<span
									class="state"></span></span>
								<p class="winClose">
									<i class="glyphicon glyphicon-remove"></i>
								</p>
							</div>
							<div class="body">
								<div class="chatContent direct-chat-default">
								</div>
								<div class="fontSet">
									<div class="font">
										<select class="form-control">
											<option>华文宋体</option>
											<option>华文行楷</option>
											<option>华文隶书</option>
											<option>华文琥珀</option>
											<option>华文彩云</option>
											<option>方正舒体</option>
										</select>
									</div>
									<div class="fontSize">
										<span><s:text name='fontSize'/></span>
										<div class="input-group has-feedback" id="role_level">
											<div class="level">
												<p class="level-control" data-toggle="tooltip"
													data-placement="top" title="15" id="level-control"></p>
											</div>
										</div>
									</div>
									<div class="fontColor">
										<span style="margin-right:10px;line-height:30px;"><s:text name='fontColor'/></span>
										<div class="input-group myColorpicker colorpicker-element"
											style="margin-top:5px;border:1px solid #CCC">
											<input type="hidden" class="form-control">
											<div class="input-group-addon"
												style="width:30px;height:20px; background-color: rgb(0, 0, 0);"></div>
										</div>
									</div>
								</div>
								<ul class="myTool">
									<li class="fontSetButton" title="<s:text name='setFont'/>"><i
										class="fa fa-font"></i></li>
									<li title="<s:text name='face'/>" class="emotion"><i class="fa fa-smile-o"></i></li>
									<li title="<s:text name='sendPic'/>" class="sendPicture"><i class="fa fa-picture-o"></i></li>
									<li style="clear:both;"></li>
									<li class="recordSwitch"><i class="glyphicon glyphicon-time"></i><s:text name='messageRecord'/><i class="fa fa-caret-down"></i></li>
								</ul>
								<textarea class="form-control textarea-control myInput" rows="3" id="myInput" name="myInput"></textarea>
								<div class="fileBox" style="display:none">
									<input type="file" id="file" name="file"
										accept="image/png,image/gif,image/jpeg">
								</div>
							</div>
							<div class="foot">
								<button class="btn btn-primary winClose"><s:text name='close'/></button>
								<div class="sendGroup btn-group dropup">
									<button type="button" class="btn btn-primary send"><s:text name='send'/></button>
									<button type="button" class="btn btn-primary dropdown-toggle"
										data-toggle="dropdown" title="<s:text name='sendKey'/>">
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu selectSendMenu" role="menu">
										<li data="ce"><a href="javascript:void(0)">Ctrl+Enter</a></li>
										<li data="se"><a href="javascript:void(0)">Shift+Enter</a></li>
										<li data="e"><a href="javascript:void(0)">Enter</a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="messageRecord">
							<div class="head">
								<span><s:text name='messageRecord'/></span>
								<p class="winCloseRecord">
									<i class="glyphicon glyphicon-remove"></i>
								</p>
							</div>
							<div class="body">
								<div class="recordContent direct-chat-default">
									
								</div>
							</div>
							<div class="foot">
								<button class="left btn btn-default">
									<i class="glyphicon glyphicon-arrow-left"></i>
								</button>
								<button class="right btn btn-default">
									<i class="glyphicon glyphicon-arrow-right"></i>
								</button>
							</div>
						</div>
					</div>
					<!--/客服聊天  -->
					<!-- breadcrumbs -->
					<div class="container">
						<ol class="breadcrumb breadcrumb1">
							<li><a href="index"><s:text name="homePage"/></a></li>
							<li class="active">${name }</li>
						</ol>
						<div class="clearfix"></div>
					</div>
				</div>
				<!-- //breadcrumbs -->

				<!-- products -->
				<div class="products">
					<div class="container">
						<div class="single-page">
							<div class="single-page-row" id="detail-21">
								<div class="col-md-5" style="padding: 0;">
									<div class="flexslider">
										<div
											style="width: 400px; height: 400px; border: 1px solid #666; padding: 2px; margin: 5px;"
											class="big-img">
											<s:if test="breviaryPicture!=null">
												<a
													href="json/download_file?isBreviary=1&id=<s:property value='breviaryPicture.id'/>"
													title="Images" class="MagicZoom"> <img
													src="json/download_file?isBreviary=1&id=<s:property value='breviaryPicture.id'/>"
													data-imagezoom="true">
												</a>
											</s:if>
											<s:else>
												<a
													href="json/download_file?isBreviary=1&id=<s:property value='breviaryPicture.id'/>"
													title="Images" class="MagicZoom"> <img
													src="json/download_file?isBreviary=1&id=<s:property value='breviaryPicture.id'/>"
													data-imagezoom="true">
												</a>
											</s:else>
										</div>
										<ul class="slides">
											<s:if test="breviaryPicture!=null">
												<li>
													<div class="thumb-image detail_images">
														<img
															src="json/download_file?isBreviary=1&id=<s:property value='breviaryPicture.id'/>"
															data-imagezoom="true" class="img-responsive">
													</div>
												</li>
											</s:if>
											<s:iterator value="#request.goodsPictures">
												<li>
													<div class="thumb-image detail_images">
														<img src="json/download_file?id=${id}"
															data-imagezoom="true" class="img-responsive">
													</div>
												</li>
											</s:iterator>
										</ul>
									</div>
								</div>
								<div class="col-md-7">
									<table class="table" style="margin-top: 20px;">
										<tr>
											<td colspan="2" style="color: #000; font-weight: bold;"><h3
													class="product_name">${name }</h3></td>
										</tr>
										<tr>
											<td colspan="2"><p style="color: #e00">${simpleDescript }</p></td>
										</tr>
										<s:if test="isSale=='1'">
											<tr>
												<td class="col-md-1 col-sm-1 col-lg-1"><s:text name="price"/></td>
												<td><del>
												<s:i18n name="format">
													<s:text name="struts.percent">
														<s:param value="price" />
													</s:text>
												</s:i18n>
												$</del></td>
											</tr>
											<tr>
												<td style="line-height: 70px;"><s:text name="preferentialPrice"/></td>
												<td style="color: #C40000;"><i class="fa fa-rmb"
													style="font-size: 20px; margin-right: 10px;"></i><span class="price"
													style="font-size: 40px;">
													<s:i18n name="format">
														<s:text name="struts.percent">
															<s:param value="salePrice" />
														</s:text>
													</s:i18n>
													</span> <small
													style="color: #999999; font-size: 10px; margin-left: 50px;"><s:text name="discountDeadline"/>
														：${saleTime}</samll></td>
											</tr>
										</s:if>
										<s:else>
											<tr>
												<td class="col-md-1 col-sm-1 col-lg-1" style="line-height: 70px;"><s:text name="price"/></td>
												<td style="color: #C40000;"><i class="fa fa-rmb"
													style="font-size: 20px; margin-right: 10px;"></i><span class="price"
													style="font-size: 40px;">
													<s:i18n name="format">
																<s:text name="struts.percent">
																	<s:param value="price" />
																</s:text>
															</s:i18n>
													</span> 
											</tr>
										</s:else>
										<tr>
											<td colspan="2" style="font-size: 15px;"><s:text name="totalSales"/> <span
												style="color: #C40000">${sellsum}</span></td>
										</tr>
										<tr>
											<td><s:text name="color"/></td>
											<td class="colorTd" data-toggle="popover" data-placement="left" data-content="<s:text name="willChooseAColor"/>">
											<s:iterator value="colors" var="c">
												<div style="background-color:${c}" class="color" data="${c}"></div>
											</s:iterator>
											</td>
										</tr>
										<tr>
											<td>${otherName }</td>
											<td>${otherValue}</td>
										</tr>
										<tr>
											<td style="line-height: 30px;"><s:text name="numberOf"/></td>
											<td>
												<div class="input-group col-md-3 col-sm-3 lg-sm-3"
													style="position: relative;" id="buyNumMade">
													<span class="input-group-addon minus" disabled><i
														class="fa fa-minus"></i></span> <input type="text"
														class="form-control buyNum" value="1"
														style="font-size: 25px; text-align: center;" maxlength="4"
														maxValue="${inventory}" sourceValue="1"> <span
														class="input-group-addon add"><i class="fa fa-plus"></i></span>
													<div
														style="position: absolute; right: -100px; bottom: 0px;">
														<span style="margin-left: 10px; font-size: 10px;">(<s:text name="inventory"/>${inventory}<s:text name="piece"/>)</span>
													</div>
												</div>

											</td>
										</tr>
										<tr>
											<td colspan="2">
												<button class="btn btn-danger intoCart" type="submit" style="width:120px;" data-id="${goodsId }" data-toggle="popover" data-placement="top"
									data-content="商品加入购物车成功"><i class="fa fa-cart-plus" aria-hidden="true" style="margin-right:5px;"></i><s:text name="addToCart"/></button>
												<button data-id="${goodsId}" class="btn btn-primary buy" id="buy" role="button"><i class="fa fa-gavel" style="margin-right:5px;"></i><s:text name="buy"/></button>
											</td>
										</tr>
									</table>
<%-- 
									<form action="#" method="post">
										<input type="hidden" name="cmd" value="_cart" /> <input
											type="hidden" name="add" value="1" /> <input type="hidden"
											name="w3ls_item" value="Snow Blower" /> <input type="hidden"
											name="amount" value="540.00" />
										<button type="submit" class="btn btn-default">
											<i class="fa fa-cart-plus" aria-hidden="true"></i>加入购物车
										</button>
									</form>
									<button class="btn btn-success">
										<span class="glyphicon glyphicon-usd"></span>购买
									</button> --%>
								</div>
								<div class="clearfix"></div>
							</div>

							<!-- <div class="single-page-icons social-icons">
								<ul>
									<li><i class="fa fa-heart-o" aria-hidden="true"></i>点击收藏该宝贝</li>
									<li><h4>Share on</h4></li>
									<li><a href="#" class="fa fa-facebook icon facebook">
									</a></li>
									<li><a href="#" class="fa fa-twitter icon twitter"> </a></li>
									<li><a href="#" class="fa fa-google-plus icon googleplus">
									</a></li>
									<li><a href="#" class="fa fa-dribbble icon dribbble">
									</a></li>
									<li><a href="#" class="fa fa-rss icon rss"> </a></li>
								</ul>
							</div> -->
						</div>
					</div>

					<!-- 商品展示页 -->
					<div style="width: 85%; margin: 0 auto; min-width: 1000px;">
						<div class="collpse tabs" style="width: 100%;padding-top:0;">
							<h3 class="w3ls-title"></h3>
							<div class="panel panel-default">
								<div class="panel-heading" role="tab">
									<h4 class="panel-title">
										<a class="collapsed pa_italic" role="button"
											data-toggle="collapse" data-parent="#accordion"
											href="#collapseTwo" aria-expanded="false"
											aria-controls="collapseTwo"> <i
											class="fa fa-info-circle fa-icon" aria-hidden="true"></i>
											<s:text name="commodityDisplayPage"/><span class="fa fa-angle-down fa-arrow"
											aria-hidden="true"></span> <i class="fa fa-angle-up fa-arrow"
											aria-hidden="true"></i>
										</a>
									</h4>
								</div>
								<div id="collapseTwo" class="panel-collapse collapse in"
									role="tabpanel" aria-labelledby="headingTwo">
									<div class="panel-body">
										<s:if test="#request.explain!=null">
											<iframe src='<s:property value="explain.path"/>'
												onLoad="reinitIframeEND();" id="iframepage"
												name="iframepage" frameBorder=0 scrolling=no width="100%"
												height="100%"></iframe>
											<script type="text/javascript">
												window.onresize = function() {
													console.log(1)
													reinitIframeEND();
												}
												function reinitIframe() {
													var iframe = document
															.getElementById("iframepage");
													try {
														var bHeight = iframe.contentWindow.document.body.scrollHeight;
														var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
														var height = Math.max(
																bHeight,
																dHeight);
														iframe.height = height;
													} catch (ex) {
													}
												}

												var timer1 = window
														.setInterval(
																"reinitIframe()",
																500); //定时开始  

												function reinitIframeEND() {
													var iframe = document
															.getElementById("iframepage");
													try {
														var bHeight = iframe.contentWindow.document.body.scrollHeight;
														var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
														var height = Math.max(
																bHeight,
																dHeight);
														iframe.height = height;
													} catch (ex) {
													}
													// 停止定时  
													window
															.clearInterval(timer1);

												}
											</script>
										</s:if>
									</div>
								</div>
							</div>
						</div>
						<!-- //collapse -->
					</div>
				</div>
				<!--//products-->

				<!-- footer-top -->
				<div class="w3agile-ftr-top">
					<div class="container">
						<div class="ftr-toprow">
							<div class="col-md-4 ftr-top-grids">
								<div class="ftr-top-left">
									<i class="fa fa-truck" aria-hidden="true"></i>
								</div>
								<div class="ftr-top-right">
									<h4><s:text name="freeDelivery"/></h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing
										elit. Fusce tempus justo ac</p>
								</div>
								<div class="clearfix"></div>
							</div>
							<div class="col-md-4 ftr-top-grids">
								<div class="ftr-top-left">
									<i class="fa fa-user" aria-hidden="true"></i>
								</div>
								<div class="ftr-top-right">
									<h4><s:text name="customerCare"/></h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing
										elit. Fusce tempus justo ac</p>
								</div>
								<div class="clearfix"></div>
							</div>
							<div class="col-md-4 ftr-top-grids">
								<div class="ftr-top-left">
									<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
								</div>
								<div class="ftr-top-right">
									<h4><s:text name="goodQuality"/></h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing
										elit. Fusce tempus justo ac</p>
								</div>
								<div class="clearfix"></div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
				<!-- //footer-top -->
				<div class="copy-right">
					<div class="container">
						<p>Copyright &copy; 2016.Company name All rights reserved</p>
					</div>
				</div>
				<!-- content push wrapper -->
			</div>
		</div>
		<!-- /购物车结束 -->
	</div>
	<!-- /购物车结束 -->
	<div class="modal fade" id="showPicture" tabindex="-1" role="dialog" aria-labelledby="showPicture" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="showPictureLabel"><s:text name="selectBigPic"/></h4>
	      </div>
	      <div class="modal-body">
	      	<img alt="pic" src="img/loading.gif" class="showPictrueMore">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal"><s:text name="close"/></button>
	      </div>
	    </div>
	  </div>
	</div>
	<!--i18n  -->
	<script src="js/admin/map.js"></script>
	<script type="text/javascript">
		try{
		var i18nConfig = eval("(" + "${sessionScope.i18nConfig}" + ")");
		var i18n = new Map();
		for ( var key in i18nConfig) {
			i18n.put(key, i18nConfig[key]);
		}
	}catch(e){
		alert(e);
	}
	</script>
	<!--/i18n  -->
	<script src="js/sidebar/classie.js"></script>
	<script src="js/sidebar/modernizr.custom.js"></script>
	<script src="js/sidebar/sidebarEffects.js"></script>
	<script src="js/single.js"></script>
	<script src="js/cart.js"></script>
	<!--聊天  -->
	<script src="js/move.js"></script>
	<script src="js/chat.js"></script>
	<script src="js/admin/levelControl.js" type="text/javascript"></script>
	<script src="js/colorpicker/bootstrap-colorpicker.min.js" type="text/javascript"></script>
	<script src="css/face/js/jquery-browser.js"></script>
	<script src="css/face/js/jquery.qqFace.js"></script>
	<script src="js/fileUpload/ajaxfileupload.js"></script>
	<script type="text/javascript">
		var webSocketUri="<%=serverPath%>chatServer.server?user=${user.nickname!=null?user.nickname:user.username!=null?user.username:user.phone}";
		var currentUserName="${user.nickname!=null?user.nickname:user.username!=null?user.username:user.phone}";
		var photoID = "${user.photo!=null?user.photo.id:''}";
		$(function(){
		$(".bodyLoader").remove();
			//显示聊天窗口
			$(".linkService").click(function(){
			if($('.chatWinBox').is(":hidden")){
				if(currentUserName==''){
					window.location.href="loginUi?url="+window.location.href.substr(7);
					return;
				}
				$(".chatWinBox").show();
				//连接聊天服务器
				openWebSocket();
			}
			})
		})
	</script>
	<!--/聊天  -->
</body>
</html>