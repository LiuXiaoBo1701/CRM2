package com.crm.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crm.dao.RoleModulesMapper;
import com.crm.entity.RoleModules;
@Service
public class RoleModulesServiceImpl implements RoleModulesService {
	@Resource
	private RoleModulesMapper roleModulesMapper;

	@Override
	public List<RoleModules> selectRoleModulesById(Integer rolesId) {
		
		return roleModulesMapper.selectRoleModulesById(rolesId);
	}

	@Override
	public Integer selectRoleModulesByRolesId(Integer rolesId) {
		// TODO Auto-generated method stub
		return roleModulesMapper.selectRoleModulesByRolesId(rolesId);
	}

	@Override
	public Integer selectRoleModulesByModulesId(Integer modulesId) {
		// TODO Auto-generated method stub
		return roleModulesMapper.selectRoleModulesByModulesId(modulesId);
	}

	@Override
	public Integer deleteRoleModulesById(Integer rolesId) {
		// TODO Auto-generated method stub
		return roleModulesMapper.deleteRoleModulesById(rolesId);
	}

	@Override
	public Integer insertRoleModules(RoleModules roleModules) {
		// TODO Auto-generated method stub
		return roleModulesMapper.insertRoleModules(roleModules);
	}

}
