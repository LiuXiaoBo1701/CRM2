package com.crm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crm.dao.ConsultantlabelsMapper;
import com.crm.entity.ConsultantLabels;
import com.crm.entity.Fenye;
@Service
public class ConsultantlabelsServiceImp implements ConsultantlabelsService {
	@Autowired
	private ConsultantlabelsMapper ConsultantlabelsMapper;
	@Override
	public List<ConsultantLabels> SelectConsultantlabels(Fenye fenye) {
		return ConsultantlabelsMapper.SelectConsultantlabels(fenye);
	}

}
