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
	
	@GetMapping("addressForm")
	public String addressForm() {
		return "frags/addressForm";
	}
	@GetMapping("paymentTest")
	public String paymentTest() {
		return "productSale/paymentTest";
	}
	
	
	
	// 정리를 먼저 해보자
	
	// ★ ERD 테이블
	// 주문서 테이블
	// 주문서 - 상품 테이블
	// 결제정보 공통
	// PG사별 결제정보 테이블
	// 주문서 - 결제정보 테이블
	
	// 장바구니 수량 변경 시 => 장바구니 테이블 update
	
	// order/main
	// 카트페이지에서 물건 선택 후 주문페이지로 뿌림
	/* 카트페이지에서 선택된 장바구니 넘버 넘김
	 * SELECT구문 시행 
	 * 주문서 페이지로 전환 해당 정보 뿌림
	 * 
	 * cartMain SQL문과 같으면서 where절 조건만 다름
	 * 
	 * 상품(옵션) / 수량 / 가격 / 배송 / 상품합계
	 */
	
	
	// product/order
	// 1. 주문페이지에서 결제버튼 누르면(AJAX) 주문번호 생성
	// 2. cartNo이용해 결제 예정금액 SELECT
	// 2. 사전등록 POST요청 https://api.iamport.kr/payments/prepare
	// 사전검증 처리 성공코드 200이면 merchant_uid 리턴
	
	// 결제요청 (여기서 금액은 클라이언트 단의 금액 보냄 / 조작 시 사전검증 등록되었기 때문에 창 호출 거부됨)
	/* 성공 : TB_ORDER, TB_ORDER_PRODUCT 채우기
	 * 실패 : 해당 주문서 삭제
	 */
	
	// 성공 시 : 사후검증 : 성공시 결제완료 / 실패시 주문정보 상태 실패
	// 실패 시 : 생성됐던 주문정보 삭제
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
