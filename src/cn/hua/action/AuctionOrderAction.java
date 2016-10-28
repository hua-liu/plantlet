package cn.hua.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import cn.hua.model.OrderForm;
import cn.hua.model.User;
import cn.hua.service.Service;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class AuctionOrderAction extends ActionSupport{
	/**
	 * 确认订单
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private Service service;
	public void setService(Service service) {
		this.service = service;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String execute(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null){
			return INPUT;
		}
		ServletActionContext.getRequest().setAttribute("addrs",service.getTakedeliverysByUserId(user.getId()));
		if(id!=null){
			//这里添加list为了兼容多个商品时页面也能正常处理
			List<OrderForm> list = new ArrayList<OrderForm>();
			list.add(service.findOrderFormById(id));
			ServletActionContext.getRequest().setAttribute("orderForms", list);;
		}else{
			ServletActionContext.getRequest().setAttribute("orderForms", service.getOrderFormByUserId(user.getId()));
		}
		return SUCCESS;
	}
}
