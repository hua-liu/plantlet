package cn.hua.service.impl;

import cn.hua.dao.*;
import cn.hua.formBean.GoodsPaging;
import cn.hua.formBean.Paging;
import cn.hua.model.*;
import cn.hua.service.Service;

import org.apache.commons.beanutils.PropertyUtilsBean;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import java.beans.PropertyDescriptor;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Component
public class ServiceImpl implements Service {
	private UserDao userDao;
	private Dao<Safe> safeDao;
	private OtherDao<Classify, State> otherDao;
	private RoleDao roleDao;
	private PermissionDao permissionDao;
	private GoodsDao goodsDao;
	private OrderFormDao orderFormDao;
	@Resource
	public void setOrderFormDao(OrderFormDao orderFormDao) {
		this.orderFormDao = orderFormDao;
	}
	@Resource
	public void setGoodsDao(GoodsDao goodsDao) {
		this.goodsDao = goodsDao;
	}
	@Resource
	public void setPermissionDao(PermissionDao permissionDao) {
		this.permissionDao = permissionDao;
	}
	@Resource
	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}
	@Resource
	public void setSafeDao(Dao<Safe> safeDao) {
		this.safeDao = safeDao;
	}

	@Resource
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@Resource
	public void setOtherDao(OtherDao<Classify, State> otherDao) {
		this.otherDao = otherDao;
	}

	@Override
	public void addUser(User user) {
		Safe safe = new Safe();
		safe.setLoginPassword(user.getPassword());
		safe.setBalance(100000);
		safeDao.save(safe);
		user.setSafe(safe);
		userDao.save(user);
	}

	@Override
	public void updateUser(User user) {
		userDao.update(user);
	}

	@Override
	public void deleteUser(User user) {
		userDao.delete(user);

	}

	@Override
	public User findUserById(String id) {
		return userDao.findById(id);
	}

	@Override
	public boolean UserIsExist(String type, String name,String id) {
		String sql = "";
		int count = 0;
		if(id==null||id!=null&&"".equals(id)){
			sql = "select count(*) from User where "+type+"=?";
			count = userDao.isExist(sql,name);
		}else{
			sql = "select count(*) from User where id!=? and "+type+"=?";
			count = userDao.isExist(sql,id,name);
		}
		if (count > 0) {
			return true;
		}
		return false;
	}
	@Override
	public boolean UserIsExist(String type, String name) {
		String sql = "select count(*) from User where "+type+"=?";
		if(userDao.isExist(sql,name)>0){
			return true;
		}
		return false;
	}
	@Override
	public User findAccount(String value) {
		String sql = "from User where phone=:key or username=:key or email=:key or nickname=:key";
		return userDao.findAccount(sql,value);
	}

	@Override
	public List<Classify> getClassifys() {
		return this.otherDao.getAll();
	}

	@Override
	public List<State> getStates() {
		return this.otherDao.getStates();
	}
	@Override
	public List<OrderForm> getPagingData(Paging paging, String id) {
		if(paging.getSize()<=1){
			MySet myset = getSet(id);
			if (myset != null) {
				paging.setSize(myset.getPageRowNum());
			}
		}
		String totalSql="";//用于查询总数
		String sql = "";
		if (paging.getClassify() == 1) {
			 sql = "select new User(u.id,u.username,u.nickname,u.phone,u.email,u.state) from User u where " + (paging.getState() == 0 ? " ": ("state.id="
					+ paging.getState()+" and "))+ (paging.getRole().equals("0")? " ": ("role.id='"+ paging.getRole()+
					"' and "))+ " (username like :key or nickname like :key or phone like :key or email like :key)";
			totalSql = "select count(*) from kjuser where " + (paging.getState() == 0 ? " ": ("state_id="
					+ paging.getState()+" and "))+ (paging.getRole().equals("0")? " ": ("role_id='"+ paging.getRole()+
					"' and "))+ " (username like :key or nickname like :key or phone like :key or email like :key)";
		} else if (paging.getClassify() == 2) {
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
		} else if (paging.getClassify() == 3) {
			if(paging.getFunction()==9){
				sql = "select new OrderForm(ofm.id, ofm.state,ofm.goods,ofm.user,ofm.buyNum,ofm.leaveMessage) from OrderForm ofm where ofm.state.id=9 order by isNew desc,buytime";
			}else{
			sql = "select new OrderForm(ofm.id, ofm.state,ofm.goods,ofm.user,ofm.buyNum,ofm.leaveMessage) from OrderForm ofm "+ (paging.getFunction() == 0 ? "": "where ofm.state.id=" + paging.getFunction())+ " order by ofm.buytime desc";
			}
			totalSql = "select count(*) from orderform "+ (paging.getFunction() == 0 ? " ": "where state_id=" + paging.getFunction());
		} else if(paging.getClassify()==4){
			if (paging.getFunction() == 1) {	//权限管理--用户维护
				sql = "from User where role.id!=null and (username like :key or nickname like :key or"
										+ " phone like :key or email like :key or role.name like :key)";
			}else if(paging.getFunction() == 2){	//权限管理--角色维护
				sql = "from Role where name like :key";
			}else{
				sql = "from Permission where name like :key";
			}
		}
		int total = otherDao.getTotalSize(totalSql,paging.getKeywords());
		paging.setTotalNum(total);
		if(total==0){//如果没有数据则后面查询不用了
			return null;
		}
		List<OrderForm> list = otherDao.getPagingData(sql,paging);
		//查询已付款订单时进行更新处理
		if(paging.getClassify()==4){
			paging.setTotalNum(list.size());
		}
		if(paging.getClassify()==3&&paging.getFunction()==9){
			otherDao.setReaded(list);
		}
		return list;
	}

	@Override
	public void saveSet(MySet mySet) {
		otherDao.saveSet(mySet);
	}

	@Override
	public MySet getSet(String id) {
		return otherDao.getSet(id);
	}
 /*这里对前台数据进行处理
  * 
  * */
	@Override
	public Map<String, Object> findUserMoreData(String id) {
		User user = userDao.findById(id);
		Map<String, Object> map = new HashMap<String, Object>();
		if (user != null) {
			PropertyUtilsBean propertyUtilsBean = new PropertyUtilsBean();
			PropertyDescriptor[] descriptors = propertyUtilsBean
					.getPropertyDescriptors(user);
			for (PropertyDescriptor descriptor : descriptors) {
				String name = descriptor.getName();
				Object obj = null;
				try {
					obj = propertyUtilsBean.getNestedProperty(user, name);
				System.out.println(name);
				if("class".equals(name)||"safe".equals(name))continue;
				if("accountState".equals(name)){
					if(user.getAccountState()==null)continue;
					map.put("phoneState",user.getAccountState().getPhoneState());
					map.put("emailState",user.getAccountState().getEmailState());
					map.put("identityState",user.getAccountState().getIdentityState());
				}else if("state".equals(name)){
					map.put("state", user.getState().getName());
				}else if("role".equals(name)){
					map.put("roleName", user.getRole()!=null?user.getRole().getName():null);
					map.put("roleId", user.getRole()!=null?user.getRole().getId():null);
				}else
					map.put(name,obj);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return map;
	}

	@Override
	public Map<Integer, String> getPermissions(Role role) {
		role =  roleDao.getPermissions(role);
		Map<Integer,String> map = new HashMap<Integer,String>();
		if(role!=null){
			Iterator<Permission> iterator = role.getPermissions().iterator();
			while(iterator.hasNext()){
				Permission p = iterator.next();
				map.put(p.getId(), p.getName());
			}
		}
		return map;
	}
	@Override
	public List<Role> getAllRoles() {
		return roleDao.getAllRoles();
	}
	@Override
	public List<Role> getRoles() {
		return otherDao.getRoles();
	}
	@Override
	public List<User> getNoRoleUsers(String likeStr,Paging paging) {
		return userDao.getNoRoleUser(likeStr, paging);
	}
	@Override
	public void deleteRole(String roleId) {
		roleDao.delete(new Role(roleId));
		
	}
	@Override
	public Role findRoleByName(String name) {
		return roleDao.findByName(name);
	}
	@Override
	public List<Permission> getPermissions() {
		return permissionDao.getPermissions();
	}
	@Override
	public Role findRoleById(String id) {
		return roleDao.find(id);
	}
	@Override
	public void addRole(Role role) {
		roleDao.save(role);		
	}
	@Override
	public Permission findPermissionByName(String name) {
		return permissionDao.findByName(name);
	}
	@Override
	public Permission findPermissionById(int id) {
		return permissionDao.findById(id);
	}
	@Override
	public void updateRole(Role role) {
		roleDao.update(role);
	}
	@Override
	public List<GoodsKind> getGoodsKindRoot() {
		return goodsDao.getGoodsKindRoot();
	}
	/*@Override
	public List<GoodsKind> getGoodsKindChilds(int id) {
		return goodsDao.getGoodsKindChilds(id);
	}*/
	@Override
	public GoodsKind getGoodsKind(int id) {
		return goodsDao.getGoodsKind(id);
	}
	@Override
	public void savePhoto(Photo photo) {
		otherDao.savePhoto(photo);
	}
	@Override
	public Photo loadPhoto(String id) {
		return otherDao.loadPhoto(id);
	}
	@Override
	public void saveGoodsExplain(Explain explain) {
		otherDao.saveGoodsExplain(explain);
	}
	@Override
	public Explain loadGoodsExplain(String id) {
		return otherDao.loadGoodsExplain(id);
	}
	@Override
	public void saveGoods(Goods goods) {
		goodsDao.save(goods);
	}
	@Override
	public void updateGoods(Goods goods) {
		goodsDao.update(goods);
	}
	@Override
	public void deleteGoods(Goods goods) {
		goodsDao.delete(goods);
	}
	@Override
	public Goods findGoodsById(String id) {
		return goodsDao.find(id);
	}
	@Override
	public void SaveGoodsPicture(GoodsPicture goodsPicture) {
		goodsDao.SaveGoodsPicture(goodsPicture);
	}
	@Override
	public GoodsPicture getGoodsPicture(String id) {
		return goodsDao.getGoodsPicture(id);
	}
	@Override
	public List<GoodsPicture> getGoodsPicturesByGoodsId(String goodsId) {
		return goodsDao.getGoodsPicturesByGoodsId(goodsId);
	}
	@Override
	public void deleteGoodsPicture(String goodsId, String imgId) {
		goodsDao.deleteGoodsPicture(goodsId,imgId);
		
	}
	@Override
	public List<Goods> getGoodsPaging(Paging paging) {
		String sql = "";
		if(paging.getScene()!=null&&"new".equals(paging.getScene())){
			sql = "select id,name,simpleDescript,price,sellsum,breviaryPicture_id from goods where state_id=7 order by shelfTime desc";
		}else if(paging.getScene()!=null&&"recommend".equals(paging.getScene())){
			sql = "select id,name,simpleDescript,price,sellsum,breviaryPicture_id from goods where state_id=7 order by sellsum desc";
		}
		List list = goodsDao.getGoodsPaging(sql,paging.getCurrentRow(),paging.getSize());
		List<Goods> goodsList = new ArrayList<Goods>();
		for(Object obj : list){
			Object[] objArray = (Object[]) obj;
			Goods goods = new Goods(objArray[0].toString(),objArray[1].toString(),objArray[2].toString(),Float.parseFloat(objArray[3].toString()),
					Long.parseLong(objArray[4].toString()),objArray[5]==null?null:new BreviaryPicture(objArray[5].toString(), null));
			goodsList.add(goods);
		}
		return goodsList;
	}
	@Override
	public BreviaryPicture getGoodsBreviaryPicture(String id) {
		return goodsDao.getGoodsBreviaryPicture(id);
	}
	@Override
	public void deleteGoodsBreviaryPicture(String id) {
		goodsDao.deleteGoodsBreviaryPicture(id);
	}
	@Override
	public void addOrderForm(OrderForm of) {
		orderFormDao.save(of);
	}
	@Override
	public void delOrderForm(String ofId) {
		orderFormDao.delete(new OrderForm(ofId));
	}
	@Override
	public void updateOrderForm(OrderForm of) {
		orderFormDao.update(of);
	}
	@Override
	public OrderForm findOrderFormById(String id) {
		return orderFormDao.find(id);
	}
	@Override
	public List<OrderForm> getOrderFormByUserId(String id) {
		return orderFormDao.getOrderFormByUserId(id);
	}
	@Override
	public List<Area> getAreas(int id) {
		return otherDao.getAreas(id);
	}
	@Override
	public List<Takedelivery> getTakedeliverysByUserId(String id) {
		return orderFormDao.getTakedeliverysByUserId(id);
	}
	@Override
	public Takedelivery getTakedeliveryById(String id) {
		return orderFormDao.getTakedeliveryById(id);
	}
	@Override
	public void saveTakedelivery(Takedelivery take) {
		orderFormDao.saveTakedelivery(take);
	}
	@Override
	public void deleteTakedelivery(Takedelivery take) {
		orderFormDao.deleteTakedelivery(take);
	}
	@Override
	public void updateTakedelivery(Takedelivery take) {
		orderFormDao.updateTakedelivery(take);
	}
	@Override
	public void updateSafe(Safe safe) {
		userDao.updateSafe(safe);
	}
	@Override
	public List<String> getNewOrderFormNum() {
		return otherDao.getNewOrderFormNum();
	}
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
		}
		//这里用来查询总数
		String sql = "select count(*) from goods where "+(paging.getGoodsKind()==0?"":"goodsKind_id="+paging.getGoodsKind()+" and ")
				+ (paging.getMaxPrice()==0?"":"price>"+paging.getMinPrice()+" and price<"+paging.getMaxPrice()+" and ")
				+("(name like :key or otherName like :key or otherValue like :key or simpleDescript like :key)"+likes);
		int total =otherDao.getTotalSize(sql,paging.getKeywords());
		paging.setTotalNum(total);
		if(total<1)return null;
		sql = "select new Goods(g.id,g.name,g.price,g.isSale,g.salePrice,g.sellsum,g.breviaryPicture,g.inventory) "
				+ "from Goods g where "+(paging.getGoodsKind()==0?"":"g.goodsKind.id="+paging.getGoodsKind()+" and ")
				+ (paging.getMaxPrice()==0?"":"price>"+paging.getMinPrice()+" and price<"+paging.getMaxPrice()+" and ")
				+("(name like :key or otherName like :key or otherValue like :key or simpleDescript like :key)"+likes)
				+(paging.getFunction()==0?"":paging.getFunction()==1?"order by price":paging.getFunction()==2?"order by price desc":
					paging.getFunction()==3?"order by sellsum desc":"");
		return goodsDao.getGoodsRewardPaging(sql,paging);
	}
	@Override
	public void updateUserNickname(String id, String nickname) {
		userDao.updateUserNickname(id, nickname);
	}
	@Override
	public void pay(Safe safe, OrderForm of) {
		updateSafe(safe);
		updateOrderForm(of);
	}
	@Override
	public List<OrderForm> getAllOrderFormByUserId(String id) {
		if(id==null||id!=null&&id.trim().equals(""))return null;
		return orderFormDao.getAllOrderFormByUserId(id);
	}
	@Override
	public List<String> getAllColor() {
		return goodsDao.getAllColor();
	}
	@Override
	public void clearAllSoppingCart(String id) {
		orderFormDao.clearAllSoppingCart(id);
	}
	
}
