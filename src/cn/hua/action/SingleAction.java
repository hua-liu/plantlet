package cn.hua.action;

import cn.hua.model.Goods;
import cn.hua.service.Service;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.RequestAware;

import java.util.Map;

public class SingleAction extends ActionSupport implements RequestAware{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String goodsId;
	private Service service;
	private Map<String,Object> request;
	public void setService(Service service) {
		this.service = service;
	}
	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}
	public String get(){
		System.out.println(goodsId);
		if(goodsId==null){
			return "index";
		}
		Goods goods = service.findGoodsById(goodsId);
		if(goods==null){
			return "index";
		}
		goods.setGoodsPicture(null);
		long start = System.currentTimeMillis();
		request.put("goodsPictures", service.getGoodsPicturesByGoodsId(goodsId));
		ActionContext.getContext().getValueStack().push(goods);
		System.out.println("用时"+(System.currentTimeMillis()-start));
		return SUCCESS;
	}
	@Override
	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}
}
