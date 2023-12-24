package com.kh.ttp.orderKinds.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder @ToString
public class OrderDetailVO {
	/*
	ORDER_DETAIL_NO	NUMBER
	ORDER_NO	NUMBER
	PDT_NO	NUMBER
	PAY_NO	NUMBER
	ORDER_PRICE	NUMBER
	ORDER_QUANTITY	NUMBER
	*/
	private int orderDetailNo;
	private int orderNo;
	private int payNo;
	
	private ArrayList<OrderProductVO> orderProduct;
}
