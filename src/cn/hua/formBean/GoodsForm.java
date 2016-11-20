package cn.hua.formBean;

import java.io.Serializable;

import cn.hua.model.Goods;
import edu.emory.mathcs.backport.java.util.Arrays;

public class GoodsForm extends Goods implements Serializable {
	/**
	 * 商品：名字，商品数量，是否抢购，销售数量，状态，商店，说明，访问日志
	 */
	private static final long serialVersionUID = 1L;
	private String otherName;
	private String otherValue;
	private String goodsSize;
	private String color;
	private int[] moreKindTemp;
	private int goodsKindTemp;
	private String[] colors;
	private String breviaryPicture1;//用于接收缩略图的ID
	
	public String getBreviaryPicture1() {
		return breviaryPicture1;
	}
	public void setBreviaryPicture1(String breviaryPicture1) {
		this.breviaryPicture1 = breviaryPicture1;
	}
	public String[] getColors() {
		return colors;
	}
	public void setColors(String[] colors) {
		this.colors = colors;
	}
	public String getOtherName() {
		return otherName;
	}
	public void setOtherName(String otherName) {
		this.otherName = otherName;
	}
	public String getOtherValue() {
		if(otherValue!=null){
			String regex = "\\s+";  
			otherValue = otherValue.replaceAll(regex, " ");
		}
		return otherValue;
	}
	public void setOtherValue(String otherValue) {
		this.otherValue = otherValue;
	}
	public String getGoodsSize() {
		if(goodsSize!=null){
			return goodsSize.replaceAll(",", " ").replaceAll("\\s+", " ");
		}
		return null;
	}
	public void setGoodsSize(String goodsSize) {
		this.goodsSize = goodsSize;
	}
	public String getColor() {
		if(colors!=null&&colors.length>0){
			color =Arrays.toString(colors);
			color = color.substring(1,color.length()-1);
		}
		return color;
	}
	public void setColor(String color) {
		if(color!=null)
		this.colors = color.split(",");
		this.color = color;
	}
	public int[] getMoreKindTemp() {
		return moreKindTemp;
	}
	public void setMoreKindTemp(int[] moreKindTemp) {
		this.moreKindTemp = moreKindTemp;
	}
	public int getGoodsKindTemp() {
		return goodsKindTemp;
	}
	public void setGoodsKindTemp(int goodsKindTemp) {
		this.goodsKindTemp = goodsKindTemp;
	}
}
