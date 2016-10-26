package cn.hua.action;

import cn.hua.formBean.UserRegister;
import cn.hua.model.State;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import cn.hua.utils.Verification;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.interceptor.SessionAware;

import java.util.Map;

public class RegisterAction extends ActionSupport implements ModelDriven<UserRegister>,SessionAware{
	private static final long serialVersionUID = 1L;
	private Service service;
	private UserRegister userRegister;
	private Map<String,Object> session;
	public void setService(Service service) {
		this.service = service;
	}
	/*
	 * 注册Action
	 */
	public String register(){
		if(Verification.register(this,userRegister)){
			User user = new Conversion<User,UserRegister>().beanToBean(new User(), userRegister);
			if(user!=null){
				if("email".equals(userRegister.getRegisterType()))
					user.setState(new State(2));
				else
					user.setState(new State(1));
				service.addUser(user);
				session.put("user", user);
				return SUCCESS;
			}
		}
		return INPUT;
	}
	@Override
	public UserRegister getModel() {
		userRegister = new UserRegister();
		return userRegister;
	}
	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session=arg0;		
	}
}
