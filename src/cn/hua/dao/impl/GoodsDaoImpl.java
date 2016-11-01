package cn.hua.dao.impl;

import cn.hua.dao.GoodsDao;
import cn.hua.formBean.Paging;
import cn.hua.model.*;

import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.List;
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
	 * 
	 */
	public List<Goods> getGoodsPaging(Paging paging) {
			Session session = hibernateTemplate.getSessionFactory()
					.getCurrentSession();
			Query<Goods> query = null; //
			System.out.println(paging);
			if(paging.getScene()!=null&&"new".equals(paging.getScene())){
				query = session.createNativeQuery("select id,name,simpleDescript,price,sellsum,breviaryPicture_id from goods where state_id=7 order by shelfTime desc");
				//query = session.createQuery("select new Goods(g.goodsId,g.name,g.simpleDescript,g.price,g.sellsum,g.breviaryPicture,g.state) from Goods g where state_id=7 order by shelfTime desc");
			}else if(paging.getScene()!=null&&"recommend".equals(paging.getScene())){
				query = session.createNativeQuery("select id,name,simpleDescript,price,sellsum,breviaryPicture_id from goods where state_id=7 order by sellsum desc");
				//query = session.createQuery("select new Goods(g.goodsId,g.name,g.simpleDescript,g.price,g.sellsum,g.breviaryPicture,g.state) from Goods g where g.state.id=7 order by sellsum desc");
			}else
			query = session.createQuery("select new Goods(g.goodsId,g.name,g.simpleDescript,g.price,g.sellsum,g.breviaryPicture) from Goods g");
			List list = query.setFirstResult(paging.getCurrentRow())
					.setMaxResults(paging.getSize()).list();
			paging.setTotalNum(list.size());
			List<Goods> goodsList = new ArrayList<Goods>();
			for(Object obj : list){
				Object[] objArray = (Object[]) obj;
				Goods goods = new Goods(objArray[0].toString(),objArray[1].toString(),objArray[2].toString(),Float.parseFloat(objArray[3].toString()),
						Long.parseLong(objArray[4].toString()),new BreviaryPicture(objArray[5].toString(), null));
				goodsList.add(goods);
			}
			return goodsList;
	}
	@Override
	public void addShoppingCart(ShoppingCart cart) {
		hibernateTemplate.save(cart);
		
	}
	@Override
	public void deleteShoppingCart(String id) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public ShoppingCart getShoppingCartById(String id) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public ShoppingCart getShoppingCartByUserId(String id) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void updateShoppingCart(ShoppingCart cart) {
		// TODO Auto-generated method stub
		
	}

}
