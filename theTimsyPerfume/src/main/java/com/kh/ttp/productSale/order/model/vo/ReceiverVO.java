package com.kh.ttp.productSale.order.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
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
