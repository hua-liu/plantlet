var isColse=true;
$(function(){
	//从购物车删除商品
	$(".mini-cart-item-del").bind("click",function(){
		delEvent(this);
	});
	$(".mini-cart-items-list>li").bind("click",function(){
		window.location.href="auctionOrder?id="+$(this).attr("data-id");
	})
	$(".goBuy").bind("click",function(){
		window.location.href="auctionOrder";
	})
	//添加商品到购物车
	$(".intoCart").click(function(){
		var buyNum = $(".buyNum").length>1?$(this).prev():$(".buyNum");//如果是商品分类页则调用当前上一个
		if(parseInt($(buyNum).val())>parseInt($(buyNum).attr("maxValue"))){
			$(this).attr("data-content",i18n.get('intoCartFailure')+':'+i18n.get('noGoods'));
			$(this).popover("show");
			var currentNode = this;
			window.setTimeout(function() {$(currentNode).popover("destroy");}, 2000)
			return;
		}
		if($(".color").length>0&&$(".color.checked").length<1){
			$(".colorTd").popover("show");
			setTimeout(function(){
				$(".colorTd").popover("destroy");
			},3000);
			return;
		}
		if($(this).parents("tbody").find(".color.checked").length>0){
			addOrderForm(this,$(buyNum).val(),$(this).parents("tbody").find(".color.checked").attr("data"));
		}else{
			addOrderForm(this,$(buyNum).val(),"");
		}
		
	})
	$(".clearCart").click(function(){
		clearCart();
	})
	
})
//添加购物车商品节点
function createCartItim(id,img,name,price,num){
	//添加节点
	$(".mini-cart-items-list").append($('<li data-id="'+id+'"><div class="mini-cart-item"><div class="mini-cart-item-pic"><img src="'+img+'"></div><div class="mini-cart-item-info">'
			+'<div class="mini-cart-item-title">'+name+'</div><div class="mini-cart-item-price">'
			+'<i class="fa fa-rmb"></i><span class="cart-price">'+(price*num).toFixed(2)+'</span></div><a class="mini-cart-item-del" href="#"><i class="fa fa-times"></i></a></div></div></li>'));
	/*$(".intoCart").popover("show");
	window.setTimeout(function() {
	$(".intoCart").popover("destroy");}, 2000)*/
	$("#cart-item-num").html(parseInt($("#cart-item-num").html())+1)
	$(".mini-cart-item-del").unbind();
	$(".mini-cart-item-del").bind("click",function(){
		delEvent(this);
	});
}
//向数据库发送添加购物车请求
function addOrderForm(el,num,color){
	var id=$(el).attr("data-id");
	var url = "json/userOrderForm_add";
	var data = "goods.goodsId="+id+"&buyNum="+num+"&color="+color;
	$.post(url,data,function(data){
		if(data==null){
			$(el).attr("data-content",i18n.get('intoCartFailure'));
			$(el).popover("show");
			window.setTimeout(function() {$(el).popover("destroy");}, 2000)
			$(".mini-cart-items-list li[data-id="+$(el).attr("data-id")+"]").remove();
		}
		if(data=='input'){
			window.location.href="loginUi?url="+window.location.href.substr(7);
		}else{
			data = eval("("+data+")");
			if(data.message){
				if($(".buyNum").length>1){
					createCartItim(data.id,$(el).parents(".product-grids").find("img").attr("src"),$(el).parents(".product-grids").find(".product_name").html(),$(el).parents(".product-grids").find(".price").html(),$(el).parents(".product-grids").find(".buyNum").val())
				}else
				createCartItim(data.id,$(".big-img .MagicZoom img").attr("src"),$(".product_name").html(),$(".price").html(),$(".buyNum").val())
				$(el).attr("data-content",i18n.get('intoCartSuccess'));
				$(el).popover("show");
				$(".mini-cart-items-list>li").unbind();
				$(".mini-cart-items-list>li").bind("click",function(){
					window.location.href="auctionOrder?id="+$(this).attr("data-id");
				})
				if($(".goBuy").is(":hidden")){//判断结算按钮是否显示
					$(".goBuy").css("display","block");
				}
				window.setTimeout(function() {$(el).popover("destroy");}, 2000)
			}else{
				$(el).attr("data-content",i18n.get('intoCartFailure')+","+i18n.get('cause')+"："+data.cause);
				$(el).popover("show");
				window.setTimeout(function() {$(el).popover("destroy");}, 2000)
				$(".mini-cart-items-list li[data-id="+$(el).attr("data-id")+"]").remove();
			}
		}
	},"json")
}
//清空购物车
function clearCart(){
	$.post("json/userOrderForm_clearAll",null,function(data){
		if(data!=null){
			data = eval("("+data+")");
			if(data.message){
				$(".mini-cart-items-list li").remove();
				$("#cart-item-num").html(0);
				$(".goBuy").css("display","none");
			}else{
				alert(i18n.get('clearCartFailure'))
			}
		}
	})
}
function delEvent(el){
	removeOrderForm(el);
	$(el).parents("li").remove();
	$("#cart-item-num").html(parseInt($("#cart-item-num").html())-1);
	isColse=false;
	if($(".mini-cart-item").length<1){
		$(".goBuy").css("display","none");
	}
	window.setTimeout(function() {
		isColse=true;
	}, 1000)
}
function removeOrderForm(el){
	var id=$(el).parents("li").attr("data-id");
	var url = "json/userOrderForm_delete";
	var data = "id="+id;
	$.post(url,data,null)
}