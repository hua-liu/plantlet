$(function(){
	//$('[data-toggle="popover"]').popover();
	$(".slides li .img-responsive").bind("click mouseover",function(){
		$(".big-img img").attr("src",$(this).attr("src"))
	})
	$("#buyNumMade input").keyup(function(e){
		if(/^[0-9]{1,4}$/.test(this.value)){
			var maxValue=parseInt($(this).attr("maxValue"));
			if(this.value>maxValue){
				$(this).val(maxValue);
				$(this).attr("sourceValue",this.value);
			}else if(this.value<1){
				$(this).val(1);
				$(this).attr("sourceValue",this.value);
			}
		}else{
			$(this).val($(this).attr("sourceValue"));
		}
	})
	$("#buyNumMade .minus").click(function(){
		var val = parseInt($("#buyNumMade input").val())-1;
		if(val<1)val=1;
		$("#buyNumMade input").val(val);
	})
	$("#buyNumMade .add").click(function(){
		var maxValue=$("#buyNumMade input").attr("maxValue");
		var val = parseInt($("#buyNumMade input").val())+1;
		if(val>maxValue)val=maxValue;
		$("#buyNumMade input").val(val);
	})
	//添加商品到购物车
	$(".intoCart").click(function(){
		addOrderForm($(this).attr("data-id"),$(".buyNum").val());
	})
	
})
var isColse=true;
//添加购物车商品节点
function createCartItim(id,img,name,price,num){
	//添加节点
	$(".mini-cart-items-list").append($('<li data-id="'+id+'"><div class="mini-cart-item"><div class="mini-cart-item-pic"><img src="'+img+'"></div><div class="mini-cart-item-info">'
			+'<div class="mini-cart-item-title">'+name+'</div><div class="mini-cart-item-price">'
			+'<i class="fa fa-rmb"></i><span class="cart-price">'+price*num+'</span></div><a class="mini-cart-item-del" href="#"><i class="fa fa-times"></i></a></div></div></li>'));
	/*$(".intoCart").popover("show");
	window.setTimeout(function() {
	$(".intoCart").popover("destroy");}, 2000)*/
	$("#cart-item-num").html(parseInt($("#cart-item-num").html())+1)
	$(".mini-cart-item-del").unbind();
	$(".mini-cart-item-del").bind("click",function(){
		$(this).parent().parent().remove();
		isColse=false;
		$("#cart-item-num").html(parseInt($("#cart-item-num").html())-1)
		window.setTimeout(function() {
			isColse=true;
		}, 1000)
	});
}
//向数据库发送添加购物车请求
function addOrderForm(id,num){
	var url = "json/orderForm_add";
	var data = "goods.goodsId="+id+"&buyNum="+num;
	
	$.post(url,data,function(data){
		if(data==null){
			$(".intoCart").attr("data-content","加入购物车失败");
			$(".intoCart").popover("show");
			window.setTimeout(function() {$(".intoCart").popover("destroy");}, 2000)
			$(".mini-cart-items-list li[data-id="+$(".iotoCart").attr("data-id")+"]").remove();
		}
		if(data=='input'){
			window.location.href="loginUi?url="+window.location.href.substr(7);
		}else{
			data = eval("("+data+")");
			if(data.message){
				createCartItim($(this).attr("data-id"),$(".big-img .MagicZoom img").attr("src"),$(".product_name").html(),$(".price").html(),$(".buyNum").val())
				$(".intoCart").attr("data-content","加入购物车成功");
				$(".intoCart").popover("show");
				window.setTimeout(function() {$(".intoCart").popover("destroy");}, 2000)
			}else{
				$(".intoCart").attr("data-content","加入购物车失败:原因："+data.cause);
				$(".intoCart").popover("show");
				window.setTimeout(function() {$(".intoCart").popover("destroy");}, 2000)
				$(".mini-cart-items-list li[data-id="+$(".iotoCart").attr("data-id")+"]").remove();
			}
		}
	},"json")
}
