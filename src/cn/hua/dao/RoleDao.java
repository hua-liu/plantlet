package cn.hua.dao;

import cn.hua.model.Role;

import java.util.List;
import java.util.Map;

public interface RoleDao extends Dao<Role>{
	Map<Integer, String> getPermissions(Role role);
	public List<Role> getAllRoles();
	public Role findByName(String name);
}
