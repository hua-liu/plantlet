package cn.hua.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;

import cn.hua.formBean.GoodsPaging;
import cn.hua.service.Service;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import edu.emory.mathcs.backport.java.util.Arrays;

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
		/*String[] colors = new String[7];
		colors[0] = "#FF0000";
		colors[1] = "#FFF000";
		colors[2] = "#FFFF00";
		colors[3] = "#00FF00";
		colors[4] = "#00FFFF";
		colors[5] = "#0000FF";
		colors[6] = "#F000FF";
		ServletActionContext.getRequest().setAttribute("colors", colors);*/
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
