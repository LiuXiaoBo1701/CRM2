package com.crm.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.crm.entity.Fenye;
import com.crm.entity.Users;
import com.crm.service.UserRolesService;
import com.crm.service.UsersService;
import com.crm.util.MD5Util;

@Controller
public class UsersController {

	@Autowired
	private UsersService usersService;
	@Autowired
	private UserRolesService userRolesService;
	@Autowired
	private Fenye fenye;
	@Autowired
	private Users users;

	@RequestMapping(value="/selectUsersAll",method=RequestMethod.POST)
	@ResponseBody
	public Fenye selectUsersAll(Integer rows,Integer page,Users users,String minTime,String maxTime){
		fenye.setPageSize(rows);
		fenye.setPage((page-1)*rows);
		fenye.setUsers(users);
		fenye.setMaxTime(maxTime);
		fenye.setMinTime(minTime);
		Fenye selectUsersAll = usersService.selectUsersAll(fenye);
		return selectUsersAll;
	}
	
	@RequestMapping(value="/insertUsers",method=RequestMethod.POST)
	@ResponseBody
	public Integer insertUsers(@RequestParam("add_Img") MultipartFile file,Users users,HttpServletRequest request) throws IllegalStateException, IOException{
		//根据输入的用户名进行查询
		Integer selectusersByName = usersService.selectUsersByName(users.getUs_LoginName());
			//判断用户名是否存在
			if(selectusersByName==0) {
				//根据输入的邮箱进行查询
				Integer selectusersByEmail = usersService.selectUsersByEmail(users.getUs_ProtecEmail());
				//判断邮箱是否存在
				if(selectusersByEmail==0) {
					//根据输入的手机号进行查询
					Integer selectusersByMtel = usersService.selectUsersByMtel(users.getUs_ProtecMtel());
					//判断手机号是否存在
					if(selectusersByMtel==0) {
						// 获取Tomcat项目的绝对路径
			            String tomcatAbsolutePath = request.getSession().getServletContext().getRealPath(File.separator+"image");
	        	        // 拿到图片名
	        			String fileName = file.getOriginalFilename();
	        			// 给图片重起一个名字
	        			String newFileName = UUID.randomUUID()+fileName;
	        			// 生成File对象
        				File targetFile = new File(tomcatAbsolutePath,newFileName);
        				// 保存到本地
        				file.transferTo(targetFile);
						//密码加密
						String us_PassWord = users.getUs_PassWord();
						String pwd = MD5Util.getPwd(us_PassWord);
						users.setUs_PassWord(pwd);
						//转换提日期输出格式     获取当前时间
						Date date = new Date();
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						users.setUs_UserImg(newFileName);
						users.setUs_CreateTime(dateFormat.format(date));
						//添加用户成功
						Integer i = usersService.insertUsers(users);
						return i;
					}else {
						return 4;//手机号已存在
					}
				}else {
					return 3;//邮箱已存在
				}
			}else {
				return 2;//用户名已存在
			}
		
	}

	
	@RequestMapping(value="/deleteusers",method=RequestMethod.POST)
	@ResponseBody
	public Integer deleteusers(Integer usersId){
		//判断该用户是否有角色
		Integer selectUserRolesById = userRolesService.selectUserRolesById(usersId);
		if(selectUserRolesById==0) {
			//删除
			Integer deleteusers = usersService.deleteusers(usersId);
			return deleteusers;
		}else {
			return 2;
		}
	}
	
	@RequestMapping(value="/updateUsersPwd",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateUsersPwd(Users users){
		//默认密码
		String pwd="ysd123";
		String pwd2 = MD5Util.getPwd(pwd);
		users.setUs_PassWord(pwd2);
		Integer updateUsersPwd = usersService.updateUsersPwd(users);
		return updateUsersPwd;
	}
	
	@RequestMapping(value="/updateUsersJieSuo",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateUsersJieSuo(Users users){
		//解锁用户
		users.setUs_LockTime("");
		users.setUs_IsLockout(0);
		users.setUs_PsdWrongNum(0);
		Integer updateUsersJieSuo =usersService.updateUsersJieSuo(users);
		return updateUsersJieSuo;
	}
	
	@RequestMapping(value="/updateUsersSuoDing",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateUsersSuoDing(Users users){
		//转换提日期输出格式     获取当前时间
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//锁定时间
		users.setUs_LockTime(dateFormat.format(date));
		//锁定用户
		users.setUs_IsLockout(1);
		Integer updateUsersIsLockout =usersService.updateUsersIsLockout(users);
		return updateUsersIsLockout;
	}
	
	@RequestMapping(value="/updateUsersByNameEmailMtel",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateUsersByNameEmailMtel(Users users){
		//判断邮箱是否存在
		Integer selectUsersByEmail = usersService.selectUsersByEmail(users.getUs_ProtecEmail());
		//判断手机号是否存在
		Integer selectUsersByMtel = usersService.selectUsersByMtel(users.getUs_ProtecMtel());
		if(selectUsersByMtel==0) {
			if(selectUsersByEmail==0) {
				Integer i = usersService.updateUsersByNameEmailMtel(users);
				return i;
			}else {
				return 2;
			}
		}else {
			return 3;
		}
	}
	
	@RequestMapping(value="/updatePwd",method=RequestMethod.POST)
	@ResponseBody
	public Integer updatePwd(String usersName,String jiuPwd,String xinPwd){
		System.out.println("jiuPwd"+jiuPwd+"xinPwd"+xinPwd);
		users.setUs_LoginName(usersName);
		// 把用户输入的密码用MD5加密    给旧密码加密
		String pwd = MD5Util.getPwd(jiuPwd); 
		//根据名称查询该条信息
		Users selectUsersLogin = usersService.selectUsersLogin(users);
		//判断输入的旧密码是否和查询到的密码是否相同
		if(selectUsersLogin.getUs_PassWord().equals(pwd)==true) {
			// 把用户输入的密码用MD5加密    给密码加密
			String xin = MD5Util.getPwd(xinPwd); 
			users.setUs_PassWord(xin);
			//根据名称修改密码
			Integer updateUsersPassWord = usersService.updateUsersPassWord(users);
			return updateUsersPassWord;
		}else {	
			return 2;		//旧密码不对
		}
	}
	
}
