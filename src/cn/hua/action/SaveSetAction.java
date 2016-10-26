package cn.hua.action;

import cn.hua.model.MySet;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.interceptor.SessionAware;

import java.util.Map;

public class SaveSetAction extends ActionSupport implements ModelDriven<MySet>,SessionAware{
	private static final long serialVersionUID = 1L;
	private MySet mySet;
	private Map<String,Object> session;
	private Service service;
	private String result;
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public String execute(){
		try{
			User user = (User) session.get("user");
			if(user!=null&&mySet!=null){
				mySet.setUser(user);
				service.saveSet(mySet);
				this.result = Conversion.stringToJson("res,true");
				return SUCCESS;
			}
		}catch(Exception e){
			this.result = Conversion.stringToJson("res,false");
		}
		return SUCCESS;
	}


	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}


	@Override
	public MySet getModel() {
		this.mySet = new MySet();
		return mySet;
	}
}
