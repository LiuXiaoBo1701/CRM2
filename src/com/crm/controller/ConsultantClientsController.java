package com.crm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.entity.ClientUserRecord;
import com.crm.entity.Clients;
import com.crm.entity.Fenye;
import com.crm.service.ConsultantClientsService;




@Controller
public class ConsultantClientsController {
	@Autowired
	private ConsultantClientsService consultantClientsService;
	@Autowired
	private Fenye fenye;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss aa");  
	 String time=sdf.format(new Date());
	@RequestMapping(value="/selectCstClientsByAll",method=RequestMethod.POST)
	@ResponseBody	
	public Fenye selectCstClientsByAll(@RequestParam(value="rows") Integer pageSize,Integer page,String minTime,String maxTime,Clients clients) {
		System.out.println(clients);
		fenye.setMaxTime(maxTime);
		fenye.setMinTime(minTime);
		
		fenye.setClients(clients);
		  fenye.setPageSize(pageSize);
		 fenye.setPage((page-1)*pageSize);
		
		  System.out.println(fenye);
		  Fenye selectClientsByAll = consultantClientsService.selectClientsByAll(fenye);		 	
		  return selectClientsByAll;	
	}
	@RequestMapping(value="/updateClient",method=RequestMethod.POST)
	@ResponseBody
	public int updateClient(Clients clients) {
		System.out.println(clients+"1111111111");
		return consultantClientsService.updateClient(clients);
	}
	@RequestMapping(value="/insertClientUserRecord",method=RequestMethod.POST)
	@ResponseBody
	public int insertClientUserRecord(ClientUserRecord clientUserRecord) {
		
		
		 clientUserRecord.setCur_RecordTime(time);
		
		 
		 System.out.println(clientUserRecord+"1111111111");
		return consultantClientsService.insertClientUserRecord(clientUserRecord);
	}
	@RequestMapping(value="/exportExcel",method=RequestMethod.POST)
	@ResponseBody
	public Integer exportExcel(String ClientsData,String datagridTitle,String filePath) {
		 System.out.println(datagridTitle+"1111111111111111111111111"+ClientsData+"22222222222222222222222222"+filePath);
		
		return consultantClientsService.export(ClientsData, datagridTitle,filePath);
	}
	
	

}
