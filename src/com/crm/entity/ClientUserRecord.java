package com.crm.entity;

import org.springframework.stereotype.Component;

@Component
public class ClientUserRecord {//跟踪记录表
	private  Integer Cur_Id;//编号
	private  String Cur_Title;//标题
	private  Integer Cur_ClientId;//客户编号
	private  Integer Cur_UserId;//用户编号
	private  Integer Cur_ZhuangTai;//意向状态（意向中、意向中 一般、意向中 中强、意向中 强）
	private  Integer Cur_LianXiFangShi;//联系方式（来电、邮箱、短信、来访）
	private  String Cur_RecordTime;//记录时间
	private  String Cur_Remark;//备注
	private Clients clients;
	private Users users;
	private  Integer Cur_Ext1;//预留字段
	private  String Cur_Ext2;//预留字段
	
	public Clients getClients() {
		return clients;
	}
	public void setClients(Clients clients) {
		this.clients = clients;
	}
	public Users getUsers() {
		return users;
	}
	public void setUsers(Users users) {
		this.users = users;
	}
	public Integer getCur_Id() {
		return Cur_Id;
	}
	public void setCur_Id(Integer cur_Id) {
		Cur_Id = cur_Id;
	}
	public String getCur_Title() {
		return Cur_Title;
	}
	public void setCur_Title(String cur_Title) {
		Cur_Title = cur_Title;
	}
	public Integer getCur_ClientId() {
		return Cur_ClientId;
	}
	public void setCur_ClientId(Integer cur_ClientId) {
		Cur_ClientId = cur_ClientId;
	}
	public Integer getCur_UserId() {
		return Cur_UserId;
	}
	public void setCur_UserId(Integer cur_UserId) {
		Cur_UserId = cur_UserId;
	}
	public Integer getCur_ZhuangTai() {
		return Cur_ZhuangTai;
	}
	public void setCur_ZhuangTai(Integer cur_ZhuangTai) {
		Cur_ZhuangTai = cur_ZhuangTai;
	}
	public Integer getCur_LianXiFangShi() {
		return Cur_LianXiFangShi;
	}
	public void setCur_LianXiFangShi(Integer cur_LianXiFangShi) {
		Cur_LianXiFangShi = cur_LianXiFangShi;
	}
	public String getCur_RecordTime() {
		return Cur_RecordTime;
	}
	public void setCur_RecordTime(String cur_RecordTime) {
		Cur_RecordTime = cur_RecordTime;
	}
	
	public String getCur_Remark() {
		return Cur_Remark;
	}
	public void setCur_Remark(String cur_Remark) {
		Cur_Remark = cur_Remark;
	}
	public Integer getCur_Ext1() {
		return Cur_Ext1;
	}
	public void setCur_Ext1(Integer cur_Ext1) {
		Cur_Ext1 = cur_Ext1;
	}
	public String getCur_Ext2() {
		return Cur_Ext2;
	}
	public void setCur_Ext2(String cur_Ext2) {
		Cur_Ext2 = cur_Ext2;
	}
	@Override
	public String toString() {
		return "ClientUserRecord [Cur_Id=" + Cur_Id + ", Cur_Title=" + Cur_Title + ", Cur_ClientId=" + Cur_ClientId
				+ ", Cur_UserId=" + Cur_UserId + ", Cur_ZhuangTai=" + Cur_ZhuangTai + ", Cur_LianXiFangShi="
				+ Cur_LianXiFangShi + ", Cur_RecordTime=" + Cur_RecordTime + ", Cur_Remark=" + Cur_Remark + ", clients="
				+ clients + ", users=" + users + ", Cur_Ext1=" + Cur_Ext1 + ", Cur_Ext2=" + Cur_Ext2 + "]";
	}
	

	
	
	
	
	
}
