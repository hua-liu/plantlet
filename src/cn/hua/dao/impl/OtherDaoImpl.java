package cn.hua.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.jdbc.Work;
import org.hibernate.query.ParameterMetadata;
import org.hibernate.query.Query;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import cn.hua.dao.OtherDao;
import cn.hua.formBean.Paging;
import cn.hua.model.Area;
import cn.hua.model.Classify;
import cn.hua.model.Explain;
import cn.hua.model.MySet;
import cn.hua.model.OrderForm;
import cn.hua.model.Photo;
import cn.hua.model.Role;
import cn.hua.model.State;
import cn.hua.model.User;

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
	public List<OrderForm> getPagingData(String sql,Paging paging) {
		Query query = hibernateTemplate.getSessionFactory()
				.getCurrentSession().createQuery(sql);
		ParameterMetadata pm = query.getParameterMetadata();
		Iterator<String> it = pm.getNamedParameterNames().iterator();
		while(it.hasNext()){
			query.setParameter(it.next(),"%" + paging.getKeywords() + "%");
		}
		return query.setFirstResult(paging.getCurrentRow()).setMaxResults(paging.getSize()).getResultList(); // 获取不同对象的分页数据
	}
	//更改已读
	public void setReaded(final List<OrderForm> list){
		Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
		session.doWork(new Work(){
			@Override
			public void execute(Connection conn)
					throws SQLException {
				PreparedStatement ps = conn.prepareStatement("update OrderForm set isNew=0 where id=?");
				for(OrderForm orderForm : list){
					if(orderForm.getIsNew()==1){
						ps.setString(1, orderForm.getId());
						ps.addBatch();
					}
				}
				ps.executeBatch();
			}
			
		});
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
	public int getTotalSize(String sql,Object ... obj){
		if("".equals(sql))return -1;
		Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createNativeQuery(sql);
		ParameterMetadata pm = query.getParameterMetadata();
		Iterator<String> it  = pm.getNamedParameterNames().iterator();
		while(it.hasNext()){
			query.setParameter(it.next(),  "%" + obj[0] + "%");
		}
		return  Integer.parseInt(query.getSingleResult().toString());
			
	}
}
