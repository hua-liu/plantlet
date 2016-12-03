package cn.hua.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

import java.io.Serializable;
@Entity
@Table(name="breviarypicture")
public class BreviaryPicture implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String path;
	//private Goods goods;
	@Id
	@GeneratedValue(generator="uuid")
	@GenericGenerator(name="uuid",strategy="uuid2")
	@Column(name="id",length=40)
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
	/*@OneToOne(mappedBy="breviaryPicture",fetch=FetchType.LAZY)
	public Goods getGoods() {
		return goods;
	}
	public void setGoods(Goods goods) {
		this.goods = goods;
	}*/
	public BreviaryPicture(){}
	public BreviaryPicture(String id,String path){
		if(id!=null){
			this.id = id;
		}
		this.path = path;
	}
}
