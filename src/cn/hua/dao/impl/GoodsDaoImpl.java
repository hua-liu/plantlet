package cn.hua.dao.impl;

import cn.hua.dao.GoodsDao;
import cn.hua.formBean.Paging;
import cn.hua.model.*;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
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
	 * 鑾峰彇鍒嗛〉鏁版嵁
	 * @parme paging  鍒嗛〉淇℃伅
	 * @parme id	褰撳墠鐢ㄦ埛鐨処D锛岀敤浜庤幏鍙栧叏灞�璁剧疆(paging.getMoreKind() == 0 ? " " : "moreKind.id in("
				+ paging.getMoreKind() + ") and ")
	 */
	public List<Goods> getGoodsPaging(Paging paging) {
			Session session = hibernateTemplate.getSessionFactory()
					.getCurrentSession();
			Query<Goods> query = null; // 鑾峰彇涓嶅悓瀵硅薄鐨勫垎椤垫暟鎹�
			System.out.println(paging);
			if(paging.getScene()!=null&&"new".equals(paging.getScene())){
				query = session.createQuery("from Goods where state.id=7 order by shelfTime desc");
			}else if(paging.getScene()!=null&&"recommend".equals(paging.getScene())){
				query = session.createQuery("from Goods where state.id=7 order by sellsum desc");
			}else
			query = session.createQuery("from Goods");
			paging.setTotalNum(query.list().size());
			return query.setFirstResult(paging.getCurrentRow())
					.setMaxResults(paging.getSize()).list();
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
