package com.kh.ttp.productSale.funding.model.vo;

import java.sql.Date;


import lombok.AllArgsConstructor;

import lombok.Data;
import lombok.NoArgsConstructor;
@Data @NoArgsConstructor
public class FundingVO {
	private int fundingNo;
	private int pdtNo;
	private int fundingViewCount;
	private Date cuttingDate;
	private int fundingFee;
	private int cuttingPrice;
	
	//private ProductVo product;
}
