<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<title>SinglePage</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<%-- <script type="application/x-javascript">
	
	
	
	
	
	
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } 







</script> --%>
<!-- Custom Theme files -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/cart.css" rel="stylesheet" type="text/css" media="all" />
<!-- <link href="css/animate.min.css" rel="stylesheet" type="text/css"
	media="all" />
animation
<link href="css/menu.css" rel="stylesheet" type="text/css" media="all" />
menu style
<link href="css/owl.carousel.css" rel="stylesheet" type="text/css"
	media="all"> -->
<!-- carousel slider -->
<!-- //Custom Theme files -->
<!-- font-awesome icons -->
<link href="css/font-awesome.css" rel="stylesheet">
<!-- <link href="css/sidebar/component.css" rel="stylesheet"> -->
<link href="css/sidebar/components-right.css" rel="stylesheet">
<!-- //font-awesome icons -->
<!-- js -->
<script src="js/jquery/jquery.min.js"></script>
<%-- <script src="js/owl.carousel.js"></script> --%>
<script src="bootstrap/js/bootstrap.min.js"></script>
<!--flex slider-->
<%-- <script defer src="js/jquery.flexslider.js"></script> --%>
<!-- <link rel="stylesheet" href="css/flexslider.css" type="text/css"
	media="screen" /> -->
<%-- <script>
	// Can also be used with $(document).ready()
	$(window).load(function() {
		$('.flexslider').flexslider({
			animation : "slide",
			controlNav : "thumbnails"
		});
	});
