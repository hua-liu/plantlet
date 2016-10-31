package cn.hua.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.components.ActionError;
import org.apache.struts2.components.FieldError;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import cn.hua.model.OrderForm;
import cn.hua.model.Safe;
import cn.hua.model.State;
import cn.hua.model.Takedelivery;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import cn.hua.utils.ThreadControl;
import cn.hua.utils.ThreadPool;

public class PayAction extends ActionSupport{
	/**
	 * 支付处理
	 */
	private static final long serialVersionUID = 1L;
	private String[] id;
	private String[] leaveMessage;
	private int[] buyNum;
	private String addr;
	protected static double sumPrice;
	private String pp;
	private String result;
	private Service service;
	protected static List<OrderForm> readlyOf;
	public String getResult() {
		return result;
	}
	public void setPp(String pp) {
		this.pp = pp;
	}
	public double getSumPrice() {
		return sumPrice;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public void setId(String[] id) {
		this.id = id;
	}
	public void setLeaveMessage(String[] leaveMessage) {
		this.leaveMessage = leaveMessage;
	}
	public void setBuyNum(int[] buyNum) {
		this.buyNum = buyNum;
	}
	//进入支付界面
	public String payUi(){
		List<OrderForm> ofs = new ArrayList<OrderForm>();
		User user = (User) ActionContext.getContext().getSession().get("user");
		if(user==null)return INPUT;
		sumPrice=0;
		for(int i=0;i<id.length;i++){
			//这里使用多线程来处理,这里未知数太多，现在不处理
			OrderForm of = (OrderForm) ThreadPool.submit(new ThreadControl(this, "threadUpdate", new String[]{id[i],buyNum[i]+"",leaveMessage[i]}));
			if(of==null){
				this.addActionError("订单已过期!!");
				return SUCCESS;
			}
			sumPrice += of.getBuyNum()*of.getGoods().getPrice();
			ofs.add(of);
		}
		ServletActionContext.getRequest().setAttribute("orderForms", ofs);
		ActionContext.getContext().getValueStack().push(sumPrice);
		readlyOf = ofs;
		Timer timer = new Timer();	//设置一个定时器，2分钟后清楚数据
		timer.scheduleAtFixedRate(new TimerTask(){
			@Override
			public void run() {
				sumPrice = 0;
				readlyOf.clear();
			}
			
		}, new Date(System.currentTimeMillis()+1000*120), 100);
		//readlyOf = ofs;
		return SUCCESS;
	}
	public String pay(){
		if(readlyOf==null||readlyOf!=null&&readlyOf.size()<1){
			this.result = Conversion.stringToJson("message,false,cause,订单已超时！！");
			return SUCCESS;
		}
		User user = (User) ActionContext.getContext().getSession().get("user");
		if(user!=null)user = service.findUserById(user.getId());
		if(user==null){
			return INPUT;
		}
		if(pp==null){
			this.result = Conversion.stringToJson("message,false,cause,密码错误!!");
			return SUCCESS;
		}
		if(user.getSafe().getPayPassword()==null){
			this.result = Conversion.stringToJson("message,false,cause,noPassword");
			return SUCCESS;
		}
		if(pp.equals(user.getSafe().getPayPassword())){
			try{//这里其实可以使用个事务，但是呢，好麻烦的说
				Safe safe = user.getSafe();
				safe.setBalance(user.getSafe().getBalance()-sumPrice);
				service.updateSafe(safe);
				for(OrderForm of : readlyOf){
					of.setState(new State(9));
					service.updateOrderForm(of);
				}
				this.result = Conversion.stringToJson("message,true");
				sumPrice = 0;
				readlyOf.clear();
			}catch(Exception e){
				this.result = Conversion.stringToJson("message,false,cause,支付异常!!");
			}
			return SUCCESS;
		}
		this.result = Conversion.stringToJson("message,false,password,false,cause,密码错误!!");
		return SUCCESS;
	}
	public Object threadUpdate(String[] args){
		OrderForm of = service.findOrderFormById(args[0]);
		if(of!=null){
			if(of.getState().getId()!=10)return null;
			of.setBuyNum(Integer.parseInt(args[1]));
			of.setLeaveMessage(args[2]);
			of.setState(new State(8));
			of.setTakedelivery(new Takedelivery(addr));
			service.updateOrderForm(of);
			return of;
		}
		return null;
	}
}
