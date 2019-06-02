package com.crm.dao;

import java.util.List;
import java.util.Map;

import com.crm.entity.Clients;
import com.crm.entity.Consultant;
import com.crm.entity.Fenye;
import com.crm.entity.Users;

public interface ClientMapper {
	/**
	 * 查询总条数
	 * 
	 * @param fenye
	 * @return分页
	 */
	Integer countClient(Fenye fenye);

	/**
	 * 查询数据
	 * 
	 * @param fenye
	 * @return分页查询数据
	 */
	List<Clients> selectClient(Fenye fenye);

	/**
	 * 删除数据
	 * 
	 * @param id
	 * @return是否成功返回值1or0
	 */
	Integer deleClient(Integer id);
	/*		*//**
				 * 修改客户表
				 * 
				 * @param clients
				 * @return 是否成功
				 */
	/*
	 * Integer updateClient(Clients clients);
	 */
	
	/**
	 * 添加数据
	 * 
	 * @param clients
	 * @return是否添加成功
	 */
	 Integer innserClient(Clients clients);
	 /**
	  * 修改客户基本信息
	  * @param cs_Id
	  * @return
	  */
	 Integer updatashi(Integer cs_Id);
	/**
	 * 查询所有咨询师
	 * @return
	 */
	 List<Users> seleceShi();
	 
	 Integer fenpeizixinshi(Clients clients);
	 /**
	  * 首页客户来源统计图
	  * @return
	  */
	 List<Map<Integer, String>> selectStuSourceUrl();

			 
}
