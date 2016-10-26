package cn.hua.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name="goodsexplain")
public class Explain implements Serializable {
	/**
	 * 商品说明：地址
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String path;
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
	public Explain(){
		
	}
	public Explain(String filePath) {
		this.path = filePath;
	}
	
}
