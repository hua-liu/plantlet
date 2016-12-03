package cn.hua.model;

import javax.persistence.*;

import java.io.Serializable;
import java.util.Date;
@Entity
@Table(name="visitgoodslog")
public class VisitGoodsLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private Date visittime;
	private Goods goods;
	private User user;
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getVisittime() {
		return visittime;
	}
	public void setVisittime(Date visittime) {
		this.visittime = visittime;
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
