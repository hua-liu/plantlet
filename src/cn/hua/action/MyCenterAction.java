package cn.hua.action;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import cn.hua.formBean.Paging;
import cn.hua.model.Log;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.GetI18nConfig;
import cn.hua.utils.Logging;
import cn.hua.utils.MessageOperation;

import com.opensymphony.xwork2.ActionContext;

public class MyCenterAction{
	private Service service;
	private String result;
	private int function;
	private Log log;
	public Log getLog() {
		return log;
	}
	public void setFunction(int function) {
		this.function = function;
	}
	public int getFunction() {
		return function;
	}
	public String getResult() {
		return result;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public String execute(){
		Map<String, Object> session = ActionContext.getContext().getSession();
		User user = (User)session.get("user");
		if(user==null)return "input";
		user = service.findUserById(user.getId());
		if(user==null)return "input";
		session.put("user", user);
		log = (Log) session.get("log");
		if(log==null){
			List<Log> logs = Logging.read("login", user.getId());
			if(logs!=null&&logs.size()>1){
				Collections.sort(logs);
				log = logs.get(1);
				ActionContext.getContext().getSession().put("log", log);
			}
		}
		//js国际化文件
		new GetI18nConfig(ActionContext.getContext()).start();
		return "success";
	}
	public String myInfo(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		//ModifyUser mu = new Conversion<ModifyUser,User>().beanToBean(new ModifyUser(), user);
		ActionContext.getContext().getValueStack().push(user);
		return "success";
	}
	public String myOrderForm(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		//第一次访问时就重新new一个
		Paging paging = new Paging();
		paging.setClassify(3);
		paging.setFunction(0);
		paging.setSize(1000);
		ServletActionContext.getRequest().setAttribute("orderForms", service.getAllOrderFormByUserId(user.getId()));
		return "success";
	}
	public String myMoney(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		ActionContext.getContext().getValueStack().push(user);
		List<Log> logs = Logging.read("pay",user.getId());
		ServletActionContext.getRequest().setAttribute("logs", logs);
		return "success";
	}
	public String myDeliveryAddr(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		ServletActionContext.getRequest().setAttribute("addrs",service.getTakedeliverysByUserId(user.getId()));
		return "success";
	}
	public String myMessage(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		ServletActionContext.getRequest().setAttribute("messages",MessageOperation.read(user.getId()));
		return "success";
	}
	public String mySafe(){
		return "success";
	}
}
