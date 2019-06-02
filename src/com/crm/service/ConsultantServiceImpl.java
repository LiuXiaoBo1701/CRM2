package com.crm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crm.dao.ConsultantMapper;
import com.crm.entity.Consultant;
@Service
public class ConsultantServiceImpl implements ConsultantService {
	
	@Autowired
	private ConsultantMapper consultantMapper;
	
	public Integer insertConsultant(Consultant consultant) {
		// TODO Auto-generated method stub
		return consultantMapper.insertConsultant(consultant);
	}

	@Override
	public Integer deletConsultantById(Integer consultantId) {
		// TODO Auto-generated method stub
		return consultantMapper.deletConsultantById(consultantId);
	}

}
