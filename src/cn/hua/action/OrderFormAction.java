package cn.hua.action;

import cn.hua.model.OrderForm;
import cn.hua.model.State;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import cn.hua.utils.Verification;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class OrderFormAction extends ActionSupport implements ModelDriven<OrderForm>{
	/**
	 * 订单管理
	 */
	private static final long serialVersionUID = 1L;
	private OrderForm orderForm;
	private String result;
	private Service service;
	public void setService(Service service) {
		this.service = service;
	}
	public String getResult() {
		return result;
	}
	public OrderForm getOrderForm() {
		return orderForm;
	}

	public void setOrderForm(OrderForm orderForm) {
		this.orderForm = orderForm;
	}
	public String add(){
		try{
			String error[] = Verification.orderForm(this,orderForm);
			if(error!=null&&error.length>0){
				this.result = Conversion.stringToJson("message,false,cause,"+error[0]);
				return SUCCESS;
			}
			User user = (User) ActionContext.getContext().getSession().get("user");
			orderForm.setUser(user);
			orderForm.setState(new State(10));
			service.addOrderForm(orderForm);
			this.result = Conversion.stringToJson("message,true,id,"+orderForm.getId());
		}catch(Exception e){
			e.printStackTrace();
			this.result = Conversion.stringToJson("message,false,cause,"+getText("dbException"));
		}
		return SUCCESS;
	}
	public String delete(){
		try{
			if(orderForm==null||orderForm!=null&&orderForm.getId()==null){
				this.result = Conversion.stringToJson("message,false,cause,"+getText("noGetData"));
				return SUCCESS;
			}
			service.delOrderForm(orderForm.getId());
			this.result = Conversion.stringToJson("message,true");
		}catch(Exception e){
			this.result = Conversion.stringToJson("message,false,cause,"+getText("dbException"));
		}
		return SUCCESS;
	}
	//清空购物车
	public String clearAll(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		try{
			if(user!=null)
			service.clearAllSoppingCart(user.getId());
			this.result = Conversion.stringToJson("message,true");
			return "success";
		}catch(Exception e){
			e.printStackTrace();
		}
		this.result = Conversion.stringToJson("message,false");
		return "success";
	}
	public String update(){
		try{
			String error[] = Verification.orderForm(this,orderForm);
			if(error.length>0){
				this.result = Conversion.stringToJson("message,false,cause,"+error[0]);
				return SUCCESS;
			}
			service.updateOrderForm(orderForm);
			this.result = Conversion.stringToJson("message,true");
		}catch(Exception e){
			e.printStackTrace();
			this.result = Conversion.stringToJson("message,false,cause,"+getText("dbException"));
		}
		return SUCCESS;
	}
	@Override
	public OrderForm getModel() {
		this.orderForm = new OrderForm();
		return this.orderForm;
	}
}
