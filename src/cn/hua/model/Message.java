package cn.hua.model;

import java.io.Serializable;
import java.util.Date;
public class Message implements Serializable,Comparable<Message>{
	/**
	 * 消息：发送时间，是否查看，发送者ID，发送者名字，接收者ID
	 * 	 */
	private static final long serialVersionUID = 1L;
	private Date sendDate;
	private int isNew;
	private String sendID;
	private String sendName;
	private String receiveID;
	private String content;
	private String id;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getSendDate() {
		return sendDate;
	}
	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	public int getIsNew() {
		return isNew;
	}
	public void setIsNew(int isNew) {
		this.isNew = isNew;
	}
	public String getSendID() {
		return sendID;
	}
	public void setSendID(String sendID) {
		this.sendID = sendID;
	}
	public String getSendName() {
		return sendName;
	}
	public void setSendName(String sendName) {
		this.sendName = sendName;
	}
	public void setReceiveID(String receiveID) {
		this.receiveID = receiveID;
	}
	public String getReceiveID() {
		return receiveID;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public int compareTo(Message o) {
		if(this.sendDate.getTime()<o.getSendDate().getTime()){
			return 1;
		}else
		return -1;
	}
	
}
