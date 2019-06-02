package com.crm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.entity.Fenye;
import com.crm.entity.Message;
import com.crm.service.MessageService;

@Controller
public class MessageController {

	@Autowired
	private MessageService messageService;
	@Autowired
	private Fenye fenye;
	@RequestMapping(value="/selectMessageWeiJieShouCount",method=RequestMethod.POST)
	@ResponseBody
	public Integer selectMessageWeiJieShouCount(String usersName) {
		Integer selectMessageWeiJieShouCount = messageService.selectMessageWeiJieShouCount(usersName);
		return selectMessageWeiJieShouCount;
	}
	@RequestMapping(value="/selectMessageByAll",method=RequestMethod.POST)
	@ResponseBody
	public Fenye selectMessageByAll(Integer rows,Integer page,Message message) {
		fenye.setMessage(message);
		fenye.setPageSize(rows);
		fenye.setPage((page-1)*rows);
		 Fenye selectMessageByAll = messageService.selectMessageByAll(fenye);
		return selectMessageByAll;
	}
	@RequestMapping(value="/updateMessageState",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateMessageState(String M_ReceiveName) {		 
		return messageService.updateMessageState(M_ReceiveName);
	}
}
