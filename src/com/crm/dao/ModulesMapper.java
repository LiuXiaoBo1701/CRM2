package com.crm.dao;

import java.util.List;

import com.crm.entity.Modules;

public interface ModulesMapper {
	/**
	 * 根据用户id链表（用户，角色，用户角色，模块，角色模块）查询
	 * @param usersId
	 * @return
	 */
	List<Modules> selectModulesById(Integer usersId);
	/**
	 * 查询全部模块
	 * @return
	 */
	List<Modules> selectModulesAll();
	/**
	 * 添加模块
	 * @param modules
	 * @return
	 */
	Integer insertModules(Modules modules);
	/**
	 * 判断模块名称是否存在
	 * @param modulesName
	 * @return
	 */
	Integer selectModulesByName(String modulesName);
	/**
	 * 判断模块路径是否存在
	 * @param modulesName
	 * @return
	 */
	Integer selectModulesByUrl(String ModulesUrl);
	/**
	 * 根据模块名称查询该条数据
	 * @param modulesName
	 * @return
	 */
	Modules selectModulesByModulesName(String modulesName);
	/**
	 * 根据模块id修改信息(模块名称，权重)
	 * @param modules
	 * @return
	 */
	Integer updateModules(Modules modules);
	/**
	 * 根据模块id修改信息(模块名称，权重，路径)
	 * @param modules
	 * @return
	 */
	Integer updateModules1(Modules modules);
	/**
	 * 根据模块id删除数据
	 * @param modulesId
	 * @return
	 */
	Integer deleteModules(Integer modulesId);
	/**
	 * 添加父模块
	 * @param modules
	 * @return
	 */
	Integer insertModulesFuJieDian(Modules modules);

}
