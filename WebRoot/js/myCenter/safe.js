/**
 * 刘华
 */
$(function(){
	$(".setContent button").click(function(){
		var type=$(this).attr("data");
		if(type==null||type=='')return;
		type=='phone'?setPhone():type=='email'?setEmail():type=='loginPassword'?setLoginPassword():type=='payPassword'?setPayPassword():'';
	})
})
function setPhone(){
	var newPhone = $(".setPhone input[name=newPhone]")[0];
	var oldPhone = $(".setPhone input[name=oldPhone]")[0];
	if(oldPhone.value!=''&&!/^[1][3-8][0-9]{9}$/.test(oldPhone.value)){
		$(oldPhone).attr("title",i18n.get("phoneFillError"));
		$(oldPhone).tooltip("show");
		setTimeout(function(){
			$(oldPhone).tooltip("destroy");
		},3000);
		return;
	}
	if(newPhone.value==''){
		$(newPhone).attr("title",i18n.get("noFillPhone"));
		$(newPhone).tooltip("show");
		setTimeout(function(){
			$(newPhone).tooltip("destroy");
		},3000)
		return;
	}
	if(!/^[1][3-8][0-9]{9}$/.test(newPhone.value)){
		$(newPhone).attr("title",i18n.get("phoneFillError"));
		$(newPhone).tooltip("show");
		setTimeout(function(){
			$(newPhone).tooltip("destroy");
		},3000)
		return;
	}
	if(oldPhone.value==newPhone.value){
		$(newPhone).attr("title",i18n.get("oldPhoneSame"));
		$(newPhone).tooltip("show");
		setTimeout(function(){
			$(newPhone).tooltip("destroy");
		},3000)
		return;
	}
	updateData("type=phone&oldData="+oldPhone.value+"&newData="+newPhone.value);
}
function setEmail(){
	var newEmail = $(".setEmail input[name=newEmail]")[0];
	var oldEmail = $(".setEmail input[name=oldEmail]")[0];
	if(oldEmail.value!=''&&!/^[0-9a-zA-Z]+@[0-9a-zA-Z]+[.][0-9a-zA-Z]+$/.test(oldEmail.value)){
		$(oldEmail).attr("title",i18n.get("emailFillError"));
		$(oldEmail).tooltip("show");
		setTimeout(function(){
			$(oldEmail).tooltip("destroy");
		},3000);
		return;
	}
	if(newEmail.value==''){
		$(newEmail).attr("title",i18n.get("onFillEmail"));
		$(newEmail).tooltip("show");
		setTimeout(function(){
			$(newEmail).tooltip("destroy");
		},3000)
		return;
	}
	if(!/^[0-9a-zA-Z]+@[0-9a-zA-Z]+[.][0-9a-zA-Z]+$/.test(newEmail.value)){
		$(newEmail).attr("title",i18n.get("emailFillError"));
		$(newEmail).tooltip("show");
		setTimeout(function(){
			$(newEmail).tooltip("destroy");
		},3000)
		return;
	}
	if(oldEmail.value==newEmail.value){
		$(newEmail).attr("title",i18n.get("oldEmailSame"));
		$(newEmail).tooltip("show");
		setTimeout(function(){
			$(newEmail).tooltip("destroy");
		},3000)
		return;
	}
	updateData("type=email&oldData="+oldEmail.value+"&newData="+newEmail.value);
}
function setLoginPassword(){
	var newLoginPassword = $(".setLoginPassword input[name=newLoginPassword]")[0];
	var newLoginPassword2 = $(".setLoginPassword input[name=newLoginPassword2]")[0];
	var oldLoginPassword = $(".setLoginPassword input[name=oldLoginPassword]")[0];
	if(oldLoginPassword.value==''){
		$(oldLoginPassword).attr("title",i18n.get("mustFillLoginPassword"));
		$(oldLoginPassword).tooltip("show");
		setTimeout(function(){
			$(oldLoginPassword).tooltip("destroy");
		},3000)
		return;
	}
	if(oldLoginPassword.value.length<5||oldLoginPassword.value.length>20){
		$(oldLoginPassword).attr("title",i18n.get("lengthNoRight"));
		$(oldLoginPassword).tooltip("show");
		setTimeout(function(){
			$(oldLoginPassword).tooltip("destroy");
		},3000)
		return;
	}
	if(newLoginPassword.value==''){
		$(newLoginPassword).attr("title",i18n.get("noFillPassword"));
		$(newLoginPassword).tooltip("show");
		setTimeout(function(){
			$(newLoginPassword).tooltip("destroy");
		},3000)
		return;
	}
	if(newLoginPassword.value.length<5||newLoginPassword.value.length>20){
		$(newLoginPassword).attr("title",i18n.get("lengthNoRight"));
		$(newLoginPassword).tooltip("show");
		setTimeout(function(){
			$(newLoginPassword).tooltip("destroy");
		},3000)
		return;
	}
	if(oldLoginPassword.value==newLoginPassword.value){
		$(newLoginPassword).attr("title",i18n.get("oldPasswordSame"));
		$(newLoginPassword).tooltip("show");
		setTimeout(function(){
			$(newLoginPassword).tooltip("destroy");
		},3000)
		return;
	}
	if(newLoginPassword.value!=newLoginPassword2.value){
		$(newLoginPassword2).attr("title",i18n.get("twoPasswordNoSame"));
		$(newLoginPassword2).tooltip("show");
		setTimeout(function(){
			$(newLoginPassword2).tooltip("destroy");
		},3000)
		return;
	}
	updateData("type=loginPassword&oldData="+oldLoginPassword.value+"&newData="+newLoginPassword.value);
}
function setPayPassword(){
	var oldLoginPassword = $(".setPayPassword input[name=oldLoginPassword]")[0];
	var oldPayPassword = $(".setPayPassword input[name=oldPayPassword]")[0];
	var newPayPassword = $(".setPayPassword input[name=newPayPassword]")[0];
	var newPayPassword2 = $(".setPayPassword input[name=newPayPassword2]")[0];
	if(oldLoginPassword.value==''){
		$(oldLoginPassword).attr("title",i18n.get("mustFillLoginPassword"));
		$(oldLoginPassword).tooltip("show");
		setTimeout(function(){
			$(oldLoginPassword).tooltip("destroy");
		},3000)
		return;
	}
	if(oldLoginPassword.value.length<5||oldLoginPassword.value.length>20){
		$(oldLoginPassword).attr("title",i18n.get("lengthNoRight"));
		$(oldLoginPassword).tooltip("show");
		setTimeout(function(){
			$(oldLoginPassword).tooltip("destroy");
		},3000)
		return;
	}
	if(oldPayPassword.value!=''&&(oldPayPassword.value.length<5||oldPayPassword.value.length>20)){
		$(oldPayPassword).attr("title",i18n.get("lengthNoRight"));
		$(oldPayPassword).tooltip("show");
		setTimeout(function(){
			$(oldPayPassword).tooltip("destroy");
		},3000)
		return;
	}
	if(newPayPassword.value==''){
		$(newPayPassword).attr("title",i18n.get("noFillPassword"));
		$(newPayPassword).tooltip("show");
		setTimeout(function(){
			$(newPayPassword).tooltip("destroy");
		},3000)
		return;
	}
	if(newPayPassword.value.length<5||newPayPassword.value.length>20){
		$(newPayPassword).attr("title",i18n.get("lengthNoRight"));
		$(newPayPassword).tooltip("show");
		setTimeout(function(){
			$(newPayPassword).tooltip("destroy");
		},3000)
		return;
	}
	if(oldPayPassword.value==newPayPassword.value){
		$(newPayPassword).attr("title",i18n.get("oldPasswordSame"));
		$(newPayPassword).tooltip("show");
		setTimeout(function(){
			$(newPayPassword).tooltip("destroy");
		},3000)
		return;
	}
	if(newPayPassword.value!=newPayPassword2.value){
		$(newPayPassword2).attr("title",i18n.get("twoPasswordNoSame"));
		$(newPayPassword2).tooltip("show");
		setTimeout(function(){
			$(newPayPassword2).tooltip("destroy");
		},3000)
		return;
	}
	updateData("type=payPassword&oldData="+oldLoginPassword.value+"&oldData2="+oldPayPassword.value+"&newData="+newPayPassword.value);
}
function updateData(data){
	if(data==null)return;
	$.post("json/myCenter_mySafe",data,function(data){
		if(data!=null){
			data = eval("("+data+")");
			if(data.message){
				$(".successSign").show();
				$(".setContent input").val("");//清除内容
				setTimeout(function(){
					$(".successSign").hide();
				},5000);
			}else{
				showError(data);
			}
		}
	})
}
function showError(data){
	for(var temp in data){
		if(temp=='message')continue;
		$("input[name="+temp+"]").attr("title",data[temp]);
		$("input[name="+temp+"]").tooltip("show");
		setTimeout(function(){
			$("input[name="+temp+"]").tooltip("destroy");
		},3000);
	}
}