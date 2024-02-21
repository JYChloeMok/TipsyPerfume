package com.kh.ttp.productSale.receiver.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.common.ProductSaleUtil;
import com.kh.ttp.productSale.receiver.model.service.ReceiverService;
import com.kh.ttp.productSale.receiver.model.vo.ReceiverVO;
import com.kh.ttp.user.model.vo.User;

import lombok.RequiredArgsConstructor;


@RestController
@CrossOrigin("*")
@RequestMapping("/receiver/")
@RequiredArgsConstructor
public class AjaxReceiverController {

	private final ProductSaleUtil productUtil;
	private final ReceiverService receiverService;
	
	@GetMapping
	public ResponseEntity<List<ReceiverVO>> selectReceiver(HttpSession session) {
		List<ReceiverVO> receiverList = receiverService.selectReceiver(((User)LoginUser.getLoginUser(session)).getUserNo());
		HttpHeaders header = productUtil.makeHeader("application", "json", "UTF-8");
		return new ResponseEntity<List<ReceiverVO>>(receiverList, header, HttpStatus.OK);
	}
	
}
