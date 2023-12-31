package com.kh.ttp.forward;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class forwardController {
	
	@RequestMapping("fundingMain.list")
	public String fundingListPage() {
		return"funding/fundingList";
	}
	
	
	@RequestMapping("starDrinkFunding.list")
	public String starDrinkFundingListPage() {
		return "funding/starDrinkFundingList";
	}
	@RequestMapping("drinkEnrollForm.funding")
	public String enrollFormDrinkFunding() {
		return "funding/drinkEnrollForm";
	}
	
	
	@GetMapping("addressEnrollForm.re")
	public String search() {
		return "frags/addressEnrollForm";
	}
	
	@GetMapping("errorPage.er")
	public String errorPage() {
		return "common/errorPage";
	}
	
	@GetMapping("orderSheet")
	public String orderSheet() {
		return "orderKinds/OrderSheet";
	}
	@GetMapping("addressForm")
	public String addressForm() {
		return "frags/addressForm";
	}
	@GetMapping("paymentTest")
	public String paymentTest() {
		return "orderKinds/paymentTest";
	}
	

}
