package com.crm.service;

import com.crm.entity.Consultant;

public interface ConsultantService {

	/**
	 * 添加用户（咨询师）Id,权重
	 * @param consultant
	 * @return
	 */
	Integer insertConsultant(Consultant consultant);
	/**
	 * 根据用户id删除
	 * @param consultantId
	 * @return
	 */
	Integer deletConsultantById(Integer consultantId);
}
