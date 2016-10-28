package cn.hua.dao;

import java.util.List;

import cn.hua.model.OrderForm;
import cn.hua.model.Takedelivery;

public interface OrderFormDao extends Dao<OrderForm>{
	List<OrderForm> getOrderFormByUserId(String id);
	List<Takedelivery> getTakedeliverysByUserId(String id);
	Takedelivery getTakedeliveryById(String id);
	void saveTakedelivery(Takedelivery take);
	void deleteTakedelivery(Takedelivery take);
	void updateTakedelivery(Takedelivery take);
}
