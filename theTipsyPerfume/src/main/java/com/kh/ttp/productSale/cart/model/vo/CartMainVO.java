package com.kh.ttp.productSale.cart.model.vo;

import com.kh.ttp.productSale.productInfo.model.vo.ProductOptionVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class CartMainVO {

	private int totalPrice;
	private String pdtName;
	private String pdtShipping;
	
	private CartVO cart;
	private ProductOptionVO productOption;
	
}
