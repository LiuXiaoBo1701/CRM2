package com.crm.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crm.dao.ConsultantClientsMapper;
import com.crm.entity.ClientUserRecord;
import com.crm.entity.Clients;
import com.crm.entity.Fenye;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Service
public class ConsultantClientsServiceImp implements ConsultantClientsService {
	@Autowired
	private ConsultantClientsMapper consultantClientsMapper;
	public Fenye selectClientsByAll(Fenye fenye) {
		// TODO Auto-generated method stub
		fenye.setRows(consultantClientsMapper.selectClientsByAll(fenye));
		fenye.setTotal(consultantClientsMapper.selectClientsCount(fenye));
		return fenye;
	}
	public Integer updateClient(Clients clients) {
		// TODO Auto-generated method stub
		return consultantClientsMapper.updateClient(clients);
	}
	public Integer insertClientUserRecord(ClientUserRecord cur) {
		// TODO Auto-generated method stub
		 
		return consultantClientsMapper.insertClientUserRecord(cur);
	}
	public Integer export(String StudentData,String datagridTitle,String filePath) {
					/*ServletOutputStream out = null;*/
		List<Clients> list1 = new ArrayList<Clients>(); // 先把json 字符串转换为json 数组 
		String[] Titles = datagridTitle.split(",");//分割字符串放进一个数组中
		
		JSONArray jsonArray1 = JSONArray.fromObject(StudentData); //循环获取json数组中的 json 对象，然后转换为 object 
		for (int j = 0; j < jsonArray1.size(); j++) {
			JSONObject jsonObject2 = jsonArray1.getJSONObject(j);
			Clients cust = (Clients) JSONObject.toBean(jsonObject2, Clients.class); 
			list1.add(cust); 
			} 
					System.out.println(datagridTitle);
		
		/* String filePath="sample.xls";文件路径 */
		 			// 第一步，创建一个workbook，对应一个Excel文件
		             HSSFWorkbook workbook = new HSSFWorkbook();
		            // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
		             HSSFSheet hssfSheet = workbook.createSheet("sheet1");
		             // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
		             HSSFRow hssfRow = hssfSheet.createRow(0);
		            // 第四步，创建单元格，并设置值表头 设置表头居中
		            HSSFCellStyle hssfCellStyle = workbook.createCellStyle();
		            //居中样式
		            hssfCellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		    		HSSFCell hssfCell = null;		           
		
		  for(int i = 0; i < Titles.length-2; i++) { 
			  hssfCell = hssfRow.createCell(i);//列索引从0开始 
			  hssfCell.setCellValue(Titles[i+2]);//列名1
			  hssfCell.setCellStyle(hssfCellStyle);//列居中显示
		  }
		 
		            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		            if(list1 != null){
		            	for (int i = 0; i < list1.size(); i++) {
		            		 HSSFRow createRow = hssfSheet.createRow(i+1);
		            		 createRow.createCell(0).setCellValue(list1.get(i).getCs_Id());
		            		 createRow.createCell(1).setCellValue(list1.get(i).getCs_Img());
		            		 createRow.createCell(2).setCellValue(list1.get(i).getCs_Name());		
		            		 createRow.createCell(3).setCellValue(list1.get(i).getCs_Sex());
		            		 createRow.createCell(4).setCellValue(list1.get(i).getCs_Age());
		            		 createRow.createCell(5).setCellValue(list1.get(i).getCs_Phone());
		            		 createRow.createCell(6).setCellValue(list1.get(i).getCs_Xueli());
		            		 createRow.createCell(7).setCellValue(list1.get(i).getCs_Email());
		            		 createRow.createCell(8).setCellValue(list1.get(i).getCs_QQ());
		            		 createRow.createCell(9).setCellValue(list1.get(i).getCs_WeiXin());
		            		 createRow.createCell(10).setCellValue(list1.get(i).getCs_Source());
		            		 createRow.createCell(11).setCellValue(list1.get(i).getCs_ClientState());
		            		 createRow.createCell(12).setCellValue(list1.get(i).getCs_FenPei());
		            		 createRow.createCell(13).setCellValue(list1.get(i).getCs_SiteSheng());
		            		 createRow.createCell(14).setCellValue(list1.get(i).getCs_SiteShi());
		            		 createRow.createCell(15).setCellValue(list1.get(i).getCs_SiteXian());
		            		 createRow.createCell(16).setCellValue(list1.get(i).getCs_SiteXiangXi());
		            		 createRow.createCell(17).setCellValue(list1.get(i).getCs_IsJiaoFei());
				
							  createRow.createCell(18).setCellValue(list1.get(i).getCs_IsHuiFang());
							  createRow.createCell(19).setCellValue(list1.get(i).getCs_IsValid());
							  createRow.createCell(20).setCellValue(list1.get(i).getCs_IsVisit());
							  createRow.createCell(21).setCellValue(list1.get(i).getCs_BirthTime());
							  createRow.createCell(22).setCellValue(list1.get(i).getCs_IsTuiFen());
							  createRow.createCell(23).setCellValue(list1.get(i).getCs_TuiFenInfo());
							  createRow.createCell(24).setCellValue(list1.get(i).getCs_IsJinBan());
							  createRow.createCell(25).setCellValue(list1.get(i).getCs_HuiFangInfo());
							  createRow.createCell(26).setCellValue(list1.get(i).getCs_Courses());
							  createRow.createCell(27).setCellValue(list1.get(i).getCs_Money());
							  createRow.createCell(28).setCellValue(list1.get(i).getCs_Grade());
							  createRow.createCell(29).setCellValue(list1.get(i).getCs_IsValidInfo());
							  createRow.createCell(30).setCellValue(list1.get(i).getCs_HuiFangTime());
							  createRow.createCell(31).setCellValue(list1.get(i).getCs_VisitTime());
							  createRow.createCell(32).setCellValue(list1.get(i).getCs_JiaoFeiTime());
							  createRow.createCell(33).setCellValue(list1.get(i).getCs_FoundTime());
							  createRow.createCell(34).setCellValue(list1.get(i).getCs_JinBanTime());
							  createRow.createCell(35).setCellValue(list1.get(i).getCs_ShenFenZheng());
							  createRow.createCell(36).setCellValue(list1.get(i).getCs_BirthTime());
							  createRow.createCell(37).setCellValue(list1.get(i).getCs_ConsultantRemark());
							  createRow.createCell(38).setCellValue(list1.get(i).getCs_Remark());
							  createRow.createCell(38).setCellValue(list1.get(i).getCs_Weight());
							 
							
							 
		            	}
		         }
		            try {
		            	FileOutputStream out = new FileOutputStream(filePath+".xls");
		            	workbook.write(out);//保存Excel文件
		            	out.close();//关闭文件流 
                         return 1;
					} catch (IOException e) {
						e.printStackTrace();
						 return -1;
					}		                  		           
	}
	
	
	
	

}
