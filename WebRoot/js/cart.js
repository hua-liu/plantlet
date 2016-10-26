var isColse=true;
$(function(){
	//从购物车删除商品
	$(".mini-cart-item-del").bind("click",function(){
		removeOrderForm(this);
		$(this).parents("li").remove();
		$("#cart-item-num").html(parseInt($("#cart-item-num").html())-1);
		isColse=false;
		window.setTimeout(function() {
			isColse=true;
		}, 1000)
		
	});
	$(".mini-cart-items-list>li").bind("click",function(){
		window.location.href="single?goodsId="+$(this).attr("data-id");
	})
})
function removeOrderForm(el){
	var id=$(el).parents("li").attr("data-id");
	var url = "json/orderForm_delete";
	var data = "id="+id;
	$.post(url,data,null)
}