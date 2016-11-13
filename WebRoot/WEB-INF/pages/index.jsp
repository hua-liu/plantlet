<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	 String serverPath="ws://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<title>小苗基地</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<!-- Custom Theme files -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="css/admin/AdminLTE.min.css">
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/iconfont.css" rel="stylesheet" type="text/css">
<!-- <link href="css/spinMenu.css" rel="stylesheet" type="text/css"
	media="all" /> -->
<!-- menu style -->
<!-- banner slider -->
<link href="css/animate.min.css" rel="stylesheet" type="text/css"
	media="all" />
<link rel="stylesheet" href="css/MagicZoom.css" type="text/css" />
<link href="css/sidebar/components-right.css" rel="stylesheet">
<link href="css/cart.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/colorpicker/bootstrap-colorpicker.min.css" rel="stylesheet" type="text/css" />
<!-- <link href="css/owl.carousel.css" rel="stylesheet" type="text/css"
	media="all"> -->
<!-- carousel slider -->
<!-- //Custom Theme files -->
<!-- font-awesome icons -->
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/chat.css" rel="stylesheet">
<!-- //font-awesome icons -->
<style type="text/css">
body {
	background: #FAFAFA;
}

.thumbnail {
	width: 220px;
	height: 270px;
	text-align: center;
	vertical-align: middle;
	cursor: pointer;
	float: left;
	margin: 2px;
}

.thumbnail .pimg {
	width: 100%;
	height: 100%;
}

.thumbnail .productPicture {
	width: 200px;
	height: 200px;
	margin: 0 auto;
}

.thumbnail .caption h4 {
	margin-top: 0;
}

.thumbnail .caption a i {
	font-size: 17px;
}

.btn-group-justified {
	width: 100%;
}
</style>
<!-- js -->
<script src="js/jquery/jquery.min.js"></script>
<!-- //js -->
<script src="js/jquery-scrolltofixed-min.js" type="text/javascript"></script>
<script>
	$(document).ready(function() {

		$('.header-two').scrollToFixed();
		// previous summary up the page.

		var summaries = $('.summary');
		summaries.each(function(i) {
			var summary = $(summaries[i]);
			var next = summaries[i + 1];

			summary.scrollToFixed({
				marginTop : $('.header-two').outerHeight(true) + 10,
				zIndex : 999
			});
		});
	});
