package cn.hua.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import java.io.Serializable;

@Entity
public class Takedelivery implements Serializable {
	/**
	 * 收货地址
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String name;
	private String address;
	private String moreAddress;
	private String phone;
	private String postcode;
	private String telephone;
	private User user;
	public Takedelivery(){}
	public Takedelivery(String addr) {
		this.id = addr;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	@ManyToOne
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getMoreAddress() {
		return moreAddress;
	}
	public void setMoreAddress(String moreAddress) {
		this.moreAddress = moreAddress;
	}
	
}
