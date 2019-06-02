package com.crm.controller;


import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Date;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.entity.Clients;
import com.crm.entity.ConsultantLabels;
import com.crm.entity.Fenye;
import com.crm.entity.Message;
import com.crm.entity.Users;
import com.crm.service.ClientsUsersService;
import com.crm.service.MessageService;
import com.crm.service.UserRolesService;



@Controller
public class ClientsUsersController {
	@Autowired
	private  ClientsUsersService clientsUsersService;
	@Autowired
	private  Clients clients;
	@Autowired
	private UserRolesService userRolesService;
	@Resource
	private MessageService messageService;
	@Resource
	private Message message;

	@RequestMapping(value="/SelectClientsUsers",method=RequestMethod.POST)
	@ResponseBody
	public Fenye  SelectClientsUsers(HttpServletRequest s,@RequestParam(value="rows") Integer pageSize,Fenye fenye) {
		fenye.setPageSize(pageSize);
		fenye.setPage((fenye.getPage()-1)*pageSize);
		Fenye selectClientsUsers = clientsUsersService.SelectClientsUsers(fenye);
		return selectClientsUsers;
	}
	
	//下拉框
		@RequestMapping(value="/selectUsers",method=RequestMethod.POST)
		@ResponseBody
		public List<Users> selectUsers( ) {
			List<Users> selectUsers = clientsUsersService.SelectUsers();
			return selectUsers;
			
		}
    //下拉框
		@RequestMapping(value="/ziXunSHiQianDaoFenLiangOption",method=RequestMethod.POST)
		@ResponseBody
		public List<Users> selectZiXunSHiQianDaoFenLiangOption( ) {
			List<Users> selectZiXunSHiQianDaoFenLiangOption = clientsUsersService.ZiXunSHiQianDaoFenLiangOption();
			return selectZiXunSHiQianDaoFenLiangOption;
			
		}
		
	@RequestMapping(value="/SelectUsersRolesClients",method=RequestMethod.POST)
	@ResponseBody
	public Fenye  SelectUsersRolesClients(HttpServletRequest s,@RequestParam(value="rows") Integer pageSize,Fenye fenye) {
		fenye.setPageSize(pageSize);
		fenye.setPage((fenye.getPage()-1)*pageSize);
		Fenye selectClientsUsers = clientsUsersService.SelectUsersRolesClients(fenye);
		List<Users> selectUsers = clientsUsersService.SelectUsers();
		HttpSession  session=s.getSession(true);
		session.setAttribute("selectUsers", selectUsers);
		return selectClientsUsers;
	}
	
