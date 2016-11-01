package cn.hua.action;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import cn.hua.annotation.Jurisdiction;
import cn.hua.formBean.Paging;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;

public class AdminOrderFormAction extends ActionSupport{
	/**
	 * 订单管理页处理
	 */
	private static final long serialVersionUID = 1L;
	private Service service;
	private int function=-1;
	public void setFunction(int function) {
		this.function = function;
	}
	public void setService(Service service) {
		this.service = service;
	}
	@Jurisdiction("BackgroundLogin")
	public String execute(){
		User user = (User) ActionContext.getContext().getSession().get("user");
		if (user == null) {
			return INPUT;
		}
		//第一次访问时就重新new一个
		Paging paging = (Paging) ActionContext.getContext().getSession().get("paging");
		if(paging==null||function!=-1){
			paging = new Paging();
		}
		paging.setClassify(3);
		if(function!=-1){	//这里当菜单跳转时，设置function,当搜索时则不设置
			paging.setKeywords("");  //当切换菜单时，清空搜索值
			paging.setFunction(function);
		}
		ActionContext.getContext().getValueStack().push(paging);
		ActionContext.getContext().getSession().put("paging", paging);
		ServletActionContext.getRequest().setAttribute("permissions", service.getPermissions(user.getRole()));
		ServletActionContext.getRequest().setAttribute("list", service.getPagingData(paging,user.getId()));
		return SUCCESS;
	}
}
