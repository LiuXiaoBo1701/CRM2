package com.crm.entity;

import org.springframework.stereotype.Component;

@Component
public class Modules {//(模块表
	 private Integer ms_Id;//模块编号
	 private String ms_Name;//模块名称
	 private Integer ms_ParentId;//父模块编号
	 private Integer ms_Weight;//权重
	 private Integer ms_Ext1;//预留字段
	 private String ms_Ext2;//模块路径
	public Integer getMs_Id() {
		return ms_Id;
	}
	public void setMs_Id(Integer ms_Id) {
		this.ms_Id = ms_Id;
	}
	public String getMs_Name() {
		return ms_Name;
	}
	public void setMs_Name(String ms_Name) {
		this.ms_Name = ms_Name;
	}
	public Integer getMs_ParentId() {
		return ms_ParentId;
	}
	public void setMs_ParentId(Integer ms_ParentId) {
		this.ms_ParentId = ms_ParentId;
	}
	public Integer getMs_Weight() {
		return ms_Weight;
	}
	public void setMs_Weight(Integer ms_Weight) {
		this.ms_Weight = ms_Weight;
	}
	public Integer getMs_Ext1() {
		return ms_Ext1;
	}
	public void setMs_Ext1(Integer ms_Ext1) {
		this.ms_Ext1 = ms_Ext1;
	}
	public String getMs_Ext2() {
		return ms_Ext2;
	}
	public void setMs_Ext2(String ms_Ext2) {
		this.ms_Ext2 = ms_Ext2;
	}
	@Override
	public String toString() {
		return "Modules [ms_Id=" + ms_Id + ", ms_Name=" + ms_Name + ", ms_ParentId=" + ms_ParentId + ", ms_Weight="
				+ ms_Weight + ", ms_Ext1=" + ms_Ext1 + ", ms_Ext2=" + ms_Ext2 + "]";
	}
	
 
}
