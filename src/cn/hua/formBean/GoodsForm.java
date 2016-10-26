package cn.hua.formBean;

import java.io.Serializable;
import java.util.Date;

public class GoodsForm implements Serializable {
	/**
	 * 商品：名字，商品数量，是否抢购，销售数量，状态，商店，说明，访问日志
	 */
	private static final long serialVersionUID = 1L;
	private String goodsId;
	private String name;
	private String simpleDescript;
	private int inventory;
	private float price;
	private char isSale;
	private float salePrice;
	private Date saleTime;
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
	public String getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSimpleDescript() {
		return simpleDescript;
	}
	public void setSimpleDescript(String simpleDescript) {
		this.simpleDescript = simpleDescript;
	}
	public int getInventory() {
		return inventory;
	}
	public void setInventory(int inventory) {
		this.inventory = inventory;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public float getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(float salePrice) {
		this.salePrice = salePrice;
	}
	public Date getSaleTime() {
		return saleTime;
	}
	public void setSaleTime(Date saleTime) {
		this.saleTime = saleTime;
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
		if(color!=null){
			return color.replaceAll(",", " ").replaceAll("\\s+", " ");
		}
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public char getIsSale() {
		return isSale;
	}
	public void setIsSale(char isSale) {
		this.isSale = isSale;
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
