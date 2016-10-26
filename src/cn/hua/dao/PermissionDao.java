package cn.hua.dao;

import cn.hua.model.Permission;

import java.util.List;

public interface PermissionDao extends Dao<Permission>{
	public List<Permission> getPermissions();
	public Permission findByName(String name);
	public Permission findById(int name);
}
