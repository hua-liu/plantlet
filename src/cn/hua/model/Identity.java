package cn.hua.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="kjidentity")
public class Identity implements Serializable {
	/**
	 * 身份：姓名，身份证号，身份证前照，身份证后照，自己的照片
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String name;
	private String identityNumber;//身份证
	private Photo frontPhoto;
	private Photo backPhotot;
	private Photo selfPhoto;
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
	
	public String getIdentityNumber() {
		return identityNumber;
	}
	public void setIdentityNumber(String identityNumber) {
		this.identityNumber = identityNumber;
	}
	@OneToOne
	public Photo getFrontPhoto() {
		return frontPhoto;
	}
	public void setFrontPhoto(Photo frontPhoto) {
		this.frontPhoto = frontPhoto;
	}
	@OneToOne
	public Photo getBackPhotot() {
		return backPhotot;
	}
	public void setBackPhotot(Photo backPhotot) {
		this.backPhotot = backPhotot;
	}
	@OneToOne
	public Photo getSelfPhoto() {
		return selfPhoto;
	}
	public void setSelfPhoto(Photo selfPhoto) {
		this.selfPhoto = selfPhoto;
	}
	
}
