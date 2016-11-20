package cn.hua.dao.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import cn.hua.dao.GoodsDao;
import cn.hua.formBean.GoodsPaging;
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
			}
			List list = query.setFirstResult(paging.getCurrentRow())
					.setMaxResults(paging.getSize()).list();
			List<Goods> goodsList = new ArrayList<Goods>();
			for(Object obj : list){
				Object[] objArray = (Object[]) obj;
				Goods goods = new Goods(objArray[0].toString(),objArray[1].toString(),objArray[2].toString(),Float.parseFloat(objArray[3].toString()),
						Long.parseLong(objArray[4].toString()),objArray[5]==null?null:new BreviaryPicture(objArray[5].toString(), null));
				goodsList.add(goods);
			}
			return goodsList;
	}
	/*
	 * (non-Javadoc)
	 * @see cn.hua.dao.GoodsDao#getGoodsRewardPaging(cn.hua.formBean.GoodsPaging)
	 * 
	 *产品页面的分页查询
	 */
	@Override
	public List<Goods> getGoodsRewardPaging(GoodsPaging paging) {
		String likes = "";
		if(paging.getColor()!=null){
			String[] colors = paging.getColor().split(",");
			for(int i=0;i<colors.length;i++){
				if(i==0){
					likes += " and (";
				}
				if(i==colors.length-1){
					likes += "color like '%"+colors[i]+"%')";
				}else
					likes += "color like '%"+colors[i]+"%' or ";
			}
			System.out.println(likes);
		}
		
		Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
		String sql = "select new Goods(g.id,g.name,g.price,g.isSale,g.salePrice,g.sellsum,g.breviaryPicture,g.inventory) "
				+ "from Goods g where "+(paging.getGoodsKind()==0?"":"g.goodsKind.id="+paging.getGoodsKind()+" and ")
				+ (paging.getMaxPrice()==0?"":"price>"+paging.getMinPrice()+" and price<"+paging.getMaxPrice()+"and")
				+("(name like :key or otherName like :key or otherValue like :key or simpleDescript like :key)"+likes)
				+(paging.getFunction()==0?"":paging.getFunction()==1?"order by price":paging.getFunction()==2?"order by price desc":
					paging.getFunction()==3?"order by sellsum desc":"");
		Query query = session.createQuery(sql).setParameter("key","%" + paging.getKeywords() + "%");
		//这里用来查询总数
		sql = "select count(*) from Goods where "+(paging.getGoodsKind()==0?"":"goodsKind_id="+paging.getGoodsKind()+" and ")
				+ (paging.getMaxPrice()==0?"":"price>"+paging.getMinPrice()+" and price<"+paging.getMaxPrice()+"and")
				+("(name like :key or otherName like :key or otherValue like :key or simpleDescript like :key)"+likes);
		Object obj = session.createNativeQuery(sql).setParameter("key","%" + paging.getKeywords() + "%").getSingleResult();
		paging.setTotalNum(Long.parseLong(obj.toString()));
		return query.setFirstResult(paging.getCurrentRow()).setMaxResults(paging.getSize()).list();
	}
	@Override
	public List<String> getAllColor() {
		return hibernateTemplate.getSessionFactory().getCurrentSession().createNativeQuery("select color from goods group by color").getResultList();
	}

}
