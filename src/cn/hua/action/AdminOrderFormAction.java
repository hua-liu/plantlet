package cn.hua.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import cn.hua.annotation.Jurisdiction;
import cn.hua.formBean.Paging;
import cn.hua.model.OrderForm;
import cn.hua.model.State;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;

public class AdminOrderFormAction extends ActionSupport{
	/**
	 * 订单管理页处理
	 */
	private static final long serialVersionUID = 1L;
	private Service service;
	private int function=-1;
	private String id;
	private int stateId;
	private int once;
	private String result;
	private static String oldData="";
	public void setId(String id) {
		this.id = id;
	}
	public String getResult() {
		return result;
	}
	public void setStateId(int stateId) {
		this.stateId = stateId;
	}
	public void setOnce(int once) {
		this.once = once;
	}
	public void setFunction(int function) {
		this.function = function;
	}
	public void setService(Service service) {
		this.service = service;
	}
	@Jurisdiction("BackgroundLogin")
	public String execute(){
		User user = (User) ActionContext.getContext().getSession().get("user");
		if (user == null) {
			return INPUT;
		}
		//第一次访问时就重新new一个
		Paging paging = (Paging) ActionContext.getContext().getSession().get("paging");
		if(paging==null||function!=-1){
			paging = new Paging();
		}
		paging.setClassify(3);
		if(function!=-1){	//这里当菜单跳转时，设置function,当搜索时则不设置
			paging.setKeywords("");  //当切换菜单时，清空搜索值
			paging.setFunction(function);
		}
		ActionContext.getContext().getValueStack().push(paging);
		ActionContext.getContext().getSession().put("paging", paging);
		ServletActionContext.getRequest().setAttribute("permissions", service.getPermissions(user.getRole()));
		ServletActionContext.getRequest().setAttribute("list", service.getPagingData(paging,user.getId()));
		List<State> states = new ArrayList<State>();
		states.add(new State(8,"未付款"));
		states.add(new State(9,"已付款"));
		states.add(new State(10,"购物车"));
		states.add(new State(11,"已发货"));
		states.add(new State(12,"完成"));
		states.add(new State(13,"失败"));
		ServletActionContext.getRequest().setAttribute("orderFormStates",states);
		return SUCCESS;
	}
	@Jurisdiction("DeleteOrderForm")
	public String delete(){
		try{
			if(id==null){
				this.result = Conversion.stringToJson("message,false,cause,未获取到商品信息");
				return SUCCESS;
			}
			service.delOrderForm(id);
			this.result = Conversion.stringToJson("message,true");
		}catch(Exception e){
			this.result = Conversion.stringToJson("message,false,cause,服务器繁忙");
		}
		return SUCCESS;
	}
	@Jurisdiction("UpdateOrderForm")
	public String updateState(){
		if(id==null||stateId==0){
			this.result = Conversion.stringToJson("message,false,cause,未获取到订单信息");
			return SUCCESS;
		}
		try{
			OrderForm of = service.findOrderFormById(id);
			if(of==null){
				this.result = Conversion.stringToJson("message,false,cause,未获取到订单信息");
				return SUCCESS;
			}
			of.setState(new State(stateId));
			service.updateOrderForm(of);
			this.result = Conversion.stringToJson("message,true");
		}catch(Exception e){
			e.printStackTrace();
			this.result = Conversion.stringToJson("message,false,cause,服务器繁忙");
		}
		return SUCCESS;
	}
	//获取最新订单消息
		public String getNewMessage(){
			List<String> newOrderForm = service.getNewOrderFormNum();
			System.out.println(newOrderForm);
			int i=5;//用户循环请求最大次数
			while((oldData.equals(newOrderForm.toString())&&once!=1)||newOrderForm.size()==0){
				if(--i<1){//当次数达到5次时退出循环，并返回
					break;
				}
				try {
					Thread.sleep(30000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				newOrderForm = service.getNewOrderFormNum();//重新获取数据
				System.out.println(newOrderForm);
			}
			oldData = newOrderForm.toString();//赋给判断语句
			this.result=Conversion.stringToJson("message,true,num,"+newOrderForm.size());
			return SUCCESS;
		}
}
