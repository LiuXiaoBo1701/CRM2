package com.crm.entity;

import org.springframework.stereotype.Component;

@Component
public class Message {
	private Integer M_Id;
	private String M_Content;	//内容
	private String M_InitiateName;	//发起人
	private String M_ReceiveName;	//接受人
	private Integer M_State;	//状态（是否接收到）
	private String M_Time;		//时间
	private Integer M_Ext1;		//预留字段
	private String M_Ext2;		//预留字段
	public Integer getM_Id() {
		return M_Id;
	}
	public void setM_Id(Integer m_Id) {
		M_Id = m_Id;
	}
	public String getM_Content() {
		return M_Content;
	}
	public void setM_Content(String m_Content) {
		M_Content = m_Content;
	}
	public String getM_InitiateName() {
		return M_InitiateName;
	}
	public void setM_InitiateName(String m_InitiateName) {
		M_InitiateName = m_InitiateName;
	}
	public String getM_ReceiveName() {
		return M_ReceiveName;
	}
	public void setM_ReceiveName(String m_ReceiveName) {
		M_ReceiveName = m_ReceiveName;
	}
	public Integer getM_State() {
		return M_State;
	}
	public void setM_State(Integer m_State) {
		M_State = m_State;
	}
	public String getM_Time() {
		return M_Time;
	}
	public void setM_Time(String m_Time) {
		M_Time = m_Time;
	}
	public Integer getM_Ext1() {
		return M_Ext1;
	}
	public void setM_Ext1(Integer m_Ext1) {
		M_Ext1 = m_Ext1;
	}
	public String getM_Ext2() {
		return M_Ext2;
	}
	public void setM_Ext2(String m_Ext2) {
		M_Ext2 = m_Ext2;
	}
	@Override
	public String toString() {
		return "message [M_Id=" + M_Id + ", M_Content=" + M_Content + ", M_InitiateName=" + M_InitiateName
				+ ", M_ReceiveName=" + M_ReceiveName + ", M_State=" + M_State + ", M_Time=" + M_Time + ", M_Ext1="
				+ M_Ext1 + ", M_Ext2=" + M_Ext2 + "]";
	}
	

}
