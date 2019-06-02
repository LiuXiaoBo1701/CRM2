package com.crm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crm.dao.UserRolesMapper;
import com.crm.entity.Consultant;
import com.crm.entity.Fenye;
import com.crm.entity.Roles;
import com.crm.entity.UserRoles;
import com.crm.entity.Users;

@Service
public class UserRolesServiceImpl implements UserRolesService {

	@Autowired
	private UserRolesMapper userRolesMapper;
	

	public UserRoles selectUserRolesByName(UserRoles ur) {
		// TODO Auto-generated method stub
		return userRolesMapper.selectUserRolesByName(ur);
	}

	@Override
	public Integer insertUserRoles(UserRoles userRoles) {
		// TODO Auto-generated method stub
		return userRolesMapper.insertUserRoles(userRoles);
	}

	@Override
	public Integer deleteUserRoles(UserRoles userRoles) {
		// TODO Auto-generated method stub
		return userRolesMapper.deleteUserRoles(userRoles);
	}

	@Override
	public Integer selectUserRolesById(Integer usersId) {
		// TODO Auto-generated method stub
		return userRolesMapper.selectUserRolesById(usersId);
	}

	
	
	

	public Fenye SelectUserRoles(Fenye fenye) {
		Integer selectCountUserRoles = userRolesMapper.SelectCountUserRoles(fenye);
		List<UserRoles> selectUserRoles = userRolesMapper.SelectUserRoles(fenye);
		fenye.setTotal(selectCountUserRoles);
		fenye.setRows(selectUserRoles);
		return fenye;
	}

	public List<Roles> SelectRoles() {
		List<Roles> selectRoles = userRolesMapper.SelectRoles();
		return selectRoles;
	}

	public Integer ConsultantLabelsStart(Integer C_UserId) {
		Integer consultantLabelsStart = userRolesMapper.ConsultantLabelsStart(C_UserId);
		return consultantLabelsStart;
	}

	public List<Users> SelectUserRolesExport(Integer Cs_Id) {
		List<Users> selectUserRolesExport = userRolesMapper.SelectUserRolesExport(Cs_Id);
		return selectUserRolesExport;
	}

	public Integer UsersQianTui(Integer Us_Id) {
		Integer usersQianTui = userRolesMapper.UsersQianTui(Us_Id);
		return usersQianTui;
	}

	@Override
	public Users UsersLoginState(Fenye fenye) {
		// TODO Auto-generated method stub
		return userRolesMapper.UsersLoginState(fenye);
	}

	@Override
	public Integer updateQuanZhong(Consultant con) {
		return userRolesMapper.updateQuanZhong(con);
	}
	
	
}
