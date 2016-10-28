package cn.hua.service.impl;

import cn.hua.dao.*;
import cn.hua.formBean.Paging;
import cn.hua.model.*;
import cn.hua.service.Service;

import org.apache.commons.beanutils.PropertyUtilsBean;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import java.beans.PropertyDescriptor;
import java.util.HashMap;
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
		return userDao.isExist(type, name,id);
	}
	@Override
	public boolean UserIsExist(String type, String name) {
		return userDao.isExist(type, name,null);
	}
	@Override
	public User findAccount(String value) {
		return userDao.findAccount(value);
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
	public List<?> getPagingData(Paging paging, String id) {
		return otherDao.getPagingData(paging, id);
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
		return roleDao.getPermissions(role);
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
		return goodsDao.getGoodsPaging(paging);
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

}
