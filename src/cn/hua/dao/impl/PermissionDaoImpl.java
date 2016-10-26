package cn.hua.dao.impl;

import cn.hua.dao.PermissionDao;
import cn.hua.model.Permission;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;
@Component
public class PermissionDaoImpl implements PermissionDao{
	private HibernateTemplate hibernateTemplate;

	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	@Override
	public void save(Permission t) {
		hibernateTemplate.save(t);
	}

	@Override
	public void update(Permission t) {
		hibernateTemplate.update(t);
	}

	@Override
	public void delete(Permission t) {
		hibernateTemplate.delete(t);
	}

	@Override
	public Permission find(String id) {
		return hibernateTemplate.get(Permission.class, id);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Permission> getPermissions() {
		return (List<Permission>) hibernateTemplate.find("from Permission");
	}
	@Override
	public Permission findByName(String name) {
		List<?> list = hibernateTemplate.find("from Permission where name='"+name+"'");
		if(list!=null&&list.size()>0){
			return (Permission) list.get(0);
		}
		return null;
	}
	@Override
	public Permission findById(int id) {
		return hibernateTemplate.get(Permission.class, id);
	}
}
