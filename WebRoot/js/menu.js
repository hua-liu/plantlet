$(function() {
	getElement("#registerButton").addEventListener("click", function(e) {
		window.location.href = "phoneRegisterUi";
	})
	getElement("#loginButton").addEventListener("click", function(e) {
		window.location.href = "loginUi";
	})
	getElement("#registerButton2").addEventListener("click", function(e) {
		window.location.href = "phoneRegisterUi";
	})
	getElement("#loginButton2").addEventListener("click", function(e) {
		window.location.href = "loginUi";
	})
})
function getElement(str) {
	if (str.charAt(0) == ".")
		return document.getElementsByClassName(str.substr(1));
	else if (str.charAt(0) == "#")
		return document.getElementById(str.substr(1));
}