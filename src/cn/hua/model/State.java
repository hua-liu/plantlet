package cn.hua.model;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
public class State implements Serializable {
	/**
	 * 状态（正常，锁定，未激活）
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private Set<User> users = new HashSet<User>();

	@Id
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

	@OneToMany(mappedBy = "state", fetch = FetchType.LAZY)
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}
	public State(){
	}
	public State(int id, String name) {
		this.id = id;
		this.name = name;
	};

	public State(int id) {
		this.id = id;
	}

	public State(String name) {
		this.name = name;
	}
}
