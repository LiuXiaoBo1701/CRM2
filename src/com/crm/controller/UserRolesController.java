package com.crm.controller;



import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.entity.Consultant;
import com.crm.entity.Fenye;
import com.crm.entity.Roles;
import com.crm.entity.UserRoles;
import com.crm.entity.Users;
import com.crm.service.ConsultantService;
import com.crm.service.RolesService;
import com.crm.service.UserRolesService;
@Controller
public class UserRolesController {
	
	@Autowired
	private UserRolesService userRolesService;
	@Autowired
	private RolesService rolesService;
	@Autowired
	private ConsultantService consultantService;
	@Autowired
	private Consultant consultant;
	@Autowired
	private UserRoles userRoles;

	@RequestMapping(value="/insertUserRoles",method=RequestMethod.POST)
	@ResponseBody
	public Integer insertUserRoles(UserRoles userRoles){
		//根据角色id查询
		Roles selectRolesById = rolesService.selectRolesById(userRoles.getUrs_RoleId());
		Integer insertUserRoles=0;
		if(selectRolesById.getRs_Name().equals("咨询师")) {
			insertUserRoles = userRolesService.insertUserRoles(userRoles);
			consultant.setC_UserId(userRoles.getUrs_UserId());
			consultantService.insertConsultant(consultant);
		}else {
			insertUserRoles = userRolesService.insertUserRoles(userRoles);
		}
		
		return insertUserRoles;
	}
	
	@RequestMapping(value="/deleteUserRoles",method=RequestMethod.POST)
	@ResponseBody
	public Integer deleteUserRoles(UserRoles userRoles){
		//根据角色id查询
		Roles selectRolesById = rolesService.selectRolesById(userRoles.getUrs_RoleId());
		Integer deleteUserRoles =0;
		if(selectRolesById.getRs_Name().equals("咨询师")) {
			consultantService.deletConsultantById(userRoles.getUrs_UserId());
			deleteUserRoles = userRolesService.deleteUserRoles(userRoles);
		}else {
			deleteUserRoles = userRolesService.deleteUserRoles(userRoles);
		}
		return deleteUserRoles;
	}
	//查询页面显示
		@RequestMapping(value="/SelectUserRoles",method=RequestMethod.POST)
		@ResponseBody
		public Fenye  SelectClientsUsers(HttpServletRequest s,@RequestParam(value="rows") Integer pageSize,Fenye fenye) {
			fenye.setPageSize(pageSize);
			fenye.setPage((fenye.getPage()-1)*pageSize);
			Fenye selectClientsUsers = userRolesService.SelectUserRoles(fenye);
			List<Roles> selectRoles = userRolesService.SelectRoles();
			HttpSession  session=s.getSession(true);
			session.setAttribute("selectClientsUsers", selectClientsUsers);
	        
			session.setAttribute("selectRoles", selectRoles);
			return selectClientsUsers;
			
		}
		//签到
		@RequestMapping(value="/ConsultantLabelsStart",method=RequestMethod.POST)
		@ResponseBody()
		public Integer ConsultantLabelsStart(Integer C_UserId,Fenye fenye,HttpServletRequest s){
			Integer ConsultantLabelsStart = userRolesService.ConsultantLabelsStart(C_UserId);
			HttpSession  session=s.getSession(true);
			Users usersLoginState = userRolesService.UsersLoginState(fenye);
			session.setAttribute("usersLoginState", usersLoginState);
			return ConsultantLabelsStart;
		}
		//签退
		@RequestMapping(value="/UsersQianTui",method=RequestMethod.POST)
		@ResponseBody()
		public Integer UsersQianTui(HttpServletRequest s,Integer Us_Ida){
			 String Us_Ids=s.getParameter("Us_Id");
				String[] Us_Id = Us_Ids.split(",");
				Integer ConsultantLabelsStart=null;
		        for(int i=0;i<Us_Id.length;i++){
		        	ConsultantLabelsStart = userRolesService.UsersQianTui(Integer.parseInt(Us_Id[i]));
		            
		        }
			
			return ConsultantLabelsStart;
		}
		//首页个人信息
		@RequestMapping(value="/selectUserRolesByName",method=RequestMethod.POST)
		@ResponseBody
		public UserRoles selectUserRolesByName(Users users){
			//根据角色名字查询
			userRoles.setUsers(users);
			UserRoles selectUserRolesByName = userRolesService.selectUserRolesByName(userRoles);		
			return selectUserRolesByName;
		}
		//修改权重
				@RequestMapping(value="/updateQuanZhong",method=RequestMethod.POST)
				@ResponseBody
				public Integer updateQuanZhong(Consultant con){
					Integer updateQuanZhong = userRolesService.updateQuanZhong(con);
					return updateQuanZhong;
				}
		
}
