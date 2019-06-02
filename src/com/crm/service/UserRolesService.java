package com.crm.service;


import java.util.List;

import com.crm.entity.Consultant;
import com.crm.entity.Fenye;
import com.crm.entity.Roles;
import com.crm.entity.UserRoles;
import com.crm.entity.Users;

public interface UserRolesService {

	/**
	 * 根据用户名查询该条数据
	 * @param UserRoles
	 * @return
	 */
	UserRoles selectUserRolesByName(UserRoles ur);
	/**
	 * 添加角色模块
	 * @param userRoles
	 * @return
	 */
	Integer insertUserRoles(UserRoles userRoles);
	/**
	 * 根据用户id和角色id删除该条数据
	 * @param userRoles
	 * @return
	 */
	Integer deleteUserRoles(UserRoles userRoles);
	/**
	 * 根据用户id查询判读该用户时候有角色
	 * @param usersId
	 * @return
	 */
	Integer selectUserRolesById(Integer usersId);
	
	
	

	//查询
	Fenye SelectUserRoles(Fenye fenye);
	//查询所有角色
	List<Roles> SelectRoles();
	//签到
	Integer ConsultantLabelsStart(Integer C_UserId);
	//手动签退
	Integer UsersQianTui(Integer Us_Id);
	//导出
	List<Users>  SelectUserRolesExport(Integer Cs_Id);
	Users  UsersLoginState(Fenye fenye);
	 //修改权重
    Integer  updateQuanZhong(Consultant con);
}