	//添加
	@RequestMapping(value="/innsertClient",method=RequestMethod.POST)
	@ResponseBody
	public Integer innsertClient(Clients clients) {
		Integer innserClient = clientsUsersService.innserClient(clients);
		return innserClient;
		
	}
	//自动分量开启
	@RequestMapping(value="/ClientsUsersFenLiangZhuangTaiKaiQi",method=RequestMethod.POST)
	@ResponseBody
	public Integer ClientsUsersFenLiangZhuangTaiKaiQi(Fenye fenye,HttpServletRequest s) {
		
		Integer clientsUsersFenLiangZhuangTaiKaiQi = clientsUsersService.ClientsUsersFenLiangZhuangTaiKaiQi(fenye);
	
		return clientsUsersFenLiangZhuangTaiKaiQi;
		
	}
	//关闭
	@RequestMapping(value="/ClientsUsersFenLiangZhuangTaiGuanBi",method=RequestMethod.POST)
	@ResponseBody
	public Integer ClientsUsersFenLiangZhuangTaiGuanBi(Fenye fenye,HttpServletRequest s) {
	 Integer clientsUsersFenLiangZhuangTaiGuanBi = clientsUsersService.ClientsUsersFenLiangZhuangTaiGuanBi(fenye);
	
		return clientsUsersFenLiangZhuangTaiGuanBi;
		
	}
	//图表成交率
		@RequestMapping(value="/SelectTuBiaoLiuShiLv",method=RequestMethod.POST)
		@ResponseBody
		public Double SelectTuBiaoLiuShiLv(Fenye fenye) {
			Double clientsUsersFenLiangZhuangTaiGuanBi = clientsUsersService.SelectTuBiaoLiuShiLv(fenye);
			return clientsUsersFenLiangZhuangTaiGuanBi;
			
		}
		//手动分量
		@RequestMapping(value="/UsersQianDaoFenLiang",method=RequestMethod.POST)
		@ResponseBody
		public Integer UsersQianDaoFenLiang(HttpServletRequest s, Integer C_Id, String Cs_Id,String JieShouRen,String faSongRen){
				String[] Cs_Idb = Cs_Id.split(",");
				Integer usersQianDaoFenLiang=null;
		        for(int i=0;i<Cs_Idb.length;i++){
		        	clients.setC_Id(C_Id);
		        	clients.setCs_Id(Integer.parseInt(Cs_Idb[i]));
		        	usersQianDaoFenLiang = clientsUsersService.UsersQianDaoFenLiang(clients);
		        }
		        if(usersQianDaoFenLiang>0) {
		        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");  
		    		String Time=sdf.format(new Date());	
					message.setM_InitiateName(faSongRen);//发送人
					message.setM_ReceiveName(JieShouRen);//接受人
					message.setM_Time(Time);//时间
					message.setM_Content(faSongRen+"给您分配了一名新客户，请注意查收！");//信息
					messageService.insertMessage(message);//添加方法
					return usersQianDaoFenLiang;
				}
				return usersQianDaoFenLiang;

		}
		//自动分量
	@RequestMapping(value="/ZiDongFenLiang",method=RequestMethod.POST,produces="text/html;charset=utf-8")
	@ResponseBody
	public String ZiDongFenLiang(Fenye fenye, String Cs_Id,HttpServletRequest s,String faSongRen) {
		HttpSession  session=s.getSession(true);
		Users usersLoginState = userRolesService.UsersLoginState(fenye);
		session.setAttribute("usersLoginState", usersLoginState);
		List<Users> selectQianDaoZiXuShiZiDongFenLiang = clientsUsersService.SelectQianDaoZiXuShiZiDongFenLiang();//根据签到状态 和他有咨询师角色
		String[] Cs_Idb = Cs_Id.split(",");//对多个客户id进行分割
		Integer usersQianDaoFenLiang=null;
		String arr="";
        for(int i=0;i<Cs_Idb.length;i++){
        	paixu(selectQianDaoZiXuShiZiDongFenLiang);//排序
        	clients.setCs_Id(Integer.parseInt(Cs_Idb[i]));//设置客户id
        	System.out.println("第"+i+"次咨询师id："+selectQianDaoZiXuShiZiDongFenLiang.get(0).getUs_Id());
            clients.setC_Id(selectQianDaoZiXuShiZiDongFenLiang.get(0).getUs_Id());;//设置用户id
            usersQianDaoFenLiang = clientsUsersService.UsersQianDaoFenLiang(clients);//根据用户id和客户id修改
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");  
    		String Time=sdf.format(new Date());	
			message.setM_InitiateName(faSongRen);//发送人
			String name=selectQianDaoZiXuShiZiDongFenLiang.get(0).getUs_LoginName();
			arr+=name+",";
			message.setM_ReceiveName(selectQianDaoZiXuShiZiDongFenLiang.get(0).getUs_LoginName());//接受人
			message.setM_Time(Time);//时间
			message.setM_Content(faSongRen+"给您分配了一名新客户，请注意查收！");//信息
			messageService.insertMessage(message);//添加方法
            selectQianDaoZiXuShiZiDongFenLiang.get(0).getClients().setCs_Ext1(selectQianDaoZiXuShiZiDongFenLiang.get(0).getClients().getCs_Ext1()+1);//让数据变化或者把查询结果放循环里面
        }
        System.out.println("33333333333333333333333333333333333333333333333333333333333333333"+arr);
       return arr;
      
	}
	public static void paixu(List<Users> UserList) { //根据用户的权重 客户数量
		Collections.sort(UserList, new Comparator<Users>() {
			@Override
			public int compare(Users o1, Users o2) {
				if(o1!=null && o2!=null) {
					if(o1.getClients().getCs_Ext1()>o2.getClients().getCs_Ext1()){
						System.out.println("当前咨询师客户数量大于下一个:"+o1.getUs_LoginName());
		                return 1;
		            }else if(o1.getClients().getCs_Ext1()<o2.getClients().getCs_Ext1()){
		            	System.out.println("当前咨询师客户数量小于下一个:"+o1.getUs_LoginName());
		                return -1;
		            }else if(o1.getClients().getCs_Ext1()==o2.getClients().getCs_Ext1()) {
		            	if(o1.getConsultant().getC_Weight()>o2.getConsultant().getC_Weight()) {
		            		System.out.println("客户数量相等权重大于下一个:"+o1.getUs_LoginName());
		            		return -1;
		            	}
		            }
				}
	            return 0;
			}
		});
	}

}
