<%@ page language="java" pageEncoding="UTF-8"%>

<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<title>payPage</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<!-- Custom Theme files -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/auctionOrder.css" rel="stylesheet" type="text/css"
	media="all" />
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
.orderForm td {
	text-align: center;
}

a {
	cursor: pointer;
}
</style>
</head>
<body style="min-width:1000px;">

	<div class="st-pusher">
		<div class="st-content" style="background: none">
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
			<div class="container" style="margin:50px auto;min-height:500px;min-width:1000px;">
				<table class="table addr">
					<tr>
						<th><b>确认收货地址</b><a style="float:right" data-toggle="modal"
							data-target="#addAddrModal" id="addAddrModalButton"><i class="fa fa-plus"></i>新增地址</a></th>
					</tr>
					<s:if test="#request.addrs!=null">
						<s:iterator value="#request.addrs" status="c">
						<tr>
							<td style="padding-left:100px;">
	 							<label>
									<input type="radio" <s:property value="#c.count==1?'checked':''"/> value="${id}"name="addr">
									${address}--${moreAddress}（${name} 收）${phone}
								</label>
								<span class="glyphicon glyphicon-pencil changeAddress" title="修改"></span>
								<span class="glyphicon glyphicon-remove deleteAddress" title="删除"></span>
							</td>
						</tr>
						</s:iterator>
					</s:if>
					<s:else>
						<tr>
							<td style="padding:100px;">你没有收货地址，请选择新增地址</td>
						</tr>
					</s:else>
					<%-- <s:iterator value="#request.addrs">
						<tr>
							<td style="padding-left:100px;"><input type="radio"
								name="addr">四川省 内江市 东兴区 东兴街道 东兴区尚华名（刘华 收）15808325356</td>
						</tr>
					</s:iterator> --%>
				</table>
				<table class="table orderForm">
					<thead>
						<tr>
							<th><b>确认订单信息</b></th>
						</tr>
						<tr style="font-size:10px;color:#555;">
							<th style="text-align:center;">商品信息</th>
							<th style="text-align:center;">商品属性</th>
							<th style="text-align:center;">数量</th>
							<th style="text-align:center;">小计</th>
						</tr>
					</thead>
					<tbody>
					<s:if test="#request.orderForms!=null">
					<s:iterator value="#request.orderForms">
						<tr>
							<td>
								<div class="mini-cart-item-pic">
									<img  width="40px"
										src="json/download_file?isBreviary=1&id=${goods.breviaryPicture.id}">
								</div>
								<div class="mini-cart-item-info">
									<span class="mini-cart-item-title">${goods.name}</span><br/>
									<small style="font-size:10px;">${goods.simpleDescript}</small>
								</div>
							</td>
							<td><span style="min-width:100px;">颜色：默认<br/> 邮寄：包邮</span></td>
							<td>
								<div class="input-group col-md-3 col-sm-3 lg-sm-3"
									style="position: relative;" id="buyNumMade">
									<span class="input-group-addon minus" disabled><i
										class="fa fa-minus"></i></span> <input type="text"
										class="form-control buyNum" value="${buyNum}"
										style="font-size: 25px; text-align: center; width:80px;"
										maxlength="4" maxValue="${goods.inventory}" sourceValue="1">
									<span class="input-group-addon add"><i
										class="fa fa-plus"></i></span>
								</div>
							</td>
							<td><span style="line-height:40px;" class='singlePrice' singlePrice="${goods.price}">
								<i class="fa fa-rmb"></i>
								<span><s:i18n name="format"><s:text name="struts.percent"><s:param value="goods.price*buyNum"/></s:text></s:i18n></span></span></td>
						</tr>
						</s:iterator>
						</s:if>
						<s:else>
							<tr>
								<s:debug></s:debug>
								<td>你选择的商品不存在或已下架</td>
							</tr>
						</s:else>
						<tr>
							<td colspan="2" class="col-md-8">
								<div class="input-group">
									<div class="input-group-addon">给老板留言</div>
									<input type="text" class="form-control" id="exampleInputAmount"
										placeholder="输入留言信息">
								</div>
							</td>
							<td class="col-md-2"><span style="line-height:30px;">商品合计：<i class="fa fa-rmb" style="margin-right:5px;"></i><span class="sumPrice">0</span></span></td>
							<td class="col-md-2"><button class="btn btn-default">提交订单</button></td>
						</tr>
					</tbody>

				</table>
			</div>
			<!-- //breadcrumbs -->
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
	<!-- /购物车结束 -->
	<div class="modal fade" id="addAddrModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><b>添加收货地址</b></h4>
				</div>
				<form action="addAddr" method="post" id="addressForm">
				<div class="modal-body">
					<s:hidden name="address"></s:hidden>
					<div class="input-group">
						<div class="input-group-addon">所在地区</div>
						<div class="form-control selectArea" data-toggle="popover" data-placement="top" data-content="省市是必须要选的">
							<span class="selectedArea initArea">选择省/市/区...</span> <span
								class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"
								style="float:right"></span>
						</div>
						 <div class="provinesBox">
							<ul class="provinesMenu">
							<li class="provinces active">省份</li>
							<li class="city">城市</li>
							<li class="district">县区</li>
							<li class="street">街道</li>
						<!-- 	<li class="village">村</li> -->
						</ul>
						<div class="provinesContent">
							<div class="city-group city-provinces active">
								<table>
									<tr>
										<td><b>A-G</b></td>
										<td class="col-md-11">
											<ul class="ag">
											</ul></td>
									</tr>
									<tr>
										<td><b>H-K</b></td>
										<td class="col-md-11">
											<ul class="hk">
											</ul></td>
									</tr>
									<tr>
										<td><b>L-S</b></td>
										<td class="col-md-11">
											<ul class="ls">
											</ul></td>
									</tr>
									<tr>
										<td><b>T-Z</b></td>
										<td class="col-md-11">
											<ul class="tz">
											</ul></td>
									</tr>
								</table>
							</div>
							<div class="city-group city-city">
								<table>
									<tr>
										<td><b>A-G</b></td>
										<td class="col-md-11">
											<ul class="ag">
											</ul></td>
									</tr>
									<tr>
										<td><b>H-K</b></td>
										<td class="col-md-11">
											<ul class="hk">
											</ul></td>
									</tr>
									<tr>
										<td><b>L-S</b></td>
										<td class="col-md-11">
											<ul class="ls">
											</ul></td>
									</tr>
									<tr>
										<td><b>T-Z</b></td>
										<td class="col-md-11">
											<ul class="tz">
											</ul></td>
									</tr>
								</table>
							</div>
							<div class="city-group city-district">
								<table>
									<tr>
										<td><b>A-G</b></td>
										<td class="col-md-11">
											<ul class="ag">
											</ul></td>
									</tr>
									<tr>
										<td><b>H-K</b></td>
										<td class="col-md-11">
											<ul class="hk">
											</ul></td>
									</tr>
									<tr>
										<td><b>L-S</b></td>
										<td class="col-md-11">
											<ul class="ls">
											</ul></td>
									</tr>
									<tr>
										<td><b>T-Z</b></td>
										<td class="col-md-11">
											<ul class="tz">
											</ul></td>
									</tr>
								</table>
							</div>
							<div class="city-group city-street">
								<table>
									<tr>
										<td><b>A-G</b></td>
										<td class="col-md-11">
											<ul class="ag">
											</ul></td>
									</tr>
									<tr>
										<td><b>H-K</b></td>
										<td class="col-md-11">
											<ul class="hk">
											</ul></td>
									</tr>
									<tr>
										<td><b>L-S</b></td>
										<td class="col-md-11">
											<ul class="ls">
											</ul></td>
									</tr>
									<tr>
										<td><b>T-Z</b></td>
										<td class="col-md-11">
											<ul class="tz">
											</ul></td>
									</tr>
								</table>
							</div>
							<!-- <div class="city-group city-village"></div> -->
						</div>
					</div>
		
					</div>
					<div class="input-group">
						<div class="input-group-addon">详细地址</div>
						<textarea class="form-control" name="moreAddress" rows="3" placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息" style="max-width:490px;"  data-toggle="popover" data-placement="top" data-content="多多少少也请填写一点，让你取货更方便"></textarea>
