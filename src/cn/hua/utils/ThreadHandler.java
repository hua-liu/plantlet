package cn.hua.utils;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class ThreadHandler extends Thread{
	private Class obj;
	private String method;
	private Object args;
	public ThreadHandler(Class obj,String method,Object args){
		this.obj = obj;
		this.method = method;
		this.args = args;
	}
	@Override
	public void run() {
		try {
			Method me= this.obj.getDeclaredMethod(method, args.getClass());
			me.invoke(this.obj, args);
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
