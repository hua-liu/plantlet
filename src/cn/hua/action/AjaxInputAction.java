package cn.hua.action;


public class AjaxInputAction {
	private String result;
	public String getResult() {
		return result;
	}
	public String execute(){
		this.result="input";
		return "success";
	}
}
