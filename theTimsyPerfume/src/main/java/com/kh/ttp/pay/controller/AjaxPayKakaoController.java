package com.kh.ttp.pay.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.ttp.pay.model.service.PayKakaoService;
import com.kh.ttp.pay.model.vo.prepay.PayKakaoReadyVO;
import com.kh.ttp.pay.model.vo.prepay.PayKakaoVO;
import com.kh.ttp.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@CrossOrigin("*")
@RestController
@RequiredArgsConstructor
@RequestMapping("/pay/kakao")
public class AjaxPayKakaoController {
	
	
	// 주문상품 정보들은 DB조회!!
	public final static String SERVICE_KEY = "187196bd1303eec04b4d5abd920985f3";
	public final static String CID = "TC0ONETIME";
	
	private final PayKakaoService payKakaoService;
	
	
	
	
	@PostMapping(value="/ready", produces="application/json; charset=UTF-8")
	public ResponseEntity<String> payKakaoReady(@RequestBody PayKakaoReadyVO kakaoReady, HttpSession session) throws MalformedURLException, IOException, ParseException {
		return payKakaoService.payKakaoReady(kakaoReady, session);
	}
	
	
	@GetMapping("/approve")
	public void payKakaoApprove(@RequestParam(value = "pg_token") String pgToken, String userEmail, HttpSession session) throws MalformedURLException, IOException {
		
		System.out.println("approve이 시점에 pgToken저장해야함 pgToken : " + pgToken);
		System.out.println(pgToken + "토큰들어오나욤");
		// 토큰 DB에 저장 => ㄴㄴ 필요없지않나? (일단 여기선 세션)
		// session.setAttribute("pgToken", pgToken);
		
		User user = (User)session.getAttribute("loginUser");
		String url = "https://kapi.kakao.com/v1/payment/approve";
		
		System.out.println("카페 결과~~~ kakaoNo" + payKakaoService.selectPayKakao(userEmail));
		PayKakaoVO payKakao = payKakaoService.selectPayKakao(userEmail);

		String param = "cid=" + CID
					 + "&tid=" + payKakao.getTid()
					 + "&partner_order_id=" + payKakao.getPayKakaoNo()
					 + "&partner_user_id=" + userEmail
					 + "&pg_token=" + pgToken;
		
		HttpURLConnection urlConnection = (HttpURLConnection)new URL(url).openConnection();
		urlConnection.setRequestMethod("POST");
		urlConnection.setRequestProperty("Authorization", "KakaoAK " + SERVICE_KEY);
		urlConnection.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		urlConnection.setDoOutput(true);
		
		
		DataOutputStream dataOutputStream = new DataOutputStream(urlConnection.getOutputStream());
		dataOutputStream.writeBytes(param);
		dataOutputStream.close();
		
		if(urlConnection.getResponseCode() != 200) {
			System.out.println(urlConnection.getResponseCode());
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getErrorStream()));
			System.out.println("여기까진될듯?");
		}
		
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		
		
		JsonObject totalObj = JsonParser.parseString(bufferedReader.readLine()).getAsJsonObject();
		System.out.println(totalObj + " <<<<<<<<<total오브젝트"); // 콘솔창엔 똑같이 보임 근데 하나는 String, 하나는 오브젝트!
		
	}
	
	
	
}
