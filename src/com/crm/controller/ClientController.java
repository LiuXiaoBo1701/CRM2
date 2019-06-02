package com.crm.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.crm.entity.Clients;
import com.crm.entity.Fenye;
import com.crm.entity.Message;
import com.crm.entity.Users;
import com.crm.service.ClientService;
import com.crm.service.MessageService;

@Controller
public class ClientController {
	@Autowired
	private ClientService clientService;
	@Autowired
	private Fenye fenye;
	@Autowired
	private Clients clients;
	@Resource
	private MessageService messageService;
	@Resource
	private Message message;
	@RequestMapping(value="/getClient",method=RequestMethod.POST)
	@ResponseBody
	public Fenye getClient(Integer page,Integer rows,String minTime,String maxTime,Clients clients) {
		fenye.setClients(clients);	
		fenye.setMinTime(minTime);
		fenye.setMaxTime(maxTime);
		fenye.setPageSize(rows);
		fenye.setPage((page-1)*rows);
		List<Clients> selectClient = clientService.selectClient(fenye);
		Integer countClient = clientService.countClient(fenye);
		fenye.setTotal(countClient);
		fenye.setRows(selectClient);
		System.out.println("888888888888888"+fenye+"555555");
		return fenye;
		
	}
	
	
	@RequestMapping(value="/innsertClients",method=RequestMethod.POST)
	@ResponseBody
	public Integer innsertClient(@RequestParam("add_Img") MultipartFile file,Clients clients,HttpServletRequest request,String JieShouRen,String faSongRen) throws IllegalStateException, IOException {
		// 获取Tomcat项目的绝对路径
        String tomcatAbsolutePath = request.getSession().getServletContext().getRealPath(File.separator+"image");
        System.out.println(tomcatAbsolutePath);
        // 拿到图片名
		String fileName = file.getOriginalFilename();
		// 给图片重起一个名字
		String newFileName = UUID.randomUUID()+fileName;
		System.out.println(newFileName);
		// 生成File对象
		File targetFile = new File(tomcatAbsolutePath,newFileName);
		// 保存到本地
		file.transferTo(targetFile);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		String Cs_FoundTime=sdf.format(new Date());
		clients.setCs_Img(newFileName);
		clients.setCs_FoundTime(Cs_FoundTime);
		Integer innserClient = clientService.innserClient(clients);
		//判断是否添加成功
		if(innserClient>0) {
			message.setM_InitiateName(faSongRen);//发送人
			message.setM_ReceiveName(JieShouRen);//接受人
			message.setM_Time(Cs_FoundTime);//时间
			message.setM_Content(faSongRen+"录入了一名新客户，请注意查收！");//信息
			messageService.insertMessage(message);//添加方法
			return innserClient;
		}
		return innserClient;
		
	}
	@RequestMapping(value="/fenpeizixunshi",method=RequestMethod.POST)
	@ResponseBody
	public Integer fenpeizixunshi(String Cs_ids,Integer C_Id ) {
		Integer fenpeizixunshi = clientService.fenpeizixunshi(Cs_ids, C_Id);
		return fenpeizixunshi;
		
	}
	
	 @RequestMapping(value="/getClasses",method=RequestMethod.POST)
	 @ResponseBody
	 public List<Users> getClasses() {
			  List<Users> seleceShi = clientService.seleceShi();
			
			return seleceShi;
	  }
	 

	 @RequestMapping(value="/updateshi",method=RequestMethod.POST)
	 @ResponseBody
	 public String updateshi(HttpServletRequest request) {
			return clientService.updateshi(request);
	  }
	
	 @RequestMapping(value="/selectStuSourceUrl",method=RequestMethod.POST)
	 @ResponseBody
	 public List<Map<Integer, String>> selectStuSourceUrl() {
			return clientService.selectStuSourceUrl();
	  }
}
