package cn.hua.action;

import cn.hua.utils.CacheData;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletResponseAware;

import javax.servlet.http.HttpServletResponse;

public class LogoutAction extends ActionSupport implements ServletResponseAware{
	private static final long serialVersionUID = 1L;
	private HttpServletResponse httpServletResponse;
	/**
	 * 登陆Action
	 */
	public String execute(){
		ActionContext.getContext().getSession().remove("user");
		CacheData.removeCookie(httpServletResponse, "skjsAutoData");
		return SUCCESS;
	}

	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		this.httpServletResponse = arg0;
	}
}
