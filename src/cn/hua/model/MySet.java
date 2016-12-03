package cn.hua.model;

import javax.persistence.*;

import java.io.Serializable;

@Entity
@Table(name="myset")
public class MySet implements Serializable {
	/**
	 * 设置：页面显示数量，显示视图，时间
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int pageRowNum;
	private int showChart;
	private String time;
	private User user;
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPageRowNum() {
		return pageRowNum;
	}
	public void setPageRowNum(int pageRowNum) {
		this.pageRowNum = pageRowNum;
	}
	public int getShowChart() {
		return showChart;
	}
	public void setShowChart(int showChart) {
		this.showChart = showChart;
	}
	@OneToOne
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	@Transient
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
}
