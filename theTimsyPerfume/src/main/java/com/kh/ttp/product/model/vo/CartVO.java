package com.kh.ttp.product.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString
public class CartVO extends ProductVO {
	
	/*
	CART_NO	NUMBER
	USER_NO	NUMBER
	PDT_NO	NUMBER
	CART_QUANTIRY	NUMBER
	*/
	// private int pdtNo;
	private int cartNo;
	private int userNo;
	private int cartQuantity;
	private int pdtOptionNo;
	private int cartAddingQuantity;
}
