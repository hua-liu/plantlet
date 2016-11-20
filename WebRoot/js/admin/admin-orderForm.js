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
	//搜索
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
	/*
	 * 高级选项点击事件绑定
	 */
	$("#myModal").on("show.bs.modal", function() {
		if (permissions.indexOf("SelectOrderForm") == -1) {
			return false;
		}
	})
	
	var uls = getElement(".advanced");
	for (i = 0; i < uls.length; i++) {
		uls[i].getElementsByTagName("li")[0].addEventListener("click",
				function(e) {
					if (permissions.indexOf("DeleteOrderForm") == -1) {
						showWarning(false,"权限不足，无法删除用户...");
						return;
					} else
						deleteOrderFormData(this);
				})
		uls[i].getElementsByTagName("li")[1].addEventListener("click",
				function(e) {
					if (permissions.indexOf("SelectOrderForm") == -1) {
						showWarning(false,"权限不足，不能显示更多...");
						return;
					} else
						getOrderFromMoreData(this);
				})
	}
	

	/* 打印事件 */
	$("#printUser").click(function() {
		$("#printContext").printArea();
	})
	/* 关闭窗口事件 */
	var wins = $(".closeWin");
	for (var i = 0; i < wins.length; i++) {
		wins[i].addEventListener("click", function(e) {
			closeWin(this);
		})
	}
	//窗口改变时关闭选择状态框
	window.onresize=function(){
		$(".orderFormStateUi").hide();
	}
	//更改状态按钮事件
	$(".stateButton").bind("click",function(){
		var currentButton = this;
		$(".orderFormStateUi").toggle();
		$(".orderFormStateUi").css({"top":this.getBoundingClientRect().top-$(".orderFormStateUi").height(),"left":this.getBoundingClientRect().left-($(".orderFormStateUi").width()-this.offsetWidth)/2});
		$(".orderFormStateUi li").unbind();
		$(".orderFormStateUi li").bind("click",function(){
			$(".orderFormStateUi").hide();
			if($(this).attr("data-id")==$(currentButton).attr("data-id"))return;
			var li = this;
			$.post("json/orderForm_updateState","id="+$(currentButton).parents("tr").attr("data-id")+"&stateId="+$(this).attr("data-id"),function(data){
				if(data!=null){
					data = eval("("+data+")");
					if(data.message){
						$(currentButton).find(".stateText").html($(li).html());
						$(currentButton).attr($(li).attr("data-id"));
						showWarning(true,"订单已成功更新！！");
						return;
					}else{
						showWarning(false,"订单更新失败，原因："+data.cause+"...");
						return;
					}
				}
				showWarning(false,"更新失败，请稍候重试...");
				return;
			})
		})
	})
})
function pagingGo(el) { // 分页数据请求
	var current = el.getElementsByTagName("a")[0].getAttribute("paging-data");
	if (current != null) {
		if (current != currentPage && current <= totalPage) {
			parent.loaderAnimation();	//调用父窗口的js方法
			$("#currentPage").val(current);
			$("#ScopeSearch").submit();
		}
	}
}


function getElement(str) {
	if (str.charAt(0) == ".")
		return document.getElementsByClassName(str.substr(1));
	else if (str.charAt(0) == "#")
		return document.getElementById(str.substr(1));
}
function deleteOrderFormData(el) {
	$("#sureDelete").unbind("click");
	$("#deleteWarning").slideDown(500);
	var id = el.parentNode.getAttribute("data-id");
	var tds = $(".orderFormList[data-id='" + id + "'] td");
	$("#deleteWarning .deleteWarning-text").html(tds[1].innerHTML);
	/* 删除按钮事件 */
	if (id == null) {
		return;
	}
	$("#sureDelete").click(function() {
		$.post({
			url : "json/orderForm_delete",
			data : "id=" + id,
			success : function(data) {
				if (data != null) {
					data = eval("(" + data + ")");
					$("#deleteWarning").slideUp(500);
					if (data.message) {
						showWarning(true,"删除成功...");
						$(".orderFormList[data-id=" + id + "]").get(0).remove();
						return;
					} else {
						showWarning(false,"删除失败，请稍候重试...");
						return;
					}
				}
			},
		})
	})
}
function getOrderFromMoreData(el) {
	var id = el.parentNode.getAttribute("data-id");
	var data = "id=" + id;
	$.post({
		url : "json/getMoreData_orderForm",
		data : data,
		success : function(data) {
			if (data != null) {
				getElement("#moreInfor").innerHTML = "";
				data = eval("(" + data + ")");
				setMoreData(data);
			}
			return;
		}
	})
}
function setMoreData(data) {
	for ( var val in data) {
		if(val=='state')data[val]='状态';
		if (data[val] != null) {
			//createTrTd(nameArr[val], data[val])
			createTrTd(val, data[val])
		}
	}

}
function createTrTd(name, value) {
	$("#moreInfor").append(
			$("<tr><td>" + name + "</td><td>" + value + "</td></tr>"));
}

function cancelPropover(ele) {
	$(ele).popover('destroy');
	ele.style.borderColor = "#ccc";
}
/* ajax校验唯一 */
var existError = function(ty) {
	var type = ty;
};
function closeWin(el) {
	$(el.parentNode).hide(500);
}
