package com.crm.service;



import java.util.List;

import com.crm.entity.ConsultantLabels;
import com.crm.entity.Fenye;


public interface ConsultantlabelsService {
	//根据用户id查询每月签到的信息
	List<ConsultantLabels> SelectConsultantlabels(Fenye fenye);
}
