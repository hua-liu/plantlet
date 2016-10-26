package cn.hua.dao.impl;

import cn.hua.dao.Dao;
import cn.hua.model.Safe;
import cn.hua.utils.Encryption;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
@Component
public class SafeDaoImpl implements Dao<Safe> {
	private HibernateTemplate hibernateTemplate;
	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	@Override
	public void save(Safe safe) {
		hibernateTemplate.save(safe);
		safe.setLoginPassword(Encryption.encryption(safe.getLoginPassword()+safe.getId()));
	}

	@Override
	public void update(Safe safe) {
		hibernateTemplate.update(safe);
	}

	@Override
	public void delete(Safe safe) {
		hibernateTemplate.delete(safe);
		
	}
	@Override
	public Safe find(String id) {
		// TODO Auto-generated method stub
		return null;
	}
}
