package cn.hua.service;

import cn.hua.formBean.GoodsPaging;
import cn.hua.formBean.Paging;
import cn.hua.model.*;

import java.util.List;
import java.util.Map;

public interface Service {
	void addUser(User user);
	void updateUser(User user);
	void deleteUser(User user);
	User findUserById(String id);
	List<User> getNoRoleUsers(String likeStr,Paging paging);
	boolean UserIsExist(String type,String name,String id);
	boolean UserIsExist(String type,String name);
	User findAccount(String value);
	List<Classify> getClassifys();
	List<State> getStates();
	List<?> getPagingData(Paging paging,String id);
	void saveSet(MySet mySet);
	MySet getSet(String id);
	Map<String, Object> findUserMoreData(String id);
	Map<Integer, String> getPermissions(Role role);
	List<Role> getAllRoles();
	List<Role> getRoles();
	void deleteRole(String roleId);
	Role findRoleByName(String name);
	Role findRoleById(String id);
	List<Permission> getPermissions();
	void addRole(Role role);
	Permission findPermissionByName(String name);
	Permission findPermissionById(int id);
	void updateRole(Role role);
	List<GoodsKind> getGoodsKindRoot();
/*	List<GoodsKind> getGoodsKindChilds(int id);*/
	GoodsKind getGoodsKind(int id);
	void savePhoto(Photo photo);
	Photo loadPhoto(String id);
	void saveGoodsExplain(Explain explain);
	Explain loadGoodsExplain(String id);
	void saveGoods(Goods goods);
	void updateGoods(Goods goods);
	void deleteGoods(Goods goods);
	Goods findGoodsById(String id);
	void SaveGoodsPicture(GoodsPicture goodsPicture);
	GoodsPicture getGoodsPicture(String id);
	List<GoodsPicture> getGoodsPicturesByGoodsId(String goodsId);
	void deleteGoodsPicture(String goodsId, String imgId);
	List<Goods> getGoodsPaging(Paging paging);
	BreviaryPicture getGoodsBreviaryPicture(String id);
	void deleteGoodsBreviaryPicture(String id);
	void addOrderForm(OrderForm of);
	void delOrderForm(String ofId);
	void updateOrderForm(OrderForm of);
	OrderForm findOrderFormById(String id);
	List<OrderForm> getOrderFormByUserId(String id);
	List<Area> getAreas(int id);
	List<Takedelivery> getTakedeliverysByUserId(String id);
	Takedelivery getTakedeliveryById(String id);
	void saveTakedelivery(Takedelivery take);
	void deleteTakedelivery(Takedelivery take);
	void updateTakedelivery(Takedelivery take);
	void updateSafe(Safe safe);
	List<String> getNewOrderFormNum();
	List<Goods> getGoodsRewardPaging(GoodsPaging paging);
	void updateUserNickname(String id,String nickname);
}
