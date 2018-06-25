package com.web.pojo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

public class ProductionBean implements Serializable{
	/** 商品号 */
	private int id;
	/** 商品名称 */
	@NotEmpty(message="不能为空")
	private String name;
	/** 价格 */
	@NotNull(message="不能为空")
	private double price;
	/** 销量 */
	private int sales_volume;
	/** 库存 */
	@NotNull(message="不能为空")
	private int stock;
	/** 种类 */
	@NotNull(message="不能为空")
	private int type_id;
	/** 型号 */
	@NotEmpty(message="不能为空")
	private String model;
	/** 品牌 */
	@NotEmpty(message="不能为空")
	private String brands;
	/** 图片路径 */
	@NotEmpty(message="不能为空")
	private String imgpath;
	/** 评论数 */
	private int reviewnumber;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getSales_volume() {
		return sales_volume;
	}
	public void setSales_volume(int sales_volume) {
		this.sales_volume = sales_volume;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getBrands() {
		return brands;
	}
	public void setBrands(String brands) {
		this.brands = brands;
	}
	public String getImgpath() {
		return imgpath;
	}
	public void setImgpath(String imgpath) { 
		this.imgpath = imgpath;
	}
	public int getType_id() {
		return type_id;
	}
	public void setType_id(int type_id) {
		this.type_id = type_id;
	}
	public int getReviewnumber() {
		return reviewnumber;
	}
	public void setReviewnumber(int reviewnumber) {
		this.reviewnumber = reviewnumber;
	}
}
