package cn.hua.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Photo implements Serializable {
	/**
	 * 照片：照片地址
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
	public Photo(){}
	public Photo(String path){
		this.path = path;
	}
}
