package com.crm.dao;

import java.util.List;

import com.crm.entity.Fenye;
import com.crm.entity.Message;

public interface MessageMapper {
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
	 * 分页查询所有消息
	 * @param fenye
	 * @return
	 */
	List<Message> selectMessageByAll(Fenye fenye);
	/**
	 * 查询总条数
	 * @param fenye
	 * @return
	 */
	Integer selectMessageCount(Fenye fenye);
	/**
	 * 修改信息状态为（1）已读
	 * @param M_ReceiveName
	 * @return
	 */
	Integer updateMessageState(String M_ReceiveName);
}
