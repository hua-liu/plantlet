package cn.hua.action;

import cn.hua.model.Takedelivery;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import cn.hua.utils.Verification;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class AddressAction extends ActionSupport implements ModelDriven<Takedelivery>{
	/**
	 * 收货地址管理
	 */
	private static final long serialVersionUID = 1L;
	private Takedelivery take = new Takedelivery();
	private String result;
	private Service service;
	public void setService(Service service) {
		this.service = service;
	}
	public String getResult() {
		return result;
	}
	public Takedelivery getTake() {
		return take;
	}

	public void setTake(Takedelivery take) {
		this.take = take;
	}
	public String add(){
		try{
			String[] error = Verification.address(this,take);
			if(error!=null&&error.length>0){
				this.result = Conversion.stringToJson("message,false,cause,"+error[0]);
				return SUCCESS;
			}
			User user = (User) ActionContext.getContext().getSession().get("user");
			if(user==null){
				return INPUT;
			}
			take.setUser(user);
			if(take.getId()!=null&&!take.getId().trim().equals("")){
				service.updateTakedelivery(take);
			}else{
				service.saveTakedelivery(take);
			}
			this.result = Conversion.stringToJson("message,true,id,"+take.getId());
		}catch(Exception e){
			this.result = Conversion.stringToJson("message,false,cause,无法添加到数据库");
		}
		return SUCCESS;
	}
	public String get(){
		if(take==null||take!=null&&take.getId()==null){
			this.result = Conversion.stringToJson("message,false,cause,没有获取到地址信息");
			return SUCCESS;
		}
		try{
			take = service.getTakedeliveryById(take.getId());
			if(take==null){
				this.result = Conversion.stringToJson("message,false,cause,没有获取到地址信息");
				return SUCCESS;
			}
			this.result =Conversion.stringToJson("message,true,id,"+take.getId()+",address,"+take.getAddress()+",moreAddress,"+
					take.getMoreAddress()+",name,"+take.getName()+",postcode,"+take.getPostcode()+
					",phone,"+take.getPhone()+",telephone,"+take.getTelephone());
		}catch(Exception e){
			this.result = Conversion.stringToJson("message,false,cause,数据库异常");
		}
		return SUCCESS;
	}
	//删除收货地址
	public String delete(){
		if(take==null||take!=null&&take.getId()==null){
			this.result = Conversion.stringToJson("message,false,cause,没有获取到地址信息");
			return SUCCESS;
		}
		try{
			service.deleteTakedelivery(take);
			this.result = Conversion.stringToJson("message,true");
		}catch(Exception e){
			try{
				take = service.getTakedeliveryById(take.getId());
				take.setUser(null);
				service.updateTakedelivery(take);
				this.result = Conversion.stringToJson("message,true");
			}catch(Exception e1){
				e.printStackTrace();
				this.result = Conversion.stringToJson("message,false,cause,数据库异常");
			}
		}
		return SUCCESS;
	}
	@Override
	public Takedelivery getModel() {
		take = new Takedelivery();
		return take;
	}
	
}
