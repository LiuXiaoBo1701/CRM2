package com.crm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crm.dao.ClientUserRecordMapper;
import com.crm.entity.ClientUserRecord;
import com.crm.entity.Fenye;
import com.crm.entity.Users;
@Service
public class ClientUserRecordServiceImp implements ClientUserRecordService {
	@Autowired
	private ClientUserRecordMapper clientUserRecordMapper;
	public Fenye selectClientUserRecordByAll(Fenye fenye) {
		// TODO Auto-generated method stub
		List<ClientUserRecord> selectClientUserRecordByAll = clientUserRecordMapper.selectClientUserRecordByAll(fenye);
		Integer selectClientUserRecordCount = clientUserRecordMapper.selectClientUserRecordCount(fenye);
		fenye.setRows(selectClientUserRecordByAll);
		fenye.setTotal(selectClientUserRecordCount);
		return fenye;
	}
	public List<Users> selectUsers() {
		// TODO Auto-generated method stub
		return clientUserRecordMapper.selectUsers();
	}

}
