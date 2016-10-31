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
})
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
	var url = "json/orderForm_delete";
	var data = "id="+id;
	$.post(url,data,null)
}