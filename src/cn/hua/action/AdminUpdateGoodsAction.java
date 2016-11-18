package cn.hua.action;

import cn.hua.formBean.GoodsForm;
import cn.hua.model.Goods;
import cn.hua.model.GoodsKind;
import cn.hua.model.GoodsPicture;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.interceptor.RequestAware;

import java.util.List;
import java.util.Map;

public class AdminUpdateGoodsAction extends ActionSupport implements RequestAware,ModelDriven<GoodsForm>{
	private static final long serialVersionUID = 1L;
	private Map<String,Object> request;
	private Service service;
	private String id;
	private GoodsForm goodsForm;
	public void setId(String id) {
		this.id = id;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public GoodsForm getGoodsForm() {
		return goodsForm;
	}
	public void setGoodsForm(GoodsForm goodsForm) {
		this.goodsForm = goodsForm;
	}
	public String execute(){
		if(goodsForm!=null){
			List<GoodsKind> goodsKinds = service.getGoodsKindRoot();
			goodsKinds.add(0,new GoodsKind(0, "----点击选择商品分类----"));
			request.put("goodsKind", goodsKinds);	//获取分类
			/*request.put("moreKindAllChild",service.getGoodsKindChilds(goodsForm.getGoodsKindTemp()));	//获取详细分类
*/			List<GoodsPicture> goodsPictures = service.getGoodsPicturesByGoodsId(goodsForm.getGoodsId());
			
			request.put("goodsPictures",goodsPictures);//将商品所有图片存入reques
			ActionContext.getContext().getValueStack().push(goodsForm);		//把商品页面表单压入值栈
			return "success";
		}
		return "error";
	}

	@Override
	public GoodsForm getModel() {
		if(id!=null){
			Goods goods = service.findGoodsById(id);
			goodsForm = new Conversion<GoodsForm, Goods>().beanToBean(new GoodsForm(), goods);	//bean转换
			goodsForm.setGoodsKindTemp(goods.getGoodsKind().getId());	//设置商品分类
			if(goods.getColor()!=null){
				goodsForm.setColors(goods.getColor().split(","));
			}
			/*goodsForm.setMoreKindTemp(array);*/
			if(goods.getExplain()!=null){
				request.put("explain", goods.getExplain().getPath());
			}
			if(goods.getBreviaryPicture()!=null){
				goodsForm.setBreviaryPicture1(goods.getBreviaryPicture().getId());
			}
		}
		return null;
	}
	@Override
	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}
}
