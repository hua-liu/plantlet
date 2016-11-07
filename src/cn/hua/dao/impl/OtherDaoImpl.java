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
		String totalSql="";//用于查询总数
		if (paging.getClassify() == 1) {
			System.out.println(paging);
			query = session.createQuery("select new User(u.id,u.username,u.nickname,u.phone,u.email,u.state) from User u where " + (paging.getState() == 0 ? " ": ("state.id="
					+ paging.getState()+" and "))+ (paging.getRole().equals("0")? " ": ("role.id='"+ paging.getRole()+
					"' and "))+ " (username like :key or nickname like :key or phone like :key or email like :key)");
			totalSql = "select count(*) from kjuser where " + (paging.getState() == 0 ? " ": ("state_id="
					+ paging.getState()+" and "))+ (paging.getRole().equals("0")? " ": ("role_id='"+ paging.getRole()+
					"' and "))+ " (username like :key or nickname like :key or phone like :key or email like :key)";
		} else if (paging.getClassify() == 2) {
			String sql;
			if(paging.getFunction()==1){
				sql  = "from Goods g where "+ (paging.getGoodsKind() == 0 ? " " : "g.goodsKind.id="
						+ paging.getGoodsKind() + " and ")+ " inventory=0 and g.name like :key";
				totalSql = "select count(*) from goods where "+ (paging.getGoodsKind() == 0 ? " " : "goodsKind_id="
						+ paging.getGoodsKind() + " and ")+ " inventory=0 and name like :key";
			}else if(paging.getFunction()==2){
				sql  = "from Goods g where "+ (paging.getGoodsKind() == 0 ? " " : "g.goodsKind.id="
						+ paging.getGoodsKind() + " and ")+ " g.name like :key order by sellsum desc";
				totalSql = "select count(*) from goods where "+ (paging.getGoodsKind() == 0 ? " " : "goodsKind_id="
						+ paging.getGoodsKind() + " and ")+ " name like :key";
			}else if(paging.getFunction()==3){
				sql  = "from Goods g where "+ (paging.getGoodsKind() == 0 ? " " : "g.goodsKind.id="
						+ paging.getGoodsKind() + " and ")+ " g.name like :key order by sellsum desc";
				totalSql = "select count(*) from goods where "+ (paging.getGoodsKind() == 0 ? " " : "goodsKind_id="
						+ paging.getGoodsKind() + " and ")+ " name like :key";
			}else{
				sql = "from Goods g where "+ (paging.getGoodsKind() == 0 ? " " : "g.goodsKind.id="
						+ paging.getGoodsKind() + " and ")+ " g.name like :key ";
				totalSql = "select count(*) from goods where "+ (paging.getGoodsKind() == 0 ? " " : "goodsKind_id="
						+ paging.getGoodsKind() + " and ")+ " name like :key";
			}
			query = session.createQuery(sql);
		} else if (paging.getClassify() == 3) {
			if(paging.getFunction()==9){
				query = session.createQuery("select new OrderForm(ofm.id, ofm.state,ofm.goods,ofm.user,ofm.buyNum,ofm.leaveMessage) from OrderForm ofm where ofm.state.id=9 and ofm.id like :key order by isNew desc,buytime");
			}else{
			query = session.createQuery("select new OrderForm(ofm.id, ofm.state,ofm.goods,ofm.user,ofm.buyNum,ofm.leaveMessage) from OrderForm ofm where "+ (paging.getFunction() == 0 ? " ": "ofm.state.id=" + paging.getFunction()
					+ " and")+ " ofm.id like :key order by ofm.buytime desc");
			}
			totalSql = "select count(*) from OrderForm where "+ (paging.getFunction() == 0 ? " ": "state_id=" + paging.getFunction()+" and")+ " id like :key";
		} else if(paging.getClassify()==4){
			if (paging.getFunction() == 1) {	//权限管理--用户维护
				query = session.createQuery("from User where role.id!=null and (username like :key or nickname like :key or"
										+ " phone like :key or email like :key or role.name like :key)");
			}else if(paging.getFunction() == 2){	//权限管理--角色维护
				query = session.createQuery("from Role where name like :key");
			}else{
				query = session.createQuery("from Permission where name like :key");
			}
		}
		query = query.setParameter("key", "%" + paging.getKeywords() + "%");
		if(paging.getClassify()==4){
			paging.setTotalNum(query.list().size());
		}else{
			Object obj = session.createNativeQuery(totalSql).setParameter("key", "%" + paging.getKeywords() + "%").getSingleResult();
			paging.setTotalNum(Long.parseLong(obj.toString()));
		}
		List<OrderForm> ofs =  query.setFirstResult(paging.getCurrentRow()).setMaxResults(paging.getSize()).list();
		//查询已付款订单时进行更新处理
		if(paging.getClassify()==3&&paging.getFunction()==9){
			for(OrderForm of : ofs){
				if(of.getIsNew()==1){
					session.createQuery("update OrderForm set isNew=0 where id=?").setParameter(0, of.getId()).executeUpdate();
				}
			}
		}
		return ofs;
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

	@Override
	public List<String> getNewOrderFormNum() {
		return hibernateTemplate.getSessionFactory().getCurrentSession().createNativeQuery("select id from orderForm where state_id=9 and isnew=1").getResultList();
	}
}
