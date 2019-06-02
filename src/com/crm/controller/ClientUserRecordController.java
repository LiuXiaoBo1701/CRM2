package com.crm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.entity.ClientUserRecord;
import com.crm.entity.Clients;
import com.crm.entity.Fenye;
import com.crm.entity.Users;
import com.crm.service.ClientUserRecordService;

@Controller
public class ClientUserRecordController {
	@Autowired
	private ClientUserRecordService clientUserRecordService;
	@Autowired
	private Fenye fenye;
	@RequestMapping(value="/selectClientUserRecordByAll",method=RequestMethod.POST)
	@ResponseBody	
	public Fenye selectClientUserRecordByAll(@RequestParam(value="rows") Integer pageSize,Integer page,String minTime,String maxTime,ClientUserRecord clientUserRecord) {
		System.out.println(clientUserRecord);
		fenye.setMaxTime(maxTime);
		fenye.setMinTime(minTime);
		
		fenye.setClientUserRecord(clientUserRecord);
		  fenye.setPageSize(pageSize);
		 fenye.setPage((page-1)*pageSize);
		  System.out.println(fenye);
		   Fenye selectClientUserRecordByAll = clientUserRecordService.selectClientUserRecordByAll(fenye);
		   System.out.println("111111111111111"+selectClientUserRecordByAll);
		  return selectClientUserRecordByAll;	
	}
	@RequestMapping(value="/selectZHaoUsers",method=RequestMethod.POST)
	@ResponseBody	
	public List<Users> selectZHaoUsers() {		
		  return clientUserRecordService.selectUsers();	
	}
}
