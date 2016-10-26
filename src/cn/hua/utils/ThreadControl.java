package cn.hua.utils;

import java.util.concurrent.Callable;

public class ThreadControl implements Callable<Object>{
	private Object obj;
	private String method;
	public ThreadControl(Object obj,String method){
		this.obj = obj;this.method= method;
	}
	@Override
	public Object call() throws Exception {
		System.out.println(Thread.currentThread().getName());
		return obj.getClass().getMethod(method).invoke(obj);
	}
	
}
