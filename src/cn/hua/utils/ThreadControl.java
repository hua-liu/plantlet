package cn.hua.utils;

import java.util.concurrent.Callable;

public class ThreadControl implements Callable<Object>{
	private Object obj;
	private String method;
	private String[] args;
	public ThreadControl(Object obj,String method,String[] args){
		this.obj = obj;this.method= method;this.args = args;
	}
	@Override
	public Object call() throws Exception {
		System.out.println(Thread.currentThread().getName());
		//反射调用带数组参数的方法
		return obj.getClass().getMethod(method,String[].class).invoke(obj,(Object)args);
	}
	
}
