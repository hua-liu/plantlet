package cn.hua.log;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
@Aspect
@Component
public class UserLogging {
	@Pointcut("execution(public * cn.hua.service.impl.*.*(..))")
	public void myPointcut(){}
	/*@Before("myPointcut()")
	public void saveLogging(){
		System.out.println("start logging saved");
	}*/
	@Around("myPointcut()")
	public void saveLogging2(ProceedingJoinPoint pjp){
		System.out.println("this function start");
		System.out.println(pjp.getClass().getName());
		System.out.println(pjp.getThis());
		try {
			pjp.proceed();
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("this function end");
	}
}
