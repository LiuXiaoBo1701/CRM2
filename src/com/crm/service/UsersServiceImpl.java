package com.crm.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crm.dao.UsersMapper;
import com.crm.entity.Fenye;
import com.crm.entity.Users;
@Service
public class UsersServiceImpl implements UsersService {

	@Autowired
	private UsersMapper usersMapper;
	
	@Override
	public Users selectUsersLogin(Users users) {
		// TODO Auto-generated method stub
		return usersMapper.selectUsersLogin(users);
	}
	
	public Integer updateUsers(Users users) {
		// TODO Auto-generated method stub
		return usersMapper.updateUsers(users);
	}

	@Override
	public Fenye selectUsersAll(Fenye fenye) {
		// TODO Auto-generated method stub
		Integer total = usersMapper.selectUsersCount(fenye);
		List<Users> rows = usersMapper.selectUsersAll(fenye);
		fenye.setRows(rows);
		fenye.setTotal(total);
		return fenye;
	}

	@Override
	public Integer insertUsers(Users users) {
		// TODO Auto-generated method stub
		return usersMapper.insertUsers(users);
	}
	
	@Override
	public Integer selectUsersByName(String usersName) {
		// TODO Auto-generated method stub
		return usersMapper.selectUsersByName(usersName);
	}

	@Override
	public Integer selectUsersByEmail(String usersEmail) {
		// TODO Auto-generated method stub
		return usersMapper.selectUsersByEmail(usersEmail);
	}

	@Override
	public Integer selectUsersByMtel(String usersMtel) {
		// TODO Auto-generated method stub
		return usersMapper.selectUsersByMtel(usersMtel);
	}

	@Override
	public Integer deleteusers(Integer usersId) {
		// TODO Auto-generated method stub
		return usersMapper.deleteusers(usersId);
	}

	@Override
	public Integer updateUsersPwd(Users users) {
		// TODO Auto-generated method stub
		return usersMapper.updateUsersPwd(users);
	}

	@Override
	public Integer updateUsersIsLockout(Users users) {
		// TODO Auto-generated method stub
		return usersMapper.updateUsersIsLockout(users);
	}

	@Override
	public Integer updateUsersByNameEmailMtel(Users users) {
		// TODO Auto-generated method stub
		return usersMapper.updateUsersByNameEmailMtel(users);
	}

	@Override
	public Integer updateUsersSuoDing(Users users) {
		// TODO Auto-generated method stub
		return usersMapper.updateUsersSuoDing(users);
	}

	@Override
	public Integer updateUsersJieSuo(Users users) {
		// TODO Auto-generated method stub
		return usersMapper.updateUsersJieSuo(users);
	}

	@Override
	public Integer updateUsersPassWord(Users users) {
		// TODO Auto-generated method stub
		return usersMapper.updateUsersPassWord(users);
	}

	@Override
	public Users UsersLoginState(Integer usersId) {
		// TODO Auto-generated method stub
		return usersMapper.UsersLoginState(usersId);
	}




}
