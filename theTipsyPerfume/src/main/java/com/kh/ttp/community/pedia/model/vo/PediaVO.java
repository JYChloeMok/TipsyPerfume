package com.kh.ttp.community.pedia.model.vo;

import lombok.Data;

@Data
public class PediaVO {
	private int pdtNo;
	private String pdtName;
	private String pdtImage;
	private String pdtPrice;
	private String pdtStock;
	private String pdtIntro;
	private String pdtDescription;
	private String pdtIngredient;
	
	private String userBuy;
	private String totalPrice;
	private String totalReview;
	private String userReview;
}
