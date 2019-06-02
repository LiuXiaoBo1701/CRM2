package com.crm.service;

import com.crm.entity.Fenye;
import com.crm.entity.Message;

public interface MessageService {

	/**
	 * 根据用户名查询该用户未收到的信息
	 * @return
	 */
	Integer selectMessageWeiJieShouCount(String usersName);
	/**
	 * 添加一条信息
	 * @return
	 */
	Integer insertMessage(Message message);
	/**
	 * 修改信息状态为（1）已读
	 * @param M_ReceiveName
	 * @return
	 */
	Integer updateMessageState(String M_ReceiveName);
	/**
	 * 分页查询所有消息
	 * @param fenye
	 * @return
	 */
	Fenye selectMessageByAll(Fenye fenye);
}
