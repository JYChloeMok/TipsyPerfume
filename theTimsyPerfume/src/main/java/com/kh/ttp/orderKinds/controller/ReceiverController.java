package com.kh.ttp.orderKinds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ttp.orderKinds.model.service.ReceiverService;
import com.kh.ttp.orderKinds.model.vo.Receiver;

@Controller
public class ReceiverController {

	@Autowired
	private ReceiverService receiverService;
	
	@ResponseBody
	@PostMapping(value="ajaxInsertReceiver.re", produces="text/html; charset=UTF-8")
	public String insertReceiver(Receiver receiver) {
		// 값 가공
		receiver.setPhone(receiver.getPhone().replaceAll("-", ""));
		receiver.setPrimaryStatus("Y".equals(receiver.getPrimaryStatus()) ? "Y" : "N");
		// 등록성공 Y 실패 N
		return (receiverService.ajaxInsertReceiver(receiver) > 0) ? "Y" : "N";
	}
	
	
}
