package cn.hua.action;

import java.util.Date;
import java.util.UUID;

import cn.hua.model.Message;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import cn.hua.utils.MessageOperation;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class MyMessageAction extends ActionSupport implements ModelDriven<Message>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Message message;
	private String result;
	private Service service;
	private String username;
	private String[] ids;
	public void setIds(String[] ids) {
		this.ids = ids;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public String getResult() {
		return result;
	}
	public Message getMessage() {
		return message;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public void setMessage(Message message) {
		this.message = message;
	}
	public String send(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		if(message==null){
			this.result = Conversion.stringToJson("message,false,cause,"+getText("noGetData"));
			return "error";
		}
		if(message.getReceiveID()==null||message.getContent()==null){
			this.result = Conversion.stringToJson("message,false,cause,"+getText("infoFIllNoFull"));
			return "error";
		}
		if(service.findUserById(message.getReceiveID())==null){
			this.result = Conversion.stringToJson("message,false,cause,"+getText("receiveNoExist"));
			return "error";
		}
		message.setSendID(user.getId());
		message.setSendName(user.getNickname()!=null?user.getNickname():user.getUsername()!=null?user.getUsername():user.getPhone());
		message.setSendDate(new Date());
		message.setId(UUID.randomUUID().toString());
		message.setContent(Conversion.filter(message.getContent()));
		if(MessageOperation.save(message)){
			this.result = Conversion.stringToJson("message,true");
			return "success";
		}else{
			this.result = Conversion.stringToJson("message,false,"+getText("fileSysError"));
			return "error";
		}
	}
	public String isHasNewMessage(){
		User user = (User)ActionContext.getContext().getSession().get("user");
		if(user==null)return "input";
		if(MessageOperation.readNew(user.getId())){
			this.result = Conversion.stringToJson("message,true");
		}else
			this.result = Conversion.stringToJson("message,false");
		return "success";
	}
	public String checkIsExist(){
		User my = (User)ActionContext.getContext().getSession().get("user");
		if(my==null)return "input";
		User user = service.findAccount(username);
		if(user==null){
			this.result=Conversion.stringToJson("message,false");
		}else{
			if(my.getId().equals(user.getId())){
				this.result=Conversion.stringToJson("message,false,cause,"+getText("noSendSelf"));
			}else
			this.result=Conversion.stringToJson("message,true,id,"+user.getId());
		}
		return "success";
	}
	public String selected(){
		if(ids.length<1)return "success";
		User my = (User)ActionContext.getContext().getSession().get("user");
		if(my==null)return "input";
		MessageOperation.readed(my.getId(),ids);
		return "success";
	}
	public String delete(){
		if(ids.length<1)return "success";
		User my = (User)ActionContext.getContext().getSession().get("user");
		if(my==null)return "input";
		if(MessageOperation.delete(my.getId(),ids)){
			this.result=Conversion.stringToJson("message,true");
		}else
			this.result=Conversion.stringToJson("message,false");
		
		return "success";
	}
	@Override
	public Message getModel() {
		message = new Message();
		return message;
	}
}
