package com.crm.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.crm.dao.RolesMapper;
import com.crm.entity.Roles;
@Service
public class RolesServiceImpl implements RolesService {

	@Resource
	private RolesMapper rolesMapper;
	
	@Override
	public List<Roles> selectRolesAll() {
		// TODO Auto-generated method stub
		return rolesMapper.selectRolesAll();
	}

	@Override
	public List<Roles> selectUserRolesById(Integer usersId) {
		// TODO Auto-generated method stub
		return rolesMapper.selectUserRolesById(usersId);
	}

	@Override
	public Integer deleteRoles(Integer rolesId) {
		// TODO Auto-generated method stub
		return rolesMapper.deleteRoles(rolesId);
	}

	@Override
	public Integer insertRoles(Roles roles) {
		// TODO Auto-generated method stub
		return rolesMapper.insertRoles(roles);
	}

	@Override
	public Integer updateRoles(Roles roles) {
		// TODO Auto-generated method stub
		return rolesMapper.updateRoles(roles);
	}

	@Override
	public Integer selectRolesByName(String RolesName) {
		// TODO Auto-generated method stub
		return rolesMapper.selectRolesByName(RolesName);
	}

	@Override
	public Roles selectRolesById(Integer rolesId) {
		// TODO Auto-generated method stub
		return rolesMapper.selectRolesById(rolesId);
	}

}
