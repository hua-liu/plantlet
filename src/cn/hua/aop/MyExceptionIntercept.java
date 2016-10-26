package cn.hua.aop;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.StaticParametersInterceptor;

public class MyExceptionIntercept extends StaticParametersInterceptor{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		// TODO Auto-generated method stub
		return super.intercept(invocation);
	}


}
