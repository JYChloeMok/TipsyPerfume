package com.kh.ttp.productSale.common.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import org.springframework.stereotype.Component;

import com.kh.ttp.productSale.cart.model.vo.SaleMainDTO;

@Component
public final class BillingUtil {
	
	ProductSaleUtil productUtil;
	
	// 주문번호 만들기
	/**
	 * 주문 번호 만들기
	 * @return : 만들어진 주문 번호(날짜8자리 + 난수 12자리)
	 */
	public String makeMerchantUid() {
		// 스트링 빌더, 캘린더, 포매팅 객체 (주문번호 만들기 준비)
		StringBuilder sb = new StringBuilder();
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		
		// 주문번호 만들기 날짜8자리 + 난수 12자리 / (or randomUUID)
		sb.append(formatter.format(calendar.getTime()));
		for(int i = 0; i < 12; i++) {
			sb.append((int)(Math.random() * 10));
		}
		// 주문번호
		return sb.toString();
	}
	
	
	/**
	 * 최소 배송비 계산 메소드
	 */
	public int calcMinShipping(ArrayList<SaleMainDTO> productList) {
		int currShipping;
		// 0번 인덱스 배송비를 minShipping으로 설정
		int minShipping = Integer.parseInt(productList.get(0).getPdtShipping());
		// 제일 작은 값을 minShipping으로 설정
		// minShipping이 0이면 중단
		for (int i = 1; i < productList.size(); i++) {
			if (minShipping == 0) {
				break;
			} else {
				// i번째 인덱스 배송비
				currShipping = Integer.parseInt(productList.get(i).getPdtShipping());
				if (currShipping < minShipping) {
					minShipping = currShipping;
				}
			}
		}
		return minShipping;
	}

	
	/**
	 * 전체 주문금액(총 합계) 계산 메소드
	 */
	public int calcCartAmount(ArrayList<SaleMainDTO> productList) {
		int sum = 0;
		for (SaleMainDTO item : productList) {
			sum += item.getTotalPrice();
		}
		return sum;
	}
	
	
	/**
	 * 상품 재고 체크<br>
	 * 음수, 양수는 확인하지 않고 단순히cartQuantity(카트 선택 개수)가  productStock(재고수량) 이내 범위인지만 확인함<br>
	 * 음수가 들어올 수 있는 경우(ex. 클라이언트 단에서 cartQuantity에 음수값을 보냄)는 controller에서 체크 필요
	 * @return : 재고가 충분한 경우라면 true, 아니라면 false 반환
	 */
	public boolean isEnoughStock(ArrayList<SaleMainDTO> productList) {
		for(SaleMainDTO product : productList) {
			if(product.getProductOption().getPdtOptionStock() < product.getCart().getCartQuantity()) {
				return false;
			}
		}
		return true;
	}
	
	
	
	
	

}
