package com.crm.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.crm.entity.Users;
import com.crm.service.UsersService;
import com.crm.util.MD5Util;
import com.crm.util.RandomValidateCode;

@Controller
public class LoginController {

	@Resource
	private UsersService usersService;
	@Autowired
	private Users users;

	// 获取生成验证码
    @RequestMapping(value="/checkCode")
    public void checkCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置相应类型,告诉浏览器输出的内容为图片
        response.setContentType("image/jpeg");
        
        // 设置响应头信息，告诉浏览器不要缓存此内容
        response.setHeader("pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);
        
        RandomValidateCode randomValidateCode = new RandomValidateCode();
        try {
            // 输出图片方法
            randomValidateCode.getRandcode(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //登录
	@RequestMapping(value = "/selectUserRolesLogin", method = RequestMethod.POST)
	public String selectUserRolesLogin(Model model,String us_LoginName,String dl,String us_PassWord,String yanzheng,HttpServletRequest request,
			HttpServletResponse response,HttpSession session) {
		System.out.println(dl);
		System.out.println("登陆了");
		//转换提日期输出格式     获取当前时间
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//获取随机产生的验证码
		String verificationCode = (String)session.getAttribute("randomcode_key");
		// 把用户输入的密码用MD5加密
		String pwd = MD5Util.getPwd(us_PassWord); 
		//判断验证码是否正确
		if(verificationCode.toLowerCase().equals(yanzheng.toLowerCase())==true) {
			//把用户输入的用户名存到users中
			users.setUs_LoginName(us_LoginName);
			//查询用户名是否存在
			Users selectUsersLogin = usersService.selectUsersLogin(users);
			//判断用户名是否跟查询到的数据用户名一样
			if(selectUsersLogin!=null) {  
				//判定是否锁定
				if(selectUsersLogin.getUs_IsLockout() != 1) {
					//判断密码是否正确
                	if(selectUsersLogin.getUs_PassWord().equals(pwd)) {
                		//单点登录  声明application
                        ServletContext application = request.getServletContext();
                		//如果application中存在此用户名则不能登录
                        if(application.getAttribute(selectUsersLogin.getUs_LoginName()) != null && application.getAttribute(selectUsersLogin.getUs_LoginName()).equals(selectUsersLogin.getUs_LoginName())){
                            model.addAttribute("msg","该账号已登录！");
                            return "login";
                        } else
                        // 将用户名放入application中
                        application.setAttribute(selectUsersLogin.getUs_LoginName(),selectUsersLogin.getUs_LoginName());

                    	//记录最后一次登录时间,密码错误次数为0,
                    	users.setUs_LastLoginTime(dateFormat.format(date));	//登录时间
                    	users.setUs_PsdWrongNum(0);	//密码错误次数为0
                    	users.setUs_Id(selectUsersLogin.getUs_Id());
                    	usersService.updateUsers(users);
                    	//request.getSession().setAttribute("selectUserRolesByName", selectUserRolesByName);
                    	request.getSession().setAttribute("usersImg", selectUsersLogin.getUs_UserImg());
                    	request.getSession().setAttribute("usersName", selectUsersLogin.getUs_LoginName());
                    	request.getSession().setAttribute("usersId", selectUsersLogin.getUs_Id());
                    	Users usersLoginState = usersService.UsersLoginState(selectUsersLogin.getUs_Id());
            			session.setAttribute("usersLoginState", usersLoginState);
                    	if(dl!=null) {
                    		Cookie name=new Cookie("usersName",selectUsersLogin.getUs_LoginName());
                    		name.setMaxAge(60*60*24*7);
                    		response.addCookie(name);
                    	}
                    	return "index";
                	}else{
                		//判断密码错误次数
                		if(selectUsersLogin.getUs_PsdWrongNum()<3) {
                			//记录密码错误次数
						    users.setUs_PsdWrongNum(selectUsersLogin.getUs_PsdWrongNum()+1);
						    users.setUs_Id(selectUsersLogin.getUs_Id());
						    usersService.updateUsers(users);
						    model.addAttribute("msg","密码错误！");
                		}else {
                			//密码错误次数太多进行锁定,记录时间
                			users.setUs_LockTime(dateFormat.format(date));	//锁定时间
                			users.setUs_IsLockout(1);	//锁定
                			users.setUs_Id(selectUsersLogin.getUs_Id());
                			usersService.updateUsersSuoDing(users);
                			model.addAttribute("msg","密码错误次数太多，已经锁定，请联系管理员！");
                		}
                	}
				}else {
					model.addAttribute("msg","该用户已经锁定，请联系管理员！");
				}
			}else {
				model.addAttribute("msg","用户名不存在");
			}
		}else {
			model.addAttribute("msg","验证码不正确");
		}
		return "login";
	}
	//退出登录
	@RequestMapping(value = "/initSession",method=RequestMethod.POST)
	@ResponseBody
	public Integer initSession(HttpServletRequest request){
		// 声明application
        ServletContext application = request.getServletContext();
        //清除application里的值
		application.removeAttribute(users.getUs_LoginName());
		//清空session
		request.getSession().invalidate();
		return 1;
	 }  
	//找回密码验证用户名,手机号
	@RequestMapping(value = "/ZhaoHuiMiMaYanZheng",method=RequestMethod.POST)
	@ResponseBody
	public Integer ZhaoHuiMiMaYanZheng(String us_LoginName,String us_ProtecMtel){
		//把用户输入的用户名存到users中
		users.setUs_LoginName(us_LoginName);
		//查询用户名是否存在
		Users selectUsersLogin = usersService.selectUsersLogin(users);
		//判断用户名是否跟查询到的数据用户名一样
		if(selectUsersLogin!=null) {  
			//判断手机号是否正确
			if(selectUsersLogin.getUs_ProtecMtel().equals(us_ProtecMtel)) {
				return 1;
			}else {
				return 2;	//手机号错误
			}
		}else {
			return 3;	//用户名不存在
		}
	 }  
	
	//找回密码
	@RequestMapping(value = "/ZhaoHuiMiMa",method=RequestMethod.POST)
	@ResponseBody
	public Integer ZhaoHuiMiMa(String us_LoginName,String us_PassWord){
		System.out.println("找回密码");
		// 把用户输入的密码用MD5加密
		String pwd = MD5Util.getPwd(us_PassWord); 
		users.setUs_LoginName(us_LoginName);
		users.setUs_PassWord(pwd);
		Integer updateUsersPassWord = usersService.updateUsersPassWord(users);
		return updateUsersPassWord;
	 }  
	//单点登录
	@RequestMapping(value="errorClose",method=RequestMethod.POST)
    public void errorClose(HttpServletRequest request,Users users) {
        // 声明application
        ServletContext application = request.getServletContext();
        
        // 判断当前用户名是否还存在
        if (application.getAttribute(users.getUs_LoginName()) != null && application.getAttribute(users.getUs_LoginName()).equals(users.getUs_LoginName())) {
            // 从application中移除当前用户
            application.removeAttribute(users.getUs_LoginName());
        }
        
    }

}

