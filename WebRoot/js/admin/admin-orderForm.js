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
						showWarning(false,i18n.get("insufficientPermissions")+i18n.get("canNot")+i18n.get("deleteUser")+"...");
						return;
					} else
						deleteOrderFormData(this);
				})
		uls[i].getElementsByTagName("li")[1].addEventListener("click",
				function(e) {
					if (permissions.indexOf("SelectOrderForm") == -1) {
						showWarning(false,i18n.get("insufficientPermissions")+i18n.get("canNot")+i18n.get("showMore")+"...");
						return;
					} else
						getUserMoreData(this);
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
						showWarning(true,i18n.get("_delete")+i18n.get("success")+"...");
						$(".orderFormList[data-id=" + id + "]").get(0).remove();
						return;
					} else {
						showWarning(false,i18n.get("_delete")+i18n.get("failure")+"！"+i18n.get("pleaseTryAgainLater")+"...");
						return;
					}
				}
			},
		})
	})
}
function getUserMoreData(el) {
	var id = el.parentNode.getAttribute("data-id");
	var data = "id=" + id;
	$.post({
		url : "json/getMoreData_user",
		data : data,
		success : function(data) {
			if (data != null) {
				getElement("#moreInfor").innerHTML = null;
				data = eval("(" + data + ")");
				setMoreData(data);
			}
			return;
		}
	})
}
function setMoreData(data) {
	for ( var val in data) {
		if(val=='roleId')continue;
		if(val=='state')data[val]=i18n.get(data[val]);
		if (data[val] != null) {
			createTrTd(nameArr[val], data[val])
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
function checkIsExist(type, ele) {
	if (ele.value == ele.getAttribute("source-data")) {
		return false;
	}
	var data = "type=" + type + "&id=" + getElement("#update.id").value
			+ "&value=" + ele.value;
	$.post({
		url : "json/checkIsExist",
		data : data,
		success : function(data) { // 此处可以因为版本问题导入包commons-lang-2.3.jar
			if (data != null) {
				var data = eval("(" + data + ")");
				if (data.message) {
					type == 'usename' ? ele.setAttribute("data-content",
							i18n.get("usernameInvalid")) : type == 'email' ? ele.setAttribute(
							"data-content", i18n.get("emailInvalid")) : type == 'phone' ? ele
							.setAttribute("data-content", i18n.get("phoneInvalid")) : ele
							.setAttribute("data-content", i18n.get("nicknameInvalid"));
					$(ele).popover('show');
					ele.style.borderColor = "#f00";
					isExsit.put(type, null);
				} else {
					$(ele).popover('destroy');
					ele.style.borderColor = "#ccc";
					isExsit.remove(type);
				}
			}
		}
	});
}
function closeWin(el) {
	$(el.parentNode).hide(500);
}
