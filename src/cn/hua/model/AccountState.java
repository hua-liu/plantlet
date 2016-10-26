package cn.hua.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import java.io.Serializable;

@Entity
public class AccountState implements Serializable{
	/**
	 * 账号状态：手机状态，邮箱状态，身份状态
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int phoneState;
	private int emailState;
	private int identityState;
	private User user;
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPhoneState() {
		return phoneState;
	}
	public void setPhoneState(int phoneState) {
		this.phoneState = phoneState;
	}
	public int getEmailState() {
		return emailState;
	}
	public void setEmailState(int emailState) {
		this.emailState = emailState;
	}
	public int getIdentityState() {
		return identityState;
	}
	public void setIdentityState(int identityState) {
		this.identityState = identityState;
	}
	@OneToOne
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
}
