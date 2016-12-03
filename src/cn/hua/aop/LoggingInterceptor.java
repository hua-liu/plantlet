package cn.hua.aop;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import cn.hua.model.Log;
import cn.hua.model.User;
import cn.hua.utils.Logging;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

public class LoggingInterceptor extends MethodFilterInterceptor{
	private static final long serialVersionUID = 1L;
	/**
	 * @author liuhua
	 * @category this is a jurisdiction interceptor;
	 */
	@Override
	protected String doIntercept(ActionInvocation action) throws Exception {
		String methodName = action.getProxy().getMethod();
		System.out.println(methodName);
		String result = null;
		if("pay".equals(methodName)){
			User user = (User) action.getInvocationContext().getSession().get("user");	//从session获取用户
			if(user==null)return "input";
			Log log = new Log();
			log.setChangeType("pay");
			String ip = getIpAddr(ServletActionContext.getRequest());
			log.setChangeIp(ip);
			log.setChangeBegin(user.getSafe().getBalance()+"");
			log.setUserID(user.getId());
			log.setCurrentDate(new Date());
			result = action.invoke();
			if("success".equals(result)){
				user = (User) action.getInvocationContext().getSession().get("user");
				log.setChangeAfter(user.getSafe().getBalance()+"");
				Logging.save("pay", log);
			}
			
		}else if("login".equals(methodName)||"adminlogin".equals(methodName)){
			Log log = new Log();
			log.setChangeType("login");
			String ip = getIpAddr(ServletActionContext.getRequest());
			log.setChangeIp(ip);
			log.setCurrentDate(new Date());
			result = action.invoke();
			ActionContext.getContext().getSession().remove("log");
			if("success".equals(result)){
				User user = (User) action.getInvocationContext().getSession().get("user");	//从session获取用户
				if(user!=null){
					log.setUserID(user.getId());
					log.setChangeAfter("user");
					Logging.save("login", log);
				}
			}else if("admin".equals(result)){
				User user = (User) action.getInvocationContext().getSession().get("user");	//从session获取用户
				if(user!=null){
					log.setUserID(user.getId());
					log.setChangeAfter("admin");
					Logging.save("login", log);
				}
			}
		}else if("index".equals(methodName)){
			result = action.invoke();
			Logging.saveVisit(getIpAddr(ServletActionContext.getRequest()));
		}else{
			result = action.invoke();
		}
		return result;
	}
	//获取客户端ip
	private String getIpAddr(HttpServletRequest httpServletRequest) {   
	     String ipAddress = null;   
	     //ipAddress = this.getRequest().getRemoteAddr();   
	     ipAddress = httpServletRequest.getHeader("x-forwarded-for");   
	     if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {   
	      ipAddress = httpServletRequest.getHeader("Proxy-Client-IP");   
	     }   
	     if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {   
	         ipAddress = httpServletRequest.getHeader("WL-Proxy-Client-IP");   
	     }   
	     if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {   
	      ipAddress = httpServletRequest.getRemoteAddr();   
	      if(ipAddress.equals("127.0.0.1")){   
	       //根据网卡取本机配置的IP   
	       InetAddress inet=null;   
	    try {   
	     inet = InetAddress.getLocalHost();   
	    } catch (UnknownHostException e) {   
	     e.printStackTrace();   
	    }   
	    ipAddress= inet.getHostAddress();   
	      }   
	            
	     }   
	  
	     //对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割   
	     if(ipAddress!=null && ipAddress.length()>15){ //"***.***.***.***".length() = 15   
	         if(ipAddress.indexOf(",")>0){   
	             ipAddress = ipAddress.substring(0,ipAddress.indexOf(","));   
	         }   
	     }   
	     return ipAddress;    
	  }   
}
