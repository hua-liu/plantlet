package cn.hua.action;

import java.io.IOException;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import org.apache.struts2.interceptor.SessionAware;

import cn.hua.formBean.UserRegister;
import cn.hua.model.Message;
import cn.hua.model.State;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import cn.hua.utils.MessageOperation;
import cn.hua.utils.ThreadHandler;
import cn.hua.utils.Verification;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class RegisterAction extends ActionSupport implements ModelDriven<UserRegister>,SessionAware{
	private static final long serialVersionUID = 1L;
	private Service service;
	private UserRegister userRegister;
	private Map<String,Object> session;
	private String account;
	public String getAccount() {
		return account;
	}
	private static Properties properties = new Properties();
	static{
		try {
			properties.load(MessageOperation.class.getClassLoader().getResourceAsStream("admin.properties"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
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
				session.put("account", userRegister.getUsername()!=null?userRegister.getUsername():userRegister.getPhone()!=null?userRegister.getPhone():userRegister.getEmail());
				//发送第一个站内么信
				Message message = new Message();
				message.setContent(properties.getProperty("content"));
				message.setSendID(properties.getProperty("userid"));
				message.setSendName(properties.getProperty("username"));
				message.setId(UUID.randomUUID().toString());
				message.setReceiveID(user.getId());
				new ThreadHandler(MessageOperation.class, "sendFirstMessage", message).start();
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
