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
	$("#update_submit").bind("click", function() {
		updateUser();
	})
	/*
	 * 高级选项点击事件绑定
	 */
	$("#updateModal").on("show.bs.modal", function() {
		if (permissions.indexOf("GiveJurisdiction" && "CancelJurisdiction") == -1) {
			return false;
		}
	})
	$("#myModal").on("show.bs.modal", function() {
		if (permissions.indexOf("SelectUser") == -1) {
			return false;
		}
	})
	//用户维护高级选项事件绑定
	var advanced = $(".advanced");
	for(var i=0;i<advanced.length;i++){
		$(advanced[i]).children("li:first").click(function(e) {
			if (permissions.indexOf("GiveJurisdiction" && "CancelJurisdiction") == -1) {
				showWarning(false,i18n.get('insufficientPermissions')+"，"+i18n.get('canNot')+i18n.get('updateUser')+"...");
				return;
			} else
				updateUserData(this);
		})
		$(advanced[i]).children("li:eq(1)").click(function(e) {
			if (permissions.indexOf("CancelJurisdiction") == -1) {
				showWarning(false,i18n.get('insufficientPermissions')+"，"+i18n.get('canNot')+i18n.get('kickOut')+i18n.get('manage')+"...");
				return;
			} else
				deleteUserPermission(this);
		})
		$(advanced[i]).children("li:last").click(function(e) {
			if (permissions.indexOf("SelectUser") == -1) {
				showWarning(false,i18n.get('insufficientPermissions')+"，"+i18n.get('canNot')+i18n.get('selectMoreInformation')+"...");
				return;
			} else
				getUserMoreData(this);
		})
	}
	//角色维护高级选项事件绑定
	var advancedRole = $(".advancedRole");
	for(var i=0;i<advancedRole.length;i++){
		$(advancedRole[i]).children("li:first").click(function(e) {
			if (permissions.indexOf("UpdateRole") == -1) {
				showWarning(false,i18n.get('insufficientPermissions')+"，"+i18n.get('canNot')+i18n.get('updateRole')+"...");
				return;
			}else{
				getRoleMoreData(this);
			}
				//updateUserData(this);
		})
		$(advancedRole[i]).children("li:last").click(function(e) {
			if (permissions.indexOf("DeleteRole") == -1) {
				showWarning(false,i18n.get('insufficientPermissions')+"，"+i18n.get('canNot')+i18n.get('deleteRole')+"...");
				return;
			} else
				deleteRole(this);
		})
	}
	/*
	 * 更新字段验证
	 */
	$("#update.username").bind("change", function(e) {
		verify("username", this);
	})
	$("#update.email").bind("change", function(e) {
		verify("email", this);
	})
	$("#update.phone").bind("change", function(e) {
		verify("phone", this);
	})
	$("#update.nickname").bind("change", function(e) {
		verify("nickname", this);
	})
	/*
	 * 修改规范打开与关闭
	 */
	$(".changeNormButton").bind("click", function(e) {
		var changeNoorm = this.parentNode.parentNode.parentNode.getElementsByClassName("changeNorm")[0];
		if (changeNoorm.style.display == 'none') {
			$("#update_submit").popover("destroy")
			$("#suerUpdateRole").popover("destroy");
			changeNoorm.style.display = "block";
			this.innerHTML = i18n.get('hideChangeNorm');
		} else {
			$("#update_submit").popover("destroy")
			$("#suerUpdateRole").popover("destroy");
			changeNoorm.style.display = "none";
			this.innerHTML = i18n.get('readChangeNorm');
		}
	})
	$(".changeNorm").css("display", "none");//[0].style.display = "none";

	/*
	 * 修改模态框隐藏时取消所有提示框
	 */
	$("#updateModal").on("hide.bs.modal", function() {
		cancelPropover(getElement("#update.username"));
		cancelPropover(getElement("#update.email"));
		cancelPropover(getElement("#update.phone"));
		cancelPropover(getElement("#update.nickname"));
		cancelPropover(getElement("#update_submit"));
	})

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
			
	$("#addManager").on("hide.bs.modal", function() {
		if ($(".modal-backdrop").get(1) != null) {
			$(".modal-backdrop").get(1).remove();
		}
	})
	$("#addManager").on("shown.bs.modal", function() {
		$("#add_username_input").focus();
	})
	$("#updateRole").on("show.bs.modal", function() {
		if (permissions.indexOf("UpdateRole") == -1) {
			showWarning(false, "您没有权限变更的权限！！")
			return false;
		}
		$("#updateRole_input").val("");
		$("#suerUpdateRole").removeAttr("data-id");
		var permissionInput = $("#update_permission input");
		for(var i=0;i<permissionInput.length;i++){
			$(permissionInput[i]).removeAttr("checked");
		}
	})
	$("#addManager").on("hidden.bs.modal", function() {
		$("#add-user-linkman").unbind();
		$("#sureAddManager").unbind();
	})
	$("#addLinkMan").on("show.bs.modal",function() {
						getElement("#addLinkMan").style.top = (getElement("#addManagerArea").offsetTop + 150)
								+ "px";
						$(".addLinManClose").click(function() {
							$("#addLinkMan").modal("hide");
						})
						if($("#selectUserListBox").html()==''){
							showSelectUserRow=0;
							getNoRoleUser();
						}

					})
	$("#addLinkMan").on("hidden.bs.modal", function() {
		$(".addLinManClose").unbind();
	})
	$("#suerAddManager").click(function(){
			addManagerSure();
		})
	/* 实现延迟加载数据 */
	var mousewheel = document.all ? "mousewheel" : "DOMMouseScroll";
	$("#selectUserTable").bind("mousewheel", function(event, delta) {
		var table = $(this);
		if (delta < 0) {
			console.log($(this).scrollTop() + "=" + (this.scrollHeight - 300))
			if ($(this).scrollTop() >= this.scrollHeight - 300) { // 此除去除滚动条本身高度200,另100是预加载
				if (sysnchronized)
					return;
				sysnchronized = true;//同步
				var currentPage = $("#selectUserListBox").attr("data-page");
				var totalPage = $("#selectUserListBox").attr("total-page");
				if (currentPage < totalPage) {	//当前页少于总页时请求数据
					$("#selectUserListBox").attr("data-page", ++currentPage);
					getNoRoleUser();
				} else
					sysnchronized = false;
			}
		}
	});
	 $("#selectUserTable").scroll(function(event){
		 console.log($(this).scrollTop() + "=" + (this.scrollHeight - 200))
		 if ($(this).scrollTop() >= this.scrollHeight - 200) { // 此除去除滚动条本身高度200,另100是预加载
				if (sysnchronized)
					return;
				sysnchronized = true;//同步
				var currentPage = $("#selectUserListBox").attr("data-page");
				var totalPage = $("#selectUserListBox").attr("total-page");
				if (currentPage < totalPage) {	//当前页少于总页时请求数据
					$("#selectUserListBox").attr("data-page", ++currentPage);
					getNoRoleUser();
				} else
					sysnchronized = false;
			}
	 });
	/*removeSection = function(e) {
		$(e).parents(".section").remove();
		$('[data-spy="scroll"]').each(function () {
			var $spy = $(this).scrollspy('refresh')
			});
	}
    $("#myScrollspy").scrollspy();*/
	/*$('[data-spy="scroll"]').each(function () {
		  var $spy = $(this).scrollspy('refresh')
		})*/
	//选择用户搜索
	$("#selectUserSearchContext").keydown(function(event){
		if(event.which==13){
			selectUserListSearch();
		}
	})
	$("#selectUserListSearch").click(function(){
		selectUserListSearch();
	})
	
	//当输入框失去焦点时隐藏自动提示框
	$("#add_username_input").blur(function(){
		$("#autoComplateContext").hide();
	})
	//添加管理员用户搜索
	$("#add_username_input").keyup(function(event){
		if(event.which==40){
			var aTags = $("#autoComplateContext a");
			$("#autoComplateContext a").removeClass();
			$("#autoComplateContext a").addClass("list-group-item");
			var aLength = $("#autoComplateContext a").length;
			if(aLength<6&&currentCursorRow==aLength-1||currentCursorRow==5){
				currentCursorRow=-1;
			}
			aTags[++currentCursorRow].setAttribute("class", "list-group-item active")
		}else if(event.which==38){
			var aTags = $("#autoComplateContext a");
			$("#autoComplateContext a").removeClass();
			$("#autoComplateContext a").addClass("list-group-item");
			var aLength = $("#autoComplateContext a").length;
			if(currentCursorRow<=0){
				if(aLength<6)currentCursorRow=aLength;
				else currentCursorRow=6;
			}
			aTags[--currentCursorRow].setAttribute("class", "list-group-item active")
		}else if(event.which==13&&$("#autoComplateContext a").length>0){
			var currentA = $("#autoComplateContext a[class='list-group-item active']");
			if(currentA.length<1){	//如果此时没有选中项则默认选则第一项
				currentA=$("#autoComplateContext a:first");
			}
			var value = currentA[0].innerHTML;
			value = value.substr(value.indexOf("：")+1);
			this.value="";	//清空输入值
			addMember(currentA.attr("data-text"),value);	//添加成员
			$("#autoComplateContext").hide();	//隐藏自动提示
			$(this).attr("source-data","");
		}else{
			if(this.value.trim()==''){
				$("#autoComplateContext a").remove();
				$("#autoComplateContext").hide();
			}else if(this.value.trim()!=$(this).attr("source-data")){
				currentCursorRow=-1
				autoComplate(this)
			}
			$(this).attr("source-data",this.value.trim());
		}
	})
	//添加角色
	$("#addRole_input").bind("change",function(){
		addRoleInputVerify(this);
	})
	//确认添加角色
	$("#suerAddRole").bind("click", function(){
		suerAddRole();
	})
	//UpdateRole事件绑定
	$("#suerUpdateRole").bind("click",function(){
		updateRoleSure(this);
	})
})
//确认UpdateRole
function updateRoleSure(el){
	var data = "roleId="+$(el).attr("data-id")+"&level="+$("#update_level_control").attr("data-original-title");
	var permissionInput = $("#update_permission input:checked");
	if(permissionInput.length<1){
		$("#update_permission").popover("show");
		return;
	}else{
		$("#update_permission").popover("destroy");
	}
	var text="";
	for(var i=0;i<permissionInput.length;i++){
		data += "&permissions="+permissionInput[i].value;
		if(i==permissionInput.length-1){
			text += $(permissionInput[i]).siblings("span").html()
		}else
		text += $(permissionInput[i]).siblings("span").html()+" <strong>|</strong> ";
	}
	$.post({
		url:"json/ajaxData_updateRole",
		data:data,
		success:function(data){
		if(data!=null){
			data = eval("("+data+")");
			if(data.message){
				$("#updateRole").modal("hide");
				showWarning(true,i18n.get('update')+i18n.get('success')+"...");
				$(".roleList[data-id="+$(el).attr("data-id")+"] td:eq(2)").html(text);//设置更新后的值
			}else{
				$("#suerUpdateRole").attr("data-content", i18n.get('update')+i18n.get('failure')+"："+data.cause)
				$("#suerUpdateRole").popover("show");
			}
		}
	}})
}
//确认添加角色
function suerAddRole(){
	var el = $("#addRole_input").get(0);
	var value = el.value;
	if(value==''){
		$("#add_role").addClass("has-error");
		$("#add_role_icon").addClass("glyphicon glyphicon-remove");
		el.setAttribute("data-content", i18n.get('formatError')+":"+i18n.get('canNotNull')+"！");
		$(el).popover('show');
		el.focus();
		return false;
	}
	if(/[`~!@#$%^&&*()_|=+-<>?:“：｜｛｝《》？。，、＇＼［］）×（＊＆＾％＄#＠！￣｀"{},.\/;'[\]]+/.test(value)){
			if(!/[0-9]+/.test(value)){
			$("#add_role").addClass("has-error");
			$("#add_role_icon").addClass("glyphicon glyphicon-remove");
			el.setAttribute("data-content", i18n.get('formatError')+":"+i18n.get('canNotContainSpecialCharacter'));
			$(el).popover('show');
			return false;
		}
	}
	if(!/^(.){2,10}$/.test(value)){
		$("#add_role").addClass("has-error");
		$("#add_role_icon").addClass("glyphicon glyphicon-remove");
		el.setAttribute("data-content", i18n.get('formatError')+":"+i18n.get('lengthIn2-10'));
		$(el).popover('show');
		return false;
	}
	if($("#add_permission input:checked").length<1){
		$("#add_permission").popover("show");
		return;
	}else
	$("#add_permission").popover("destroy");
	addRole(value,el);
}
function addRole(value,el){
	var data = "roleName="+value+"&level="+$("#level-control").attr("data-original-title");
	var permissionInput = $("#add_permission input:checked");
	for(var i=0;i<permissionInput.length;i++){
		data += "&permissions="+permissionInput[i].value;
	}
	$.post({
		url:"json/ajaxData_addRole",
		data:data,
		success:function(data){
		if(data!=null){
			data = eval("("+data+")");
			if(data.message){
				$("#addRole").modal("hide");
				showWarning(true,i18n.get('addRole')+i18n.get('success')+","+i18n.get('requestData')+"...");
				window.setTimeout(function() {
					window.location.reload();
				}, 3000)
				return;
			}else{
				$("#suerAddRole").attr("data-content", i18n.get('update')+i18n.get('failure')+"："+data.cause);
				$("#suerAddRole").popover("show");
				return;
			}
		}
		$("#suerAddRole").attr("data-content", i18n.get('update')+i18n.get('failure')+"："+i18n.get('insufficientPermissions'));
		$("#suerAddRole").popover("show");
		return;
	}})
}
//角色名验证
function addRoleInputVerify(el){
	var value = el.value;
	if(value==''){
		$("#add_role").addClass("has-error");
		$("#add_role_icon").addClass("glyphicon glyphicon-remove");
		el.setAttribute("data-content", i18n.get('formatError')+":"+i18n.get('canNotNull')+"！");
		$(el).popover('show');
		el.focus();
		return false;
	}
	if(/[`~!@#$%^&&*()_|=+-<>?:“：｜｛｝《》？。，、＇＼［］）×（＊＆＾％＄#＠！￣｀"{},.\/;'[\]]+/.test(value)){
			if(!/[0-9]+/.test(value)){
			$("#add_role").addClass("has-error");
			$("#add_role_icon").addClass("glyphicon glyphicon-remove");
			el.setAttribute("data-content", i18n.get('formatError')+":"+i18n.get('canNotContainSpecialCharacter'));
			el.focus();
			$(el).popover('show');
			return false;
		}
	}
	if(!/^(.){2,10}$/.test(value)){
		$("#add_role").addClass("has-error");
		$("#add_role_icon").addClass("glyphicon glyphicon-remove");
		el.setAttribute("data-content", i18n.get('formatError')+":"+i18n.get('lengthIn2-10'));
		$(el).popover('show');
		el.focus();
		return false;
	}
	verifyRoleName(value,el);
}
function verifyRoleName(name,el){
	$.post({
		url : "json/ajaxData_verifyRoleName",
		data : "roleName=" + name,
		success : function(data) {
			if (data != null) {
			data = eval("(" + data + ")");
			if(!data.message){
				$("#add_role").addClass("has-error");
				$("#add_role_icon").addClass("glyphicon glyphicon-remove");
				el.setAttribute("data-content", i18n.get('roleNameUsed')+"！！");
				$(el).popover('show');
				el.focus();
				return false;
			}else{
				$("#add_role").removeClass("has-error");
				$("#add_role").addClass("has-success");
				$("#add_role_icon").removeClass("glyphicon glyphicon-remove");
				$("#add_role_icon").addClass("glyphicon glyphicon-ok");
				$(el).popover('destroy');
				return true;
			}
		}
	}
	})
}
//自动完成
var currentCursorRow=-1;
function autoComplate(el){
	$.post({
				url : "json/ajaxData_getNoRoleUsers",
				data : "currentPage=" + 1 +"&likeStr="+el.value.trim(),
				success : function(data) {
					if (data == null) {
						alert(i18n.get('notGetAnyUser'));
						return;
					}
					data = eval("(" + data + ")");
					//$(".showTotalNum").html(data[0].totalNum);	//设置显示的总条数
					$("#autoComplateContext a").remove();
					$("#autoComplateContext").show();
					$("#searcRresult").html(data[0].totalNum);
					for (var i = 1; i < data.length&&i<7; i++) {
						fillAutoComplateData(data[i],el.value.trim());
					}
					$("#autoComplateContext a").unbind();
					$("#autoComplateContext a").mouseover(function(){
						$("#autoComplateContext a").removeClass();
						$("#autoComplateContext a").addClass("list-group-item");
						this.setAttribute("class","list-group-item active");
						currentCursorRow = $("#autoComplateContext a").index(this);//获取当前下标
					})
					$("#autoComplateContext a").mousedown(function(){
						var value = this.innerHTML;
						value = value.substr(value.indexOf("：")+1);
						el.value="";
						$("#autoComplateContext").hide();
						addMember($(this).attr("data-text"),value);
					})
					//sysnchronized = false;
					
				}
			})
}
function fillAutoComplateData(data,value){
	var text = data.username!=null&&data.username.indexOf(value)!=-1?"用户名："
			+data.username:data.email!=null&&data.email.indexOf(value)!=-1?"邮箱："+data.email:"手机号："+data.phone;
	var aTag = $("<a class='list-group-item' data-text="+data.id+">"+text+"</a>");
	$("#autoComplateContext p").before(aTag);
}
//添加用户确认按钮事件
function addManagerSure(){
	var members = $(".member");
	if(members.length<1){
		$("#add-user").popover("show")
		return;
	}
	$("#add-user").popover("destroy")
	var selectRole = $("#add-role input:radio:checked").val();
	if(selectRole==null){
		$("#add-role").popover("show");
		return;
	}
	$("#add-role").popover("destroy");
	if(selectRole<myRole){
		alert(i18n.get('changeJurisdictionCannothighself')+"！！");
		return;
	}
	var data="";
	for(var i=0;i<members.length;i++){
		data += "member="+members[i].getAttribute("data-text")+"&";
	}
	data += "roleId="+selectRole;
	$.post({
		url:"json/ajaxData_updateUserRole",
		data:data,
		success:function(data){
			if(data==null){
				$("#suerAddManager").popover("show")
				return;
			}
			$("#suerAddManager").popover("destroy")
			if(data!=''){
				data = eval("("+data+")");
				$("#addManager").modal("hide");
				if(data.message){
					showWarning(true,i18n.get('addManager')+":"+data.successNum+i18n.get('success')+","+data.loseNum+i18n.get('failure')+","+i18n.get('requestData')+"...");
					window.setTimeout(function() {
						window.location.reload();
					}, 3000)
					return;
				}
			}
			$("#suerAddManager").popover("show")
			return;
		}
	})
	
}
//选择用户搜索方法中转
function selectUserListSearch(){
	showSelectUserRow=0;
	$("#selectUserListBox").html("");
	var page = $("#selectUserListBox").attr("data-page","1");
	var search = $("#selectUserSearchContext").val();
	getNoRoleUser(search);
}
var sysnchronized = false;	//用作同步
function getNoRoleUser(search,page) {
	var page = $("#selectUserListBox").attr("data-page");
	$.post({
				url : "json/ajaxData_getNoRoleUsers",
				data : "currentPage=" + page +"&likeStr="+(search!=null?search:""),
				success : function(data) {
					if (data == null) {
						alert(i18n.get('notGetAnyUser'));
						return;
					}
					data = eval("(" + data + ")");
					$("#selectUserListBox").attr("total-page",	//设置总页属性
							data[0].totalPage);
					$(".showTotalNum").html(data[0].totalNum);	//设置显示的总条数
					for (var i = 1; i < data.length; i++) {
						fillData(data[i]);
					}
					sysnchronized = false;
					$(".selectUserList").unbind("click");
					$(".selectUserList").click(function(){
						selectUserListClick(this);
					});
				}
			})
}
function selectUserListClick(el){
		if($(".member").length>=3){
			alert(i18n.get('onceChoose3'));
			return;
		}
		el.setAttribute("class","selectUserListChecked");
	
			var tds = el
					.getElementsByTagName("td");
			var text = (tds[1].innerHTML == '-' ? tds[2].innerHTML == '-' ? tds[3].innerHTML
					: tds[2].innerHTML
					: tds[1].innerHTML);
			
			addMember($(el).attr("data-text"),text);
			$(el).unbind("click");
			$(el).click(function(){
				this.setAttribute("class","selectUserList");
				$(".member[data-text='"+$(el).attr("data-text")+"']").remove();
				$(this).click(function(){
					selectUserListClick(this);
				})
			});
}
function addMember(id,text){
	if($(".member[data-text='"+id+"']").length>0)return;
	if($(".member").length>=3){
		alert(i18n.get('onceChoose3'));
		return;
	}
	var li = $("<li class='member' data-text='"+id+"'><span>"
			+ text
			+ "</span><button type='button' class='close' onclick='removeWin(this)' aria-label='Close'><span>&times;</span></li>");
	$("#add_username_input_li").before(li);
	var selectUserList = $(".selectUserList[data-text='"+id+"'");
	if(selectUserList.length>0){	//添加成员时判断是否有没被选中的，有则选中
		selectUserList[0].setAttribute("class", "selectUserListChecked")
	}
}
var showSelectUserRow=0;//显示行数
function fillData(data) {
	var boolContain=false;//用于记录当前数据是否已被选中
	//获取第一个不为空的值
	//var text = data.username!=null?data.username:data.email!=null?data.email:data.phone;
	//var boolText = data.username+data.email+data.phone;	//用于判断已选择成员是否包含其内
	var classText = "selectUserList";
	var member = $(".member>span");
	//判断获取的数据是否有已选中的
	for(var i=0;i<member.length;i++){
		if($(".member[data-text='"+data.id+"']").attr("data-text")==data.id){
			boolContain = true;
			classText = "selectUserListChecked";
		}
	}
	var tr = $("<tr class='"+classText+"' data-text='"+data.id+"'><td>"+(++showSelectUserRow)+"</td><td>"
			+ (data.username == null ? '-' : data.username) + "</td><td>"
			+ (data.email == null ? '-' : data.email) + "</td><td>"
			+ (data.phone == null ? '-' : data.phone) + "</td></tr>")
	$("#selectUserListBox").append(tr);
	if(boolContain){
		$(".selectUserListChecked[data-text='"+data.id+"'").unbind("click");
		$(".selectUserListChecked[data-text='"+data.id+"'").click(function(){
			this.setAttribute("class","selectUserList");
			$(".member[data-text='"+data.id+"']").remove();
			$(this).click(function(){
				selectUserListClick(this);
			})
		});
	}
}
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
				var roleId = data.roleId;
				$("#update-role").attr("source-data", roleId);
				$("#update-role input").removeAttr("checked");
				$("#update-role input[data-id='" + roleId + "']").prop("checked", true);
			}
		}
	})
}
//DeleteRole
function deleteRole(el){
	$("#sureDelete").unbind("click");
	var id = el.parentNode.getAttribute("data-id");
	if (id == null) {
		return;
	}
	if(id<=myRole){
		showWarning(true,i18n.get('delete')+i18n.get('failure')+"！"+i18n.get('cause')+"："+i18n.get('insufficientPermissions')+"...");
		return;
	}
	$("#deleteRoleWarning").slideDown(500);
	var tds = $(".roleList[data-id='" + id + "'] td:eq(1)");
	$("#deleteRoleWarning .deleteWarning-text").html(tds[0].innerHTML);
	/* 删除按钮事件 */
	$("#sureDeleteRole").click(function() {
		$.post({
			url : "json/ajaxData_deleteRole",
			data : "roleId=" + id,
			success : function(data) {
				if (data != null) {
					data = eval("(" + data + ")");
					$("#deleteRoleWarning").slideUp(500);
					if (data.message) {
						showWarning(true,i18n.get('delete')+i18n.get('success')+"...");
						$(".roleList[data-id=" + id + "]").get(0).remove();
						return;
					} else {
						showWarning(false,i18n.get('delete')+i18n.get('failure')+"！"+i18n.get('cause')+"："+data.cause);
						return;
					}
				}
				showWarning(false,i18n.get('delete')+i18n.get('failure')+"！"+i18n.get('pleaseTryAgainLater')+"...");
				return;
			}
		})
	})
}
//删除用户权限
function deleteUserPermission(el) {
	$("#sureDelete").unbind("click");
	$("#deleteWarning").slideDown(500);
	var id = el.parentNode.getAttribute("data-id");
	var tds = $(".userList[data-id='" + id + "'] td");
	$("#deleteWarning .deleteWarning-text").html(
			(tds[1].innerHTML != '-' ? i18n.get('username')+i18n.get('_for')+"[" + tds[1].innerHTML
					: tds[2].innerHTML != "-" ? i18n.get('nickname')+i18n.get('_for')+"[" + tds[2].innerHTML
							: tds[3].innerHTML != '-' ? i18n.get('phone')+i18n.get('_for')+"["
									+ tds[3].innerHTML : i18n.get('email')+i18n.get('_for')+"["
									+ tds[4].innerHTML)
					+ "]"+i18n.get('of') + tds[5].innerHTML);
	/* 删除按钮事件 */
	if (id == null) {
		return;
	}
	$("#sureDelete").click(function() {
		$.post({
			url : "json/ajaxData_deleteUserRole",
			data : "id=" + id,
			success : function(data) {
				if (data != null) {
					data = eval("(" + data + ")");
					$("#deleteWarning").slideUp(500);
					if (data.message) {
						$(".userList[data-id=" + id + "]").remove();
						showWarning(true,i18n.get('kickOut')+i18n.get('success')+"...");
						return;
					} else {
						showWarning(false,i18n.get('kickOut')+i18n.get('failure')+"！"+i18n.get('cause')+":"+data.cause);
						return;
					}
				}
				showWarning(false,i18n.get('kickOut')+i18n.get('failure')+"！"+i18n.get('pleaseTryAgainLater')+"...");
				return;
			}
		})
	})
}
//获取角色更多信息
function getRoleMoreData(el) {
	var id = el.parentNode.getAttribute("data-id");
	var data = "id=" + id;
	$.post({
		url : "json/getMoreData_role",
		data : data,
		success : function(data) {
			
			if (data != null) {
				data = eval("(" + data + ")");
				setUpdateRoleData(data);
			}
			return;
		}
	})
}
//设置UpdateRole数据
function setUpdateRoleData(data){
	$("#updateRole_input").val(data.name);
	$("#suerUpdateRole").attr("data-id", data.id);
	var permissionInput = $("#update_permission input");
	for(var i=0;i<permissionInput.length;i++){
		if(data.permissions.indexOf(permissionInput[i].value+",")!=-1){
			$(permissionInput[i]).prop("checked", true);
		}
	}
	var level = (data.level-data.parentLevel)/10;	//获取级别
	$("#update_level_control").attr("title",level).attr("data-original-title",level).css({'left':level});
}
//获取用户更多信息
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
		if (data[val] != null) {
			if(val=='roleId')continue;
			if(val=='roleName'||val=='state')data[val]=i18n.get(data[val]);
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
			ele.setAttribute("data-content", i18n.get('username')+i18n.get('formatError'));
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
			ele.setAttribute("data-content", i18n.get('email')+i18n.get('formatError'));
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
			ele.setAttribute("data-content", i18n.get('phone')+i18n.get('formatError'));
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
			ele.setAttribute("data-content", i18n.get('nickname')+i18n.get('formatError'));
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
/* 更新user */
function updateUser() {
	var username = getElement("#update.username");
	var email = getElement("#update.email");
	var phone = getElement("#update.phone");
	var nickname = getElement("#update.nickname");
	var role = $("#update-role input:checked");
	if (username.value == '' && email.value == '' && phone.value == ''
			|| role.length < 1) {
		$(getElement("#update_submit")).popover('show');
		return;
	}
	if (username.value == username.getAttribute("source-data")
			&& email.value == email.getAttribute("source-data")
			&& phone.value == phone.getAttribute("source-data")
			&& nickname.value == nickname.getAttribute("source-data")
			&& role[0].value == $("#update-role").attr("source-data")) {
		$("#updateModal").modal("hide");
		showWarning(false,i18n.get('noAnyChange'));
		return;
	}
	if (isExsit.size() > 0) {
		$(getElement("#update_submit")).popover('show');
		return;
	} else {
		$(getElement("#update_submit")).popover('destroy');
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
	role[0].value != $("#update-role").attr("source-data") ? data += "&roleId="
			+ role[0].value
			: '';
	var roleName = $(role).siblings("span").html();
	$.post({
		url : "json/ajaxData_updateUser",
		data : data,
		success : function(data) {
			if (data != null) {
				$(getElement("#updateModal")).modal("hide");
				var data = eval("(" + data + ")");
				if (data.message) {
					if (role[0].value == 0) {	//更改为普通用户
						showWarning(true,i18n.get('successChangeJurisdiction')+"...");
						$(".userList[data-id=" + id + "]").get(0).remove();
						return;
					}
					var tds = $(".userList[data-id='" + id + "'] td");
					tds[1].innerHTML = username.value == '' ? '-'
							: username.value;
					tds[2].innerHTML = nickname.value == '' ? '-'
							: nickname.value;
					tds[3].innerHTML = phone.value == '' ? '-' : phone.value;
					tds[4].innerHTML = email.value == '' ? '-' : email.value;
					tds[5].innerHTML = roleName;
					//showWarning(true,i18n.get('modifySuccess')+"...");
					showWarning(true,"已成功修改管理员身份为["+roleName+"]");
				} else {
					showWarning(false,i18n.get('modifyUserFailed')+"！"+i18n.get('cause')+"："+data.cause);
				}
			}
		}
	});
}
function closeWin(el) {
	$(el.parentNode).hide(500);
}
//移除selectUserListChecked
function removeWin(el) {
	var text = $(el).parent().attr("data-text");
	$(el.parentNode).remove();
	var selectUserListChecked = $(".selectUserListChecked[data-text='"+text+"']")[0];
	if(selectUserListChecked!=null){
		selectUserListChecked.setAttribute("class","selectUserList");
		selectUserListChecked.click(function(){
			selectUserListClick(this);
		})
	}
}