package com.crm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crm.dao.ClientMapper;
import com.crm.entity.Clients;
import com.crm.entity.Fenye;
import com.crm.entity.Users;
import com.sun.security.ntlm.Client;
@Service
public class ClientServiceimp implements ClientService{
	
	@Autowired
	private ClientMapper clientMapper;
	@Autowired
	private Clients clients;
	public Integer countClient(Fenye fenye) {
		// TODO Auto-generated method stub
		Integer countClient = clientMapper.countClient(fenye);
		return countClient;
	}

	public List<Clients> selectClient(Fenye fenye) {
		// TODO Auto-generated method stub
		List<Clients> selectClient = clientMapper.selectClient(fenye);
		return selectClient;
	}

	public List<Clients> SelectBookBid(int parseInt) {
		// TODO Auto-generated method stub
		return null;
	}

	public Integer innserClient(Clients clients) {
		// TODO Auto-generated method stub
		Integer innserClient = clientMapper.innserClient(clients);
		
		return innserClient;
	}

	public List<Users> seleceShi() {
		// TODO Auto-generated method stub
		List<Users> seleceShi = clientMapper.seleceShi();
		return seleceShi;
	}

	@Override
	public String updateshi(HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer fenpeizixunshi(String Cs_ids, Integer C_Id) {
		// TODO Auto-generated method stub
		int	fenpeizixunshi=0;
		String[] split = Cs_ids.split(",");
		for(int i=0;i<split.length;i++) {
		clients.setCs_Id(Integer.parseInt(split[i]));
		clients.setC_Id(C_Id);
		fenpeizixunshi=clientMapper.fenpeizixinshi(clients);
		}
		
		return fenpeizixunshi;
	}

	@Override
	public List<Map<Integer, String>> selectStuSourceUrl() {
		// TODO Auto-generated method stub
		return clientMapper.selectStuSourceUrl();
	}
	
}
