package cn.hua.action;

import cn.hua.formBean.Paging;
import cn.hua.service.Service;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.interceptor.SessionAware;

import java.util.Map;

public class ScopeSearchAction extends ActionSupport implements ModelDriven<Paging>,SessionAware{
	private static final long serialVersionUID = 1L;
	private Service service;
	private Paging paging;
	private Map<String,Object> session;
	public void setService(Service service) {
		this.service = service;
	}
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
