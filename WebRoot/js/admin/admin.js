$(function() {
	//退出监听
	$("#logout").click(function() {
		var bool = confirm("确定要退出当前用户吗？");
		if (bool) {
			window.location.href = "adminuserLogout";
			return false;
		} else {
			return false;
		}
	})
	// 设置菜单点击监听
	$(".sidebar-menu li").bind("click", function() {
		headerText($(this).attr("class"))
	})
	// 显示设置--每页显示条数更改监听
	$("#rowNum").bind("change", function() {
		saveSet();
	})
	$(".sidebar-menu .liMenu").bind("click",loaderAnimation);
	//将菜单放入到map，用于菜单搜索
	var menu = new Map();
	var menuSpans = $(".liMenu");
	for(var i=0;i<menuSpans.length;i++){
		menu.put($(menuSpans[i]).find("span").html(), menuSpans[i])
	}
	$("#menuSearch").bind("keyup",function(){
		if(this.value==''){
			$(".search-sidebar-menu").html("");
			$(".sidebar-menu").show();
		}else{
			$(".search-sidebar-menu").html("");
			var likeArray = menu.likeKey(this.value);
			for(var i=0;i<likeArray.length;i++){
				$(".search-sidebar-menu").append("<li style='margin:10px 0;'>"+likeArray[i].innerHTML+"</li>");
			}
			$(".sidebar-menu").hide();
		}
	})
})
var loaderAnimation=function (){
	$(".loaderMenuBox").remove();
	$(".content-wrapper").append($('<div class="loaderMenuBox"><div class="loaderMenu"><div class="loader-inner pacman"><div></div><div></div><div></div><div></div><div></div></div></div></div>'))
}
// 菜单显示文字判断
function headerText(str) {
	if (str.indexOf('homeMenu')!=-1) {
		setHeaderText("统计数据")
	} else if (str.indexOf("userMenu")!=-1) {
		setHeaderText("用户管理")
	} else if (str.indexOf("addProduct")!=-1) {
		setHeaderText("添加商品")
	} else if (str.indexOf("manageProduct")!=-1) {
		setHeaderText("商品管理")
	}else if(str.indexOf("userJurisdiction")!=-1){
		setHeaderText("管理员维护")
	}else if(str.indexOf("roleManage")!=-1){
		setHeaderText("角色维护")
	}else if(str.indexOf("selectJurisdiction")!=-1){
		setHeaderText("查看权限")
	}
}
// 设置开头位信息
function setHeaderText(t1) {
	$(".content-header h1 span").html(t1);
	$(".content-header ol li span").html("首页");
	if (t1 == "统计数据")
		$(".content-header ol .active").hide();
	else
		updateProductText(t1,false);
}
// 保存设置
function saveSet() {
	/* 当与源数据相同时返回 */
	if ($("#rowNum").val() == $("#rowNum").attr("source-data")
			&& $("#personalizeSet .mcControl").val() == $(
					"#personalizeSet .mcControl").attr("source-data")) {
		$("#personalizeSet").modal("hide");
		return;
	}
	/* 当不匹配返回 */
	if (!/^[1-9]{1,1}[0-9]{0,1}$/.test($("#rowNum").val())) {
		$("#rowNum").popover('show');
		return;
	}
	$("#rowNum").popover('destroy');
	var data = "pageRowNum=" + $("#rowNum").val();
	$.post({
		url : "json/saveSet",
		data : data,
		success : function(data) {
			if (data != null) {
				data = eval("(" + data + ")");
				if (data.res) {
					showWarning(true, i18n.get("setSaved") + ","
							+ i18n.get("requestData") + "...")
					$("#rowNum").attr("source-data", $("#rowNum").val());
					window.setTimeout(function() {
						document.getElementById('iframepage').contentWindow.location.reload();
					}, 2000);
					return;
				}
			}
			showWarning(false, i18n.get("canNotSave") + ","
					+ i18n.get("pleaseCheckNetwork") + "！！");
			return;
		}
	})
}

function showWarning(isPass, str) {// 显示提示框
	if (isPass) {
		$("#warning").removeClass("alert-warning");
		$("#warning").addClass("alert-success");
		$("#warning i").removeClass("fa-warning");
		$("#warning i").addClass("fa-check");
	} else {
		$("#warning").removeClass("alert-success");
		$("#warning").addClass("alert-warning");
		$("#warning i").removeClass("fa-check");
		$("#warning i").addClass("fa-warning");
	}
	$("#warning-text").html(str);
	$("#warning").slideDown(500);
	var closeTimer = window.setTimeout(function() {
		$("#warning").slideUp(500);
	}, 5000)
}
function updateProductText(span,bool){
	$(".content-header h1 span").html(span);
	if(bool){
		$(".content-header .breadcrumb li:eq(1)").click(function(){
			window.history.back(-1);
			updateProductText("商品管理",false)
		})
		$(".content-header .breadcrumb li:eq(2)").remove();
		$(".content-header .breadcrumb li:eq(1)").after($('<li><a><i class="fa fa-dashboard"></i> <span>'+span+'</span></a></li>'))
	}else{
		$(".content-header .breadcrumb li:eq(2)").remove();
		$(".content-header .breadcrumb li:eq(1)").remove();
		$(".content-header .breadcrumb li:eq(0)").after($('<li><a><i class="fa fa-dashboard"></i> <span>'+span+'</span></a></li>'))
	}
}