package cn.hua.action;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;

import cn.hua.formBean.Paging;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;

public class MyCenterAction{
	private Service service;
	private String result;
	public String getResult() {
		return result;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public String myOrderForm(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		//第一次访问时就重新new一个
		Paging paging = new Paging();
		paging.setClassify(3);
		paging.setFunction(0);
		paging.setSize(1000);
		ServletActionContext.getRequest().setAttribute("orderForms", service.getPagingData(paging,user.getId()));
		return "success";
	}
}
