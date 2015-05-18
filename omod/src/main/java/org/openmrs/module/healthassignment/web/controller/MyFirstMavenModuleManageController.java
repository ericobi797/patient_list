/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */
package org.openmrs.module.healthassignment.web.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Patient;
import org.openmrs.PatientIdentifier;
import org.openmrs.PersonName;
import org.openmrs.api.context.Context;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * The main controller.
 */
@Controller
public class  MyFirstMavenModuleManageController {
	
	protected final Log log = LogFactory.getLog(getClass());
	
	@RequestMapping(value = "/module/healthassignment/manage", method = RequestMethod.GET)
	public void manage(ModelMap model) {
		//model.addAttribute("user", Context.getAuthenticatedUser());
		List<Patient> allPatients = Context.getPatientService().getAllPatients();
		model.addAttribute("listPatient", allPatients);
	}
	@RequestMapping(value = "/module/healthassignment/create", method = RequestMethod.POST)
	public ModelAndView create(@RequestParam(value = "fname", required = false) String fname,
							   @RequestParam(value = "lname", required = false) String lname,
							   @RequestParam(value = "mname", required = false) String mname,
							   @RequestParam(value = "id", required = false) String pid
	){
		ModelAndView model = new ModelAndView();
		Patient patient = new Patient();
		String givenName = fname + mname;
		PatientIdentifier id = new PatientIdentifier(pid, Context.getPatientService().getPatientIdentifierType(3), Context.getLocationService().getDefaultLocation());
		String gender = "Male";
		patient.setGender(gender);
		PersonName pn = new PersonName(givenName, null, lname);
		patient.addName(pn);
		Context.getPatientService().savePatient(patient);
		List<Patient> allPatients = Context.getPatientService().getAllPatients();
		model.addObject("listPatient", allPatients);
		model.addObject("msg","Patient Added Successfully");
		model.setViewName("manage");
		return model;
	}
	@RequestMapping(value= "/module/healthassignment/summary", method = RequestMethod.GET)
	public ModelAndView displaySummary(@RequestParam(value = "id", required = false) int id){
		ModelAndView model = new ModelAndView();
		model.addObject("patientName", Context.getPatientService().getPatient(id));
		model.addObject("detail", Context.getEncounterService().getEncountersByPatient(Context.getPatientService().getPatient(id)));
		//model.setViewName("manage");
		return model;
	}

}
