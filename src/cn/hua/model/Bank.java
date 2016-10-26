package cn.hua.model;

import java.io.Serializable;

public class Bank implements Serializable{
	/**
	 * 银行：卡号，银行名称，银行地址，是否快捷支付
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String banknum;
	private String name;
	private String bankadd;
	private char quickpay;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBanknum() {
		return banknum;
	}
	public void setBanknum(String banknum) {
		this.banknum = banknum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBankadd() {
		return bankadd;
	}
	public void setBankadd(String bankadd) {
		this.bankadd = bankadd;
	}
	public char getQuickpay() {
		return quickpay;
	}
	public void setQuickpay(char quickpay) {
		this.quickpay = quickpay;
	}
	
}
