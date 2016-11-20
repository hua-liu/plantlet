package cn.hua.dao;

import java.util.List;
import java.util.Map;

import cn.hua.formBean.Paging;
import cn.hua.model.Area;
import cn.hua.model.Explain;
import cn.hua.model.MySet;
import cn.hua.model.Photo;
import cn.hua.model.Role;

public interface OtherDao <T,K>{
	List<T> getAll();
	List<K> getStates();
	List<?> getPagingData(Paging paging, String id);
	void saveSet(MySet mySset);
	MySet getSet(String id);
	Map<String,Object> findUserMoreData(String id);
	List<Role> getRoles();
	void savePhoto(Photo photo);
	Photo loadPhoto(String id);
	void saveGoodsExplain(Explain explain);
	Explain loadGoodsExplain(String id);
	List<Area> getAreas(int id);
	List<String> getNewOrderFormNum();
}
