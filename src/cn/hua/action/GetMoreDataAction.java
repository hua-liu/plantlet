package cn.hua.action;

import cn.hua.model.Permission;
import cn.hua.model.Role;
import cn.hua.service.Service;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.SessionAware;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GetMoreDataAction extends ActionSupport implements SessionAware {
	/**
	 * 用户AJAX获取用户，角色更多信息
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private Map<String, Object> session;
	private Service service;
	private String result;
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setService(Service service) {
		this.service = service;
	}
	/**
	 * 获取用户的更多信息
	 * @return
	 */
	public String user() {
		if (session.get("user") != null) { // 此处简单判断是否登陆，以后加入权限再判断是否有权限
			Map<String, Object> map = service.findUserMoreData(id);
			if (map != null) {
				ObjectMapper mapper = new ObjectMapper();
				try {
					this.result = mapper.writeValueAsString(map);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				System.out.println(result);
			}
		}
		return SUCCESS;
	}
	/**
	 * 获取角色的更多信息
	 * @return
	 */
	public String role() {
		if (session.get("user") != null) { // 此处简单判断是否登陆，以后加入权限再判断是否有权限
			Role role = service.findRoleById(id);
			if (role != null) {
				Map<String, Object> map = new HashMap<String, Object>();
				BeanInfo beanInfo;
				try {
					beanInfo = Introspector.getBeanInfo(role.getClass(),	//通过内省获取到类信息
							Object.class);
					PropertyDescriptor[] propertyDescriptors = beanInfo		//通过类信息获取到属性
							.getPropertyDescriptors();
					for (PropertyDescriptor descriptor : propertyDescriptors) {	//遍历属性
						Method getMethod = descriptor.getReadMethod();	//获取get方法
						String methodName = getMethod.getName();	//获取方法名字
						Method method = role.getClass().getDeclaredMethod(	//获取指定方法
								methodName);
						method.setAccessible(true);	//设置私有可访问
						Object object = method.invoke(role, new Object[] {}); //调用方法
						if (methodName.equals("getPermissions")) {
							@SuppressWarnings("unchecked")	//压制警告
							List<Permission> list = (List<Permission>) object;
							String permissions = "";
							for (Permission permission : list) {
								permissions = permissions + permission.getId()
										+ ",";
							}
							map.put(descriptor.getName(), permissions);
						} else {
							map.put(descriptor.getName(), object);
						}
					}
				} catch (Exception e1) {
					throw new RuntimeException();
				}
				if (map != null) {
					ObjectMapper mapper = new ObjectMapper();
					try {
						this.result = mapper.writeValueAsString(map);
					} catch (JsonProcessingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					System.out.println(result);
				}
			}
		}
		return SUCCESS;
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}
}
