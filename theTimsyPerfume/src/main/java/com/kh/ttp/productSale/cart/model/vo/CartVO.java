package com.kh.ttp.productSale.cart.model.vo;

import com.kh.ttp.productSale.product.model.vo.ProductVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @SuperBuilder
public class CartVO extends ProductVO {
	
	/*
	CART_NO	NUMBER
	USER_NO	NUMBER
	PDT_NO	NUMBER
	PDT_OPTION_NO NUMBER
	CART_QUANTIRY	NUMBER
	*/
	// private int pdtNo;
	private int cartNo;
	private int userNo;
	private int pdtOptionNo;
	private int cartQuantity;
	private int cartAddingQuantity;
}
