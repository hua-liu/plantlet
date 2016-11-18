package cn.hua.action;

import org.apache.struts2.ServletActionContext;

import cn.hua.annotation.Jurisdiction;
import cn.hua.formBean.UserLogin;
import cn.hua.model.User;
import cn.hua.utils.CacheData;
import cn.hua.utils.Verification;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class LoginAction extends ActionSupport implements
		ModelDriven<UserLogin>{
	private static final long serialVersionUID = 1L;
	private UserLogin userLogin;
	private String resourceUrl;
	private String url;
	private String account;
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public void setResourceUrl(String resourceUrl) {
		this.resourceUrl = resourceUrl;
	}
	public String getResourceUrl() {
		System.out.println(url);
		if(url==null){
			this.resourceUrl = "index";
		}else{
			String path = ServletActionContext.getRequest().getContextPath();
			this.resourceUrl = url.substring(url.indexOf(path)+path.length()+1);
		}
		System.out.println(resourceUrl);
		return this.resourceUrl;
	}
	//private HttpServletResponse httpServletResponse;

	public String accountParameter() {
		if(ActionContext.getContext().getSession().get("account")!=null){
			ServletActionContext.getRequest().setAttribute("account", ActionContext.getContext().getSession().get("account"));
			ActionContext.getContext().getSession().remove("account");
		}
		/*ActionContext.getContext().getValueStack().push(userLogin);*/
		return SUCCESS;
	}
	/**
	 * 前台登陆Action
	 */
	public String login() {
		User user = Verification.loginVerification(userLogin);
		if (user != null) {	
			//如果用户选择了记住登陆，则向本地写入Cookie
			if (userLogin.getIsRemember() != null
					&& userLogin.getIsRemember().equals("on")) {
				CacheData.addCookie(ServletActionContext.getResponse(), user);
				System.out.println("addCookie");
			}
			ActionContext.getContext().getSession().put("user", user);
			this.url =ActionContext.getContext().getSession().get("url")!=null?ActionContext.getContext().getSession().get("url").toString():null;
			ActionContext.getContext().getSession().remove("url");
			return SUCCESS;
		}
		this.addActionError("账号或密码错误！请检查后重试..");
		return INPUT;
	}
/*	public void getCartToSession(){
		User user = (User) ActionContext.getContext().getSession().get("user");
		List<OrderForm> list = service.getOrderFormByUserId(user.getId());
		ActionContext.getContext().getSession().put("orderForms", list);
	}*/
	/**
	 * 后台登陆Action之后拦截器会进行权限检查
	 * @return
	 */
	@Jurisdiction("BackgroundLogin")
	public String adminlogin() {
		User user = Verification.loginVerification(userLogin);
		if (user != null) {
			ActionContext.getContext().getSession().put("user", user);
			if (userLogin.getIsRemember() != null
					&& userLogin.getIsRemember().equals("on")) {
				CacheData.addCookie(ServletActionContext.getResponse(), user);
				System.out.println("addCookie");
			}else{
				CacheData.removeCookie(ServletActionContext.getResponse(), "skjsAutoData");
			}
			if (userLogin.getType() != null
					&& userLogin.getType().equals("admin")) {
				return "admin";
			}
		}
		this.addActionError("账号或密码错误！请检查后重试...");
		return INPUT;
	}

	@Override
	public UserLogin getModel() {
		userLogin = new UserLogin();
		return userLogin;
	}

/*	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		this.httpServletResponse = arg0;
	}*/
}
