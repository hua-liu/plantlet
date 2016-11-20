package cn.hua.utils;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import cn.hua.model.Role;
import cn.hua.model.User;
import cn.hua.service.Service;
@Component
public class WhetherPermission {
	private static Service service;
	@Resource
	public void setService(Service service) {
		this.service = service;
	}
	/**
	 * 检查是否有权限<br/>
	 *map sessionMap用于获取user<br/>
	 *param 权限值，用于比对 */
	public static boolean isPass(Map<String, Object> map, int param){
		User user = (User) map.get("user");
		if(user==null){
			return false;
		}
		Role role = user.getRole();
		if(role==null){
			return false;
		}
		Map<Integer,String> permissions = service.getPermissions(role);
			if(permissions.get(param)==null){
				return false;
			}
		return true;
	}
}
