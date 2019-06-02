package com.crm.entity;

import org.springframework.stereotype.Component;

@Component
public class ConsultantLabels {//咨询师签到表
	private Integer Rls_Id;//编号
	private Integer Rls_ConsultantId;//咨询师表
	private Integer Rls_State;//签到状态（上班、下班）
	private String Rls_StartTime;//签到时间
	private String Rls_FinishTime;//签退时间
	private String Cur_Remark;//备注
	private Integer Cur_Ext1;//预留字段
	private String Cur_Ext2;//预留字段
	public Integer getRls_Id() {
		return Rls_Id;
	}
	public void setRls_Id(Integer rls_Id) {
		Rls_Id = rls_Id;
	}
	public Integer getRls_ConsultantId() {
		return Rls_ConsultantId;
	}
	public void setRls_ConsultantId(Integer rls_ConsultantId) {
		Rls_ConsultantId = rls_ConsultantId;
	}
	public Integer getRls_State() {
		return Rls_State;
	}
	public void setRls_State(Integer rls_State) {
		Rls_State = rls_State;
	}
	public String getRls_StartTime() {
		return Rls_StartTime;
	}
	public void setRls_StartTime(String rls_StartTime) {
		Rls_StartTime = rls_StartTime;
	}
	public String getRls_FinishTime() {
		return Rls_FinishTime;
	}
	public void setRls_FinishTime(String rls_FinishTime) {
		Rls_FinishTime = rls_FinishTime;
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
	public String toString() {
		return "Consultantlabels [Rls_Id=" + Rls_Id + ", Rls_ConsultantId=" + Rls_ConsultantId + ", Rls_State="
				+ Rls_State + ", Rls_StartTime=" + Rls_StartTime + ", Rls_FinishTime=" + Rls_FinishTime
				+ ", Cur_Remark=" + Cur_Remark + ", Cur_Ext1=" + Cur_Ext1 + ", Cur_Ext2=" + Cur_Ext2 + "]";
	}
	
	
	
}
