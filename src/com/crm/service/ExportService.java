package com.crm.service;

import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;

import com.crm.entity.Clients;
import com.crm.entity.Users;
@Service
public class ExportService {
	String[] excelHeader = { "客户名称","性别", "年龄", "电话","学历", "邮箱","QQ","微信","客户来源","客户状态","分配","地址（省）","地址（市）","地址（县）","地址（详细地址）","是否缴费","是否回访","登录名","最后一次登录时间","记录标题","意向状态","记录时间","备注"};  
	 public HSSFWorkbook export(List<Clients> list) {  
	        HSSFWorkbook wb = new HSSFWorkbook();  
	        HSSFSheet sheet = wb.createSheet("Clients");  
	        HSSFRow row = sheet.createRow((int) 0);  
	        HSSFCellStyle style = wb.createCellStyle();  
	        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
	       
	        for (short i = 0; i < excelHeader.length; i++) {  
	            HSSFCell cell = row.createCell(i);  
	            cell.setCellValue(excelHeader[i]);  
	            cell.setCellStyle(style);  
	            sheet.autoSizeColumn(i);  
	            sheet.setColumnWidth(i, 40 * 80);  
	        }  
	  
	        for (int i = 0; i < list.size(); i++) {   
            row = sheet.createRow(i + 1);  
            Clients clients = list.get(i); 
          if(clients!=null) {
              row.createCell(0).setCellValue(clients.getCs_Name());  
              row.createCell(1).setCellValue(clients.getCs_Sex());
			  row.createCell(2).setCellValue(clients.getCs_Age());
			  row.createCell(3).setCellValue(clients.getCs_Phone());
			  row.createCell(4).setCellValue(clients.getCs_Xueli());
			  row.createCell(5).setCellValue(clients.getCs_Email());
			  row.createCell(6).setCellValue(clients.getCs_QQ());
			  row.createCell(7).setCellValue(clients.getCs_WeiXin());
			  row.createCell(8).setCellValue(clients.getCs_Source());
			  row.createCell(9).setCellValue(clients.getCs_ClientState());
			  row.createCell(10).setCellValue(clients.getCs_FenPei());
			  row.createCell(11).setCellValue(clients.getCs_SiteSheng());
			  row.createCell(12).setCellValue(clients.getCs_SiteShi());
			  row.createCell(13).setCellValue(clients.getCs_SiteXian());
			  row.createCell(14).setCellValue(clients.getCs_SiteXiangXi());
			  row.createCell(15).setCellValue(clients.getCs_IsJiaoFei());
			  row.createCell(16).setCellValue(clients.getCs_IsHuiFang());
          }
			  if(clients.getUsers()!=null) {
				  row.createCell(17).setCellValue(clients.getUsers().getUs_LoginName());
				  row.createCell(18).setCellValue(clients.getUsers().getUs_LastLoginTime());
			  }
			  if(clients.getClientUserRecord()!=null) {
				  row.createCell(19).setCellValue(clients.getClientUserRecord().getCur_Title()); 
				  row.createCell(20).setCellValue(clients.getClientUserRecord().getCur_ZhuangTai());
				  row.createCell(21).setCellValue(clients.getClientUserRecord().getCur_RecordTime());
				  row.createCell(22).setCellValue(clients.getClientUserRecord().getCur_Remark());
			  } 
        }  
        return wb;  
    }  
	 String[] excelHeaderUser = { "用户名","所属角色", "创立时间", "是否锁定","被锁定时间", "签到状态", "签到时间","签退时间", "邮箱","手机号","客户数量"};  
	 public HSSFWorkbook exportUser(List<Users> list) {  
	        HSSFWorkbook wb = new HSSFWorkbook();  
	        HSSFSheet sheet = wb.createSheet("UserRoles");  
	        HSSFRow row = sheet.createRow((int) 0);  
	        HSSFCellStyle style = wb.createCellStyle();  
	        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
	       
	        for (short i = 0; i < excelHeaderUser.length; i++) {  
	            HSSFCell cell = row.createCell(i);  
	            cell.setCellValue(excelHeaderUser[i]);  
	            cell.setCellStyle(style);  
	            sheet.autoSizeColumn(i);  
	            sheet.setColumnWidth(i, 40 * 80);  
	        }  
	  
	        for (int i = 0; i < list.size(); i++) {   
            row = sheet.createRow(i + 1);  
            Users users = list.get(i); 
          
            row.createCell(0).setCellValue(users.getUs_LoginName());  
            if(users.getRoles()!=null) {
            	 row.createCell(1).setCellValue(users.getRoles().getRs_Name());
            }
			  row.createCell(2).setCellValue(users.getUs_CreateTime());
			  row.createCell(3).setCellValue(users.getUs_IsLockout());
			  row.createCell(4).setCellValue(users.getUs_LockTime());
			  if(users.getConsultantLabels()!=null) {
		      row.createCell(5).setCellValue(users.getConsultantLabels().getRls_State());
		      row.createCell(6).setCellValue(users.getConsultantLabels().getRls_StartTime());
		      row.createCell(7).setCellValue(users.getConsultantLabels().getRls_FinishTime());
			  }
			  row.createCell(8).setCellValue(users.getUs_ProtecEmail());
			  row.createCell(9).setCellValue(users.getUs_ProtecMtel());
			  if(users.getClients()!=null) {
			  row.createCell(10).setCellValue(users.getClients().getCs_Id());
			  }
			 
          }  
        return wb;  
    }   
	 
}
