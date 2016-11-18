<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//聊天服务头
	String serverPath="ws://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<title>Products</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<!-- Custom Theme files -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- <link href="css/menu.css" rel="stylesheet" type="text/css" media="all" /> -->
<!-- menu style -->
<link href="css/sidebar/components-right.css" rel="stylesheet">
<link href="css/animate.min.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/iconfont.css" rel="stylesheet">
<!-- carousel slider -->
<!-- //Custom Theme files -->
<!-- font-awesome icons -->
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/cart.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/admin/AdminLTE.min.css">
<link href="css/chat.css" rel="stylesheet">
<link href="css/colorpicker/bootstrap-colorpicker.min.css" rel="stylesheet" type="text/css" />
<link href="css/admin/animation.css" rel="stylesheet">
<!-- //font-awesome icons -->
<!-- js -->
<script src="js/jquery/jquery.min.js"></script>
<!-- //js -->
<style type="text/css">
body {
	background: #FAFAFA;
}

.faq li {
	float: left;
	text-align: center;
}

.faq li:hover {
	color: #0E0;
}
/* 分页CSS */
.paging {
	width: 100%;
	height: 35px;
	position: relative;
	border-radius: 5px;
	background: rgba(0, 0, 0, 0.1);
	float: left;
	margin-top: 50px;
}

.paging .pagination {
	position:absolute;
	top:-17px;left:20%;
}

.pagination li a {
	background: none;
	color: #333;
	height: 30px;
	border-color: #999;
}

.pagination li a:hover {
	border-color: #555;
}
.productsSort li a{
	cursor:pointer;
}

