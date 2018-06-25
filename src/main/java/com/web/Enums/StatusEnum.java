package com.web.Enums;

public enum StatusEnum {
	/** 待收货 */
	waitConfirm(1,"待收货"),
	/** 待发货 */
	waitDelivery(2,"待发货"),
	/** 待付款 */
	waitPay(3,"待付款"),
	/** 到货 待評價 */
	waitReview(4,"待评价"),
	OK(5,"已评价");
	private int id;
	private String name;
	
	private StatusEnum(int id,String name){
		this.id = id;
		this.name = name;
	}
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
	
	public static StatusEnum getStatus(int id){
		if(id==1){
			return waitConfirm;
		}else if(id==2){
			return waitDelivery;
		}else if(id==3){
			return waitPay;
		}else if(id==4){
			return waitReview;
		}else{
			return OK;
		}
	}
}
