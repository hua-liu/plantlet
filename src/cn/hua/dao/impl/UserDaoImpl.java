package cn.hua.dao.impl;

import cn.hua.dao.UserDao;
import cn.hua.formBean.Paging;
import cn.hua.model.Safe;
import cn.hua.model.User;

import org.hibernate.Session;
import org.hibernate.query.ParameterMetadata;
import org.hibernate.query.Query;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import java.util.Iterator;
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
	public int isExist(String sql,String ... param) {
		Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
		Query query = session.createQuery(sql);
		ParameterMetadata pm = query.getParameterMetadata();
		for(int i=0;i<pm.getPositionalParameterCount();i++){
			query.setParameter(i, param[i]);
		}
		return Integer.parseInt(query.getSingleResult().toString());
	}

	@Override
	public User findAccount(String sql,String key) {
		Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery(sql);
		ParameterMetadata pm = query.getParameterMetadata();
		Iterator<String> it = pm.getNamedParameterNames().iterator();
		while(it.hasNext()){
			query.setParameter(it.next(), key);
			break;
		}
		List<User> list =query.getResultList();
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

	@Override
	public void updateUserNickname(String id,String nickname) {
		hibernateTemplate.getSessionFactory().getCurrentSession().createNativeQuery("update kjuser set nickname=:nickname where id=:id")
		.setParameter("nickname", nickname).setParameter("id", id).executeUpdate();
	}

}
