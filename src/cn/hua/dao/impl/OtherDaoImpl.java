package cn.hua.dao.impl;

import cn.hua.dao.OtherDao;
import cn.hua.formBean.Paging;
import cn.hua.model.*;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import java.util.List;
import java.util.Map;

@Component
public class OtherDaoImpl implements OtherDao<Classify, State> {
	private HibernateTemplate hibernateTemplate;

	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Classify> getAll() {
		return (List<Classify>) hibernateTemplate.find("from Classify");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<State> getStates() {
		return (List<State>) hibernateTemplate
				.find("from State s where s.id in(select u.state.id as id from User u group by u.state.id)");
	}

	@Override
	/**
	 * 获取分页数据
	 * @parme paging  分页信息
	 * @parme id	当前用户的ID，用于获取全局设置
	 */
	public List<?> getPagingData(Paging paging, String id) {
		MySet myset = getSet(id);
		if (myset != null) {
			paging.setSize(myset.getPageRowNum());
		}
		Session session = hibernateTemplate.getSessionFactory()
				.getCurrentSession();
		Query query = null; // 获取不同对象的分页数据
		if (paging.getClassify() == 1) {
			System.out.println(paging);
			query = session.createQuery("from User where " + (paging.getState() == 0 ? " ": ("state.id="
					+ paging.getState()+" and "))+ (paging.getRole().equals("0")? " ": ("role.id='"+ paging.getRole()+
					"' and "))+ " (username like :key or nickname like :key or phone like :key or email like :key)")
					.setParameter("key", "%" + paging.getKeywords() + "%");
		} else if (paging.getClassify() == 2) {
			query = session.createQuery("from Goods where "+ (paging.getGoodsKind() == 0 ? " " : "goodsKind.id="
					+ paging.getGoodsKind() + " and ")+ " name like :key ")
					.setParameter("key","%" + paging.getKeywords() + "%");
		} else if (paging.getClassify() == 3) {
			query = session.createQuery("from Store where "+ (paging.getState() == 0 ? " ": "state.id=" + paging.getState()
					+ " and")+ " (name like :key "+ "or description like :key)")
					.setParameter("key", "%" + paging.getKeywords() + "%");
		} else if(paging.getClassify()==4){
			if (paging.getFunction() == 1) {	//权限管理--用户维护
				query = session.createQuery("from User where role.id!=null and (username like :key or nickname like :key or"
										+ " phone like :key or email like :key or role.name like :key)")
						.setParameter("key", "%" + paging.getKeywords() + "%");
			}else if(paging.getFunction() == 2){	//权限管理--角色维护
				query = session.createQuery("from Role where name like :key")
						.setParameter("key", "%" + paging.getKeywords() + "%");
			}else
				query = session.createQuery("from Permission where name like :key")
				.setParameter("key", "%" + paging.getKeywords() + "%");
		}
		paging.setTotalNum(query.list().size());
		return query.setFirstResult(paging.getCurrentRow())
				.setMaxResults(paging.getSize()).list();
	}

	@Override
	public void saveSet(MySet mySet) {
		MySet mySet1 = getSet(mySet.getUser().getId());
		if (mySet1 == null)
			hibernateTemplate.save(mySet);
		else {
			mySet1.setPageRowNum(mySet.getPageRowNum());
			mySet1.setShowChart(mySet.getShowChart());
		}
	}

	@Override
	public MySet getSet(String id) {
		List list = hibernateTemplate.find("from MySet where user.id='" + id
				+ "'");
		if (list != null && list.size() > 0) {
			return (MySet) list.get(0);
		}
		return null;
	}

	public Map<String, Object> findUserMoreData(String id) {
		System.out.println("这里没用吗？");
		hibernateTemplate.get(User.class, id);
		return null;
	}

	@Override
	public List<Role> getRoles() {
		Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
		return session.createNativeQuery("select * from UserAllRole", Role.class).list();
	}

	@Override
	public void savePhoto(Photo photo) {
		hibernateTemplate.save(photo);
	}

	@Override
	public Photo loadPhoto(String id) {
		return hibernateTemplate.get(Photo.class, id);
	}

	@Override
	public void saveGoodsExplain(Explain explain) {
		hibernateTemplate.save(explain);
	}

	@Override
	public Explain loadGoodsExplain(String id) {
		return hibernateTemplate.get(Explain.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Area> getAreas(int id) {
		return hibernateTemplate.getSessionFactory().getCurrentSession().createQuery("from Area where parent=:p1 order by name").setParameter("p1", id).list();
	}
}
