package com.kh.ttp.productSale.wishlist.model.vo;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class WishlistVO {

	private int pdtNo;
	private int userNo;
	private String wishlistDate;
	
}
