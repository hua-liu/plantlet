package cn.hua.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import cn.hua.dao.OrderFormDao;
import cn.hua.model.OrderForm;
import cn.hua.model.Takedelivery;
@Component
public class OrderFormDaoImpl implements OrderFormDao {
	private HibernateTemplate hibernateTemplate;
	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	
	@Override
	public void save(OrderForm t) {
		hibernateTemplate.save(t);
	}

	@Override
	public void update(OrderForm t) {
		hibernateTemplate.update(t);

	}

	@Override
	public void delete(OrderForm t) {
		hibernateTemplate.delete(t);

	}

	@Override
	public OrderForm find(String id) {
		return hibernateTemplate.get(OrderForm.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrderForm> getOrderFormByUserId(String id) {
		return hibernateTemplate.getSessionFactory().getCurrentSession()
				.createQuery("from OrderForm where user.id=? order by buyTime").setParameter(0, id).list();
	}

	@Override
	public List<Takedelivery> getTakedeliverysByUserId(String id) {
		return hibernateTemplate.getSessionFactory().getCurrentSession().createQuery("from Takedelivery where user.id=?").setParameter(0, id).list();
	}

	@Override
	public Takedelivery getTakedeliveryById(String id) {
		return hibernateTemplate.get(Takedelivery.class, id);
	}

	@Override
	public void saveTakedelivery(Takedelivery take) {
		hibernateTemplate.save(take);
	}

	@Override
	public void deleteTakedelivery(Takedelivery take) {
		hibernateTemplate.delete(take);
	}

}
