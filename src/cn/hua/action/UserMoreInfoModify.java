package cn.hua.action;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;

import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;

public class UserMoreInfoModify{
	private String onlyNickname;
	private Service service;
	private String result;
	public String getResult() {
		return result;
	}
	public void setOnlyNickname(String onlyNickname) {
		this.onlyNickname = onlyNickname;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public String modifyNickname(){
		if(onlyNickname==null)return "input";
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		if(user.getId().equals("")&&user.getId().trim().equals(""))return "input";
		try{
			service.updateUserNickname(user.getId(), onlyNickname);
			this.result = Conversion.stringToJson("message,true");
			user.setNickname(onlyNickname);
			ActionContext.getContext().getSession().put("user", user);
		}catch(Exception e){
			e.printStackTrace();
			this.result = Conversion.stringToJson("message,false,cause,数据库异常");
		}
		return "success";
	}
	public String myOrderForm(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		ServletActionContext.getRequest().setAttribute("orderForms",service.getOrderFormByUserId(user.getId()));
		return "success";
	}
}