<!-- 						<input type="text" class="form-control col-md-10" placeholder="输入详细的地址">
 -->					</div>
					<div class="input-group">
						<div class="input-group-addon">收&ensp;件&ensp;人</div>
						<input type="text" class="form-control col-md-10" name="name" placeholder="填写收件人姓名" data-toggle="popover" data-placement="top" data-content="你要把货寄给谁呀">
						<div class="input-group-addon">邮政编码</div>
						<input type="text" class="form-control col-md-10" name="postcode" placeholder="不填写，默认000000">
					</div>
					<div class="input-group">
						<div class="input-group-addon">手&ensp;机&ensp;号</div>
						<input type="text" class="form-control col-md-10" name="phone" placeholder="电话号码、手机号码必须填一项" data-toggle="popover" data-placement="top" data-content="手机号或电话号码为方便联系你">
						<div class="input-group-addon">电话</div>
						<input type="text" class="form-control col-md-10" name="telephone" placeholder="电话号码、手机号码必须填一项">
					</div>
				</div>
				<div class="modal-footer">
					<s:hidden name="id"></s:hidden>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="submitAddAddress" data-toggle="popover" data-placement="left" data-content="">确定添加并选择</button>
				</div>
			</form>
			</div>
		</div>
	</div>
	<script src="js/ChineseAscii.js"></script>
	<script src="js/auctionOrder.js"></script>
<%-- 	<script src="js/cart.js"></script> --%>

</body>
</html>