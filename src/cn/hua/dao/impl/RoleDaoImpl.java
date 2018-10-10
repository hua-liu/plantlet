package cn.hua.dao.impl;

import cn.hua.dao.RoleDao;
import cn.hua.model.Permission;
import cn.hua.model.Role;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
@Component
public class RoleDaoImpl implements RoleDao{
	private HibernateTemplate hibernateTemplate;
	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	@Override
	public Role getPermissions(Role role) {
		return hibernateTemplate.get(Role.class, role.getId());
	}
	@Override
	public void save(Role t) {
		hibernateTemplate.save(t);
	}
	@Override
	public void update(Role t) {
		hibernateTemplate.update(t);
		
	}
	@Override
	public void delete(Role t) {
		hibernateTemplate.delete(t);
	}
	@Override
	public Role find(String id) {
		return hibernateTemplate.get(Role.class, id);
	}
	@Override
	public Role findByName(String name) {
		List<Role> list = (List<Role>) hibernateTemplate.find("from Role where name='"+name+"'");
		if(list!=null&&list.size()>0){
			return list.get(0);
		}else
		return null;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Role> getAllRoles() {
		return (List<Role>) hibernateTemplate.find("from Role");
	}

}
