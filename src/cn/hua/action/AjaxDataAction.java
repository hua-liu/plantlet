package cn.hua.action;

import cn.hua.annotation.Jurisdiction;
import cn.hua.formBean.Paging;
import cn.hua.model.Permission;
import cn.hua.model.Role;
import cn.hua.model.User;
import cn.hua.service.Service;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AjaxDataAction extends ActionSupport implements ModelDriven<User> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Service service;
	private String likeStr;
	private int currentPage;
	private String result;
	private String[] member;
	private String roleId;
	private String id;
	private User user;
	private String roleName;
	private int level;
	private int[] permissions;

	public void setPermissions(int[] permissions) {
		this.permissions = permissions;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setMember(String[] member) {
		this.member = member;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getResult() {
		return result;
	}

	public void setLikeStr(String likeStr) {
		this.likeStr = likeStr;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public void setService(Service service) {
		this.service = service;
	}

	/**
	 * 获取无角色用户
	 * 需要后台登陆权限与查询用户权限
	 * @author 六画
	 * 
	 */
	@Jurisdiction({ "BackgroundLogin", "SelectUser" })
	public String getNoRoleUsers() {
		Paging paging = new Paging();
		paging.setCurrentPage(currentPage);
		paging.setSize(10);
		List<User> list = service.getNoRoleUsers(likeStr, paging);
		if (list != null) {
			this.result = "[{'totalPage':'" + paging.getTotalPage()
					+ "','totalNum':'" + paging.getTotalNum() + "'},";
			for (User user : list) {
				result += "{'username':"
						+ (user.getUsername() != null ? ("'"
								+ user.getUsername() + "'") : null)
						+ ",'email':"
						+ (user.getEmail() != null ? ("'" + user.getEmail() + "'")
								: null)
						+ ",'phone':"
						+ (user.getPhone() != null ? ("'" + user.getPhone() + "'")
								: null) + ",'id':'" + user.getId() + "'},";
			}
			result = result.substring(0, result.length() - 1) + "]";
			System.out.println(result);
		}
		return SUCCESS;
	}

	/**
	 * 更新用户角色
	 */
	@Jurisdiction({ "UpdateUser", "GiveJurisdiction", "CancelJurisdiction" })
	public String updateUserRole() {
		int loseNum = 0;
		int successNum = 0;
		if (member != null && member.length > 0 && roleId != null) {
			User user = (User) ActionContext.getContext().getSession()
					.get("user");
			if (user == null) {
				this.result = "{'message':" + false
						+ ",'cause':'"+getText("insufficientPermissions")+"(401)...'}";
				return SUCCESS;
			}
			Role role = service.findRoleById(roleId);
			if (role == null) {
				this.result = "{'message':" + false
						+ ",'cause':'"+getText("insufficientPermissions")+"(501)...'}";
				return SUCCESS;
			}
			for (int i = 0; i < member.length; i++) {
				System.out.println(member[i]);
				User memberUser = service.findUserById(member[i]);
				if (memberUser == null) {
					loseNum++;
				} else if (memberUser.getRole() != null
						&& memberUser.getRole().getLevel() < role.getLevel()) {
					loseNum++;
				} else if (memberUser.getRole() != null
						&& memberUser.getRole().getLevel() < user.getRole()
								.getLevel()) {
					loseNum++;
				} else if(role.getLevel()<user.getRole().getLevel()){
					loseNum++;
				}else {
					memberUser.setRole(new Role(roleId));
					service.updateUser(memberUser);
					successNum++;
				}
			}
			this.result = "{'message':" + true + ",'loseNum':" + loseNum
					+ ",'successNum':" + successNum + "}";
		}
		return SUCCESS;
	}

	/**
	 * 更新用户权限
	 */
	@Jurisdiction({ "UpdateUser", "GiveRole", "CancelRole" })
	public String updateUser() {
		User madeUser = (User) ActionContext.getContext().getSession()
				.get("user");
		if (madeUser == null) {
			this.result = "{'message':" + false + ",'cause':'"+getText("insufficientPermissions")+"(401)...'}";
			return SUCCESS;
		}
		if (user == null) {
			this.result = "{'message':" + false + ",'cause':'"+getText("networkError")+"(601)...'}";
			return SUCCESS;
		}
		Role role = service.findRoleById(roleId);
		if (role == null) {
			this.result = "{'message':" + false + ",'cause':'"+getText("insufficientPermissions")+"(501)...'}";
			return SUCCESS;
		}
		if (user.getRole() == null) {
			if (roleId.equals("0")) {
				this.result = "{'message':" + true + "}";
				return SUCCESS;
			} else if (madeUser.getRole().getLevel() > role.getLevel()) {
				this.result = "{'message':" + false
						+ ",'cause':'"+getText("insufficientPermissions")+"(502)...'}";
				return SUCCESS;
			} else {
				user.setRole(new Role(roleId));
				service.updateUser(user);
				this.result = "{'message':" + true + "}";
				return SUCCESS;
			}
		}
		if (madeUser.getRole().getLevel() >= user.getRole().getLevel()) {
			this.result = "{'message':" + false + ",'cause':'"+getText("insufficientPermissions")+"(503)...'}";
			return SUCCESS;
		}
		if (roleId.equals("0")) {
			user.setRole(null);
		} else
			user.setRole(new Role(roleId));
		try {
			service.updateUser(user);
		} catch (Exception e) {
			this.result = "{'message':" + false + ",'cause':'"+getText("AnUnknownError")+"(101)...'}";
			return SUCCESS;
		}
		this.result = "{'message':" + true + "}";
		return SUCCESS;
	}

	/**
	 * 删除用户角色
	 */
	@Jurisdiction({ "UpdateUser", "CancelRole" })
	public String deleteUserRole() {
		User madeUser = (User) ActionContext.getContext().getSession()
				.get("user");
		if (madeUser == null) {
			this.result = "{'message':" + false + ",'cause':'"+getText("insufficientPermissions")+"(401)...'}";
			return SUCCESS;
		}
		if (user == null) {
			this.result = "{'message':" + false + ",'cause':'"+getText("networkError")+"(601）...'}";
			return SUCCESS;
		}
		if (user.getRole() == null) {
			this.result = "{'message':" + true + "}";
			return SUCCESS;
		}
		if (madeUser.getRole().getLevel() >= user.getRole().getLevel()) {
			this.result = "{'message':" + false + ",'cause':'"+getText("insufficientPermissions")+"(503)...'}";
			return SUCCESS;
		}
		user.setRole(null);
		try {
			service.updateUser(user);
		} catch (Exception e) {
			this.result = "{'message':" + false + ",'cause':'"+getText("AnUnknownError")+"(101)...'}";
			return SUCCESS;
		}
		this.result = "{'message':" + true + "}";
		return SUCCESS;
	}

	/**
	 * 删除角色
	 */
	@Jurisdiction("DeleteRole")
	public String deleteRole() {
		User madeUser = (User) ActionContext.getContext().getSession()
				.get("user");
		if (roleId == null) {
			this.result = "{'message':" + false + ",'cause':'"+getText("networkError")+"(701)...'}";
			return SUCCESS;
		}
		Role role = service.findRoleById(roleId);
		if (role == null) {
			this.result = "{'message':" + false + ",'cause':'"+getText("insufficientPermissions")+"(501)...'}";
			return SUCCESS;
		}
		if (madeUser.getRole().getLevel() >= role.getLevel()) {
			this.result = "{'message':" + false + ",'cause':'"+getText("insufficientPermissions")+"(502)...'}";
			return SUCCESS;
		}
		try {
			service.deleteRole(roleId);
		} catch (Exception e) {
			this.result = "{'message':" + false + ",'cause':'"+getText("AnUnknownError")+"(102)...'}";
			return SUCCESS;
		}
		this.result = "{'message':" + true + "}";
		return SUCCESS;
	}

	/**
	 * 验证角色名是否已存在
	 */
	public String verifyRoleName() {
		if (roleName == null)
			return SUCCESS;
		if (roleName.equals("") || roleName.trim().equals(""))
			return SUCCESS;
		Role role = service.findRoleByName(roleName);
		if (role == null) {
			this.result = "{'message':" + true + "}";
		} else
			this.result = "{'message':" + false + "}";
		return SUCCESS;
	}
/**
 * 添加角色
 */
	@Jurisdiction("AddRole")
	public String addRole() {
		if (roleName == null && member.length < 0) {
			this.result = "{'message':" + false + ",'cause':'"+getText("networkError")+"(701)...'}";
			return SUCCESS;
		}
		Pattern pattern = Pattern
				.compile("[`~!@#$%^&&*()_|=+-<>?:“：｜｛｝《》？。，、＇＼［］）×（＊＆＾％＄#＠！￣｀{},.\"/;']+");
		Matcher matcher = pattern.matcher(roleName);
		if (matcher.find()) {
			this.result = "{'message':" + false + ",'cause':'"+getText("roleName")+getText("formatError")+"...'}";
			return SUCCESS;
		}
		User madeUser = (User) ActionContext.getContext().getSession()
				.get("user");
		if (madeUser == null) {
			this.result = "{'message':" + false + ",'cause':'"+getText("insufficientPermissions")+"(501)...'}";
			return SUCCESS;
		}
		Role role = service.findRoleByName(roleName);
		if (role != null) {
			this.result = "{'message':" + false + ",'cause':'"+getText("roleNameUsed")+"...'}";
			return SUCCESS;
		}
		level = madeUser.getRole().getLevel() + level * 10;
		role = new Role(level, madeUser.getRole().getLevel(), roleName);
		for (int i = 0; i < permissions.length; i++) {
			boolean isPass = false;	
			for(Permission p : madeUser.getRole().getPermissions()){
				if(p.getId()==permissions[i]){
					isPass = true;break;
				}
			}
			if(!isPass){
				this.result = "{'message':" + false + ",'cause':'"+getText("notCanGiveJurisdiction")+"(504)...'}";
				return SUCCESS;
			}
			Permission permission = service.findPermissionById(permissions[i]);
			role.getPermissions().add(permission);
		}
		try {
			service.addRole(role);
			this.result = "{'message':" + true + "}";
			return SUCCESS;
		} catch (Exception e) {
			this.result = "{'message':" + false + ",'cause':'"+getText("AnUnknownError")+"(103)...'}";
			return SUCCESS;
		}
	}

	// 更改角色
	@Jurisdiction({ "UpdateRole", "GiveJurisdiction", "CancelJurisdiction" })
	public String updateRole() {
		if (roleId == null) {
			this.result = "{'message':" + false + ",'cause':'"+getText("networkError")+"(701)...'}";
			return SUCCESS;
		}
		User madeUser = (User) ActionContext.getContext().getSession()
				.get("user");
		if (madeUser == null) {
			this.result = "{'message':" + false + ",'cause':'"+getText("insufficientPermissions")+"(401)...'}";
			return SUCCESS;
		}
		Role role = service.findRoleById(roleId);
		if (role == null) {
			this.result = "{'message':" + false + ",'cause':'"+getText("notFoundRole")+"(501)...'}";
			return SUCCESS;
		}
		if (madeUser.getRole().getLevel() >= role.getLevel()) {
			this.result = "{'message':" + false + ",'cause':'"+getText("insufficientPermissions")+"(502)...'}";
			return SUCCESS;
		}
		level = madeUser.getRole().getLevel() + level * 10;
		role.setLevel(level);
		role.setParentLevel(madeUser.getRole().getLevel());
		role.getPermissions().clear();	//将当前List集合清空，如不清空则会在原有的基础加上现有的
		for (int i = 0; i < permissions.length; i++) {
			boolean isPass = false;	
			for(Permission p : madeUser.getRole().getPermissions()){
				if(p.getId()==permissions[i]){
					isPass = true;break;
				}
			}
			if(!isPass){
				this.result = "{'message':" + false + ",'cause':'"+getText("notCanGiveJurisdiction")+"(504)...'}";
				return SUCCESS;
			}
			Permission permission = service.findPermissionById(permissions[i]);
			if (permission != null)
				role.getPermissions().add(permission);
		}
		try {
			service.updateRole(role);
			this.result = "{'message':" + true + "}";
			return SUCCESS;
		} catch (Exception e) {
			this.result = "{'message':" + false + ",'cause':'"+getText("AnUnknownError")+"(101)...'}";
			return SUCCESS;
		}
	}

	@Override
	public User getModel() {
		if (id != null && !id.trim().equals("")) {
			User tempUser = service.findUserById(id);
			if (tempUser != null) {
				user = tempUser;
				return user;
			}
		}
		user = new User();
		return user;
	}
}
