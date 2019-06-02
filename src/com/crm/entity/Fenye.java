package com.crm.entity;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class Fenye {
	//分页参数
	private Integer total;
	private Integer page;
	private Integer pageSize;
	private List<?> rows;
	//多条件搜索参数
	private Clients clients;	//客户表
	private Users users;	//用户表
	private ClientUserRecord clientUserRecord;//跟踪记录表
	private Message message;//信息表
	
	private String Name;
	private Integer minNumber;//最小值
	private Integer maxNumber;//最大值
	private String minTime;//最小日期
	private String maxTime;//最大日期
	
	private String   Cs_Name;
	private Integer  Cs_Sex;
	private String  Cs_Phone;
	private Integer  Cs_ClientState;
	private String  Cs_Source;
	private Integer  Us_Id;
	private Integer Cs_FenPei;
	private String  Cs_SiteSheng;
	private String  Cs_SiteShi;
	private String  Cs_SiteXian;
	private Integer  Cur_ZhuangTai;
	private String  Cur_RecordTimeMin;
	private String  Cur_RecordTimeMax;
	private String Us_LoginName;
	private Integer Rs_Id;
	private Integer Us_IsLockout;
	private String Us_ProtecMtel;
	private String Us_CreateTimeMin;
	private String Us_CreateTimeMax;
	private String Rls_StartTimeMin;
	private String Rls_StartTimeMax;
	private String Rls_FinishTimeMin;
	private String Rls_FinishTimeMax;
	private Integer Rls_State;
	private Integer C_UserId;
	
	
	public Message getMessage() {
		return message;
	}
	public void setMessage(Message message) {
		this.message = message;
	}
	public ClientUserRecord getClientUserRecord() {
		return clientUserRecord;
	}
	public void setClientUserRecord(ClientUserRecord clientUserRecord) {
		this.clientUserRecord = clientUserRecord;
	}
	@Override
	public String toString() {
		return "Fenye [total=" + total + ", page=" + page + ", pageSize=" + pageSize + ", rows=" + rows + ", clients="
				+ clients + ", users=" + users + ", Name=" + Name + ", minNumber=" + minNumber + ", maxNumber="
				+ maxNumber + ", minTime=" + minTime + ", maxTime=" + maxTime + ", Cs_Name=" + Cs_Name + ", Cs_Sex="
				+ Cs_Sex + ", Cs_Phone=" + Cs_Phone + ", Cs_ClientState=" + Cs_ClientState + ", Cs_Source=" + Cs_Source
				+ ", Us_Id=" + Us_Id + ", Cs_FenPei=" + Cs_FenPei + ", Cs_SiteSheng=" + Cs_SiteSheng + ", Cs_SiteShi="
				+ Cs_SiteShi + ", Cs_SiteXian=" + Cs_SiteXian + ", Cur_ZhuangTai=" + Cur_ZhuangTai
				+ ", Cur_RecordTimeMin=" + Cur_RecordTimeMin + ", Cur_RecordTimeMax=" + Cur_RecordTimeMax
				+ ", Us_LoginName=" + Us_LoginName + ", Rs_Id=" + Rs_Id + ", Us_IsLockout=" + Us_IsLockout
				+ ", Us_ProtecMtel=" + Us_ProtecMtel + ", Us_CreateTimeMin=" + Us_CreateTimeMin + ", Us_CreateTimeMax="
				+ Us_CreateTimeMax + ", Rls_StartTimeMin=" + Rls_StartTimeMin + ", Rls_StartTimeMax=" + Rls_StartTimeMax
				+ ", Rls_FinishTimeMin=" + Rls_FinishTimeMin + ", Rls_FinishTimeMax=" + Rls_FinishTimeMax
				+ ", Rls_State=" + Rls_State + ", C_UserId=" + C_UserId + "]";
	}
	public String getCs_Name() {
		return Cs_Name;
	}
	public void setCs_Name(String cs_Name) {
		Cs_Name = cs_Name;
	}
	public Integer getCs_Sex() {
		return Cs_Sex;
	}
	public void setCs_Sex(Integer cs_Sex) {
		Cs_Sex = cs_Sex;
	}
	public String getCs_Phone() {
		return Cs_Phone;
	}
	public void setCs_Phone(String cs_Phone) {
		Cs_Phone = cs_Phone;
	}
	public Integer getCs_ClientState() {
		return Cs_ClientState;
	}
	public void setCs_ClientState(Integer cs_ClientState) {
		Cs_ClientState = cs_ClientState;
	}
	public String getCs_Source() {
		return Cs_Source;
	}
	public void setCs_Source(String cs_Source) {
		Cs_Source = cs_Source;
	}
	public Integer getUs_Id() {
		return Us_Id;
	}
	public void setUs_Id(Integer us_Id) {
		Us_Id = us_Id;
	}
	public Integer getCs_FenPei() {
		return Cs_FenPei;
	}
	public void setCs_FenPei(Integer cs_FenPei) {
		Cs_FenPei = cs_FenPei;
	}
	public String getCs_SiteSheng() {
		return Cs_SiteSheng;
	}
	public void setCs_SiteSheng(String cs_SiteSheng) {
		Cs_SiteSheng = cs_SiteSheng;
	}
	public String getCs_SiteShi() {
		return Cs_SiteShi;
	}
	public void setCs_SiteShi(String cs_SiteShi) {
		Cs_SiteShi = cs_SiteShi;
	}
	public String getCs_SiteXian() {
		return Cs_SiteXian;
	}
	public void setCs_SiteXian(String cs_SiteXian) {
		Cs_SiteXian = cs_SiteXian;
	}
	public Integer getCur_ZhuangTai() {
		return Cur_ZhuangTai;
	}
	public void setCur_ZhuangTai(Integer cur_ZhuangTai) {
		Cur_ZhuangTai = cur_ZhuangTai;
	}
	public String getCur_RecordTimeMin() {
		return Cur_RecordTimeMin;
	}
	public void setCur_RecordTimeMin(String cur_RecordTimeMin) {
		Cur_RecordTimeMin = cur_RecordTimeMin;
	}
	public String getCur_RecordTimeMax() {
		return Cur_RecordTimeMax;
	}
	public void setCur_RecordTimeMax(String cur_RecordTimeMax) {
		Cur_RecordTimeMax = cur_RecordTimeMax;
	}
	public String getUs_LoginName() {
		return Us_LoginName;
	}
	public void setUs_LoginName(String us_LoginName) {
		Us_LoginName = us_LoginName;
	}
	public Integer getRs_Id() {
		return Rs_Id;
	}
	public void setRs_Id(Integer rs_Id) {
		Rs_Id = rs_Id;
	}
	public Integer getUs_IsLockout() {
		return Us_IsLockout;
	}
	public void setUs_IsLockout(Integer us_IsLockout) {
		Us_IsLockout = us_IsLockout;
	}
	public String getUs_ProtecMtel() {
		return Us_ProtecMtel;
	}
	public void setUs_ProtecMtel(String us_ProtecMtel) {
		Us_ProtecMtel = us_ProtecMtel;
	}
	public String getUs_CreateTimeMin() {
		return Us_CreateTimeMin;
	}
	public void setUs_CreateTimeMin(String us_CreateTimeMin) {
		Us_CreateTimeMin = us_CreateTimeMin;
	}
	public String getUs_CreateTimeMax() {
		return Us_CreateTimeMax;
	}
	public void setUs_CreateTimeMax(String us_CreateTimeMax) {
		Us_CreateTimeMax = us_CreateTimeMax;
	}
	public String getRls_StartTimeMin() {
		return Rls_StartTimeMin;
	}
	public void setRls_StartTimeMin(String rls_StartTimeMin) {
		Rls_StartTimeMin = rls_StartTimeMin;
	}
	public String getRls_StartTimeMax() {
		return Rls_StartTimeMax;
	}
	public void setRls_StartTimeMax(String rls_StartTimeMax) {
		Rls_StartTimeMax = rls_StartTimeMax;
	}
	public String getRls_FinishTimeMin() {
		return Rls_FinishTimeMin;
	}
	public void setRls_FinishTimeMin(String rls_FinishTimeMin) {
		Rls_FinishTimeMin = rls_FinishTimeMin;
	}
	public String getRls_FinishTimeMax() {
		return Rls_FinishTimeMax;
	}
	public void setRls_FinishTimeMax(String rls_FinishTimeMax) {
		Rls_FinishTimeMax = rls_FinishTimeMax;
	}
	public Integer getRls_State() {
		return Rls_State;
	}
	public void setRls_State(Integer rls_State) {
		Rls_State = rls_State;
	}
	public Integer getC_UserId() {
		return C_UserId;
	}
	public void setC_UserId(Integer c_UserId) {
		C_UserId = c_UserId;
	}
	public Users getUsers() {
		return users;
	}
	public void setUsers(Users users) {
		this.users = users;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public Integer getMinNumber() {
		return minNumber;
	}
	public void setMinNumber(Integer minNumber) {
		this.minNumber = minNumber;
	}
	public Integer getMaxNumber() {
		return maxNumber;
	}
	public void setMaxNumber(Integer maxNumber) {
		this.maxNumber = maxNumber;
	}
	public String getMinTime() {
		return minTime;
	}
	public void setMinTime(String minTime) {
		this.minTime = minTime;
	}
	public String getMaxTime() {
		return maxTime;
	}
	public void setMaxTime(String maxTime) {
		this.maxTime = maxTime;
	}
	
	public List<?> getRows() {
		return rows;
	}
	public void setRows(List<?> rows) {
		this.rows = rows;
	}
	public Clients getClients() {
		return clients;
	}
	public void setClients(Clients clients) {
		this.clients = clients;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	
	
}
