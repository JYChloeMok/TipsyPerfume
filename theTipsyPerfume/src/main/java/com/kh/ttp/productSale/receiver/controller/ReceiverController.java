package com.kh.ttp.productSale.receiver.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ttp.productSale.receiver.model.service.ReceiverService;
import com.kh.ttp.productSale.receiver.model.vo.ReceiverDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ReceiverController {

	private final ReceiverService receiverService;
	
	@ResponseBody
	@PostMapping(value="ajaxInsertReceiver.re", produces="text/html; charset=UTF-8")
	public String insertReceiver(ReceiverDTO receiver) {
		// 값 가공
		receiver.setPhone(receiver.getPhone().replaceAll("-", ""));
		receiver.setPrimaryStatus("Y".equals(receiver.getPrimaryStatus()) ? "Y" : "N");
		// 등록성공 Y 실패 N
		return (receiverService.ajaxInsertReceiver(receiver) > 0) ? "Y" : "N";
	}
	
	
}
