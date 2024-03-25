package com.kh.ttp.productSale.billing.order.controller;


import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttp.common.model.vo.CodeMessage;
import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.billing.order.model.service.OrderService;
import com.kh.ttp.productSale.billing.payment.model.service.PaymentService;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;
import com.kh.ttp.productSale.cart.model.vo.CartDTO;
import com.kh.ttp.productSale.common.util.BillingUtil;
import com.kh.ttp.productSale.common.util.ProductSaleUtil;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class OrderController {
	
	private final BillingUtil billingUtil;
	private final ProductSaleUtil productUtil;
	private final OrderService orderService;
	private final PaymentService paymentService;
	/**
	 * 주문하기 메인화면으로 이동
	 * 세션에 "orderAmount", "merchantUid"키의 값은 오직 여기서만 세팅함
	 * @param model
	 * @param cart
	 * @param session
	 * @param cartReq
	 * @return
	 */
	@GetMapping("orderMain.od")
	public String orderMain(Model model,
							CartDTO cart,
							PaymentDTO payment,
							HttpSession session,
							@RequestParam(value="cartReq", defaultValue="") String cartReq) {

		// 매개변수로 온 문자열 배열로 가공 (cartNoArr => 장바구니 카트번호 배열)
		ArrayList<Integer> cartNoArr = productUtil.shapeIntoIntegerArr(cartReq);
		
		// 가공한 배열이 null이면 에러 리턴
		if(cartNoArr == null) {
			return productUtil.makeErrorMsg(model, "올바른 요청 값이 아닙니다!"); // 숫자 배열 형태가 아니었을 경우
		}
		// 유효한 값이면 파라미터 세팅
		cart.setCartNoArr(cartNoArr);
		cart.setUserNo(LoginUser.getLoginUser(session).getUserNo());
		
		// 오더메인에 띄울 상품정보 조회
		HashMap<String, Object> orderMain = orderService.orderMain(cart);
		
		// flag변수 초기화
		// 조회 결과에 따라 반환할 Model객체 설정
		boolean flag = false;
		
		if(orderMain == null) {
			// 1. 조회된 행이 없다면
			productUtil.log.info("조회된 행이 없음");
			model.addAttribute("orderResult", "NNROW"); // 숫자 배열 형태였으나 값이 조작되거나 해서 존재하는 상품이 아닐경우
		
		} else if(!(boolean)orderMain.get("isEnoughStock")) {
			// 2. 조회된 행이 있는데 재고가 부족하다면
			// 재고 부족이 있다면 식별값 담아 결과 페이지로 리턴
			productUtil.log.info("재고 부족/판매중단 상품이 있음");
			model.addAttribute("orderResult", "NNSTOCK");

		} else {
			// 3. 조회된 행이 있고 주문 가능한 수량일 경우
			// merchantUid생성 후 세션에 정보 저장(중복이면 포트원 API에서 막힘)
			String merchantUid = billingUtil.makeMerchantUid();
			session.setAttribute("merchantUid", merchantUid);
			productUtil.log.info("session의 merchantUid={}", session.getAttribute("merchantUid"));
			
			// 재고가 충분하다면 결제금액 사전등록 요청
			payment.setOrderAmount((int)orderMain.get("orderAmount"));
			payment.setMerchantUid(merchantUid);
			CodeMessage prepareResult = paymentService.preparePortOnePayment(payment);
			
			// 코드가 0이 아니면 결제 등록과정 오류
			if(prepareResult.getCode() != 0) {
				model.addAttribute("orderResult", "FFPREP");
			} else {
				// 코드가 0이라면(정상결제) model객체 세팅
				model.addAttribute("orderMain", orderMain);
				// 플래그 true로 설정
				flag = true;
			}
			//session.setAttribute("orderAmount", orderMain.get("orderAmount"));
			//productUtil.log.info("orderAmount={}", session.getAttribute("orderAmount"));
		}
		/* 결과에 따라 보여줄 뷰를 지정하는 것은 JSTL보다 controller의 역할에 더 가까움
		 * 경우의 수가 많고 일관된 형식의 뷰가 아닐 수 있어(주문, 결제 결과에 따라 전부 다름)
		 * JSTL사용 시 html이 복잡해짐 혹은 다량의 html이 필요함
		 * 결과 별 동작도 달라질 수 있음
		 * => 컨트롤러에서 식별값을 보내고 JS를 사용해 로딩 시 동적 생성 및 함수 실행
		 * => JSTL choose-when-otherwise는 더블체크 개념
		 */
		
		// 주문 메인으로 반환
		return flag ? "productSale/orderMain" : "productSale/orderResult";
	}
	
	


	
	
	
}
