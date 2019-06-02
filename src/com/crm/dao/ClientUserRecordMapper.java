package com.crm.dao;

import java.util.List;

import com.crm.entity.ClientUserRecord;
import com.crm.entity.Fenye;
import com.crm.entity.Users;
/**
 * 咨询师所对应的跟踪记录表
 * @author zhaodongliang
 *
 */
public interface ClientUserRecordMapper {
	/**
	 * 多条件查询跟踪记录表
	 * @param fenye
	 * @return
	 */
	List<ClientUserRecord> selectClientUserRecordByAll(Fenye fenye);
	/**
	 * 多条件查询总条数
	 * @param fenye
	 * @return
	 */
	Integer selectClientUserRecordCount(Fenye fenye);
	/**
	 * 查询所有用户
	 * @return
	 */
	List<Users> selectUsers();
	

}
