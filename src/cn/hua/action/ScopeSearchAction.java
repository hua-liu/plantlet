package cn.hua.action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import cn.hua.formBean.Paging;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class ScopeSearchAction extends ActionSupport implements ModelDriven<Paging>,SessionAware{
	private static final long serialVersionUID = 1L;
	private Paging paging;
	private Map<String,Object> session;
	/**
	 * 先从session里查找user，如等于空则不获取数据*/
	public String execute(){
		if(paging!=null){
			session.put("paging", paging);
			if(paging.getClassify()==1){
				return "adminUser";
			}else if(paging.getClassify()==4){
				return "adminPermission";
			}else if(paging.getClassify()==2){
				return "adminGoods";
			}else if(paging.getClassify()==3){
				return "adminOrderForm";
			}
		}
		return SUCCESS;
	}
	@Override
	public Paging getModel() {
		paging = new Paging();
		return paging;
	}
	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}
}
