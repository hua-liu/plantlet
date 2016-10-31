package cn.hua.action;

import java.util.List;

import cn.hua.formBean.GoodsForm;
import cn.hua.model.Explain;
import cn.hua.model.Goods;
import cn.hua.model.GoodsKind;
import cn.hua.model.GoodsPicture;
import cn.hua.model.State;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import cn.hua.utils.FileOperation;
import cn.hua.utils.Verification;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class GoodsAction extends ActionSupport implements
		ModelDriven<GoodsForm> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private GoodsForm goodsForm;
	private Service service;
	private String result;
	private String imgId;
	private String goodsId;
	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}
	public String getGoodsId() {
		return goodsId;
	}
	public String getResult() {
		return result;
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
	/**
	 * 其中有新增，更新，根据是否有ID判断
	 * 
	 * @return
	 */
	public String add() {
		// 验证表单是否合法
		String[] goodsError = Verification.goodsVer(goodsForm);
		if (goodsError != null && goodsError.length > 0) {
			this.result = Conversion.stringToJson("cause," + goodsError[0]);
			return ERROR;
		}
		Goods goods = null;
		if (goodsForm.getGoodsId() != null) {
			/* service.findGoodsById(goodsForm.) */
			goods = service.findGoodsById(goodsForm.getGoodsId());
		}
		if(goods==null){
			goods = new Goods();
		}
		// 表单转换到商品BEAN
		new Conversion<Goods, GoodsForm>().beanToBean(
				goods, goodsForm);
		goods.setGoodsKind(new GoodsKind(goodsForm.getGoodsKindTemp()));
		/*
		 * Set<GoodsKind> set = new HashSet<GoodsKind>(); for(int
		 * i=0;i<goodsForm.getMoreKindTemp().length;i++){ set.add(new
		 * GoodsKind(goodsForm.getMoreKindTemp()[i])); } goods.setMoreKind(set);
		 */
		try {
			// 判断表单是否有带ID过来，如果有则执行更新，没有则新增
			if (goods.getGoodsId() == null || goods.getGoodsId() != null
					&& goods.getGoodsId().trim().equals("")) {
				goods.setState(new State(6));
				service.saveGoods(goods);
			} else {
				service.updateGoods(goods);
			}
			this.result = Conversion.stringToJson("message,true,id,"
					+ goods.getGoodsId());
		} catch (Exception e) {
			e.printStackTrace();
			this.result = Conversion
					.stringToJson("message,false,cause,未知错误(103)");
			return ERROR;
		}
		return SUCCESS;
	}

	public String delete() {
		if (goodsForm != null && goodsForm.getGoodsId() != null) {
			try {
				Goods goods = service.findGoodsById(goodsForm.getGoodsId());
				if (goods == null) {
					this.result = Conversion
							.stringToJson("message,false,cause,要删除的商品不存在");
					return SUCCESS;
				}
				List<GoodsPicture> list = service
						.getGoodsPicturesByGoodsId(goods.getGoodsId());
				for (GoodsPicture goodsPictrue : list) {
					String path = goodsPictrue.getPath();
					new FileOperation(path).start();

				}
				if (goods.getBreviaryPicture() != null) {
					new FileOperation(goods.getBreviaryPicture().getPath())
							.start();
				}
				list.clear();
				Explain explain = goods.getExplain();
				if (explain != null) {
					String path = explain.getPath();
					path = path.replace("htmlfile", "D:/DATA/SKJS/html");
					path = path.substring(0, path.lastIndexOf("/"));
					new FileOperation(path).start();
				}
				explain = null;
				service.deleteGoods(goods);
				this.result = Conversion.stringToJson("message,true");
				return SUCCESS;
			} catch (Exception e) {
				this.result = Conversion.stringToJson("message,false,cause,"
						+ e.getMessage());
				return SUCCESS;
			}
		} else {
			this.result = Conversion
					.stringToJson("message,false,cause,数据不见了，请重试一下呢");
			return SUCCESS;
		}
	}

	public String deleteImg() {
		if (goodsForm == null || goodsForm != null
				&& goodsForm.getGoodsId() == null) {
			this.result = Conversion
					.stringToJson("message,false,cause,数据不见了，请重试一下呢");
			return SUCCESS;
		}
		try {
			GoodsPicture goodsPicture = service.getGoodsPicture(imgId);
			if (goodsPicture == null) {
				this.result = Conversion.stringToJson("message,true");
				return SUCCESS;
			}
			String path = goodsPicture.getPath();
			new FileOperation(path).start();
			service.deleteGoodsPicture(goodsForm.getGoodsId(), imgId);
		} catch (Exception e) {
			this.result = Conversion
					.stringToJson("message,false,cause,服务器异常，你稍候重试！");
			return SUCCESS;
		}
		this.result = Conversion.stringToJson("message,true");
		return SUCCESS;
	}

	@Override
	public GoodsForm getModel() {
		if(goodsId!=null){
			Goods goods = service.findGoodsById(goodsId);
		}
		goodsForm = new GoodsForm();
		return goodsForm;
	}

}
