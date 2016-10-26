package cn.hua.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import org.hibernate.annotations.GenericGenerator;
@Entity
public class OrderForm implements Serializable {
	/**
	 * 订单：订单时间，付款时间，发货时间，收货时间，留言，状态，商品，
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	//private String expgname;
	private Date buytime = new Date();
	private Date paytime;
	private Date sendtime;
	private Date receivetime;
	private String leaveMessage;
	private State state;
	private Goods goods;
	private User user;
	private int buyNum;
	public OrderForm(){}
	public OrderForm(String ofId) {
		this.id = ofId;
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
	/*public String getExpgname() {
		return expgname;
	}
	public void setExpgname(String expgname) {
		this.expgname = expgname;
	}*/
	public Date getBuytime() {
		return buytime;
	}
	public void setBuytime(Date buytime) {
		this.buytime = buytime;
	}
	public Date getPaytime() {
		return paytime;
	}
	public void setPaytime(Date paytime) {
		this.paytime = paytime;
	}
	public Date getSendtime() {
		return sendtime;
	}
	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}
	public Date getReceivetime() {
		return receivetime;
	}
	public void setReceivetime(Date receivetime) {
		this.receivetime = receivetime;
	}
	public String getLeaveMessage() {
		return leaveMessage;
	}
	public void setLeaveMessage(String leaveMessage) {
		this.leaveMessage = leaveMessage;
	}
	public int getBuyNum() {
		return buyNum;
	}
	public void setBuyNum(int buyNum) {
		this.buyNum = buyNum;
	}
	@ManyToOne
	public State getState() {
		return state;
	}
	public void setState(State state) {
		this.state = state;
	}
	@OneToOne
	public Goods getGoods() {
		return goods;
	}
	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	@ManyToOne
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
}
