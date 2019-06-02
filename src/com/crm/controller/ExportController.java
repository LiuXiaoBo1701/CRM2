package com.crm.controller;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.crm.entity.Clients;
import com.crm.entity.Users;
import com.crm.service.ClientsUsersService;
import com.crm.service.ExportService;
import com.crm.service.UserRolesService;
@Controller
public class ExportController {
	@Autowired
	private  ClientsUsersService clientsUsersService;
	@Autowired 
	UserRolesService userRolesService;
	@Autowired
	private  ExportService exportService;
	 @RequestMapping(value = "/excel/export")  
	    public void exportExcel(HttpServletRequest request, HttpServletResponse response)   throws Exception {  
		 String Cs_Ids=request.getParameter("Cs_Id");
			String[] Cs_Id = Cs_Ids.split(",");
			List<Clients> list=new  ArrayList<Clients>();
	        for(int i=0;i<Cs_Id.length;i++){
	        	 List<Clients> book = clientsUsersService.SelectClientsUsersExport(Integer.parseInt(Cs_Id[i]));
	             list.addAll(book);  
	        }
	        HSSFWorkbook wb = exportService.export(list);
	        response.setContentType("application/vnd.ms-excel");  
	        response.setHeader("Content-disposition", "attachment;filename=Clients.xls"); 
	        OutputStream ouputStream = response.getOutputStream();  
	        wb.write(ouputStream);  
	        ouputStream.flush();  
	        ouputStream.close();  
	   }  
	 @RequestMapping(value = "/excel/exportUserRoles")  
	    public void exportExcelUser(HttpServletRequest request, HttpServletResponse response)   throws Exception {  
		 String Us_Ids=request.getParameter("Us_Id");
			String[] Us_Id = Us_Ids.split(",");
			List<Users> list=new  ArrayList<Users>();
	        for(int i=0;i<Us_Id.length;i++){
	        	 List<Users> book = userRolesService.SelectUserRolesExport(Integer.parseInt(Us_Id[i]));
	             list.addAll(book);  
	        }
	        HSSFWorkbook wb = exportService.exportUser(list);
	        response.setContentType("application/vnd.ms-excel");  
	        response.setHeader("Content-disposition", "attachment;filename=UserRoles.xls"); 
	        OutputStream ouputStream = response.getOutputStream();  
	        wb.write(ouputStream);  
	        ouputStream.flush();  
	        ouputStream.close();  
	   }  
}
