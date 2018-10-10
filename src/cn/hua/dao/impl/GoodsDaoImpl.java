package cn.hua.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import cn.hua.dao.GoodsDao;
import cn.hua.formBean.Paging;
import cn.hua.model.BreviaryPicture;
import cn.hua.model.Goods;
import cn.hua.model.GoodsKind;
import cn.hua.model.GoodsPicture;
@Component
public class GoodsDaoImpl implements GoodsDao {
	private HibernateTemplate hibernateTemplate;
	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	public void save(Goods t){
		hibernateTemplate.save(t);
	}
	@Override
	public void update(Goods t) {
		hibernateTemplate.update(t);
	}

	@Override
	public void delete(Goods t) {
		hibernateTemplate.delete(t);
	}

	@Override
	public Goods find(String id) {
		return hibernateTemplate.get(Goods.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsKind> getGoodsKindRoot() {
		return (List<GoodsKind>) hibernateTemplate.find("from GoodsKind where parent=null");
	}

	@Override
	public GoodsKind getGoodsKind(int id) {
		return hibernateTemplate.get(GoodsKind.class, id);
	}
	/*@SuppressWarnings("unchecked")
	@Override
	public List<GoodsKind> getGoodsKindChilds(int id) {
		return (List<GoodsKind>) hibernateTemplate.find("from GoodsKind where parent.id="+id);
	}*/
	@Override
	public void SaveGoodsPicture(GoodsPicture goodsPicture) {
		hibernateTemplate.save(goodsPicture);
		
	}
	@Override
	public GoodsPicture getGoodsPicture(String id) {
		return hibernateTemplate.get(GoodsPicture.class, id);
	}
	@Override
	public BreviaryPicture getGoodsBreviaryPicture(String id) {
		return hibernateTemplate.get(BreviaryPicture.class, id);
	}
	
	@Override
	public void deleteGoodsBreviaryPicture(String id) {
		hibernateTemplate.delete(new BreviaryPicture(id,null));
		
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsPicture> getGoodsPicturesByGoodsId(String goodsId) {
		return (List<GoodsPicture>) hibernateTemplate.find("from GoodsPicture where goods.id='"+goodsId+"'");
	}
	@Override
	public void deleteGoodsPicture(String goodsId, String imgId) {
		hibernateTemplate.getSessionFactory().getCurrentSession().createQuery("delete from GoodsPicture where id=:imgId and goods.id=:id")
				.setParameter("imgId", imgId).setParameter("id", goodsId).executeUpdate();
	}
	@SuppressWarnings("unchecked")
	@Override
	/**
	 * 首页的商品展示
	 */
	public List<Goods> getGoodsPaging(String sql,int currentRow,int size) {
			Session session = hibernateTemplate.getSessionFactory()
					.getCurrentSession();
			return session.createNativeQuery(sql).setFirstResult(currentRow)
						.setMaxResults(size).list();
	}
	/*
	 * (non-Javadoc)
	 * @see cn.hua.dao.GoodsDao#getGoodsRewardPaging(cn.hua.formBean.GoodsPaging)
	 * 
	 *产品页面的分页查询
	 */
	@Override
	public List<Goods> getGoodsRewardPaging(String sql,Paging paging) {
		Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
		return session.createQuery(sql).setParameter("key","%" + paging.getKeywords() + "%").setFirstResult(paging.getCurrentRow()).setMaxResults(paging.getSize()).list();
	}
	@Override
	public List<String> getAllColor() {
		return hibernateTemplate.getSessionFactory().getCurrentSession().createNativeQuery("select color from goods group by color").getResultList();
	}

}
