$(function() {
	$("#logout").click(function() {
		var bool = confirm(i18n.get("sureLogoutAndQuitUser") + "？");
		if (bool) {
			window.location.href = "adminuserLogout";
			return false;
		} else {
			return false;
		}
	})
	$("#quit").click(function() {
		var bool = confirm(i18n.get("sureLogoutAndQuitSystem") + "？");
		if (bool) {
			$.post({
				url : "adminuserLogout",
				success : function() {
					window.opener = null;
					window.open('', '_self');
					window.close();
					alert(i18n.get("currentWindowNotSupport") + "！！");
					window.location.reload();
				}
			});
		}
		return false;
	})
	$("#goto").bind(
			"keypress",
			function(e) {
				if (e.keyCode == 13) {
					if (this.value != null && /^[0-9]{1,5}$/.test(this.value)
							&& this.value <= totalPage
							&& this.value != currentPage && this.value > 0) {
						$("#currentPage").val(this.value);
						$("#ScopeSearch").submit();
					} else {
						this.style.border = "1px solid red";
						this.focus();
					}
				}
			})
	$(".saveSet").click(function() {
		saveSet();
	})
	//菜单管理
	$(".nav-sidebar li[data="+classify+"]").addClass("currentChecked");	//当前选项选中
	$(".nav-sidebar li[data="+classify+"]>ul").show();	//当前操作子菜单显示
	if(classify==4){//针对于权限管理默认选中
		$(".permissionLi[data-id="+functionVal+"]").addClass("currentChecked");
	}
	if(classify==2){
		if(putawayGoods==1){
			$(".goodsManageLi:first").addClass("currentChecked");
		}else{
			$(".goodsManageLi:last").addClass("currentChecked");
			$(".goodsKinidUl").show();
			if($("#goodsKind").val()!=0){
				getMoreKind($("#goodsKind").val());
			}
		}
	}
	$(".nav-sidebar li a").click(function(){
		$(this).parent().children("ul").toggle();
		if($(this).parent().children("ul").is(":hidden")){
			$(this).children("span").attr("class","glyphicon glyphicon-chevron-right");
			$(this).parent().removeClass("currentChecked");
		}else{
			$(".nav-sidebar>li a span").attr("class","glyphicon glyphicon-chevron-right");
			$(this).parent().siblings().removeClass("currentChecked");
			$(this).parent().siblings().children("ul").hide();
			$(this).children("span").attr("class","glyphicon glyphicon-chevron-down");
			if($(this).parent().attr("data")!=null){
				$(this).parent().addClass("currentChecked");
				$("#classify").val($(this).parent().attr("data"));
			}
		}
	})
	/*// 初始化子菜单
	shSubMenu();*/
	// 类别更改变更子菜单
	$("#classify").change(function() {
		shSubMenu();
	})
	$("#goodsOperating").change(function(){
		if(this.value==2){
			$(".goodsManageLi").eq(1).show();
		}else{
			$(".goodsManageLi").eq(1).hide();
		}
	})
	$("#goodsKind").change(function(){
		getMoreKind(this.value);
	})
	$(".permissionLi").click(function(){
		$("#function").val($(this).attr("data-id"));
		$("#ScopeSearchCenter").submit();
		/*alert(1);
		return false;*/
	})
	$(".goodsManageLi").click(function(){
		$("#putawayGoods").val($(this).attr("data-index"));
		if($(this).attr("data-index")==1)
		$("#ScopeSearchCenter").submit();
	})
	// 搜索前对字段进行筛选
	$("#ScopeSearchCenter").submit(
			function() {
				var classifyVal=$("#classify").val();
				if (classifyVal==1) {
					$(".goodsManage select").removeAttr("name");
				} else if (classifyVal==2) {
					$(".userManage select").removeAttr("name");
				}else{
					$("ScopeSearch").submit();
				}
			})

})
function getMoreKind(val){
		if(val==0){
			$(".moreKind").hide();
		}else{
			//向服务器请求详细分类
			$.post({
				url : "json/getMoreKind",
				data : "id="+val,
				success : function(data) {
					if (data != null) {
						data = eval("(" + data + ")");
						var moreKind = $("#moreKind");
						$("#moreKind option:gt(0)").remove();
						for(var i=0;i<data.length;i++){
							moreKind.append($("<option value='"+data[i].id+"'>"+data[i].name+"</option>"));
						}
						$(".moreKind").show();
					}
					return;
				}
			})
		}
	}
function getElement(str) {
	if (str.charAt(0) == ".")
		return document.getElementsByClassName(str.substr(1));
	else if (str.charAt(0) == "#")
		return document.getElementById(str.substr(1));
}
// 变更子菜单
/*function shSubMenu() {
	if ($("#classify").val() == 1) {
		$(".permissionLi").hide();
		$(".goodsManageLi").hide();
		for (var i = 0; i < $(".userManageLi").length; i++) {
			getElement(".userManageLi")[i].style.display = "block"
		}
	} else if ($("#classify").val() == 4) {
		$(".userManageLi").hide();
		$(".goodsManageLi").hide();
		for (var i = 0; i < $(".permissionLi").length; i++) {
			getElement(".permissionLi")[i].style.display = "block"
		}
	} else {
		$(".userManageLi").hide();
		$(".permissionLi").hide();
		$(".goodsManageLi:eq(0)").show();
		if($("#goodsOperating").val()==1){
			$(".goodsManageLi:eq(2)").hide();
		}else{
			$(".goodsManageLi:eq(1)").show();
		}
	}
}*/
function saveSet() { // 保存设置
	/* 当与源数据相同时返回 */
	if ($("#rowNum").val() == $("#rowNum").attr("source-data")
			&& $("#personalizeSet .mcControl").val() == $("#personalizeSet .mcControl").attr("source-data")) {
		$("#personalizeSet").modal("hide");
		showWaring("未对设置进行更改 ...");
		return;
	}
	/* 当不匹配返回 */
	if (!/^[1-9]{1,1}[0-9]{0,1}$/.test($("#rowNum").val())) {
		$("#rowNum").popover('show');
		return;
	}
	$("#rowNum").popover('destroy');
	var data = "pageRowNum=" + $("#rowNum").val() + "&showChart="
			+ $("#personalizeSet .mcControl").val();
	$.post({
		url : "json/saveSet",
		data : data,
		success : function(data) {
			if (data != null) {
				$("#personalizeSet").modal("hide")
				data = eval("(" + data + ")");
				if (data.res == 1) {
					showWaring(i18n.get("setSaved")+","+i18n.get("requestData")+"...")
					window.setTimeout(function() {
						window.location.reload();
					}, 2000);
					return;
				}
			}
			$("#warning-text").html(i18n.get("canNotSave")+","+i18n.get("pleaseCheckNetwork")+"！！");
			return;
		}
	})
}

