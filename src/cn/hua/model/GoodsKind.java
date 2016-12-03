package cn.hua.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import java.io.Serializable;

@Entity
@Table(name="goodskind")
public class GoodsKind implements Serializable,Comparable<GoodsKind> {
	/**
	 * 商品分类：名字，描述，商品分类
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private String description;
	private GoodsKind parent;
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@ManyToOne
	public GoodsKind getParent() {
		return parent;
	}
	public void setParent(GoodsKind parent) {
		this.parent = parent;
	}
	public GoodsKind(){}
	public GoodsKind(int id, String name) {
		this.id = id;
		this.name = name;
	}
	public GoodsKind(int mkid) {
		this.id = mkid;
	}
	@Override
	public int compareTo(GoodsKind o) {
		if(this.id>o.id)
			return 1;
		else
			return -1;
	}
	
}
