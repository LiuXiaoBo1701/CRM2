package com.crm.service;

import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crm.dao.ClientsUsersMapper;
import com.crm.entity.ClientUserRecord;
import com.crm.entity.Clients;
import com.crm.entity.ConsultantLabels;
import com.crm.entity.Fenye;
import com.crm.entity.Users;
@Service
public class ClientsUsersServiceImpl implements ClientsUsersService {
    @Autowired
    private ClientsUsersMapper  clientsUsersMapper;
	public Fenye SelectClientsUsers(Fenye fenye) {
		Integer selectCountClientsUsers = clientsUsersMapper.SelectCountClientsUsers(fenye);
		List<Clients> selectClientsUsers = clientsUsersMapper.SelectClientsUsers(fenye);
		fenye.setTotal(selectCountClientsUsers);
		fenye.setRows(selectClientsUsers);
		return fenye;
	}
	public List<Users> SelectUsers() {
		List<Users> selectUsers = clientsUsersMapper.SelectUsers();
		return selectUsers;
	}
	public List<Clients> SelectClientsUsersExport(Integer Cs_Id) {
		List<Clients> selectClientsUsersExport = clientsUsersMapper.SelectClientsUsersExport(Cs_Id);
		return selectClientsUsersExport;
	}
	public Fenye SelectUsersRolesClients(Fenye fenye) {
		Integer selectCountUsersRolesClients = clientsUsersMapper.SelectCountUsersRolesClients(fenye);
		 List<Clients> selectUsersRolesClients = clientsUsersMapper.SelectUsersRolesClients(fenye);
		fenye.setTotal(selectCountUsersRolesClients);
		fenye.setRows(selectUsersRolesClients);
		return fenye;
	}
	public List<Users> ZiXunSHiQianDaoFenLiangOption() {
		List<Users> ziXunSHiQianDaoFenLiangOption = clientsUsersMapper.ZiXunSHiQianDaoFenLiangOption();
		return ziXunSHiQianDaoFenLiangOption;
	}
	public Integer UsersQianDaoFenLiang(Clients c) {
		Integer usersQianDaoFenLiang = clientsUsersMapper.UsersQianDaoFenLiang(c);
		return usersQianDaoFenLiang;
	}
	public Integer innserClient(Clients clients) {
		Integer innserClient = clientsUsersMapper.innserClient(clients);
		return innserClient;
	}
	@Override
	public Integer ClientsUsersFenLiangZhuangTaiKaiQi(Fenye fenye) {
		
		return clientsUsersMapper.ClientsUsersFenLiangZhuangTaiKaiQi(fenye);
	}
	@Override
	public Integer ClientsUsersFenLiangZhuangTaiGuanBi(Fenye fenye) {
		// TODO Auto-generated method stub
		return clientsUsersMapper.ClientsUsersFenLiangZhuangTaiGuanBi(fenye);
	}
	@Override
	public List<Users> SelectQianDaoZiXuShiZiDongFenLiang() {
		// TODO Auto-generated method stub
		return clientsUsersMapper.SelectQianDaoZiXuShiZiDongFenLiang();
	}
	@Override
	public Double SelectTuBiaoLiuShiLv(Fenye fenye) {
		// TODO Auto-generated method stub
		return clientsUsersMapper.SelectTuBiaoLiuShiLv(fenye);
	}
	
	
}
