package com.crm.entity;

import org.springframework.stereotype.Component;

@Component
public class Users {//(用户表
	private Integer us_Id;//用户编号
	private String us_LoginName;//登录名
	private String us_PassWord;//密码
	private String us_UserImg;//用户照片
	private Integer us_IsLockout;//是否锁定
	private String us_LastLoginTime;//最后一次登录时间
	private String us_CreateTime;//用户创立时间
	private Integer us_PsdWrongNum;//密码错误次数
	private String us_LockTime;//被锁定时间
	private String us_ProtecEmail;//密保邮箱
	private String us_ProtecMtel;//密保手机号
	private Integer us_Ext1;//预留字段
	private String us_Ext2;//预留字段
	public Integer getUs_Id() {
		return us_Id;
	}
	public void setUs_Id(Integer us_Id) {
		this.us_Id = us_Id;
	}
	public String getUs_LoginName() {
		return us_LoginName;
	}
	public void setUs_LoginName(String us_LoginName) {
		this.us_LoginName = us_LoginName;
	}
	public String getUs_PassWord() {
		return us_PassWord;
	}
	public void setUs_PassWord(String us_PassWord) {
		this.us_PassWord = us_PassWord;
	}
	public String getUs_UserImg() {
		return us_UserImg;
	}
	public void setUs_UserImg(String us_UserImg) {
		this.us_UserImg = us_UserImg;
	}
	public Integer getUs_IsLockout() {
		return us_IsLockout;
	}
	public void setUs_IsLockout(Integer us_IsLockout) {
		this.us_IsLockout = us_IsLockout;
	}
	public String getUs_LastLoginTime() {
		return us_LastLoginTime;
	}
	public void setUs_LastLoginTime(String us_LastLoginTime) {
		this.us_LastLoginTime = us_LastLoginTime;
	}
	public String getUs_CreateTime() {
		return us_CreateTime;
	}
	public void setUs_CreateTime(String us_CreateTime) {
		this.us_CreateTime = us_CreateTime;
	}
	public Integer getUs_PsdWrongNum() {
		return us_PsdWrongNum;
	}
	public void setUs_PsdWrongNum(Integer us_PsdWrongNum) {
		this.us_PsdWrongNum = us_PsdWrongNum;
	}
	public String getUs_LockTime() {
		return us_LockTime;
	}
	public void setUs_LockTime(String us_LockTime) {
		this.us_LockTime = us_LockTime;
	}
	public String getUs_ProtecEmail() {
		return us_ProtecEmail;
	}
	public void setUs_ProtecEmail(String us_ProtecEmail) {
		this.us_ProtecEmail = us_ProtecEmail;
	}
	public String getUs_ProtecMtel() {
		return us_ProtecMtel;
	}
	public void setUs_ProtecMtel(String us_ProtecMtel) {
		this.us_ProtecMtel = us_ProtecMtel;
	}
	public Integer getUs_Ext1() {
		return us_Ext1;
	}
	public void setUs_Ext1(Integer us_Ext1) {
		this.us_Ext1 = us_Ext1;
	}
	public String getUs_Ext2() {
		return us_Ext2;
	}
	public void setUs_Ext2(String us_Ext2) {
		this.us_Ext2 = us_Ext2;
	}
	
	
	private Roles roles;
	private UserRoles userRoles;
	private Clients clients;
	private Consultant consultant;
	private ConsultantLabels consultantLabels;
	public Roles getRoles() {
		return roles;
	}
	public void setRoles(Roles roles) {
		this.roles = roles;
	}
	public UserRoles getUserRoles() {
		return userRoles;
	}
	public void setUserRoles(UserRoles userRoles) {
		this.userRoles = userRoles;
	}
	public Clients getClients() {
		return clients;
	}
	public void setClients(Clients clients) {
		this.clients = clients;
	}
	public Consultant getConsultant() {
		return consultant;
	}
	public void setConsultant(Consultant consultant) {
		this.consultant = consultant;
	}
	public ConsultantLabels getConsultantLabels() {
		return consultantLabels;
	}
	public void setConsultantLabels(ConsultantLabels consultantLabels) {
		this.consultantLabels = consultantLabels;
	}
	@Override
	public String toString() {
		return "Users [us_Id=" + us_Id + ", us_LoginName=" + us_LoginName + ", us_PassWord=" + us_PassWord
				+ ", us_UserImg=" + us_UserImg + ", us_IsLockout=" + us_IsLockout + ", us_LastLoginTime="
				+ us_LastLoginTime + ", us_CreateTime=" + us_CreateTime + ", us_PsdWrongNum=" + us_PsdWrongNum
				+ ", us_LockTime=" + us_LockTime + ", us_ProtecEmail=" + us_ProtecEmail + ", us_ProtecMtel="
				+ us_ProtecMtel + ", us_Ext1=" + us_Ext1 + ", us_Ext2=" + us_Ext2 + ", roles=" + roles + ", userRoles="
				+ userRoles + ", clients=" + clients + ", consultant=" + consultant + ", consultantLabels="
				+ consultantLabels + "]";
	}
	
	

}
