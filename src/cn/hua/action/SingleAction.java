package cn.hua.action;

import cn.hua.formBean.GoodsForm;
import cn.hua.model.Goods;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import cn.hua.utils.GetI18nConfig;

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
	public String getProductSingle(){
		if(goodsId==null){
			return "index";
		}
		Goods goods = service.findGoodsById(goodsId);
		if(goods==null){
			return "index";
		}
		goods.setGoodsPicture(null);
		request.put("goodsPictures", service.getGoodsPicturesByGoodsId(goodsId));
		GoodsForm goodsForm = new Conversion<GoodsForm, Goods>().beanToBean(new GoodsForm(), goods);	//bean转换
		ActionContext.getContext().getValueStack().push(goodsForm);
		//js国际化文件
		new GetI18nConfig(ActionContext.getContext()).start();
		return SUCCESS;
	}
	@Override
	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}
}
