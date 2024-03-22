package com.kh.ttp.productSale.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.stereotype.Component;

@Component
public final class BillingUtil {
	
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
}
