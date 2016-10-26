package cn.hua.utils;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ThreadPool {
	public static ExecutorService pool;
	private ThreadPool(){
		pool = Executors.newFixedThreadPool(20);
	}
	public static Object submit(Callable<Object> control){
		if(pool==null)new ThreadPool();
		try {
			return pool.submit(control).get();
		} catch (InterruptedException | ExecutionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
