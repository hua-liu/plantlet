$(function(){
	//$('[data-toggle="popover"]').popover();
	$(".slides li .img-responsive").bind("click mouseover",function(){
		$(".big-img img").attr("src",$(this).attr("src"))
	})
	//输入数量
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
	//数量减少
	$("#buyNumMade .minus").click(function(){
		var val = parseInt($("#buyNumMade input").val())-1;
		if(val<1)val=1;
		$("#buyNumMade input").val(val);
	})
	//数量增加
	$("#buyNumMade .add").click(function(){
		var maxValue=$("#buyNumMade input").attr("maxValue");
		var val = parseInt($("#buyNumMade input").val())+1;
		if(val>maxValue)val=maxValue;
		$("#buyNumMade input").val(val);
	})
	//直接购买
	$("#buy").click(function(){
		if($(".color").length>0&&$(".color.checked").length<1){
			$(".colorTd").popover("show");
			setTimeout(function(){
				$(".colorTd").popover("destroy");
			},3000);
			return;
		}
		var el = this;
		var url = "json/userOrderForm_add";
		var data = "goods.goodsId="+$(this).attr("data-id")+"&buyNum="+$(this).parents("tbody").find(".buyNum").val()+"&color="+$(this).parents("tbody").find(".color.checked").attr("data");
		$.post(url,data,function(data){
			if(data==null){
				$(el).attr("data-content",i18n.get("createOrderFailure"));
				$(el).popover("show");
				window.setTimeout(function() {$(el).popover("destroy");}, 2000)
				$(".mini-cart-items-list li[data-id="+$(el).attr("data-id")+"]").remove();
			}
			if(data=='input'){
				window.location.href="loginUi?url="+window.location.href.substr(7);
			}else{
				data = eval("("+data+")");
				if(data.message){
					window.location.href="auctionOrder?id="+data.id;
				}else{
					$(el).attr("data-content",i18n.get("buyFailure")+data.cause);
					$(el).popover("show");
					window.setTimeout(function() {$(el).popover("destroy");}, 2000)
				}
			}
		},"json")
	})
	//颜色选择
	$(".color").click(function(){
		$(this).addClass("checked");
		$(this).siblings().removeClass("checked");
	})
})

