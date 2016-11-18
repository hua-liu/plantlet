package cn.hua.action;

import org.apache.struts2.ServletActionContext;

import cn.hua.formBean.ModifyUser;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import cn.hua.utils.Encryption;
import cn.hua.utils.Verification;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class UserMoreInfoModify implements ModelDriven<User>{
	private String onlyNickname;
	private Service service;
	private String result;
	private String type;
	private String oldData;
	private String oldData2;
	private String newData;
	private User user;
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getResult() {
		return result;
	}
	public void setOnlyNickname(String onlyNickname) {
		this.onlyNickname = onlyNickname;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public void setType(String type) {
		this.type = type;
	}
	public void setOldData(String oldData) {
		this.oldData = oldData;
	}
	public void setOldData2(String oldData2) {
		this.oldData2 = oldData2;
	}
	public void setNewData(String newData) {
		this.newData = newData;
	}
	public String modifyNickname(){
		if(onlyNickname==null)return "input";
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		if(user.getId().equals("")&&user.getId().trim().equals(""))return "input";
		try{
			service.updateUserNickname(user.getId(), onlyNickname);
			this.result = Conversion.stringToJson("message,true");
			user.setNickname(onlyNickname);
			ActionContext.getContext().getSession().put("user", user);
		}catch(Exception e){
			e.printStackTrace();
			this.result = Conversion.stringToJson("message,false,cause,数据库异常");
		}
		return "success";
	}
	public String myOrderForm(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		ServletActionContext.getRequest().setAttribute("orderForms",service.getOrderFormByUserId(user.getId()));
		return "success";
	}
	//安全设置
	public String mySafe(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		try{
			user = service.findUserById(user.getId());
			if(user==null)return "input";
			String[] errors = Verification.myCenterSafe(type, oldData, oldData2, newData, user);
			if(errors!=null&&errors.length>0){
				String error="";
				for(int i=0;i<errors.length;i++){
					if(errors[i]==null)continue;
					if(i==errors.length-1){
						error += errors[i];
					}else
					error += errors[i]+",";
				}
				this.result = Conversion.stringToJson("message,false,"+error);
				return "success";
			}
			if("phone".equals(type)){
				user.setPhone(newData);
			}else if("email".equals(type)){
				user.setEmail(newData);
			}else if("loginPassword".equals(type)){
				user.getSafe().setLoginPassword(Encryption.encryption(newData+user.getSafe().getId()));
			}else if("payPassword".equals(type)){
				user.getSafe().setPayPassword(Encryption.encryption(newData+user.getSafe().getId()));
			}
			service.updateUser(user);
			this.result = Conversion.stringToJson("message,true");
			ActionContext.getContext().getSession().put("user", user);
		}catch(Exception e){
			if(e.getCause().getCause().toString().indexOf("unique constraint")!=-1){
				this.result=Conversion.stringToJson("message,false,new"+(char)(type.charAt(0)-32)+type.substring(1)+",已经被使用，换个吧");
			}else
			this.result=Conversion.stringToJson("message,false,cause,数据库异常");
		}
		return "success";
	}
	public String myInfo(){
		if(user==null){
			this.result = Conversion.stringToJson("message,false,cause,未获取到相关信息");
			return "success";
		}
		String[] error = Verification.myCenterInfo(user);
		if(error!=null&&error.length>0){
			this.result = Conversion.stringToJson("message,false,cause,"+error[0]);
			return "success";
		}
		try{
			service.updateUser(user);
			ActionContext.getContext().getSession().put("user", user);
			this.result = Conversion.stringToJson("message,true");
		}catch(Exception e){
			this.result = Conversion.stringToJson("message,false,cause,未知异常");
		}
		return "success";
	}
	@Override
	public User getModel() {
		user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return null;
		user = service.findUserById(user.getId());
		return user;
	}
}
