$(function(){
	getElement("#loginForm").onsubmit = checkInput;
	mypopover("#inputAccount");
	mypopover("#inputPassword");
})
function mypopover(str){
	$(str).blur(function(){
		if(inputAccount.value==''){
			$(str).popover('show');
		}else{
			$(str).popover('destroy')
		}
	})
	$(str).focus(function(){
		$(str).popover('destroy')
	})
}
function checkInput(){
	var inputAccount = getElement("#inputAccount");
	var inputPassword = getElement("#inputPassword");
	if(inputAccount.value==''){
		inputAccount.focus();
		$('#inputAccount').popover('show');
		return false;
	}else{
		$('#inputAccount').popover('destroy');
	}
	if(inputPassword.value==''){
		inputPassword.focus();
		$('#inputPassword').popover('show');
		return false;
	}else{
		$('#inputPassword').popover('destroy');
	}
	return true;
}