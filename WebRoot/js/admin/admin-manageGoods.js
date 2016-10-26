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
					$(".goodsList[data-id="+id+"] td:eq(4) .mc input").val(1);
					$(".goodsList[data-id="+id+"] td:eq(4) .mc input").attr("source-data",1);
					$(".goodsList[data-id="+id+"] td ul li:first").attr("class","soldOutProductLi");
					$(".goodsList[data-id="+id+"] td ul li:first a").html("下架商品");
				}else{
					showWarning(true,"商品下架成功");
					$(".goodsList[data-id="+id+"] td:eq(4) .mc input").val(0);
					$(".goodsList[data-id="+id+"] td:eq(4) .mc input").attr("source-data",0)
					$(".goodsList[data-id="+id+"] td ul li:first").attr("class","putawayProductLi");
					$(".goodsList[data-id="+id+"] td ul li:first a").html("上架商品");
				}
				$(".goodsList[data-id="+id+"] td ul li:first").click(function(){
					putawayOrSoldOut(!bool,this);	//上下架商品
				});
				myMc($(".goodsList[data-id="+id+"] td:eq(4) .mc").get(0))
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
						showWarning(true,i18n.get("_delete")+i18n.get("success")+"...");
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
				showWarning(i18n.get("_delete")+i18n.get("failure")+"！"+i18n.get("pleaseTryAgainLater")+"...");
				return;
			}
		})
	})
}
function closeWin(el) {
	$(el.parentNode).hide(500);
}
	/*getElement("#update.submit").addEventListener("click", function() {
		updateUser();
	})
	
	 * 高级选项点击事件绑定
	 
	$("#updateModal").on("show.bs.modal", function() {
		if (permissions.indexOf("updateUser") == -1) {
			return false;
		}
	})
	$("#myModal").on("show.bs.modal", function() {
		if (permissions.indexOf("selectUser") == -1) {
			return false;
		}
	})

	var uls = getElement(".advanced");
	for (i = 0; i < uls.length; i++) {
		uls[i].getElementsByTagName("li")[0].addEventListener("click",
				function(e) {
					if (permissions.indexOf("updateUser") == -1) {
						showWaring(i18n.get("insufficientPermissions")+i18n.get("canNot")+i18n.get("updateUser")+"...");
						return;
					} else
						updateUserData(this);
				})
		uls[i].getElementsByTagName("li")[1].addEventListener("click",
				function(e) {
					if (permissions.indexOf("deleteUser") == -1) {
						showWaring(i18n.get("insufficientPermissions")+i18n.get("canNot")+i18n.get("deleteUser")+"...");
						return;
					} else
						deleteUserData(this);
				})
		uls[i].getElementsByTagName("li")[2].addEventListener("click",
				function(e) {
					if (permissions.indexOf("selectUser") == -1) {
						showWaring(i18n.get("insufficientPermissions")+i18n.get("canNot")+i18n.get("showMore")+"...");
						return;
					} else
						getUserMoreData(this);
				})
	}
	
	 * 更新字段验证
	 
	getElement("#update.username").addEventListener("change", function(e) {
		verify("username", this);
	})
	getElement("#update.email").addEventListener("change", function(e) {
		verify("email", this);
	})
	getElement("#update.phone").addEventListener("change", function(e) {
		verify("phone", this);
	})
	getElement("#update.nickname").addEventListener("change", function(e) {
		verify("nickname", this);
	})
	
	 * 修改规范打开与关闭
	 
	getElement("#changeNorm").addEventListener("click", function(e) {
		if (getElement(".changeNorm")[0].style.display == 'none') {
			$(getElement("#update.submit")).popover("destroy")
			getElement(".changeNorm")[0].style.display = "block";
			this.innerHTML = i18n.get("hideChangeNorm");
		} else {
			$(getElement("#update.submit")).popover("destroy")
			getElement(".changeNorm")[0].style.display = "none";
			this.innerHTML = i18n.get("readChangeNorm");
		}
	})
	getElement(".changeNorm")[0].style.display = "none";

	
	 * 修改模态框隐藏时取消所有提示框
	 
	$("#updateModal").on("hide.bs.modal", function() {
		cancelPropover(getElement("#update.username"));
		cancelPropover(getElement("#update.email"));
		cancelPropover(getElement("#update.phone"));
		cancelPropover(getElement("#update.nickname"));
		cancelPropover(getElement("#update.submit"));
	})

	 打印事件 
	$("#printUser").click(function() {
		$("#printContext").printArea();
	})
	 关闭窗口事件 
	var wins = $(".closeWin");
	for (var i = 0; i < wins.length; i++) {
		wins[i].addEventListener("click", function(e) {
			closeWin(this);
		})
	}
})


function showWaring(str) {// 显示提示框
	$("#warning-text").html(str);
	$("#warning").slideDown(500);
	window.setTimeout(function() {
		$("#warning").slideUp(500);
	}, 5000)
}
function getElement(str) {
	if (str.charAt(0) == ".")
		return document.getElementsByClassName(str.substr(1));
	else if (str.charAt(0) == "#")
		return document.getElementById(str.substr(1));
}
var isExsit;// 保存验证错误的字段
function updateUserData(el) {
	isExsit = new Map();
	var id = el.parentNode.getAttribute("data-id");
	var data = "id=" + id;
	$.post({
		url : "json/getMoreData_user",
		data : data,
		success : function(data) {
			if (data != null) {
				data = eval("(" + data + ")");
				getElement("#update.username").value = data.username;
				getElement("#update.username").setAttribute("source-data",
						data.username == null ? "" : data.username);
				getElement("#update.email").value = data.email;
				getElement("#update.email").setAttribute("source-data",
						data.email == null ? "" : data.email);
				getElement("#update.phone").value = data.phone;
				getElement("#update.phone").setAttribute("source-data",
						data.phone == null ? "" : data.phone);
				getElement("#update.nickname").value = data.nickname;
				getElement("#update.nickname").setAttribute("source-data",
						data.nickname == null ? "" : data.nickname);
				getElement("#update.id").value = data.id;
				var stateId = data.state == 'normal' ? 1 : data.state == 'inactive' ? 2
						: 3;
				$("#update-state").attr("source-data", stateId);
				$("#update-state input[data-id='" + stateId + "']").attr(
						"checked", "checked");
			}
		}
	})
}
function deleteUserData(el) {
	$("#sureDelete").unbind("click");
	$("#deleteWarning").slideDown(500);
	var id = el.parentNode.getAttribute("data-id");
	var tds = $(".userList[data-id='" + id + "'] td");
	$("#deleteWarning .deleteWarning-text").html(
			tds[1].innerHTML != '-' ? i18n.get("username")+i18n.get("_for")+"[" + tds[1].innerHTML
					: tds[2].innerHTML != "-" ? i18n.get("nickname")+i18n.get("_for")+"[" + tds[2].innerHTML
							: tds[3].innerHTML != '-' ? i18n.get("phone")+i18n.get("_for")+"["
									+ tds[3].innerHTML : i18n.get("email")+i18n.get("_for")+"["
									+ tds[4].innerHTML);
	 删除按钮事件 
	if (id == null) {
		return;
	}
	$("#sureDelete").click(function() {
		$.post({
			url : "json/delete_user",
			data : "id=" + id,
			success : function(data) {
				if (data != null) {
					data = eval("(" + data + ")");
					$("#deleteWarning").slideUp(500);
					if (data.message) {
						showWaring(i18n.get("_delete")+i18n.get("success")+"！"+i18n.get("requestData")+"...");
						$(".userList[data-id=" + id + "]").get(0).remove();
						window.setTimeout(function() {
							window.location.reload();
						}, 2000)
						return;
					} else {
						showWaring(i18n.get("_delete")+i18n.get("failure")+"！"+i18n.get("pleaseTryAgainLater")+"...");
						return;
					}
				}
			}
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
// 验证
function verify(str, ele) {
	var value = ele.value;
	if (str == 'username') {
		if (value != '' && !/^[a-zA-Z]+[0-9a-zA-Z]{4,20}$/.test(value)) {
			ele.setAttribute("data-content", i18n.get("username")+i18n.get("formatError"));
			$(ele).popover('show');
			ele.style.borderColor = "#f00";
			isExsit.put(str, null);
		} else {
			isExsit.remove(str);
			cancelPropover(ele);
			checkIsExist("username", ele);
		}
	}
	if (str == 'email') {
		if (value != ''
				&& !/^[0-9a-zA-Z]+@[0-9a-zA-Z]+[.][0-9a-zA-Z]+$/.test(value)) {
			ele.setAttribute("data-content", i18n.get("email")+i18n.get("formatError"));
			$(ele).popover('show');
			ele.style.borderColor = "#f00";
			isExsit.put(str, null);
		} else {
			isExsit.remove(str);
			cancelPropover(ele);
			checkIsExist("email", ele);
		}
	}
	if (str == 'phone') {
		if (value != '' && !/^[1][3-8][0-9]{9}$/.test(value)) {
			ele.setAttribute("data-content", i18n.get("phone")+i18n.get("formatError"));
			$(ele).popover('show');
			ele.style.borderColor = "#f00";
			isExsit.put(str, null);
		} else {
			isExsit.remove(str);
			cancelPropover(ele);
			checkIsExist("phone", ele);
		}
	}
	if (str == 'nickname') {
		if (value != '' && value.trim() == '') {
			ele.setAttribute("data-content", i18n.get("nickname")+i18n.get("formatError"));
			$(ele).popover('show');
			ele.style.borderColor = "#f00";
			isExsit.put(str, null);
		} else {
			isExsit.remove(str);
			cancelPropover(ele);
			checkIsExist("nickname", ele);
		}
	}
}
function cancelPropover(ele) {
	$(ele).popover('destroy');
	ele.style.borderColor = "#ccc";
}
 ajax校验唯一 
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
 更新user 
function updateUser() {
	var username = getElement("#update.username");
	var email = getElement("#update.email");
	var phone = getElement("#update.phone");
	var nickname = getElement("#update.nickname");
	var state = $("#update-state input:checked");
	if (username.value == '' && email.value == '' && phone.value == ''
			|| state.length < 1) {
		$(getElement("#update.submit")).popover('show');
		return;
	}
	if (username.value == username.getAttribute("source-data")
			&& email.value == email.getAttribute("source-data")
			&& phone.value == phone.getAttribute("source-data")
			&& nickname.value == nickname.getAttribute("source-data")
			&& state[0].value == $("#update-state").attr("source-data")) {
		$(getElement("#updateModal")).modal("hide");
		showWaring(i18n.get("notModify"));
		return;
	}
	if (isExsit.size() > 0) {
		$(getElement("#update.submit")).popover('show');
		return;
	} else {
		$(getElement("#update.submit")).popover('destroy');
	}
	var id = getElement("#update.id").value;
	if (id == null || id == '')
		return;
	var data = "id=" + id;
	username.value != username.getAttribute("source-data") ? data += "&username="
			+ username.value
			: '';
	email.value != email.getAttribute("source-data") ? data += "&email="
			+ email.value : '';
	phone.value != phone.getAttribute("source-data") ? data += "&phone="
			+ phone.value : '';
	nickname.value != nickname.getAttribute("source-data") ? data += "&nickname="
			+ nickname.value
			: '';
	state[0].value != $("#update-state").attr("source-data") ? data += "&state.id="
			+ state[0].value
			: '';
	$.post({
		url : "json/update_user",
		data : data,
		success : function(data) {
			if (data != null) {
				$(getElement("#updateModal")).modal("hide");
				var data = eval("(" + data + ")");
				if (data.message) {
					var tds = $(".userList[data-id='" + id + "'] td");
					tds[1].innerHTML = username.value == null ? '-'
							: username.value;
					tds[2].innerHTML = nickname.value == null ? '-'
							: nickname.value;
					tds[3].innerHTML = phone.value == null ? '-' : phone.value;
					tds[4].innerHTML = email.value == null ? '-' : email.value;
					tds[5].innerHTML = state[0].value == '1' ? i18n.get("normal")
							: state[0].value == '2' ? i18n.get("inactive") : i18n.get("locked");
					showWaring(i18n.get("modifySuccess")+"...");
				} else {
					showWaring(i18n.get("modifyUserFailed")+"！"+i18n.get("pleaseTryAgainLater")+"...");
				}
			}
		}
	});
}

*/