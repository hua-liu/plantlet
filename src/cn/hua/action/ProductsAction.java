package cn.hua.action;

import org.apache.struts2.ServletActionContext;

import cn.hua.formBean.GoodsPaging;
import cn.hua.service.Service;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class ProductsAction extends ActionSupport implements ModelDriven<GoodsPaging>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Service service;
	private GoodsPaging goodsPaging;
	public GoodsPaging getGoodsPaging() {
		return goodsPaging;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public String execute(){
		goodsPaging.setSize(12);
		ServletActionContext.getRequest().setAttribute("products", service.getGoodsRewardPaging(goodsPaging));
		return "success";
	}
	public String Search(){
		Object obj = ActionContext.getContext().getSession().get("products");
		if(obj!=null){
			ServletActionContext.getRequest().setAttribute("products", obj);
			ActionContext.getContext().getSession().remove("products");
		}
		return "success";
	}
	@Override
	public GoodsPaging getModel() {
		goodsPaging = new GoodsPaging();
		return goodsPaging;
	}
}
