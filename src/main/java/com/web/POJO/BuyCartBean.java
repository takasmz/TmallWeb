package com.web.pojo;

import java.io.Serializable;

public class BuyCartBean implements Serializable{
	private int id;
	private int number;
	private double total;
	private int user_id;
	private int production_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getProduction_id() {
		return production_id;
	}
	public void setProduction_id(int production_id) {
		this.production_id = production_id;
	}
	
}
