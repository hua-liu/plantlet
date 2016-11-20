/**
 * 
 */
$(function() {
	var lis = $(".pagination li");
	for (var i = 0; i < lis.length; i++) {
		lis[i].addEventListener("click", function() {
			pagingGo(this);
		});
	}
	//keywords搜索
	$("#inputKeywords").bind("keypress",function(e) {
		if(e.keyCode==13){
			if(this.value==$(this).attr("source-data")){
				return;
			}
			$("#currentPage").val(1);
			$("#keywords").val(this.value);
			$("#ScopeSearch").submit();
		}
	})
	$("#keywords-submit").bind("click", function() {
		if($("#inputKeywords").val()==$("#inputKeywords").attr("source-data")){
			return;
		}
		$("#currentPage").val(1);
		$("#keywords").val($("#inputKeywords").val());
		$("#ScopeSearch").submit();
	})
	//页面跳转
	$("#goto").bind(
			"keypress",
			function(e) {
				if (e.keyCode == 13) {
					if (this.value != null && /^[0-9]{1,5}$/.test(this.value)
							&& this.value <= totalPage
							&& this.value != currentPage && this.value > 0) {
						parent.loaderAnimation();//调用父级方法
						$("#currentPage").val(this.value);
						$("#ScopeSearch").submit();
					} else {
						this.style.border = "1px solid red";
						this.focus();
					}
				}
			})
	$('[data-toggle="tooltip"]').tooltip();
	//高级菜单选项
	$(".putawayProductLi").bind("click",function(){
		putawayOrSoldOut(true,this);	//上架商品
	})
	$(".soldOutProductLi").bind("click",function(){
		putawayOrSoldOut(false,this);	//下架商品
	})
	$(".updateProductLi").bind("click",function(){
		updateProductData(this);
		parent.loaderAnimation();
	})
	$(".deleteProductLi").bind("click",function(){
		deleteProductData(this);	//删除商品
	})
	$(".showProductLi").bind("click",function(){
		$(".moreInformation[data-id="+$(this).parent().attr("data-id")+"]").parent().parent().slideToggle(1200);
		$(".moreInformation[data-id="+$(this).parent().attr("data-id")+"]").slideToggle(1000);
	})
	$(".closeWin").click(function(){
		 closeWin(this);
	});
	$(".productState .mc").bind("click",function(){
		var value = $(this).children("input").val();
		if(value==$(this).children("input").attr("source-data")){
			value = value==1?6:7;
			var bool = value==7?true:false;
			var id = $(this).parent().parent().attr("data-id");
			if(id==null){
				alert("商品无效")
			}
			putaswayOrSoldOutPost(bool,id,value);
		}
	})
})
function updateProductData(el){
	parent.updateProductText("更新商品",true);
	window.location.href="admin_updateGoods?id="+$(el).parent().attr("data-id");
}
//商品直接上下架
function putawayOrSoldOut(bool,el){
	var goodsId = $(el).parent().attr("data-id");
	if(goodsId==null||goodsId==''){
		alert("无法获取商品ID!");
		return;
	}
	putaswayOrSoldOutPost(bool,goodsId,bool?7:6);
}
function putaswayOrSoldOutPost(bool,id,stateId){
	var data = "id="+id+"&state.id="+stateId;
	$.post("json/goods_putawayOrSoldout",data,function(data){
		if(data!=null){
			data = eval("("+data+")");
			if(data.message){
				$(".goodsList[data-id="+id+"] td ul li:first").unbind();
				if(bool){
					showWarning(true,"商品上架成功");
					$(".goodsList[data-id="+id+"] .mc input").val(1);
					$(".goodsList[data-id="+id+"] .mc input").attr("source-data",1);
					$(".goodsList[data-id="+id+"] td ul li:first").attr("class","soldOutProductLi");
					$(".goodsList[data-id="+id+"] td ul li:first a").html("下架商品");
				}else{
					showWarning(true,"商品下架成功");
					$(".goodsList[data-id="+id+"] .mc input").val(0);
					$(".goodsList[data-id="+id+"] .mc input").attr("source-data",0)
					$(".goodsList[data-id="+id+"] td ul li:first").attr("class","putawayProductLi");
					$(".goodsList[data-id="+id+"] td ul li:first a").html("上架商品");
				}
				$(".goodsList[data-id="+id+"] td ul li:first").click(function(){
					putawayOrSoldOut(!bool,this);	//上下架商品
				});
				myMc($(".goodsList[data-id="+id+"] .mc").get(0))
				return;
			}
			showWarning(false,data.cause);
			return;
		}
		showWarning(false,"服务器异常！稍候再试...");
	})
}
//分页请求
function pagingGo(el) { // 分页数据请求
	var current = el.getElementsByTagName("a")[0].getAttribute("paging-data");
	if (current != null) {
		if (current != currentPage && current <= totalPage) {
			parent.loaderAnimation();
			$("#currentPage").val(current);
			$("#ScopeSearch").submit();
		}
	}
}
//删除产品
function deleteProductData(el) {
	$("#sureDelete").unbind("click");
	$("#deleteWarning").slideDown(500);
	var id = el.parentNode.getAttribute("data-id");
	var tds = $(".goodsList[data-id='" + id + "'] td");
	$("#deleteWarning .deleteWarning-text").html("商品名为["+tds[1].innerHTML);
	// 删除按钮事件 
	if (id == null) {
		return;
	}
	$("#sureDelete").click(function() {
		$.post({
			url : "json/delete_goods",
			data : "goodsId=" + id,
			success : function(data) {
				if (data != null) {
					data = eval("(" + data + ")");
					$("#deleteWarning").slideUp(500);
					if (data.message) {
						showWarning(true,"删除成功...");
						$(".goodsList[data-id=" + id + "]").hide(500);
						$(".goodsList[data-id=" + id + "]").remove();
						$(".moreInformation[data-id="+id+"]").parent().parent().hide(500);
						$(".moreInformation[data-id="+id+"]").parent().parent().remove();
						/*window.setTimeout(function() {
							window.location.reload();
						}, 2000)*/
						return;
					} else {
						showWarning(false,data.cause);
						return;
					}
				}
				showWarning(false,"删除失败，请稍候重试...");
				return;
			}
		})
	})
}
function closeWin(el) {
	$(el.parentNode).hide(500);
}
