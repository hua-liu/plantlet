package cn.hua.model;

import java.io.Serializable;
import java.util.Date;

public class Log implements Serializable,Comparable<Log>{
	/**
	 * 日志：更改类型，更改之前，更改之后，当前时间，更改IP，描述
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String changeType;
	private String changeBegin;
	private String changeAfter;
	private Date currentDate;
	private String changeIp;
	private String description;
	private String  userID;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getChangeType() {
		return changeType;
	}
	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}
	public String getChangeBegin() {
		return changeBegin;
	}
	public void setChangeBegin(String changeBegin) {
		this.changeBegin = changeBegin;
	}
	public String getChangeAfter() {
		return changeAfter;
	}
	public void setChangeAfter(String changeAfter) {
		this.changeAfter = changeAfter;
	}
	public Date getCurrentDate() {
		return currentDate;
	}
	public void setCurrentDate(Date currentDate) {
		this.currentDate = currentDate;
	}
	public String getChangeIp() {
		return changeIp;
	}
	public void setChangeIp(String changeIp) {
		this.changeIp = changeIp;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	@Override
	public int compareTo(Log o) {
		if(this.currentDate.getTime()<o.getCurrentDate().getTime()){
			return 1;
		}else
		return -1;
	}
	
}
