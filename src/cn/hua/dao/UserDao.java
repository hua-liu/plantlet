package cn.hua.dao;

import cn.hua.formBean.Paging;
import cn.hua.model.Safe;
import cn.hua.model.User;

import java.util.List;

public interface UserDao extends Dao<User>{
	User findById(String id);
	boolean isExist(String type,String name,String id);
	User findAccount(String value);
	/**
	 * 根据条件获取所有不是管理员的用户<br/>
	 * 参数1：String	指定模糊查找
	 * 参数2：int		指定当前页*/
	List<User> getNoRoleUser(String likeStr,Paging paging);
	void updateSafe(Safe safe);
	void updateUserNickname(String id,String nickname);
}
