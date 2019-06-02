package com.crm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ViewController {
	@RequestMapping(value="/indexJSP",method=RequestMethod.GET)
	public ModelAndView indexJSP() {
		return new ModelAndView("index");
	}
	@RequestMapping(value="/loginJSP",method=RequestMethod.GET)
	public ModelAndView loginJSP() {
		return new ModelAndView("login");
	}
	@RequestMapping(value="/rolesjsp",method=RequestMethod.GET)
	public ModelAndView rolesjsp() {
		return new ModelAndView("roles");
	}
	@RequestMapping(value="/userjsp",method=RequestMethod.GET)
	public ModelAndView userjsp() {
		return new ModelAndView("user");
	}
	@RequestMapping(value="/modulesjsp",method=RequestMethod.GET)
	public ModelAndView modulesjsp() {
		return new ModelAndView("modules");
	}
	@RequestMapping(value="/forgetjsp",method=RequestMethod.GET)
	public ModelAndView forgetjsp() {
		return new ModelAndView("forget");
	}
	@RequestMapping(value="/clientsjsp",method=RequestMethod.GET)
	public ModelAndView clientsjsp() {
		return new ModelAndView("clients");
	}
	@RequestMapping(value="/clientUserRecordjsp",method=RequestMethod.GET)
	public ModelAndView clientUserRecordjsp() {
		return new ModelAndView("clientUserRecord");
	}
	@RequestMapping(value="/consultant-Clientsjsp",method=RequestMethod.GET)
	public ModelAndView consultantClientsjsp() {
		return new ModelAndView("consultant-Clients");
	}
	@RequestMapping(value="/userRolesjsp",method=RequestMethod.GET)
	public ModelAndView userRolesjsp() {
		return new ModelAndView("userRoles");
	}
	@RequestMapping(value="/clientsUsersjsp",method=RequestMethod.GET)
	public ModelAndView clientsUsersjsp() {
		return new ModelAndView("clientsUsers");
	}
	@RequestMapping(value="/selectUserClientRolesjsp",method=RequestMethod.GET)
	public ModelAndView selectUserClientRolesjsp() {
		return new ModelAndView("selectUserClientRoles");
	}
	@RequestMapping(value="/updatePwdjsp",method=RequestMethod.GET)
	public ModelAndView updatePwdjsp() {
		return new ModelAndView("updatePwd");
	}
}
