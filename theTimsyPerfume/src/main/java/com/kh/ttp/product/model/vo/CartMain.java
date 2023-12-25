package com.kh.ttp.product.model.vo;

import com.kh.ttp.productOption.model.vo.ProductOption;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class CartMain {

	private int totalPrice;
	private String pdtName;
	private String pdtShipping;
	private CartVO cart;
	private ProductOption productOption;
	
}
