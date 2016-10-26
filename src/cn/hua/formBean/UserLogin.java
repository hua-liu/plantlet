package cn.hua.formBean;

public class UserLogin {
	private String account;
	private String password;
	private String verificationCode;
	private String isRemember;
	private String type;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getVerificationCode() {
		return verificationCode;
	}
	public void setVerificationCode(String verificationCode) {
		this.verificationCode = verificationCode;
	}
	public String getIsRemember() {
		return isRemember;
	}
	public void setIsRemember(String isRemember) {
		this.isRemember = isRemember;
	}
	
}
