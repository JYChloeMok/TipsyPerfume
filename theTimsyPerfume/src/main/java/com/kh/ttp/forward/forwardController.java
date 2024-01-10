package com.kh.ttp.forward;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ttp.productSale.order.model.vo.OrderProductVO;

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
	
	@GetMapping("addressForm")
	public String addressForm() {
		return "frags/addressForm";
	}
	@GetMapping("paymentTest")
	public String paymentTest() {
		return "productSale/paymentTest";
	}
	

}
