package com.crm.dao;

import com.crm.entity.Consultant;

public interface ConsultantMapper {
	/**
	 * 添加用户（咨询师）Id
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
