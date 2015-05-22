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
import org.openmrs.*;
import org.openmrs.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.validator.PatientIdentifierValidator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import java.util.*;

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
		String uniqueID = UUID.randomUUID().toString();
		model.addAttribute("uid", uniqueID);
	}

	@RequestMapping(value = "/module/healthassignment/create", method = RequestMethod.POST)
	public String create(@RequestParam(value = "fname", required = false) String fname,
							   @RequestParam(value = "lname", required = false) String lname,
							   @RequestParam(value = "mname", required = false) String mname,
							   @RequestParam(value = "pid", required = false) String pid,
							   @RequestParam(value = "address") String address1,
							   @RequestParam(value = "sex") String gender,
							   @RequestParam(value = "age") int age,
							   @RequestParam(value = "country") String country,
							   @RequestParam(value = "county") String province,
							   @RequestParam(value = "birthdate") String date
	) throws Exception {
		ModelAndView model = new ModelAndView();
		Patient patient = new Patient();
		PersonName personName = new PersonName();
		personName.setFamilyName(lname);
		personName.setMiddleName(mname);
		personName.setGivenName(fname);
		PersonAddress personAddress = new PersonAddress();
		personAddress.setCountry(country);
		personAddress.setStateProvince(province);
		personAddress.setAddress1(address1);
		Date birthdate = null;
		birthdate = Context.getDateFormat().parse(date);
		//patient.setBirthdateFromAge();
        patient.setBirthdate(birthdate);
		patient.setGender(gender);
		patient.addAddress(personAddress);
		patient.addName(personName);
		PatientIdentifier openmrsId = new PatientIdentifier();
		PatientService patientService = Context.getPatientService();

		String TARGET_ID_KEY = "patientmodule.idType";
		String TARGET_ID = Context.getAdministrationService().getGlobalProperty(TARGET_ID_KEY);
        PatientIdentifierType patientIdentifierType = patientService.getPatientIdentifierTypeByName(TARGET_ID);
		openmrsId.setIdentifier(pid);
		openmrsId.setDateCreated(new Date());
		openmrsId.setLocation(Context.getLocationService().getDefaultLocation());
		openmrsId.setIdentifierType(patientIdentifierType);
		PatientIdentifierValidator.validateIdentifier(openmrsId);
		patient.addIdentifier(openmrsId);
		//save the if id not taken patient
		if (!patientService.isIdentifierInUseByAnotherPatient(openmrsId)) {
			patientService.savePatient(patient);
		}

		List<Patient> allPatients = Context.getPatientService().getAllPatients();
		model.addObject("listPatient", allPatients);
		model.addObject("msg", "Patient Added Successfully");
		return "redirect:manage.form";
	}
	@RequestMapping(value= "/module/healthassignment/summary", method = RequestMethod.GET)
	public ModelAndView displaySummary(@RequestParam(value = "id", required = false) int id){
		ModelAndView model = new ModelAndView();
		model.addObject("patientName", Context.getPatientService().getPatient(id));
		model.addObject("detail", Context.getEncounterService().getEncountersByPatient(Context.getPatientService().getPatient(id)));
		//model.setViewName("manage");
		return model;
	}


    public @ResponseBody List<Patient> getPatients(){
        List<Patient> allPatients = Context.getPatientService().getAllPatients();
        return allPatients;
    }

}
