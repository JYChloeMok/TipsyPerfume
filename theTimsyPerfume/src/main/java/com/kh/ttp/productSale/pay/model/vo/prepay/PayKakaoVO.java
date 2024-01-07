package com.kh.ttp.productSale.pay.model.vo.prepay;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class PayKakaoVO extends Prepay {
	
	/*
	private int userNo;
	private String userEmail;
	 */

	private String payKakaoNo; // partner_order_id PAY_KAKAO_NO 유저 이메일 insert 후 결과
	private String tid; // tid 추후 발급된 tid
	private String itemCode;
	private List<String> itemCodeList;
	
}
