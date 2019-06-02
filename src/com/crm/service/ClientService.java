package com.crm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.crm.entity.Clients;
import com.crm.entity.Fenye;
import com.crm.entity.Users;

public interface ClientService {

	Integer countClient(Fenye fenye);
	
	List<Clients> selectClient(Fenye fenye);
	
	List<Clients> SelectBookBid(int parseInt);
	//添加数据
	 Integer innserClient(Clients clients);
	 
	 List<Users> seleceShi();
	 /**
	  * 修改咨询师
	  * @param request
	  * @return
	  */
	 String updateshi(HttpServletRequest request);
	 
	 Integer fenpeizixunshi(String Cs_ids,Integer C_Id);
	 /**
	  * 首页客户来源统计图
	  * @return
	  */
	 List<Map<Integer, String>> selectStuSourceUrl();

}
