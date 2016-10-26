/**
 * Created by 甜橙六画 on 2016/8/16.
 */
$(function() {
	var rb = document.getElementsByClassName("registerButton")[0];
	var isAgree = document.getElementsByClassName("isAgree")[0];
	var inputEmail = document.getElementById("inputEmail");
	var inputPhone = getElement("#inputPhone");
	if (inputPhone != null)
		inputPhone.addEventListener("change", function() {
			checkIsExist("phone", this)
		});
	if (inputEmail != null)
		inputEmail.addEventListener("change", function() {
			checkIsExist("email", this)
		});
	var inputUsername = document.getElementById("inputUsername")
	if (inputUsername != null)
		inputUsername.addEventListener("change", function() {
			checkIsExist("username", this)
		});
	document.getElementById("registerForm").onsubmit = checkInput;
	inputEmail.addEventListener("keyup", function() {
		window.setTimeout(emailPromptOn(event), 500);
	});
	inputEmail.addEventListener("blur", emailPromptOff)
	isAgree.addEventListener("change", function() {
		if (this.checked)
			rb.disabled = false;
		else
			rb.disabled = true;
	})
	/*
	 * $(function() { $('[data-toggle="tooltip"]').tooltip() })
	 */
	isAgree.checked = true;
	rb.disabled = false;
})
function getCode(el) {
	// 调用获取验证码函数
	var time = 60;
	el.disabled = true;
	el.innerHTML = i18n.sendedCode + time--;
	var countdown = window.setInterval(function() {
		el.innerHTML = i18n.sendedCode + time--;
		if (time < 1) {
			clearInterval(countdown);
			el.disabled = false;
			el.innerHTML = i18n.clickGetCode;
		}
	}, 1000);
	return false;
}
var lisIndex = 0, num = 0;
function emailPromptOn(e) {
	var el = document.getElementById("inputEmail");
	var emailPrompt = document.getElementById("emailPrompt");
	var emailData = [ "@136.com", "@163.com", "@126.com","@qq.com", "@yeah.net",
	                  "@sohu.com","@sina.com"];
	var ul;
	if (emailPrompt != null) {
		if (el.value != "")
			emailPrompt.style.display = "block";
		else
			emailPrompt.style.display = "none";
	} else {
		ul = document.createElement("div");
		ul.setAttribute("id", "emailPrompt");
		ul.setAttribute("class", "list-group emailPrompt");
		ul.style.width = el.offsetWidth + "px";
		ul.style.height = el.offsetHeight + "px";
		el.parentNode.appendChild(ul);
		for (var i = 0; i < emailData.length; i++) {
			var li = document.createElement("a")
			li.setAttribute("class", "list-group-item");
			li.addEventListener("mousedown", function() {
				el.value = this.text;
			})
			li.addEventListener("mouseover", function() {
				var lis = el.parentNode.getElementsByTagName("a");
				for (var i = 0; i < lis.length; i++) {

					lis[i].setAttribute("class", "list-group-item");
				}
				this.setAttribute("class", "list-group-item active");
			})
			li.text = el.value + emailData[i];
			ul.appendChild(li);
			if (i == 0)
				li.setAttribute("class", "list-group-item active");
		}
	}
	var lis = el.parentNode.getElementsByTagName("a");
	if (e.keyCode == 40 || e.keyCode == 38 || e.keyCode == 13) {
		if (e.keyCode == 13) {
			el.value = lis[lisIndex].text;
			// el.blur();
			emailPromptOff();
			checkIsExist("email", el);
			return false;
		} else {
			e.keyCode == 40 ? lisIndex++ : lisIndex--;
			if (lisIndex < 0)
				lisIndex = num - 1;
			else if (lisIndex > num - 1)
				lisIndex = 0;

			for (var i = 0; i < lis.length; i++) {
				lis[i].setAttribute("class", "list-group-item");
			}
			lis[lisIndex].setAttribute("class", "list-group-item active");
		}
	} else {
		if (el.value.indexOf("@") != -1) {
			num = 0;
			for (var i = 0; i < lis.length; i++) {
				var k = lis[i].text.indexOf(el.value);
				if (k == 0 && k != -1) {
					lis[i].style.display = "block";
					num++;
				} else {
					lis[i].style.display = "none";
				}
				// lis[i].text=el.value+emailData[i];
			}
		} else
			for (var i = 0; i < emailData.length; i++) {
				lis[i].text = el.value + emailData[i];
				num = lis.length;
			}
	}
}
function emailPromptOff() {
	if (document.getElementById("emailPrompt") != null)
		document.getElementById("emailPrompt").style.display = "none";
}
var inputError = new Map();
function checkInput() {
	if (getElement("#inputPassword").value == "") {
		getElement("#jspasswordError").innerHTML = i18n.passwordNull;
		inputError.put("password", getElement("#inputPassword"));
	} else if (getElement("#inputPassword").value.length < 8) {
		getElement("#jspasswordError").innerHTML = i18n.passwordLenght;
		inputError.put("password", getElement("#inputPassword"));
	} else {
		getElement("#jspasswordError").innerHTML = "";
		inputError.remove("password");
	}
	if (getElement("#inputPassword2").value == "") {
		getElement("#jspassword2Error").innerHTML = i18n.password2Null;
		inputError.put("password2", getElement("#inputPassword2"));
	} else if (getElement("#inputPassword2").value != getElement("#inputPassword").value) {
		getElement("#jspassword2Error").innerHTML = i18n.twicePasswordSame;
		inputError.put("password2", getElement("#inputPassword2"));
	} else {
		getElement("#jspassword2Error").innerHTML = "";
		inputError.remove("password2");
	}
	if (inputError.size() > 0) {
		inputError.element(0).value.focus();
		return false;
	}
	var inputEmail = document.getElementById("inputEmail");
	if (inputEmail == document.activeElement) {
		return false;
	}
	var typeValue = document.getElementById("registerType").value;
	if (typeValue == "phone") {
		checkPhoneMust();
		checkverificationCode();
		checkEmail();
	} else if (typeValue == "username") {
		checkUsername();
		checkPhone();
		checkEmail();
	} else if (typeValue == "email") {
		checkEmailMust();
		checkPhone();
	}

	console.log(inputError.size())
	if (inputError.size() > 0) {
		inputError.element(0).value.focus();
		return false;
	}
	return true;
}
function checkPhoneMust() {
	getElement("#jsphoneError").parentNode.style.color = "#f00";
	if (getElement("#inputPhone").value == "") {
		getElement("#jsphoneError").innerHTML = i18n.phoneNull;
		inputError.put("phone", getElement("#inputPhone"));
	} else if (!/^[1][3-8][0-9]{9}$/.test(getElement("#inputPhone").value)) {
		getElement("#jsphoneError").innerHTML = i18n.phoneFormatError;
		inputError.put("phone", getElement("#inputPhone"));
	} else {
		getElement("#jsphoneError").innerHTML = ""
	}

}
function checkverificationCode() {
	if (getElement("#verificationCode").value == "") {
		getElement("#jsverificationCodeError").innerHTML = i18n.verificationCodeNull;
		inputError.put("verificationCode", getElement("#verificationCode"));
	} else {
		getElement("#jsverificationCodeError").innerHTML = "";
		inputError.remove("verificationCode");
	}
}
function checkPhone() {
	getElement("#jsphoneError").parentNode.style.color = "#f00";
	if (getElement("#inputPhone").value != "") {
		if (!/^[1][3-8][0-9]{9}$/.test(getElement("#inputPhone").value)) {
			getElement("#jsphoneError").innerHTML = i18n.phoneFormatError;
			inputError.put("phone", getElement("#inputPhone"));
		} else {
			getElement("#jsphoneError").innerHTML = ""
		}
	} else {
		getElement("#jsphoneError").innerHTML = ""
	}
}
function checkEmailMust() {
	getElement("#jsemailError").parentNode.style.color = "#f00";
	if (getElement("#inputEmail") == "") {
		getElement("#jsemailError").innerHTML = i18n.emailNull;
		inputError.put("email", getElement("#inputEmail"));
	} else if (!/^[0-9a-zA-Z]+@[0-9a-zA-Z]+[.][0-9a-zA-Z]+$/
			.test(getElement("#inputEmail").value)) {
		getElement("#jsemailError").innerHTML = i18n.emailFormatError;
		inputError.put("email", getElement("#inputEmail"));
	} else {
		getElement("#jsemailError").innerHTML = "";

	}
}
function checkEmail() {
	getElement("#jsemailError").parentNode.style.color = "#f00";
	if (getElement("#inputEmail").value != ""
			&& !/^[0-9a-zA-Z]+@[0-9a-zA-Z]+[.][0-9a-zA-Z]+$/
					.test(getElement("#inputEmail").value)) {
		getElement("#jsemailError").innerHTML = i18n.emailFormatError;
		inputError.put("email", getElement("#inputEmail"));
	} else {
		getElement("#jsemailError").innerHTML = "";
	}
}
function checkUsername() {
	getElement("#jsusernameError").parentNode.style.color = "#f00";
	if (getElement("#inputUsername").value == "") {
		getElement("#jsusernameError").innerHTML = i18n.usernameNull;
		inputError.put("username", getElement("#inputUsername"));
	} else if (!/^[a-zA-Z]+[0-9a-zA-Z]{4,20}$/
			.test(getElement("#inputUsername").value)) {
		getElement("#jsusernameError").innerHTML = i18n.usernameLenght;
		inputError.put("username", getElement("#inputUsername"));
	} else {
		getElement("#jsusernameError").innerHTML = "";
	}
}
function checkIsExist(type, el) {
	if (el.value != "") {
		if (type == "phone" && /^[1][3-8][0-9]{9}$/.test(el.value)
				|| type == "email"
				&& /^[0-9a-zA-Z]+@[0-9a-zA-Z]+[.][0-9a-zA-Z]+$/.test(el.value)
				|| type == "username"
				&& /^[a-zA-Z]+[0-9a-zA-Z]{4,20}$/.test(el.value)) {
			var data = "type=" + type + "&value=" + el.value;
			$.post({
						url : "json/checkIsExist",
						data : data,
						success : function(data) { // 此处可以因为版本问题导入包commons-lang-2.3.jar
							if (data != null) {
								var data = eval("(" + data + ")");
								if (data.message == false) {
									if (type == "phone") {
										getElement("#jsphoneError").innerHTML = i18n.phoneAvailable;
										inputError.remove("phone");
									} else if (type == "email") {
										getElement("#jsemailError").innerHTML = i18n.emailAvailable;
										inputError.remove("email");
									} else {
										getElement("#jsusernameError").innerHTML = i18n.usernameAvailable;
										inputError.remove("username");
									}
									getElement("#js" + type + "Error").parentNode.style.color = "#0f0";
								} else {
									if (type == "phone") {
										getElement("#jsphoneError").innerHTML = i18n.phoneInvalid;
										inputError.put("phone",
												getElement("#inputPhone"));
									} else if (type == "email") {
										getElement("#jsemailError").innerHTML = i18n.emailInvalid;
										inputError.put("email",
												getElement("#inputEmail"));
									} else {
										getElement("#jsusernameError").innerHTML = i18n.usernameInvalid;
										inputError.put("username",
												getElement("#inputUsername"));
									}
									getElement("#js" + type + "Error").parentNode.style.color = "#f00";
								}
							}
						}
					});
		} else {
			if (type == "phone") {
				checkPhoneMust();
				checkEmail();
			} else if (type == "username") {
				checkUsername();
				checkPhone();
				checkEmail();
			} else if (type == "email") {
				checkEmailMust();
				checkPhone();
			}
		}
	} else {
		if (type == "phone") {
			getElement("#jsphoneError").innerHTML = "";
			inputError.remove("phone");
		} else if (type == "email") {
			getElement("#jsemailError").innerHTML = "";
			inputError.remove("email");
		} else {
			getElement("#jsusernameError").innerHTML = "";
			inputError.remove("username");
		}
	}
}
function clearError(el) {
	el.parentNode.parentNode.getElementsByClassName("jsError")[0].innerHTML = "";
}

