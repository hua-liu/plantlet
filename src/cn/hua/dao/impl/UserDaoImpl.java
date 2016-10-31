package cn.hua.dao.impl;

import cn.hua.dao.UserDao;
import cn.hua.formBean.Paging;
import cn.hua.model.Safe;
import cn.hua.model.User;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import java.util.List;

@Component
public class UserDaoImpl implements UserDao {
	private HibernateTemplate hibernateTemplate;

	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	@Override
	public void save(User user) {
		hibernateTemplate.save(user);
	}

	@Override
	public void update(User user) {
		hibernateTemplate.update(user);
	}

	@Override
	public void delete(User user) {
		hibernateTemplate.delete(user);

	}

	@Override
	public User findById(String id) {
		return find(id);
	}

	@Override
	public boolean isExist(String type, String name,String id) {
		System.out.println(id);
		Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
		Long userCount=0L;
		if(id==null||id.equals(""))
			userCount = (Long) session.createQuery("select count(*) from User where "+type+"=?").setParameter(0, name).uniqueResult();
		else
			userCount = (Long) session.createQuery("select count(*) from User where id!=? and "+type+"=?").setParameter(0, id).setParameter(1, name).uniqueResult();
		if (userCount > 0) {
			return true;
		}
		return false;
	}

	@Override
	public User findAccount(String value) {
		@SuppressWarnings("unchecked")
		List<User> list = (List<User>) hibernateTemplate.find("from User where phone='" + value
				+ "' or username='" + value + "' or email='" + value + "'");
		if (list != null && list.size() > 0) {
			User user = list.get(0);
			user.getSafe().getId();
			return user;
		}
		return null;
	}

	@Override
	public User find(String id) {
		return hibernateTemplate.get(User.class, id);
	}

	@Override
	public List<User> getNoRoleUser(String likeStr,Paging paging) {
		Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
		@SuppressWarnings("unchecked")
		Query<User> query = session
				.createQuery(
						"from User where role.id=null and (username like :key or nickname like :key or"
								+ " phone like :key or email like :key)")
				.setParameter("key", "%" + likeStr + "%");
			paging.setTotalNum(query.list().size());
		return query.setFirstResult(paging.getCurrentRow())
				.setMaxResults(paging.getSize()).list();
}
	@Override
	public void updateSafe(Safe safe) {
		hibernateTemplate.update(safe);
	}

}
