package com.crm.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

public class FileServiceImpl implements FileService {

	
	public String upLoadFile(MultipartFile add_Img) {
	      //定义文件保存的本地路径  
	      String localPath="C:\\Users\\LiuBo\\Desktop\\刘晓博\\CRM\\WebContent\\image";  
	      //定义 文件名  
	      String filename=null;    
	      if(add_Img.isEmpty()){    
	          //生成uuid作为文件名称    
	          String uuid = UUID.randomUUID().toString().replaceAll("-","");    
	          //获得文件类型（可以判断如果不是图片，禁止上传）    
	          String contentType=add_Img.getContentType();    
	          //获得文件后缀名   
	          String suffixName=contentType.substring(contentType.indexOf("/")+1);  
	          //得到 文件名  
	          filename=uuid+"."+suffixName;   
	          System.out.println(filename);  
	          //文件保存路径  
	          try {
				add_Img.transferTo(new File(localPath+filename));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	      }  
	      return "MyJsp";  
	}
}
