package cn.hua.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Aspect
@Component
public class Logging{
	private HibernateTemplate hibernateTemplate;
	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	public Object saveLogging(ProceedingJoinPoint pjp){
		System.out.println("loggingStart");
		if("addUser".equals(pjp.getSignature().getName()));
		try {
			return pjp.proceed();
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("loggingEnd");
		return pjp;
	}
}
