package com.crm.entity;

import org.springframework.stereotype.Component;

@Component
//角色表
public class Roles {
	private Integer rs_Id;//角色编号
	private String rs_Name;//角色名称
	private Integer rs_Ext1;//预留字段
	private String rs_Ext2;//预留字段
	public Integer getRs_Id() {
		return rs_Id;
	}
	public void setRs_Id(Integer rs_Id) {
		this.rs_Id = rs_Id;
	}
	public String getRs_Name() {
		return rs_Name;
	}
	public void setRs_Name(String rs_Name) {
		this.rs_Name = rs_Name;
	}
	public Integer getRs_Ext1() {
		return rs_Ext1;
	}
	public void setRs_Ext1(Integer rs_Ext1) {
		this.rs_Ext1 = rs_Ext1;
	}
	public String getRs_Ext2() {
		return rs_Ext2;
	}
	public void setRs_Ext2(String rs_Ext2) {
		this.rs_Ext2 = rs_Ext2;
	}
	@Override
	public String toString() {
		return "Roles [rs_Id=" + rs_Id + ", rs_Name=" + rs_Name + ", rs_Ext1=" + rs_Ext1 + ", rs_Ext2=" + rs_Ext2 + "]";
	}
	
}
