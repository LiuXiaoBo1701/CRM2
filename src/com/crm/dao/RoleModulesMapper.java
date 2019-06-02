package com.crm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;

import com.crm.entity.RoleModules;

public interface RoleModulesMapper {
	/**
	 * 根据角色id查询判断
	 * @param rolesId
	 * @return
	 */
	List<RoleModules> selectRoleModulesById(Integer rolesId);
	/**
	 * 根据角色id查询判断是否存在
	 * @param rolesId
	 * @return
	 */
	Integer selectRoleModulesByRolesId(Integer rolesId);
	/**
	 * 根据模块id查询判断是否存在
	 * @param modulesId
	 * @return
	 */
	Integer selectRoleModulesByModulesId(Integer modulesId);
	/**
	 * 根据角色id删除
	 * @return
	 */
	Integer deleteRoleModulesById(Integer rolesId);
	/**
	 * 添加信息
	 * @param roleModules
	 * @return
	 */
	Integer insertRoleModules(RoleModules roleModules);
	
}
