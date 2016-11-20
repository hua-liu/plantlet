package cn.hua.aop;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.StrutsStatics;

import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.CacheData;
import cn.hua.utils.Conversion;
import cn.hua.utils.Encryption;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

public class LoginInterceptor extends MethodFilterInterceptor{
	private static final long serialVersionUID = 1L;
	/**
	 * @author liuhua
	 * @category this is a jurisdiction interceptor;
	 */
	private String result;
	private Service service;
	public String getResult() {
		return result;
	}
	public void setService(Service service) {
		this.service = service;
	}
	@Override
	protected String doIntercept(ActionInvocation action) throws Exception {
		User user = (User) action.getInvocationContext().getSession().get("user");	//从session获取用户
		String methodName = action.getProxy().getMethod();
		System.out.println(methodName);
		if(user==null&&"add".equals(methodName)){	//如果session中用户为空，则尝试获取Cookie
			String[] cookie = CacheData.getCookie((HttpServletRequest)action.getInvocationContext().get(StrutsStatics.HTTP_REQUEST),
					"skjsAutoData");
			if (cookie != null) {
				user = service.findAccount(cookie[0]);
				if (user != null
						&& cookie[2].equals(Encryption.encryption(cookie[0]
								+ user.getSafe().getLoginPassword() + cookie[1]))) {
					action.getInvocationContext().getSession().put("user", user);
					return action.invoke();
				}
			}
			this.result=Conversion.stringToJson("input");
			return "input";
		}else{
			if(user!=null)
			ActionContext.getContext().getSession().put("orderForms", service.getOrderFormByUserId(user.getId()));
		}
		return action.invoke();
	}
	
}
