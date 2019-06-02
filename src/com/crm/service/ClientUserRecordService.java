package com.crm.service;

import java.util.List;

import com.crm.entity.ClientUserRecord;
import com.crm.entity.Fenye;
import com.crm.entity.Users;
/**
 * 跟踪记录表实现接口
 * @author zhaodongliang
 *
 */
public interface ClientUserRecordService {
	/**
	 * 多条件分页查询跟踪记录表
	 * @param fenye
	 * @return
	 */
	Fenye selectClientUserRecordByAll(Fenye fenye);
	/**
	 * 查询所有用户
	 * @return
	 */
	List<Users> selectUsers();
}
