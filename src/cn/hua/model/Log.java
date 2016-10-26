package cn.hua.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import java.io.Serializable;
import java.util.Date;
@Entity
public class Log implements Serializable{
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
	private User user;
	@Id
	@GeneratedValue(generator="uuid")
	@GenericGenerator(name="uuid",strategy="uuid2")
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
	@OneToOne
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Log(){
		
	}
	public Log(String changeType,String changeIp, User user) {
		super();
		this.changeType = changeType;
		this.changeIp = changeIp;
		this.user = user;
	}
	
}
