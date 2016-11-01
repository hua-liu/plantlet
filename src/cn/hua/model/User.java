package cn.hua.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

import java.io.Serializable;
import java.util.Date;
@Entity
@Table(name="kjuser")
@Cacheable
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE,region="org.hibernate.cache.internal.StandardQueryCache")
public class User implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;
	private String username;
	private String nickname;
	private Date birthday;
	private int credit;
	private String phone;
	private String email;
	private Photo photo;
	private Safe safe;
	private String password;
	private AccountState accountState;
	private State state;
	private Role role;
	public User(){}
	
	public User(String id, String username, String nickname, String phone,
			String email, State state) {
		this.id = id;
		this.username = username;
		this.nickname = nickname;
		this.phone = phone;
		this.email = email;
		this.state = state;
	}

	@Id
	@GeneratedValue(generator="uuid")
	@GenericGenerator(name="uuid",strategy="uuid2")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public int getCredit() {
		return credit;
	}
	public void setCredit(int credit) {
		this.credit = credit;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@OneToOne
	public Photo getPhoto() {
		return photo;
	}
	public void setPhoto(Photo photo) {
		this.photo = photo;
	}
	@JsonIgnore
	@OneToOne
	public Safe getSafe() {
		return safe;
	}
	public void setSafe(Safe safe) {
		this.safe = safe;
	}
	@Transient
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@OneToOne(mappedBy="user",fetch=FetchType.EAGER)
	public AccountState getAccountState() {
		return accountState;
	}
	public void setAccountState(AccountState accountState) {
		this.accountState = accountState;
	}
	@JsonIgnore
	@ManyToOne(fetch=FetchType.EAGER)
	public State getState() {
		return state;
	}
	public void setState(State state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", nickname="
				+ nickname + ", birthday=" + birthday + ", credit=" + credit
				+ ", phone=" + phone + ", email=" + email + ", photo=" + photo
				+ ", safe=" + safe + ", password=" + password
				+ ", accountState=" + accountState + ", state=" + state + "]";
	}
	@ManyToOne(fetch=FetchType.EAGER)
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	
}
