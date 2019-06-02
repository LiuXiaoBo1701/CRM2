package com.crm.service;

import java.util.List;
import java.util.Map;

import com.crm.entity.Modules;

public interface ModulesService {
	
	/**
	 * 根据用户id链表（用户，角色，用户角色，模块，角色模块）查询出父模块---->首页显示
	 * @param usersId
	 * @return
	 */
	List<Map<String, Object>> selectModulesById(Integer usersId);
	/**
	 * 根据usersId查询出子模块---->首页显示
	 * @param modules
	 * @param usersId
	 * @return
	 */
	List<Map<String, Object>> selectModules(Modules modules,Integer usersId);
	/**
	 * 查询全部模块---->模块管理显示
	 * @return
	 */
	List<Map<String,Object>> selectModulesAll();
	/**
	 * 根据模块id查询出子模块---->模块管理显示
	 * @param modules
	 * @return
	 */
	List<Map<String, Object>> selectMoodules(Modules modules);
	/**
	 * 查询全部模块---->角色管理设置
	 * @return
	 */
	List<Map<String,Object>> selectModulesAllSheZhi(Integer rloesId);
	/**
	 * 根据模块id查询出子模块---->角色管理设置
	 * @param modules
	 * @return
	 */
	List<Map<String, Object>> selectMoodulesSheZhi(Modules modules,Integer rloesId);
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
	 * 根据模块id修改信息
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
