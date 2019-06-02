package com.crm.dao;

import java.util.List;

import com.crm.entity.ClientUserRecord;
import com.crm.entity.Clients;
import com.crm.entity.Fenye;
	/**
	 * 咨询师所对应的客户表
	 * @author zhaodongliang
	 *
	 */
	public interface ConsultantClientsMapper {
	/**
	 * 多条件查询所有客户数据
	 * @param fenye
	 * @return
	 */
	List<Clients> selectClientsByAll(Fenye fenye);
	/**
	 * 多条件查询总条数
	 * @param fenye
	 * @return
	 */
	Integer selectClientsCount(Fenye fenye);
	/**
	 * 修改客户跟踪记录
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

}
