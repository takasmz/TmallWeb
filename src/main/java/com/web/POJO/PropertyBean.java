package com.web.pojo;

import java.io.Serializable;
import java.util.List;

public class PropertyBean implements Serializable{
	private int id;
	private int type_id;
	private int production_id;
	private String name;
	private String value;
	private List<String> namelist;
	private List<String> valuelist;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getType_id() {
		return type_id;
	}
	public void setType_id(int type_id) {
		this.type_id = type_id;
	}
	public int getProduction_id() {
		return production_id;
	}
	public void setProduction_id(int production_id) {
		this.production_id = production_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public List<String> getNamelist() {
		return namelist;
	}
	public void setNamelist(List<String> namelist) {
		this.namelist = namelist;
	}
	public List<String> getValuelist() {
		return valuelist;
	}
	public void setValuelist(List<String> valuelist) {
		this.valuelist = valuelist;
	}
	
}
