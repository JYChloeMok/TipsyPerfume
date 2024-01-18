package com.kh.ttp.productSale.order.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class ReceiverVO {

	private int receiverNo;
	private int userNo;
	private String receiverName;
	private String phone;
	private String address;
	private String addressDetail;
	private int postalCode;
	private String placeAlias;
	private String primaryStatus;
	
}
