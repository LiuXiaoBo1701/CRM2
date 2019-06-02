package com.crm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.entity.ConsultantLabels;
import com.crm.entity.Fenye;
import com.crm.service.ConsultantlabelsService;

@Controller
public class ConsultantlabelsController {
	@Autowired
	private  ConsultantlabelsService ConsultantlabelsService;
	@RequestMapping(value="/SelectConsultantLabels",method=RequestMethod.POST)
	@ResponseBody
	public List<ConsultantLabels>  SelectConsultantLabels(HttpServletRequest s,@RequestParam(value="rows") Integer pageSize,Fenye fenye) {
		fenye.setPageSize(pageSize);
		fenye.setPage((fenye.getPage()-1)*pageSize);
		List<ConsultantLabels> ConsultantLabels = ConsultantlabelsService.SelectConsultantlabels(fenye);
		return ConsultantLabels;
	}
}
