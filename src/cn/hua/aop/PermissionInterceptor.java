package cn.hua.aop;

import cn.hua.annotation.Jurisdiction;
import cn.hua.model.Permission;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.CacheData;
import cn.hua.utils.Encryption;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import org.apache.struts2.StrutsStatics;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;

public class PermissionInterceptor extends MethodFilterInterceptor{
	private static final long serialVersionUID = 1L;
	/**
	 * @author liuhua
	 * @category this is a jurisdiction interceptor;
	 */
	private String result;
	private Service service;
	public void setService(Service service) {
		this.service = service;
	}
	public String getResult() {
		return result;
	}
	@Override
	protected String doIntercept(ActionInvocation action) throws Exception {
		String methodName = action.getProxy().getMethod();		//get方法名
		if("adminlogin".equals(methodName)){
			return loginHandle(action);
		}
		Method method = action.getAction().getClass().getMethod(methodName, new Class[]{});	//获取方法
		Jurisdiction jurisdiction =  method.getAnnotation(Jurisdiction.class);	//获取自定义数组
		if(jurisdiction==null){
			return action.invoke();
		}
		User user = (User) action.getInvocationContext().getSession().get("user");	//从session获取用户
		if(user==null){	//如果session中用户为空，则尝试获取Cookie
			if("execute".equals(methodName)){	//action.getInvocationContext().get(StrutsStatics.HTTP_REQUEST)获取request
				String[] cookie = CacheData.getCookie((HttpServletRequest)action.getInvocationContext().get(StrutsStatics.HTTP_REQUEST),
						"skjsAutoData");
				if (cookie != null) {
					user = service.findAccount(cookie[0]);
					if (user != null
							&& cookie[2].equals(Encryption.encryption(cookie[0]
									+ user.getSafe().getLoginPassword() + cookie[1]))) {
						action.getInvocationContext().getSession().put("user", user);
					}else return "input";
				}else return "input";
			}else return "input";
		}else
		user = service.findUserById(user.getId());	//从数据库更新用户
		if(user==null){	//如果user不能在数据库中查询到，则返回重登陆
			return "input";
		}
		if(user.getRole()==null){
			return "error";
		}
		for(int i=0;i<jurisdiction.value().length;i++){
			boolean pass = false;		//进入循环为false，如果内循环结束没被置为true，则说明没有此权限
			for(Permission permission : user.getRole().getPermissions()){
				if(permission.getName().equals(jurisdiction.value()[i])){
					pass = true;break;
				}
			}
			if(!pass){
				this.result = "{'message':"+false+",'cause':'权限不足...'}";
				return "error";
			}
		}
		return action.invoke();
	}
	//登陆处理
	public String loginHandle(ActionInvocation action) throws Exception{	//当登陆时单独进行处理
		action.invoke();
		if("admin".equals(action.getResultCode())){
			User user = (User) action.getInvocationContext().getSession().get("user");
			if(user!=null&&user.getRole()!=null&&user.getRole().getPermissions()!=null){
				for(Permission permission :user.getRole().getPermissions()){
					if("BackgroundLogin".equals(permission.getName())){
						return "success";
					}
				}
			}
		}
		action.getInvocationContext().getSession().remove("user");
		CacheData.removeCookie((HttpServletResponse)action.getInvocationContext().get(StrutsStatics.HTTP_RESPONSE), "skjsAutoData");
		return "input";
	}
	
}