</script> --%>
<!--flex slider-->
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
</style>
</head>
<body>
	<!-- 购物车开始  -->
	<div id="st-container" class="st-container">
		<nav class="st-menu st-effect-13" id="menu-13"> 
		<div class="toolbar-main toolbar-mini-cart-main">
			<div class="toolbar-hd">
				<div class="toolbar-hd-title">购物车</div>
			</div>
			<div class="toolbar-bd">
				<div class="mini-cart-list">
					<div class="mini-cart-list-hd">
						<div class="mini-cart-list-title">最新加入的宝贝</div>
					</div>
					<div class="mini-cart-list-bd">
						<ul class="mini-cart-items-list">
							<s:if test="#session.user!=null">
								<s:iterator value="#session.orderForms">
									<li data-id="${id}"><div class="mini-cart-item">
									<div class="mini-cart-item-pic"><img src="json/download_file?isBreviary=1&id=${goods.breviaryPicture.id}"></div>
									<div class="mini-cart-item-info"><div class="mini-cart-item-title">${goods.name}</div>
									<div class="mini-cart-item-price"><i class="fa fa-rmb"></i><span class="cart-price">${Math.floor(goods.price*buyNum)}</span></div>
									<a class="mini-cart-item-del" href="#"><i class="fa fa-times"></i></a></div></div></li>
								</s:iterator>
							</s:if>
						</ul>
					</div>
					<button class="goBuy btn btn-danger">去购物车结算</button>
				</div>
			</div>
		</div>
		</nav>
		<!--购物车影响的内容  -->
		<div class="st-pusher">
			<div class="st-content" style="background: none">
			<!-- 购物车图标 -->
			<div class="cartButton" id="st-trigger-effects">
				<button data-effect="st-effect-13" class="btn btn-danger st-effect" style="width:30px;height:150px;text-align:center;padding:0;"><span class="badge" id="cart-item-num">
				<s:property value="#session.orderForms.size"></s:property>
				</span><br/>我<br/>的<br/>购<br/>物<br/>车</button>
			</div>
			<!-- 购物车图标  -->
				<!-- header -->
				<div class="header">
					<div class="w3ls-header">
						<!--header-one-->
						<div class="w3ls-header-left">
							<p>
								<a href="#"><img src="img/logo.png" class="logo" /></a>
							</p>
						</div>
						<div class="w3ls-header-right">
							<ul>
								<li class="dropdown head-dpdn"><a href="#"
									class="dropdown-toggle" data-toggle="dropdown"><i
										class="fa fa-user" aria-hidden="true"></i>我的账户<span
										class="caret"></span></a>
									<ul class="dropdown-menu">
										<s:if test="#session.user!=null">
											<li><a href="#"><s:property
														value="#session.user.username" /></a></li>
											<li><a href="userLogout">注销</a></li>
											<li><a href="login.html">我的订单</a></li>
											<li><a href="login.html">钱包</a></li>
										</s:if>
										<s:else>
											<li><a href="loginUi">登陆</a></li>
										</s:else>
									</ul></li>
								<li class="dropdown head-dpdn"><a href="#"
									class="dropdown-toggle" data-toggle="dropdown"><i
										class="fa fa-cart-plus" aria-hidden="true"></i> 购物车<span
										class="caret"></span></a>
									<ul class="dropdown-menu">
										<li id="st-trigger-effects" class="column"><a
											data-effect="st-effect-13" class="st-effect">查看购物车</a></li>
										<li><a>清空购物车</a></li>
									</ul></li>
								<li class="dropdown head-dpdn"><a href="card.html"
									class="dropdown-toggle"><i class="fa fa-star"
										aria-hidden="true"></i>收藏夹</a></li>
								<!-- <!-- <li class="dropdown head-dpdn"><a href="contact.html"
						class="dropdown-toggle"><i class="fa fa-map-marker"
							aria-hidden="true"></i>实体店</a></li> -->
								<li class="dropdown head-dpdn"><a href="card.html"
									class="dropdown-toggle"><i class="fa  fa-smile-o"
										aria-hidden="true"></i>联系客服</a></li>
								<li class="dropdown head-dpdn"><a href="help.html"
									class="dropdown-toggle"><i class="fa fa-question-circle"
										aria-hidden="true"></i> 帮助</a></li>
							</ul>
						</div>
						<div class="clearfix"></div>
					</div>
					<!-- breadcrumbs -->
					<div class="container">
						<ol class="breadcrumb breadcrumb1">
							<li><a href="index">首页</a></li>
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
												<td class="col-md-1 col-sm-1 col-lg-1">原价</td>
												<td><del>${price }$</del></td>
											</tr>
											<tr>
												<td style="line-height: 70px;">优惠价</td>
												<td style="color: #C40000;"><i class="fa fa-rmb"
													style="font-size: 20px; margin-right: 10px;"></i><span class="price"
													style="font-size: 40px;">${salePrice}</span> <small
													style="color: #999999; font-size: 10px; margin-left: 50px;">优惠截止时间
														：${saleTime}</samll></td>
											</tr>
										</s:if>
										<s:else>
											<tr>
												<td class="col-md-1 col-sm-1 col-lg-1" style="line-height: 70px;">价格</td>
												<td style="color: #C40000;"><i class="fa fa-rmb"
													style="font-size: 20px; margin-right: 10px;"></i><span class="price"
													style="font-size: 40px;">${price}</span> 
											</tr>
										</s:else>
										<tr>
											<td colspan="2" style="font-size: 15px;">总销量 <span
												style="color: #C40000">${sellsum}</span><span
												style="margin: 0 30px;">|</span>累计评价 <span
												style="color: #e00">999</span></td>
										</tr>
										<tr>
											<td>颜色</td>
											<td>${color }</td>
										</tr>
										<tr>
											<td>${otherName }</td>
											<td>${otherValue}</td>
										</tr>
										<tr>
											<td style="line-height: 30px;">数量</td>
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
														件<span style="margin-left: 10px; font-size: 10px;">(库存${inventory}件)</span>
													</div>
												</div>

											</td>
										</tr>
										<tr>
											<td colspan="2">
												<button class="btn btn-danger intoCart" type="submit" style="width:110px;" data-id="${goodsId }" data-toggle="popover" data-placement="top"
									data-content="商品加入购物车成功"><i class="fa fa-cart-plus" aria-hidden="true" style="margin-right:5px;"></i>加入购物车</button>
												<a href="#" class="btn btn-primary buy" role="button"><i class="fa fa-gavel" style="margin-right:5px;"></i>购买</a>
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

							<div class="single-page-icons social-icons">
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
							</div>
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
											商品展示页 <span class="fa fa-angle-down fa-arrow"
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
									<h4>FREE DELIVERY</h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
										Fusce tempus justo ac</p>
								</div>
								<div class="clearfix"></div>
							</div>
							<div class="col-md-4 ftr-top-grids">
								<div class="ftr-top-left">
									<i class="fa fa-user" aria-hidden="true"></i>
								</div>
								<div class="ftr-top-right">
									<h4>CUSTOMER CARE</h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
										Fusce tempus justo ac</p>
								</div>
								<div class="clearfix"></div>
							</div>
							<div class="col-md-4 ftr-top-grids">
								<div class="ftr-top-left">
									<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
								</div>
								<div class="ftr-top-right">
									<h4>GOOD QUALITY</h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
										Fusce tempus justo ac</p>
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
	<script src="js/sidebar/classie.js"></script>
	<script src="js/sidebar/modernizr.custom.js"></script>
	<script src="js/sidebar/sidebarEffects.js"></script>
	<script src="js/single.js"></script>
	<script src="js/cart.js"></script>

</body>
</html>