package cn.hua.model;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Goods implements Serializable {
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
	private long sellsum;
	private Date shelfTime;
	private State state;// 默认已下架
	private String otherName;
	private String otherValue;
	private String goodsSize;
	private String color;
	private Explain explain;
	private BreviaryPicture breviaryPicture;
	private Set<GoodsPicture> goodsPicture = new HashSet<GoodsPicture>();
	private GoodsKind goodsKind;
	private VisitGoodsLog visitGoodsLog;

	/* private Set<GoodsKind> moreKind = new HashSet<GoodsKind>(); */
	public Goods() {
	}

	public Goods(String id) {
		this.goodsId = id;
	}
	public Goods(String goodsId, String name, String simpleDescript,
			float price, long sellsum, BreviaryPicture breviaryPicture) {
		this.goodsId = goodsId;
		this.name = name;
		this.simpleDescript = simpleDescript;
		this.price = price;
		this.sellsum = sellsum;
		this.breviaryPicture = breviaryPicture;
	}

	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid2")
	@Column(name = "id")
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

	public char getIsSale() {
		return isSale;
	}

	public void setIsSale(char isSale) {
		this.isSale = isSale;
	}

	public Date getShelfTime() {
		return shelfTime;
	}

	public void setShelfTime(Date shelfTime) {
		this.shelfTime = shelfTime;
	}

	public long getSellsum() {
		return sellsum;
	}

	public void setSellsum(long sellsum) {
		this.sellsum = sellsum;
	}

	public String getOtherValue() {
		return otherValue;
	}

	public void setOtherValue(String otherValue) {
		this.otherValue = otherValue;
	}

	public String getGoodsSize() {
		return goodsSize;
	}

	public void setGoodsSize(String goodsSize) {
		this.goodsSize = goodsSize;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	@ManyToOne
	public State getState() {
		return state;
	}

	public void setState(State state) {
		this.state = state;
	}

	@ManyToOne
	public GoodsKind getGoodsKind() {
		return goodsKind;
	}

	public void setGoodsKind(GoodsKind goodsKind) {
		this.goodsKind = goodsKind;
	}

	/*
	 * @ManyToMany(fetch=FetchType.EAGER) public Set<GoodsKind> getMoreKind() {
	 * return moreKind; } public void setMoreKind(Set<GoodsKind> moreKind) {
	 * this.moreKind = moreKind; }
	 */
	@OneToOne(cascade = { CascadeType.REMOVE })
	public Explain getExplain() {
		return explain;
	}

	public void setExplain(Explain explain) {
		this.explain = explain;
	}

	@OneToOne(mappedBy = "goods")
	public VisitGoodsLog getVisitGoodsLog() {
		return visitGoodsLog;
	}

	public void setVisitGoodsLog(VisitGoodsLog visitGoodsLog) {
		this.visitGoodsLog = visitGoodsLog;
	}

	@OneToOne(cascade = { CascadeType.REMOVE })
	public BreviaryPicture getBreviaryPicture() {
		return breviaryPicture;
	}

	public void setBreviaryPicture(BreviaryPicture breviaryPicture) {
		this.breviaryPicture = breviaryPicture;
	}

	@OneToMany(mappedBy = "goods", cascade = { CascadeType.REMOVE })
	public Set<GoodsPicture> getGoodsPicture() {
		return goodsPicture;
	}

	public void setGoodsPicture(Set<GoodsPicture> goodsPicture) {
		this.goodsPicture = goodsPicture;
	}

}
