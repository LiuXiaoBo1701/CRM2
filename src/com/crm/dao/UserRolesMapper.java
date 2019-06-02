package com.crm.dao;


import java.util.List;

import com.crm.entity.Consultant;
import com.crm.entity.Fenye;
import com.crm.entity.Roles;
import com.crm.entity.UserRoles;
import com.crm.entity.Users;

public interface UserRolesMapper {
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
    Integer  SelectCountUserRoles(Fenye fenye);
    //查询
    List<UserRoles> SelectUserRoles(Fenye fenye);
    
    List<Roles> SelectRoles();
    //导出
  	List<Users>  SelectUserRolesExport(Integer Cs_Id);
    //签到
	Integer ConsultantLabelsStart(Integer C_UserId);
	//手动签退
	Integer UsersQianTui(Integer Us_Id);
	//根据登录的用户id查看签到状态
    Users  UsersLoginState(Fenye fenye);
    //修改权重
    Integer  updateQuanZhong(Consultant con);
	
}
