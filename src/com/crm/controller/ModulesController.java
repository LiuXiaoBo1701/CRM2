package com.crm.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.entity.Modules;
import com.crm.service.ModulesService;
import com.crm.service.RoleModulesService;

@Controller
public class ModulesController {

	@Autowired
	private ModulesService modulesService;
	@Autowired
	private RoleModulesService roleModulesService;
	
	@RequestMapping(value="/selectModulesById",method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String,Object>> selectModulesById(Integer usersId) {
		List<Map<String,Object>> selectModulesById = modulesService.selectModulesById(usersId);
		return selectModulesById;
	}
	
	@RequestMapping(value="/selectModulesAll",method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String,Object>> selectModulesAll() {
		List<Map<String,Object>> selectModulesAll = modulesService.selectModulesAll();
		return selectModulesAll;
	}
	
	@RequestMapping(value="/selectModulesAllSheZhi",method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String,Object>> selectModulesAllSheZhi(Integer rloesId) {
		List<Map<String,Object>> selectModulesAllSheZhi = modulesService.selectModulesAllSheZhi(rloesId);
		return selectModulesAllSheZhi;
	}
	
	@RequestMapping(value="/insertModules",method=RequestMethod.POST)
	@ResponseBody
	public Integer insertModules(Modules modules) {
		//根据模块名称判断是否存在
		Integer selectModulesByName = modulesService.selectModulesByName(modules.getMs_Name());
		//根据模块路径判断是否存在
		Integer selectModulesByUrl = modulesService.selectModulesByUrl(modules.getMs_Ext2());
		if(selectModulesByName==0) {
			if(selectModulesByUrl==0) {
				//添加成功
				Integer insertModules = modulesService.insertModules(modules);
				return insertModules;
			}else {
				return 3;	//模块路径已存在
			}
		}else {
			return 2;	//模块名称已存在
		}
		
	}
	
	@RequestMapping(value="/insertModulesFuJieDian",method=RequestMethod.POST)
	@ResponseBody
	public Integer insertModulesFuJieDian(Modules modules) {
		//根据模块名称判断是否存在
		Integer selectModulesByName = modulesService.selectModulesByName(modules.getMs_Name());
		if(selectModulesByName==0) {
			//添加成功
			Integer insertModulesFuJieDian = modulesService.insertModulesFuJieDian(modules);
			return insertModulesFuJieDian;
		}else {
			return 2;	//模块名称已存在
		}
		
	}

	@RequestMapping(value="/selectModulesByModulesName",method=RequestMethod.POST)
	@ResponseBody
	public Modules selectModulesByModulesName(String modulesName) {
		
		return modulesService.selectModulesByModulesName(modulesName);
	}
	
	@RequestMapping(value="/updateModules",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateModules(Modules modules) {
		//根据模块名称判断是否存在
		Integer selectModulesByName = modulesService.selectModulesByName(modules.getMs_Name());
		if(selectModulesByName==0) {
			//修改成功
			Integer updateModules = modulesService.updateModules(modules);
			return updateModules;
		}else {
			return 2;	//模块名称已存在
		}
	}
	
	@RequestMapping(value="/updateModules1",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateModules1(Modules modules) {
		//根据模块名称判断是否存在
		Integer selectModulesByName = modulesService.selectModulesByName(modules.getMs_Name());
		//根据模块路径判断是否存在
		Integer selectModulesByUrl = modulesService.selectModulesByUrl(modules.getMs_Ext2());
		if(selectModulesByName==0) {
			if(selectModulesByUrl==0) {
				//修改成功
				Integer updateModules1 = modulesService.updateModules1(modules);
				return updateModules1;
			}else {
				return 3;	//模块路径已存在
			}
		}else {
			return 2;	//模块名称已存在
		}
	}
	
	@RequestMapping(value="/deleteModules",method=RequestMethod.POST)
	@ResponseBody
	public Integer deleteModules(Integer modulesId) {
		//根据模块id判断是否存在
		Integer selectRoleModulesByModulesId = roleModulesService.selectRoleModulesByModulesId(modulesId);
		if(selectRoleModulesByModulesId==0) {
			//删除
			Integer deleteModules = modulesService.deleteModules(modulesId);
			return deleteModules;
		}else {
			return 2;	
		}
	}
	
}