</script>
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
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 购物车开始  -->
	<div id="st-container" class="st-container">
		<s:if test="#session.user!=null">
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
												<div class="mini-cart-item-pic">
													<img
														src="json/download_file?isBreviary=1&id=${goods.breviaryPicture.id}">
												</div>
												<div class="mini-cart-item-info">
													<div class="mini-cart-item-title">${goods.name}</div>
													<div class="mini-cart-item-price">
														<i class="fa fa-rmb"></i><span class="cart-price">
															<s:i18n name="format">
																<s:text name="struts.percent">
																	<s:param value="goods.price*buyNum" />
																</s:text>
															</s:i18n>
														</span>
													</div>
													<a class="mini-cart-item-del" href="#"><i
														class="fa fa-times"></i></a>
												</div>
											</div></li>
									</s:iterator>
								</s:if>
							</ul>
						</div>
						<button class="goBuy btn btn-danger">去购物车结算</button>
						<script type="text/javascript">
							if ($(".mini-cart-item").length < 1) {
								$(".goBuy").css("display", "none");
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
						<button data-effect="st-effect-13"
							class="btn btn-danger st-effect"
							style="width:30px;height:150px;text-align:center;padding:0;">
							<span class="badge" id="cart-item-num"> <s:property
									value="#session.orderForms.size"></s:property>
							</span><br />我<br />的<br />购<br />物<br />车
						</button>
					</div>
				</s:if>
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
											<li><a href="myCenter?function=0"><s:property
														value="#session.user.username" /></a></li>
											<li><a href="userLogout">注销</a></li>
											<li><a href="myCenter?function=2">我的订单</a></li>
											<li><a href="myCenter?function=3">钱包</a></li>
										</s:if>
										<s:else>
											<li><a href="loginUi">登陆</a></li>
										</s:else>
									</ul></li>
								<s:if test="#session.user!=null">
									<li class="dropdown head-dpdn"><a href="#"
										class="dropdown-toggle" data-toggle="dropdown"><i
											class="fa fa-cart-plus" aria-hidden="true"></i> 购物车<span
											class="caret"></span></a>
										<ul class="dropdown-menu">
											<li id="st-trigger-effects" class="column"><a
												href="javascript:" data-effect="st-effect-13"
												class="st-effect">查看购物车</a></li>
											<li><a href="javascript:alert('程序员正在加紧实现')">清空购物车</a></li>
										</ul></li>
								</s:if>
								<li class="dropdown head-dpdn linkService"><a
									href="javascript:void(0)" class="dropdown-toggle"><i
										class="fa  fa-smile-o" aria-hidden="true"></i>联系客服</a></li>
								<li class="dropdown head-dpdn"><a href="help.html"
									class="dropdown-toggle"><i class="fa fa-question-circle"
										aria-hidden="true"></i> 帮助</a></li>
							</ul>
						</div>
						<div class="clearfix"></div>
					</div>
					<!-- 客服聊天 -->
					<div class="chatWinBox" onmouseover="move(this)">
						<div class="chatWin">
							<div class="head">
								<span>小苗基地客服&ensp;<span class="serverName">系统</span>&ensp;为您服务--<span
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
										<span>字体大小</span>
										<div class="input-group has-feedback" id="role_level">
											<div class="level">
												<p class="level-control" data-toggle="tooltip"
													data-placement="top" title="15" id="level-control"></p>
											</div>
										</div>
									</div>
									<div class="fontColor">
										<span style="margin-right:10px;line-height:30px;">字体颜色</span>
										<div class="input-group myColorpicker colorpicker-element"
											style="margin-top:5px;border:1px solid #CCC">
											<input type="hidden" class="form-control">
											<div class="input-group-addon"
												style="width:30px;height:20px; background-color: rgb(0, 0, 0);"></div>
										</div>
									</div>
								</div>
								<ul class="myTool">
									<li class="fontSetButton" title="设置字体"><i
										class="fa fa-font"></i></li>
									<li title="表情" class="emotion"><i class="fa fa-smile-o"></i></li>
									<li title="发送图片" class="sendPicture"><i class="fa fa-picture-o"></i></li>
									<li style="clear:both;"></li>
									<li class="recordSwitch"><i class="glyphicon glyphicon-time"></i>消息记录<i class="fa fa-caret-down"></i></li>
								</ul>
								<textarea class="form-control textarea-control myInput" rows="3" id="myInput" name="myInput"></textarea>
								<div class="fileBox" style="display:none">
									<input type="file" id="file" name="file"
										accept="image/png,image/gif,image/jpeg">
								</div>
							</div>
							<div class="foot">
								<button class="btn btn-primary winClose">关闭</button>
								<div class="sendGroup btn-group dropup">
									<button type="button" class="btn btn-primary send">发送</button>
									<button type="button" class="btn btn-primary dropdown-toggle"
										data-toggle="dropdown" title="设置发送快捷键">
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
								<span>消息记录</span>
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
					<!-- <div class="header-two">
			header-two
			<div class="container">
				<div class="header-search">
					<form action="#" method="post">
						<input type="search" name="Search" placeholder="输入商品关键字搜索"
							required="">
						<button type="submit" class="btn btn-default"
							aria-label="Left Align">
							<i class="fa fa-search" aria-hidden="true"> </i>
						</button>
					</form>
				</div>
				<div class="header-cart">
					<div class="my-account">
						<a href="contact.html"><i class="fa fa-map-marker"
							aria-hidden="true"></i> CONTACT US</a>
					</div>
					<div class="cart">
						<form action="#" method="post" class="last">
							<input type="hidden" name="cmd" value="_cart" /> <input
								type="hidden" name="display" value="1" />
							<button class="w3view-cart" type="submit" name="submit" value="">
								<i class="fa fa-cart-arrow-down" aria-hidden="true"></i>
							</button>
						</form>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
		//header-two -->
					<!-- coming soon -->
					<div class="soon">
						<div class="container">
							<h3>Mega Deal Of the Week</h3>
							<h4>Coming Soon Don't Miss Out</h4>
							<div id="countdown1" class="ClassyCountdownDemo"></div>
						</div>
					</div>
					<!-- //coming soon -->
					<!-- welcome -->
					<div class="welcome">
						<div class="container">
							<div class="welcome-info">
								<div class="bs-example bs-example-tabs" role="tabpanel"
									data-example-id="togglable-tabs">
									<ul id="myTab" class=" nav-tabs" role="tablist">
										<li role="presentation" class="spinButton"><a
											href="products?goodsKind=1" id="home-tab" role="tab"> <i
												class="icon iconfont">&#xe601;</i>
												<h5>盘栽</h5>
										</a></li>
										<li role="presentation" class="spinButton"><a
											href="products?goodsKind=2" role="tab" id="carl-tab"> <i
												class="icon iconfont" aria-hidden="true">&#xe611;</i>
												<h5>花卉</h5>
										</a></li>
										<li role="presentation" class="spinButton"><a
											href="products?goodsKind=3" role="tab" id="james-tab"> <i
												class="icon iconfont" aria-hidden="true">&#xe60b;</i>
												<h5>树苗</h5>
										</a></li>
										<li role="presentation" class="spinButton"><a
											href="products?goodsKind=4" role="tab" id="decor-tab"> <i
												class="icon iconfont" aria-hidden="true">&#xe603;</i>
												<h5>种子</h5>
										</a></li>
										<!-- <li role="presentation" class="spinButton" data="sports"><a
								href="#sports" role="tab" id="sports-tab" data-toggle="tab">
									<i class="fa fa-motorcycle" aria-hidden="true"></i>
									<h5>Sports</h5>
							</a></li> -->
									</ul>
									<div class="clearfix"></div>
									<h3 class="w3ls-title">新品速递</h3>
									<div style="text-align:center;">
										<s:iterator value="#request.newGoodsList" status="c">
											<div class="thumbnail" data-id="${goodsId}">
												<div class="productPicture">
													<a href="single?goodsId=${goodsId }"><img class="pimg"
														src="json/download_file?isBreviary=1&id=${breviaryPicture.id}" />
													</a>
												</div>
												<div class="caption" style="position:relative;">
													<p
														style="font-size:10px;position:absolute;top:-3px;right:0;">
														成交 <span style="color:#f50;padding:0;">${sellsum}笔</span>
													</p>
													<span><b><a href="single?goodsId=${goodsId }">${name}<strong
																style="color:#E00;margin-left:10px;">¥${price}</strong></a></b></span><br />
													<div style="height:35px;overflow:hidden;">
														<small>${simpleDescript}</small>
													</div>
												</div>
											</div>
										</s:iterator>
										<div style="clear:both"></div>
									</div>
									<h3 class="w3ls-title">热门推荐</h3>
									<div>
										<s:iterator value="#request.randomList" status="c">
											<div class="thumbnail">
												<div class="productPicture">
													<a href="single?goodsId=${goodsId }"> <img class="pimg"
														src="json/download_file?isBreviary=1&id=${breviaryPicture.id}" />
													</a>
												</div>
												<div class="caption" style="position:relative">
													<p
														style="font-size:10px;position:absolute;top:-3px;right:0;">
														成交 <span style="color:#f50;padding:0;">${sellsum}笔</span>
													</p>
													<b><a href="single?goodsId=${goodsId }">${name}<strong
															style="color:#E00;margin-left:10px;">¥${price}</strong></a></b><br />
													<div style="height:35px;overflow:hidden;">
														<small>${simpleDescript}</small>
													</div>
												</div>
											</div>
										</s:iterator>
										<div style="clear:both"></div>
									</div>
									<!-- deals -->
									<div class="deals">
										<div class="container">
											<h3 class="w3ls-title">热门关键字</h3>
											<div class="deals-row">
												<div class="col-md-3 focus-grid">
													<a href="products?keywords=玫瑰" class="wthree-btn">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">玫瑰</h4>
													</a>
												</div>
												<div class="col-md-3 focus-grid">
													<a href="products?keywords=丁香" class="wthree-btn wthree1">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">丁香</h4>
													</a>
												</div>
												<div class="col-md-3 focus-grid">
													<a href="products?keywords=绿色" class="wthree-btn wthree2">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">绿色</h4>
													</a>
												</div>
												<div class="col-md-3 focus-grid">
													<a href="products?keywords=吸辐射" class="wthree-btn wthree3">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">吸辐射</h4>
													</a>
												</div>
												<div class="col-md-2 focus-grid w3focus-grid-mdl">
													<a href="products?keywords=增氧" class="wthree-btn wthree3">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">增氧</h4>
													</a>
												</div>
												<div class="col-md-2 focus-grid w3focus-grid-mdl">
													<a href="products?keywords=爱情" class="wthree-btn wthree4">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">爱情</h4>
													</a>
												</div>
												<div class="col-md-2 focus-grid w3focus-grid-mdl">
													<a href="products?keywords=礼物" class="wthree-btn wthree2">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">礼物</h4>
													</a>
												</div>
												<div class="col-md-2 focus-grid w3focus-grid-mdl">
													<a href="products?keywords=萌" class="wthree-btn wthree">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">萌</h4>
													</a>
												</div>
												<div class="col-md-2 focus-grid w3focus-grid-mdl">
													<a href="products?keywords=大叶" class="wthree-btn wthree5">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">大叶</h4>
													</a>
												</div>
												<div class="col-md-2 focus-grid w3focus-grid-mdl">
													<a href="products?keywords=银杏" class="wthree-btn wthree1">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">银杏</h4>
													</a>
												</div>
												<div class="col-md-3 focus-grid">
													<a href="products?keywords=花灌木" class="wthree-btn wthree2">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">花灌木</h4>
													</a>
												</div>
												<div class="col-md-3 focus-grid">
													<a href="products?keywords=常青树" class="wthree-btn wthree5">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">常青树</h4>
													</a>
												</div>
												<div class="col-md-3 focus-grid">
													<a href="products?keywords=小苗" class="wthree-btn wthree3">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">小苗</h4>
													</a>
												</div>
												<div class="col-md-3 focus-grid">
													<a href="products?keywords=好看" class="wthree-btn ">
														<div class="focus-image">
															<i class="icon iconfont">&#xe60c;</i>
														</div>
														<h4 class="clrchg">好看</h4>
													</a>
												</div>
												<div class="clearfix"></div>
											</div>
										</div>
									</div>
									<!-- //deals -->
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
														<h4>CUSTOMER CARE</h4>
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
														<h4>GOOD QUALITY</h4>
														<p>Lorem ipsum dolor sit amet, consectetur adipiscing
															elit. Fusce tempus justo ac</p>
													</div>
													<div class="clearfix"></div>
												</div>
												<div class="clearfix"></div>
											</div>
										</div>
									</div>
									<div class="copy-right">
										<div class="container">
											<p>Copyright &copy; 2016.Company name All rights reserved</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="showPicture" tabindex="-1" role="dialog" aria-labelledby="showPicture" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="showPictureLabel">查看大图</h4>
	      </div>
	      <div class="modal-body">
	      	<img alt="pic" src="img/loading.gif" class="showPictrueMore">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- countdown.js -->
	<script src="js/jquery.knob.js"></script>
	<script src="js/jquery.throttle.js"></script>
	<script src="js/jquery.classycountdown.js"></script>
	<script>
		$(document).ready(function() {
			$('#countdown1').ClassyCountdown({
				end : '1388268325',
				now : '1387999995',
				labels : true,
				style : {
					element : "",
					textResponsive : .5,
					days : {
						gauge : {
							thickness : .10,
							bgColor : "rgba(0,0,0,0)",
							fgColor : "#1abc9c",
							lineCap : 'round'
						},
						textCSS : 'font-weight:300; color:#fff;'
					},
					hours : {
						gauge : {
							thickness : .10,
							bgColor : "rgba(0,0,0,0)",
							fgColor : "#05BEF6",
							lineCap : 'round'
						},
						textCSS : ' font-weight:300; color:#fff;'
					},
					minutes : {
						gauge : {
							thickness : .10,
							bgColor : "rgba(0,0,0,0)",
							fgColor : "#8e44ad",
							lineCap : 'round'
						},
						textCSS : ' font-weight:300; color:#fff;'
					},
					seconds : {
						gauge : {
							thickness : .10,
							bgColor : "rgba(0,0,0,0)",
							fgColor : "#f39c12",
							lineCap : 'round'
						},
						textCSS : ' font-weight:300; color:#fff;'
					}

				},
				onEndCallback : function() {
					console.log("Time out!");
				}
			});
		});
	</script>
	<script src="js/cart.js"></script>
	<script src="js/move.js"></script>
	<script src="js/sidebar/classie.js"></script>
	<script src="js/sidebar/modernizr.custom.js"></script>
	<script src="js/sidebar/sidebarEffects.js"></script>
	<script src="js/index.js" type="text/javascript"></script>
	<script src="js/admin/levelControl.js" type="text/javascript"></script>
	<!-- 表情 -->
	<script src="css/colorpicker/bootstrap-colorpicker.min.js" type="text/javascript"></script>
	<script src="js/chat.js"></script>
	<script src="css/face/js/jquery-browser.js"></script>
	<script src="css/face/js/jquery.qqFace.js"></script>
	<script src="js/fileUpload/ajaxfileupload.js"></script>
	<script type="text/javascript">
		var webSocketUri="<%=serverPath%>chatServer.server?user=${user.nickname!=null?user.nickname:user.username!=null?user.username:user.phone}";
		var currentUserName="${user.nickname!=null?user.nickname:user.username!=null?user.username:user.phone}";
		$(function(){
			//显示聊天窗口
			$(".linkService").click(function(){
			if($('.chatWinBox').is(":hidden")){
				$(".chatWinBox").show();
				//连接聊天服务器
				openWebSocket();
			}
			})
		})
	</script>
	<!-- Resource jQuery -->
	<!-- //menu js aim -->
	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>