package com.crm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crm.dao.ModulesMapper;
import com.crm.dao.RoleModulesMapper;
import com.crm.entity.Modules;
import com.crm.entity.RoleModules;
@Service
public class ModulesServiceImpl implements ModulesService {
	
	@Autowired
	private ModulesMapper modulesMapper;
	@Autowired
	private RoleModulesMapper roleModulesMapper;
	
	//首页显示
	public List<Map<String, Object>> selectModulesById(Integer usersId) {
		// TODO Auto-generated method stub
		List<Modules> selectModulesTree = modulesMapper.selectModulesById(usersId);
		List<Map<String, Object>> list=new ArrayList<Map<String,Object>>();
		
		for (int i = 0; i < selectModulesTree.size(); i++) {
			Map<String, Object> map=new HashMap<String, Object>();
			if(selectModulesTree.get(i).getMs_ParentId()==0) {
				map.put("id", selectModulesTree.get(i).getMs_Id());
				map.put("text", selectModulesTree.get(i).getMs_Name());
				map.put("url",selectModulesTree.get(i).getMs_Ext2()); 
				map.put("children", selectModules(selectModulesTree.get(i),usersId)); 
				
				list.add(map);
			}
		}
		return list;
	}

	public List<Map<String, Object>> selectModules(Modules modules,Integer usersId){
		List<Modules> selectModulesTree = modulesMapper.selectModulesById(usersId);
		List<Map<String, Object>> list=new ArrayList<Map<String,Object>>();
		for (int i = 0; i < selectModulesTree.size(); i++) {
			Map<String, Object> map=new HashMap<String, Object>();
			if(selectModulesTree.get(i).getMs_ParentId()==modules.getMs_Id()) {
				map.put("id", selectModulesTree.get(i).getMs_Id());
				map.put("text", selectModulesTree.get(i).getMs_Name());
				map.put("url",selectModulesTree.get(i).getMs_Ext2()); 
				map.put("children", selectModules(selectModulesTree.get(i),usersId)); 
				list.add(map);
			}
		}
		return list;
	}
	//模块管理显示
	@Override
	public List<Map<String,Object>> selectModulesAll() {
		//查询全部
		List<Modules> ModulesAll = modulesMapper.selectModulesAll();
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		for(int i=0;i<ModulesAll.size();i++) {
			Map<String,Object> map=new HashMap<String, Object>();
			if(ModulesAll.get(i).getMs_ParentId()==0) {
				map.put("id", ModulesAll.get(i).getMs_Id());
				map.put("text", ModulesAll.get(i).getMs_Name());
				map.put("children", selectMoodules(ModulesAll.get(i)));
				list.add(map);
			}
			
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> selectMoodules(Modules modules) {
		List<Modules> ModulesAll = modulesMapper.selectModulesAll();
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		for(int i=0;i<ModulesAll.size();i++) {
			Map<String,Object> map=new HashMap<String, Object>();
			if(ModulesAll.get(i).getMs_ParentId()==modules.getMs_Id()) {
				map.put("id", ModulesAll.get(i).getMs_Id());
				map.put("text", ModulesAll.get(i).getMs_Name());
				map.put("children", selectMoodules(ModulesAll.get(i)));
				list.add(map);
			}
		}
		return list;
	}
	//角色管理设置
	@Override
	public List<Map<String, Object>> selectModulesAllSheZhi(Integer rloesId) {
		List<Modules> ModulesAll = modulesMapper.selectModulesAll();
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		for(int i=0;i<ModulesAll.size();i++) {
			Map<String,Object> map=new HashMap<String, Object>();
			if(ModulesAll.get(i).getMs_ParentId()==0) {
				map.put("id", ModulesAll.get(i).getMs_Id());
				map.put("text", ModulesAll.get(i).getMs_Name());
				map.put("children", selectMoodulesSheZhi(ModulesAll.get(i),rloesId));
				list.add(map);
			}
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> selectMoodulesSheZhi(Modules modules,Integer rloesId) {
		//根据角色id查询
		List<RoleModules> selectRoleModulesById = roleModulesMapper.selectRoleModulesById(rloesId);
		//查询全部
		List<Modules> ModulesAll = modulesMapper.selectModulesAll();
		List<Map<String, Object>> list=new ArrayList<Map<String,Object>>();
		for (int i = 0; i < ModulesAll.size(); i++) {
			Map<String, Object> map=new HashMap<String, Object>();
			if(ModulesAll.get(i).getMs_ParentId()==modules.getMs_Id()) {
				map.put("id", ModulesAll.get(i).getMs_Id());
				map.put("text", ModulesAll.get(i).getMs_Name());
				map.put("url",ModulesAll.get(i).getMs_Ext2()); 
				Boolean xuanZhong=false;
				System.out.println(selectRoleModulesById.size()+"1111111111111111111111111111111111111");
				
				for(int j=0;j<selectRoleModulesById.size();j++) {
					System.out.println(ModulesAll.get(i).getMs_Id()+"我来了=======");
					System.out.println(selectRoleModulesById.toString()+"=================");
					
					if(selectRoleModulesById.get(j).getRms_ModuleId()==ModulesAll.get(i).getMs_Id()) {
						xuanZhong=true;
						break;
					}else {
						xuanZhong=false;
					}
				}
				map.put("checked",xuanZhong); 
				map.put("children", selectMoodulesSheZhi(ModulesAll.get(i),rloesId)); 
				
				list.add(map);
			}
		}
		return list;
	}
	
	public Integer insertModules(Modules modules) {
		// TODO Auto-generated method stub
		return modulesMapper.insertModules(modules);
	}

	@Override
	public Integer selectModulesByName(String modulesName) {
		// TODO Auto-generated method stub
		return modulesMapper.selectModulesByName(modulesName);
	}

	@Override
	public Integer selectModulesByUrl(String ModulesUrl) {
		// TODO Auto-generated method stub
		return modulesMapper.selectModulesByUrl(ModulesUrl);
	}

	@Override
	public Modules selectModulesByModulesName(String modulesName) {
		// TODO Auto-generated method stub
		return modulesMapper.selectModulesByModulesName(modulesName);
	}

	@Override
	public Integer updateModules(Modules modules) {
		// TODO Auto-generated method stub
		return modulesMapper.updateModules(modules);
	}

	@Override
	public Integer updateModules1(Modules modules) {
		// TODO Auto-generated method stub
		return modulesMapper.updateModules1(modules);
	}

	@Override
	public Integer deleteModules(Integer modulesId) {
		// TODO Auto-generated method stub
		return modulesMapper.deleteModules(modulesId);
	}

	@Override
	public Integer insertModulesFuJieDian(Modules modules) {
		// TODO Auto-generated method stub
		return modulesMapper.insertModulesFuJieDian(modules);
	}

	

}
