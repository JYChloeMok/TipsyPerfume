package com.kh.ttp.productSale.pay.model.service;

import java.io.IOException;
import java.net.MalformedURLException;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.http.ResponseEntity;

import com.kh.ttp.productSale.pay.model.vo.prepay.PayKakaoReady;
import com.kh.ttp.productSale.pay.model.vo.prepay.PayKakaoVO;

public interface PayKakaoService {

	//추후수정
	ResponseEntity<String> payKakaoReady(PayKakaoReady kakaoReady, HttpSession session) throws MalformedURLException, IOException, ParseException;


	PayKakaoVO selectPayKakao(String userEmail);

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