</style>
<!-- scroll to fixed-->
<script src="js/jquery-scrolltofixed-min.js" type="text/javascript"></script>
<script>
	$(document).ready(function() {
		// Dock the header to the top of the window when scrolled past the banner. This is the default behaviour.
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
<!-- the jScrollPane script -->
<script type="text/javascript" src="js/jquery.jscrollpane.min.js"></script>
<script type="text/javascript" id="sourcecode">
	$(function() {
		$('.scroll-pane').jScrollPane();
	});
</script>
<!-- //the jScrollPane script -->
<!-- the mousewheel plugin -->
</head>
<body>
<div class="bodyLoader" style="width:100%;height:100%;position:absolute;top:0;left:0;background:rgba(0,0,0,0.4);z-index:1500"><div class="loader-inner square-spin" style="top:48%;left:48%;position:absolute;"><div style="border:none;background:#CD0000"></div></div></div>
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
					<button class="goBuy btn btn-danger">去购物车结算</button>
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
				</span><br/>我<br/>的<br/>购<br/>物<br/>车</button>
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
											<li><a href="myCenter"><s:property
														value="#session.user.nickname!=null?#session.user.nickname:#session.user.username!=null?#session.user.username:#session.user.email!=null?#session.user.email:#session.user.phone"/></a></li>
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
					<!-- //header -->
					<form action="products" method="get" id="searchProducts">
						<s:hidden name="function"></s:hidden>
						<s:hidden name="keywords"></s:hidden>
						<s:hidden name="minPrice"></s:hidden>
						<s:hidden name="maxPrice"></s:hidden>
						<s:hidden name="goodsKind"></s:hidden>
						<s:hidden name="color"></s:hidden>
						<s:hidden name="size" />
						<s:hidden name="currentPage"/>
					</form>
					<!-- products -->
					<div class="products col-md-12" style="padding-top:0;">
						<div class="container">
							<div class="col-md-9 product-w3ls-right">
								<!-- breadcrumbs -->
								<ol class="breadcrumb breadcrumb1">
									<li><a href="index">首页</a></li>
									<li class="active">${goodsKind==0?"全部商品":goodsKind==1?"盘栽":goodsKind==2?"花卉":goodsKind==3?"树苗":"种子"}</li>
									<s:if test="keywords!=null">
										<li class="active">${keywords}</li>
									</s:if>
								</ol>
								<div class="clearfix"></div>
								<!-- //breadcrumbs -->
								<div class="product-top" style="min-width:850px;">
									<h4>搜索结果</h4>
									<ul>
										<li class="dropdown head-dpdn"><a href="#"
											class="dropdown-toggle" data-toggle="dropdown">商品排序<span
												class="caret"></span></a>
											<ul class="dropdown-menu productsSort">
												<li data="1"><a>最低价格</a></li>
												<li data="2"><a>最高价格</a></li>
												<li data="3"><a>最高销量</a></li>
											</ul></li>
									</ul>
									<div class="clearfix"></div>
								</div>
								<s:if test="#request.products.size()<1">
									<div style="width:100%;text-align:center;color:#F00;padding:20px 0;">没有符合搜索要求的商品</div>
									<script>
										$(".bodyLoader").remove();
									</script>
								</s:if>
								<s:else>
								<div class="products-row">
									<s:iterator value="#request.products">
										<div class="col-md-3 product-grids" style="height:220px;">
											<div class="agile-products">
												<!-- <div class="new-tag">
													<h6>
														20%<br>Off
													</h6>
												</div> -->
												<a href="single?goodsId=${goodsId }"><img width="140px"
													height="140px"
													src="json/download_file?isBreviary=1&id=${breviaryPicture.id}"
													class="" alt="img"></a>
												<div class="agile-product-text">
													<h5 style="position:relative;">
														<p style="width:95px;height:25px;overflow:hidden;"><a href="single?goodsId=${goodsId }" class="product_name">${name}</a></p>
														<p style="font-size:10px;position:absolute;top:0;right:0;">
															成交 <span style="color:#f50;padding:0;">${sellsum}笔</span>
														</p>
													</h5>
													<h6 style="position:relative;">
														<del>
														<s:i18n name="format">
																<s:text name="struts.percent">
																	<s:param value="price" />
																</s:text>
															</s:i18n>
														</del>
														<span class="price">
														<s:i18n name="format">
																<s:text name="struts.percent">
																	<s:param value="salePrice==0?price:salePrice" />
																</s:text>
															</s:i18n>
														</span>
													</h6>
													<input type="hidden" class="buyNum" value="1" maxValue="${inventory}">
													<button type="button" class="w3ls-cart pw3ls-cart intoCart"
														data-id="${goodsId}" data-toggle="popover"
														data-placement="top" data-content="商品加入购物车成功">
														<i class="fa fa-cart-plus" aria-hidden="true"></i>添加到购物车
													</button>
												</div>
											</div>
										</div>
									</s:iterator>
									<!-- 分页开始 -->
									<div class="paging">
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
															<li><a href="javascript:void(0)"
																paging-data="${cur}">${cur}</a></li>
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
									</div>
									<!-- /分页结束 -->
								</div>
								</s:else>
							</div>
							<div class="col-md-3 rsidebar">
								<div class="sidebar-row">
									<h4>按条件搜索</h4>
									<ul class="faq">
										<li role="presentation" class="spinButton"><a
											href="products?goodsKind=1"> <i class="icon iconfont">&#xe601;</i>
												<h5>盘栽</h5>
										</a></li>
										<li role="presentation" class="spinButton"><a
											href="products?goodsKind=2"> <i class="icon iconfont"
												aria-hidden="true">&#xe611;</i>
												<h5>花卉</h5>
										</a></li>
										<li role="presentation" class="spinButton"><a
											href="products?goodsKind=3"> <i class="icon iconfont"
												aria-hidden="true">&#xe60b;</i>
												<h5>树苗</h5>
										</a></li>
										<li role="presentation" class="spinButton"><a
											href="products?goodsKind=4"> <i class="icon iconfont"
												aria-hidden="true">&#xe603;</i>
												<h5>种子</h5>
										</a></li>
										<%-- 	<li class="item3"><a href="#">Entertainment<span
													class="glyphicon glyphicon-menu-down"></span></a>
												<ul>
													<li class="subitem1"><a href="#"> Tv & Accessories</a></li>
													<li class="subitem1"><a href="#">Digital Camera </a></li>
													<li class="subitem1"><a href="#">Computer</a></li>
												</ul></li> --%>
									</ul>
								</div>
								<br/><br/>
								<div class="rsidebar-top">
									<div class="slider-left">
										<h4 style="padding-top:10px">价格区间</h4>
										<div class="row row1 scroll-pane priceSection">
											<label class="checkbox"><input type="checkbox" ${minPrice==0&&maxPrice!=0?"checked":""}
												name="checkbox" min="0" max="10" ><i></i>0 - 10元 </label> <label
												class="checkbox"><input type="checkbox" ${minPrice<=10&&maxPrice>=50?"checked":""}
												name="checkbox" min="10" max="50"><i></i>10元 - 50元 </label> <label
												class="checkbox"><input type="checkbox" ${minPrice<=50&&maxPrice>=100?"checked":""}
												name="checkbox" min="50" max="100"><i></i>50元 - 100元 </label> <label
												class="checkbox"><input type="checkbox" ${minPrice<=100&&maxPrice>=200?"checked":""}
												name="checkbox" min="100" max="200"><i></i>100元 - 200元 </label> <label
												class="checkbox"><input type="checkbox" ${minPrice<=200&&maxPrice>=300?"checked":""}
												name="checkbox" min="200" max="300"><i></i>200元 - 300元 </label> <label
												class="checkbox"><input type="checkbox" ${minPrice<=300&&maxPrice>=500?"checked":""}
												name="checkbox" min="300" max="500"><i></i>300元 - 500元 </label> <label
												class="checkbox"><input type="checkbox" ${maxPrice>=500?"checked":""}
												name="checkbox" min="500" max="10000"><i></i>500元及以上</label>
										</div>
									</div>
									<div class="sidebar-row">
										<h4>颜色</h4>
										<div class="row row1 scroll-pane goodsColor">
											<label class="checkbox"><input type="checkbox" ${color!=null&&color.indexOf('#ffffff')!=-1?'checked':'' } data="#ffffff"><i style="border-color:#FFFFFF"></i>白色</label> 
											<label class="checkbox"><input type="checkbox" ${color!=null&&color.indexOf('#ff0000')!=-1?'checked':'' } data="#ff0000"><i style="border-color:#FF0000"></i>红色</label> 
											<label class="checkbox"><input type="checkbox" ${color!=null&&color.indexOf('#fff000')!=-1?'checked':'' } data="#fff000"><i style="border-color:#FFF000"></i>橙色</label>
											<label class="checkbox"><input type="checkbox" ${color!=null&&color.indexOf('#ffff00')!=-1?'checked':'' } data="#ffff00"><i style="border-color:#FFFF00"></i>黄色</label>
											<label class="checkbox"><input type="checkbox" ${color!=null&&color.indexOf('#00ff00')!=-1?'checked':'' } data="#00ff00"><i style="border-color:#00FF00"></i>绿色</label>
											<label class="checkbox"><input type="checkbox" ${color!=null&&color.indexOf('#00ffff')!=-1?'checked':'' } data="#00ffff"><i style="border-color:#00FFFF"></i>青色</label>
											<label class="checkbox"><input type="checkbox" ${color!=null&&color.indexOf('#0000ff')!=-1?'checked':'' } data="#0000ff"><i style="border-color:#0000FF"></i>蓝色</label>
											<label class="checkbox"><input type="checkbox" ${color!=null&&color.indexOf('#f000ff')!=-1?'checked':'' } data="#f000ff"><i style="border-color:#F000FF"></i>紫色</label>
											<label class="checkbox"><input type="checkbox" ${color!=null&&color.indexOf('#000000')!=-1?'checked':'' } data="#000000"><i style="border-color:#000000"></i>黑色</label> 
										</div>
									</div>
								</div>
								<button class="btn btn-success searchButton"
									style="width:100%;margin-top:5px;">
									<span class="glyphicon glyphicon-search"></span>
								</button>
								<div class="related-row">
									<h4>热门搜索关键字</h4>
									<ul>
										<li><a href="products?keywords=玫瑰">玫瑰</a></li>
										<li><a href="products?keywords=丁香">丁香</a></li>
										<li><a href="products?keywords=礼物">礼物</a></li>
										<li><a href="products?keywords=盘栽">盘栽</a></li>
										<li><a href="products?keywords=绿色">绿色</a></li>
										<li><a href="products?keywords=吸辐射">吸辐射</a></li>
										<li><a href="products?keywords=增氧">增氧</a></li>
										<li><a href="products?keywords=健康">健康</a></li>
										<li><a href="products?keywords=水果">水果</a></li>
										<li><a href="products?keywords=小苗">小苗</a></li>
										<li><input type="text" class="form-control inputKey" style="width:100px;height:30px;" placeholder="输入关键字" value="${keywords}"></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="clearfix"></div>
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
	<script type="text/javascript">
		var totalPage = ${totalPage};
		var currentPage = ${currentPage};
		$(function(){
			$(".pagination li").bind("click", function() {
					pagingGo(this);
				});
			$(".productsSort li").bind("click",function(){
				$("#function").val($(this).attr("data"));
				$("#searchProducts").submit();
			})
			$(".priceSection input[type=checkbox]").change(function(){
				var priceSectionInput = $(".priceSection input[type=checkbox]:checked");
				if(priceSectionInput.length>0){
					$("#minPrice").val($(priceSectionInput[0]).attr("min"));
					$("#maxPrice").val($(priceSectionInput[priceSectionInput.length-1]).attr("max"));
				}else{
					$("#minPrice").val(0);
					$("#maxPrice").val(0);
				}
			})
			$(".searchButton").click(function(){
				$("#searchProducts").submit();
			})
			$(".goodsColor input").bind("change",function(){
				var colors = $(".goodsColor input:checked");
				var color="";
				for(var i=0;i<colors.length;i++){
					if(i==colors.length-1)
						color += $(colors[i]).attr("data");
					else
						color += $(colors[i]).attr("data")+",";
				}
				$("#color").val(color);
			})
			$(".inputKey").keyup(function(e){
				if(this.value=='')return;
				if(e.keyCode==13){
					window.location.href="products?keywords="+this.value;
				}
			})
			//用于改变分页到中间位置
			var paging = $(".paging").get(0);
			var pagination = $(".pagination").get(0);
			pagination.style.left = (paging.offsetWidth-pagination.offsetWidth)/2+"px";
		})
		//分页请求
		function pagingGo(el) { // 分页数据请求
			var current = $(el).find("a").attr("paging-data");
			if (current != null) {
				if (current != currentPage && current <= totalPage) {
					$("#currentPage").val(current);
					$("#searchProducts").submit();
				}
			}
		}
	</script>
	<!-- menu js aim -->
	<%-- <script src="js/jquery.menu-aim.js"> --%>
	<%-- 	
	</script> --%>
	<%-- <script src="js/main.js"></script> --%>
	<!-- Resource jQuery -->
	<!-- //menu js aim -->
	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="js/sidebar/classie.js" type="text/javascript"></script>
	<script src="js/sidebar/modernizr.custom.js" type="text/javascript"></script>
	<script src="js/sidebar/sidebarEffects.js" type="text/javascript"></script>
	<script src="js/cart.js" type="text/javascript"></script>
	
	<script src="js/move.js"></script>
	<script src="js/chat.js" type="text/javascript"></script>
	<script src="js/admin/levelControl.js" type="text/javascript"></script>
	<script src="js/colorpicker/bootstrap-colorpicker.min.js" type="text/javascript"></script>
	<script src="css/face/js/jquery-browser.js"></script>
	<script src="css/face/js/jquery.qqFace.js"></script>
	<script src="js/fileUpload/ajaxfileupload.js"></script>
	<script type="text/javascript">
		var webSocketUri="<%=serverPath%>chatServer.server?user=${user.nickname!=null?user.nickname:user.username!=null?user.username:user.phone}";
		var currentUserName="${user.nickname!=null?user.nickname:user.username!=null?user.username:user.phone}";
		$(function(){
		$(".bodyLoader").remove();
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
</body>
</html>