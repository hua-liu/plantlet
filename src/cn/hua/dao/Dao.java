package cn.hua.dao;
public interface Dao <T>{
	public void save(T t);
	public void update(T t);
	public void delete(T t);
	public T find(String id);
}
