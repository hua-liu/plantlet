package cn.hua.action;

import cn.hua.formBean.Paging;
import cn.hua.service.Service;
import cn.hua.utils.GetI18nConfig;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import org.apache.struts2.interceptor.RequestAware;

import java.util.Map;

public class IndexAction extends ActionSupport implements RequestAware{
	/**
	 * 处理主页需求数据
	 */
	private static final long serialVersionUID = 1L;
	private Service service;
	private Map<String,Object> request;
	public void setService(Service service) {
		this.service = service;
	}
	/*public String execute(){
		System.out.println("root");
		request.put("goodsKindRoot",service.getGoodsKindRoot());
		return SUCCESS;
	}*/
	public String execute(){
		Paging paging = new Paging();
		paging.setSize(15);
		paging.setScene("new");
		request.put("newGoodsList", service.getGoodsPaging(paging));
		paging.setScene("recommend");
		request.put("randomList", service.getGoodsPaging(paging));
		paging.setScene(null);
		ActionContext.getContext().getValueStack().push(paging);
		//js国际化文件
		new GetI18nConfig(ActionContext.getContext()).start();
		return SUCCESS;
	}
	@Override
	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}
}
