package com.crm.entity;

import org.springframework.stereotype.Component;

@Component
public class RoleModules {//角色、模块表的关联表
	private Integer rms_Id;//编号
	private Integer rms_RoleId;//角色表
	private Integer rms_ModuleId;//模块表
	private Integer rms_Ext1;//预留字段
	private String rms_Ext2;//预留字段
	public Integer getRms_Id() {
		return rms_Id;
	}
	public void setRms_Id(Integer rms_Id) {
		this.rms_Id = rms_Id;
	}
	public Integer getRms_RoleId() {
		return rms_RoleId;
	}
	public void setRms_RoleId(Integer rms_RoleId) {
		this.rms_RoleId = rms_RoleId;
	}
	public Integer getRms_ModuleId() {
		return rms_ModuleId;
	}
	public void setRms_ModuleId(Integer rms_ModuleId) {
		this.rms_ModuleId = rms_ModuleId;
	}
	public Integer getRms_Ext1() {
		return rms_Ext1;
	}
	public void setRms_Ext1(Integer rms_Ext1) {
		this.rms_Ext1 = rms_Ext1;
	}
	public String getRms_Ext2() {
		return rms_Ext2;
	}
	public void setRms_Ext2(String rms_Ext2) {
		this.rms_Ext2 = rms_Ext2;
	}
	@Override
	public String toString() {
		return "RoleModules [rms_Id=" + rms_Id + ", rms_RoleId=" + rms_RoleId + ", rms_ModuleId=" + rms_ModuleId
				+ ", rms_Ext1=" + rms_Ext1 + ", rms_Ext2=" + rms_Ext2 + "]";
	}
	
}
