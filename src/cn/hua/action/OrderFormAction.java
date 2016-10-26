package cn.hua.action;

import java.util.List;

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
			String error[] = Verification.orderForm(orderForm);
			if(error!=null&&error.length>0){
				this.result = Conversion.stringToJson("message,false,cause,"+error[0]);
				return SUCCESS;
			}
			User user = (User) ActionContext.getContext().getSession().get("user");
			orderForm.setUser(user);
			orderForm.setState(new State(10));
			service.addOrderForm(orderForm);
			this.result = Conversion.stringToJson("message,true");
		}catch(Exception e){
			e.printStackTrace();
			this.result = Conversion.stringToJson("message,false,cause,服务器繁忙");
		}
		return SUCCESS;
	}
	public String delete(){
		try{
			if(orderForm==null||orderForm!=null&&orderForm.getId()==null){
				this.result = Conversion.stringToJson("message,false,cause,未获取到商品信息");
				return SUCCESS;
			}
			service.delOrderForm(orderForm.getId());
			this.result = Conversion.stringToJson("message,true");
		}catch(Exception e){
			this.result = Conversion.stringToJson("message,false,cause,服务器繁忙");
		}
		return SUCCESS;
	}
	public String update(){
		try{
			String error[] = Verification.orderForm(orderForm);
			if(error.length>0){
				this.result = Conversion.stringToJson("message,false,cause,"+error[0]);
				return SUCCESS;
			}
			service.updateOrderForm(orderForm);
			this.result = Conversion.stringToJson("message,true");
		}catch(Exception e){
			e.printStackTrace();
			this.result = Conversion.stringToJson("message,false,cause,服务器繁忙");
		}
		return SUCCESS;
	}
	public String get(){
		
		return SUCCESS;
	}
	@Override
	public OrderForm getModel() {
		this.orderForm = new OrderForm();
		return this.orderForm;
	}
}
