package com.crm.service;

import com.crm.entity.ClientUserRecord;
import com.crm.entity.Clients;
import com.crm.entity.Fenye;
/**
 * 咨询师所对应的客户表的业务接口
 * @author zhaodongliang
 *
 */
public interface ConsultantClientsService {
	/**
	 * 多条件分页查询
	 * @param fenye
	 * @return
	 */
	Fenye selectClientsByAll(Fenye fenye);
	
	/**
	 * 根据Cs_Id修改客户信息
	 * @param clients
	 * @return
	 */
	Integer updateClient(Clients clients);
	/**
	 * 添加跟踪记录信息
	 * @param cur
	 * @return
	 */
	Integer insertClientUserRecord(ClientUserRecord cur);
	/**
	 * 导出excel
	 * @param StudentData
	 * @param datagridTitle
	 * @param filePath
	 * @return
	 */
	Integer export(String StudentData,String datagridTitle,String filePath);
	

}
