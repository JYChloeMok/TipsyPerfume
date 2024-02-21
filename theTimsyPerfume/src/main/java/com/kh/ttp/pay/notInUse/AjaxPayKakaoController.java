/*
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.ttp.common.util.LoginUser;
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
	
	
	@PostMapping
	public void pay(@PathVariable(value = "product_id") int product_id, Model model, HttpSession session) {
		
		// 재고 체크
		try {
			// Product product = productService.findProductById(productId;) 실제 있는 상품인지 체크
			if(product == null) {
				//에러센딩
			}
		}
		
		// 주문번호 생성
		User user = LoginUser.getLoginUser(session);
		long orderSerial = System.currentTimeMillis();
		String paymentId = "pid-" + orderSerial;
		
		// orderDTO만들기 주문정보 생성(상태 30분 이상 지나면 주문실패)
		Order order = Order.builder()
				.productId()
				.merchantUid()
				.amount()
				.userId()
				.status("try")
				.build();
		order = this.orderService.save(order);
		
		if(product.getStock() == 0) {
			order.update_status("fail", fail_reason "재고소진");
			orderService.save(order) // 재고소진
			// 재고소진되었습니다 에러리턴
		} else {
			// 먼저 재고 감소
			product.update_stock(product.getStock() - 1);
			this.orderService.save(order);
		}
		
		// 멀티PG분기(db관리)
		String[] pg_code = "tosspayments" "ksnet";
		String[] channelKey = "channel-key-1bwsad-9afsaedas-1qwar2-",
				"channel-asdas-asdasf-qwdq-fcaasad";
				
		// 스토어아이디
		// PG사채널키
		model영역에 담기
		
		// OrderDTO Insert
		// AJAX로 넘기기
		// 얘를 인자로 requestPay함수 호출
		
		// callBack 성공하면 ajax요청보내기
		/*
		, function (rsp) { // callback
	          if (rsp.success) {
	        	// 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
	              // jQuery로 HTTP 요청
	              jQuery.ajax({
	                url: "/payment/verify/"+ rsp.imp_uid, 
	                method: "POST",
	              }).done(function (data) {
	            	// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (iamport 서버검증)
	            	  if(rsp.paid_amount == data.response.amount){
	  		        	succeedPay(rsp.imp_uid, rsp.merchant_uid);
	  	        	} else {
	  	        		alert("결제 검증 실패");
	  	        	}
	              })
	          } else {
	        	  var msg = '결제에 실패하였습니다.';
	              msg += '에러내용 : ' + rsp.error_msg;
	              alert(msg);
	          }
		
		// 처음 DB 결제상태 UPDAE
		//주문번호, 결제고유번호, 결제상태를 인자로 넘겨준다
				int res = orderMapper.updateStatus(order_no, imp_uid, status);
	}
	
	
	
}
 */