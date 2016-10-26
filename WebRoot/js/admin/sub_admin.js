function showWarning(isPass,str) {// 显示提示框
	/*if(isPass){
		$("#warning",parent.document).removeClass("alert-warning");
		$("#warning",parent.document).addClass("alert-success");
		$("#warning i",parent.document).removeClass("fa-warning");
		$("#warning i",parent.document).addClass("fa-check");
	}else{
		$("#warning",parent.document).removeClass("alert-success");
		$("#warning",parent.document).addClass("alert-warning");
		$("#warning i",parent.document).removeClass("fa-check");
		$("#warning i",parent.document).addClass("fa-warning");
	}
	$("#warning-text",parent.document).html(str);
	$("#warning",parent.document).slideDown(500);
	window.setTimeout(function() {
		$("#warning",parent.document).slideUp(500);
	}, 3000)*/
	parent.showWarning(isPass, str);
}