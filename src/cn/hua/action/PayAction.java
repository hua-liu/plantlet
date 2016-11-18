package cn.hua.action;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import cn.hua.model.Goods;
import cn.hua.model.Log;
import cn.hua.model.OrderForm;
import cn.hua.model.Safe;
import cn.hua.model.State;
import cn.hua.model.Takedelivery;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import cn.hua.utils.Encryption;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import edu.emory.mathcs.backport.java.util.Arrays;

public class PayAction extends ActionSupport{
	/**
	 * 支付处理
	 */
	private static final long serialVersionUID = 1L;
	private String[] id;
	private String[] leaveMessage;
	private int[] buyNum;
	private String addr;
	private double sumPrice;
	private String pp;
	private String result;
	private Service service;
	private String key;
	public void setKey(String key) {
		this.key = key;
	}
	public String getKey() {
		return key;
	}
	//protected static List<OrderForm> readlyOf;
	private static Map<String,List<OrderForm>> planPay = new HashMap<String,List<OrderForm>>();
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
		if(addr==null){
			this.addActionError("收货地址无效!!");
			return SUCCESS;
		}
		System.out.println(Arrays.toString(id));
		sumPrice=0;
		for(int i=0;i<id.length;i++){
			/*//这里使用多线程来处理,这里未知数太多，现在不处理
			OrderForm of = (OrderForm) ThreadPool.submit(new ThreadControl(this, "threadUpdate", new String[]{id[i],buyNum[i]+"",leaveMessage[i]}));*/
			OrderForm of = service.findOrderFormById(id[i]);
			if(of!=null){
				if(of.getState().getId()!=10){
					this.addActionError("订单已不存在于购物车中!!");
					return SUCCESS;
				}
				of.setBuyNum(buyNum[i]);
				of.setLeaveMessage(leaveMessage[i]);
				of.setState(new State(8));
				of.setTakedelivery(new Takedelivery(addr));
				if(of.getGoods().getInventory()<buyNum[i]){
					this.addActionError("商品库存已不足!!");
					return SUCCESS;
				}
				Goods goods = of.getGoods();
				goods.setInventory(goods.getInventory()-buyNum[i]);
				service.updateGoods(goods);
				service.updateOrderForm(of);
			}
			if(of==null){
				this.addActionError("订单已过期!!");
				return SUCCESS;
			}
			sumPrice += of.getBuyNum()*of.getGoods().getPrice();
			ofs.add(of);
		}
		ServletActionContext.getRequest().setAttribute("orderForms", ofs);
		ActionContext.getContext().getValueStack().push(sumPrice);
		key = UUID.randomUUID().toString();
		planPay.put(key, ofs);
		ActionContext.getContext().getValueStack().push(key);
		Timer timer = new Timer();	//设置一个定时器，2分钟后清楚数据
		timer.scheduleAtFixedRate(new TimerTask(){
			@Override
			public void run() {
				planPay.remove(key);
			}
			
		}, new Date(System.currentTimeMillis()+1000*120), 100);
		//readlyOf = ofs;
		return SUCCESS;
	}
	//进入支付界面
	/*
	 * 这里会有一个不断刷新就会添加付款订单问题，不想处理了
	 */
	public String goPayUi(){
		List<OrderForm> ofs = new ArrayList<OrderForm>();
		User user = (User) ActionContext.getContext().getSession().get("user");
		if(user==null)return INPUT;
		sumPrice=0;
		if(id.length<1){
			this.addActionError("订单已过期!!");
			return SUCCESS;
		}
		OrderForm of = service.findOrderFormById(id[0]);
		if(of!=null){
			if(of.getState().getId()!=8){
				this.addActionError("未付款订单中不存在该订单!!");
				return SUCCESS;
			}
		}
		if(of==null){
			this.addActionError("订单已过期!!");
			return SUCCESS;
		}
		sumPrice += of.getBuyNum()*of.getGoods().getPrice();
		ofs.add(of);
		ServletActionContext.getRequest().setAttribute("orderForms", ofs);
		ActionContext.getContext().getValueStack().push(sumPrice);
		key = UUID.randomUUID().toString();
		planPay.put(key, ofs);
		ActionContext.getContext().getValueStack().push(key);
		Timer timer = new Timer();	//设置一个定时器，2分钟后清楚数据
		timer.scheduleAtFixedRate(new TimerTask(){
			@Override
			public void run() {
				planPay.remove(key);
			}
			
		}, new Date(System.currentTimeMillis()+1000*120), 100);
		//readlyOf = ofs;
		return SUCCESS;
	}
	public String pay(){
		List<OrderForm> orderForms = planPay.get(key);
		if(orderForms==null||orderForms!=null&&orderForms.size()<1){
			this.result = Conversion.stringToJson("message,false,cause,订单已超时！！");
			return ERROR;
		}
		User user = (User) ActionContext.getContext().getSession().get("user");
		if(user!=null)user = service.findUserById(user.getId());
		if(user==null){
			return INPUT;
		}
		if(pp==null){
			this.result = Conversion.stringToJson("message,false,cause,密码错误!!");
			return ERROR;
		}
		if(user.getSafe().getPayPassword()==null){
			this.result = Conversion.stringToJson("message,false,cause,noPassword");
			return ERROR;
		}
		pp = Encryption.encryption(pp+user.getSafe().getId());
		if(pp.equals(user.getSafe().getPayPassword())){
			try{//这里其实可以使用个事务，但是呢，好麻烦的说
				Safe safe = user.getSafe();
				for(OrderForm of : orderForms){
					sumPrice +=of.getBuyNum()*of.getGoods().getPrice();
				}
				if(user.getSafe().getBalance()<sumPrice){
					this.result = Conversion.stringToJson("message,false,cause,您的余额已不足以支付当前订单!!");
					return ERROR;
				}
				safe.setBalance(user.getSafe().getBalance()-sumPrice);
				//service.updateSafe(safe);
				for(OrderForm of : orderForms){
					of.setState(new State(9));
					//service.updateOrderForm(of);
					service.pay(safe,of);
					sumPrice +=of.getBuyNum()*of.getGoods().getPrice();
				}
				planPay.remove(key);
				this.result = Conversion.stringToJson("message,true");
				ActionContext.getContext().getSession().put("user", user);
				return SUCCESS;
			}catch(Exception e){
				this.result = Conversion.stringToJson("message,false,cause,支付异常!!");
			}
			return ERROR;
		}
		this.result = Conversion.stringToJson("message,false,password,false,cause,密码错误!!");
		return ERROR;
	}
	/*public boolean checkRepeat(String id){
		Collection<List<OrderForm>> coll = planPay.values();
		for(List<OrderForm> list :planPay.values()){
			for(OrderForm of : list){
				if(of.getId().equals(id)){
					return false;
				}
			}
		}
		return true;
	}*/
	/*public Object threadUpdate(String[] args){
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
	}*/
}
