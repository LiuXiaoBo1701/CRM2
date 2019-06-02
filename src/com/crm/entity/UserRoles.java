package com.crm.entity;

import org.springframework.stereotype.Component;

@Component
public class UserRoles {//用户、角色表的关联表
	private Integer urs_Id;//编号
	private Integer urs_UserId;//用户表
	private Integer urs_RoleId;//角色表
	private Integer urs_Ext1;//预留字段
	private String urs_Ext2;//预留字段
	
	private Roles roles;	//角色表
	private Users users;	//用户表
	public Integer getUrs_Id() {
		return urs_Id;
	}
	public void setUrs_Id(Integer urs_Id) {
		this.urs_Id = urs_Id;
	}
	public Integer getUrs_UserId() {
		return urs_UserId;
	}
	public void setUrs_UserId(Integer urs_UserId) {
		this.urs_UserId = urs_UserId;
	}
	public Integer getUrs_RoleId() {
		return urs_RoleId;
	}
	public void setUrs_RoleId(Integer urs_RoleId) {
		this.urs_RoleId = urs_RoleId;
	}
	public Integer getUrs_Ext1() {
		return urs_Ext1;
	}
	public void setUrs_Ext1(Integer urs_Ext1) {
		this.urs_Ext1 = urs_Ext1;
	}
	public String getUrs_Ext2() {
		return urs_Ext2;
	}
	public void setUrs_Ext2(String urs_Ext2) {
		this.urs_Ext2 = urs_Ext2;
	}
	public Roles getRoles() {
		return roles;
	}
	public void setRoles(Roles roles) {
		this.roles = roles;
	}
	public Users getUsers() {
		return users;
	}
	public void setUsers(Users users) {
		this.users = users;
	}
	@Override
	public String toString() {
		return "UserRoles [urs_Id=" + urs_Id + ", urs_UserId=" + urs_UserId + ", urs_RoleId=" + urs_RoleId
				+ ", urs_Ext1=" + urs_Ext1 + ", urs_Ext2=" + urs_Ext2 + ", roles=" + roles + ", users=" + users + "]";
	}
	
	
}
