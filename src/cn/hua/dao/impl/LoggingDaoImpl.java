/*package cn.hua.dao.impl;

import javax.annotation.Resource;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import cn.hua.aop.Logging;
import cn.hua.dao.LoggingDao;
@Component
public class LoggingDaoImpl implements LoggingDao {
	private HibernateTemplate hibernateTemplate;
	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	@Override
	public void save(Logging t) {
		hibernateTemplate.save(t);
	}
	@Deprecated
	@Override
	public void update(Logging t) {

	}

	@Override
	public void delete(Logging t) {
		hibernateTemplate.delete(t);

	}
	
	@Override
	public Logging find(String id) {
		return hibernateTemplate.get(Logging.class, id);
	}

}
*/