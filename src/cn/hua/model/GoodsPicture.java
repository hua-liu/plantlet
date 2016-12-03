package cn.hua.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import java.io.Serializable;

@Entity
@Table(name="goodspicture")
public class GoodsPicture implements Serializable {
	/**
	 * 商品照片：照片地址，商品
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String path;
	private Goods goods;
	public GoodsPicture(){}
	public GoodsPicture(String path, Goods goods) {
		this.path = path;this.goods=goods;
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
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	@ManyToOne
	public Goods getGoods() {
		return goods;
	}
	public void setGoods(Goods goods) {
		this.goods= goods;
	}
	
}
