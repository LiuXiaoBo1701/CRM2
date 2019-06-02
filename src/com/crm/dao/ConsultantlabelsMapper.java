package com.crm.dao;

import java.util.List;

import com.crm.entity.ConsultantLabels;
import com.crm.entity.Fenye;

public interface ConsultantlabelsMapper {
	Integer  SelectConsultantlabelsCount();
	 //根据用户id查询每月签到的信息
	List<ConsultantLabels> SelectConsultantlabels(Fenye fenye);
}
