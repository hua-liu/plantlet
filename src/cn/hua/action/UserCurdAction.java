package cn.hua.action;

import cn.hua.annotation.Jurisdiction;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.WhetherPermission;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.interceptor.SessionAware;

import java.util.Map;

public class UserCurdAction extends ActionSupport implements ModelDriven<User> ,SessionAware{
	private static final long serialVersionUID = 1L;
	private User user;
	private String id;
	private String result;
	private Service service;
	private Map<String,Object> session;

	public void setService(Service service) {
		this.service = service;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getResult() {
		return result;
	}
	@Jurisdiction("UpdateUser")
	public String update() {
		try {
			if(WhetherPermission.isPass(session,7)){
				service.updateUser(user);
				this.result = "{'message':" + true + "}";
			}else{
				this.result = "{'message':" + false + "}";
			}
		} catch (Exception e) {
			this.result = "{'message':" + false + "}";
		}
		return SUCCESS;
	}
	@Jurisdiction("DeleteUser")
	public String delete() {
		System.out.println("delete");
		if (id != null && !id.trim().equals("")) {
			try {
				if(WhetherPermission.isPass(session, 4)){
					service.deleteUser(user);
					this.result = "{'message':" + true + "}";
				}else{
					this.result = "{'message':" + false + "}";
				}
			} catch (Exception e) {
				this.result = "{'message':" + false + "}";
			}
		}else{
			this.result = "{'message':" + false + "}";}
		return SUCCESS;
	}
	public String myselfUpdate() {
		try {
			service.updateUser(user);
			this.result = "{'message':" + true + "}";
		} catch (Exception e) {
			this.result = "{'message':" + false + "}";
		}
		return SUCCESS;
	}
	@Override
	public User getModel() {
		if (id != null && !id.trim().equals("")) {
			User tempUser = service.findUserById(id);
			if (tempUser != null) {
				user = tempUser;
				return user;
			}
		}
		user = new User();
		return user;
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

}
