package com.crm.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crm.dao.MessageMapper;
import com.crm.entity.Fenye;
import com.crm.entity.Message;

@Service
public class MessageServiceImpl implements MessageService {

	@Resource
	private MessageMapper messageMapper;
	
	@Override
	public Integer selectMessageWeiJieShouCount(String usersName) {
		// TODO Auto-generated method stub
		return messageMapper.selectMessageWeiJieShouCount(usersName);
	}
	@Override
	public Integer insertMessage(Message message) {
		// TODO Auto-generated method stub
		return messageMapper.insertMessage(message);
	}
	@Override
	public Integer updateMessageState(String M_ReceiveName) {
		// TODO Auto-generated method stub
		return messageMapper.updateMessageState(M_ReceiveName);
	}
	@Override
	public Fenye selectMessageByAll(Fenye fenye) {
		// TODO Auto-generated method stub
		
		
		fenye.setRows(messageMapper.selectMessageByAll(fenye));
		fenye.setTotal(messageMapper.selectMessageCount(fenye));
		return fenye;
	}
	
}
