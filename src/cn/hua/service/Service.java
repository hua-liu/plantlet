package cn.hua.service;

import cn.hua.formBean.Paging;
import cn.hua.model.*;

import java.util.List;
import java.util.Map;

public interface Service {
	public void addUser(User user);
	public void updateUser(User user);
	public void deleteUser(User user);
	public User findUserById(String id);
	public List<User> getNoRoleUsers(String likeStr,Paging paging);
	public boolean UserIsExist(String type,String name,String id);
	public boolean UserIsExist(String type,String name);
	public User findAccount(String value);
	public List<Classify> getClassifys();
	public List<State> getStates();
	public List<?> getPagingData(Paging paging,String id);
	public void saveSet(MySet mySet);
	public MySet getSet(String id);
	public Map<String, Object> findUserMoreData(String id);
	public Map<Integer, String> getPermissions(Role role);
	public List<Role> getAllRoles();
	public List<Role> getRoles();
	public void deleteRole(String roleId);
	public Role findRoleByName(String name);
	public Role findRoleById(String id);
	public List<Permission> getPermissions();
	public void addRole(Role role);
	public Permission findPermissionByName(String name);
	public Permission findPermissionById(int id);
	public void updateRole(Role role);
	public List<GoodsKind> getGoodsKindRoot();
/*	public List<GoodsKind> getGoodsKindChilds(int id);*/
	public GoodsKind getGoodsKind(int id);
	public void savePhoto(Photo photo);
	public Photo loadPhoto(String id);
	public void saveGoodsExplain(Explain explain);
	public Explain loadGoodsExplain(String id);
	public void saveGoods(Goods goods);
	public void updateGoods(Goods goods);
	public void deleteGoods(Goods goods);
	public Goods findGoodsById(String id);
	public void SaveGoodsPicture(GoodsPicture goodsPicture);
	public GoodsPicture getGoodsPicture(String id);
	public List<GoodsPicture> getGoodsPicturesByGoodsId(String goodsId);
	public void deleteGoodsPicture(String goodsId, String imgId);
	public List<Goods> getGoodsPaging(Paging paging);
	public BreviaryPicture getGoodsBreviaryPicture(String id);
	public void deleteGoodsBreviaryPicture(String id);
	public void addOrderForm(OrderForm of);
	public void delOrderForm(String ofId);
	public void updateOrderForm(OrderForm of);
	public OrderForm findOrderFormById(String id);
	public List<OrderForm> getOrderFormByUserId(String id);
	public List<Area> getAreas(int id);
	public List<Takedelivery> getTakedeliverysByUserId(String id);
	public Takedelivery getTakedeliveryById(String id);
	public void saveTakedelivery(Takedelivery take);
	public void deleteTakedelivery(Takedelivery take);
}
