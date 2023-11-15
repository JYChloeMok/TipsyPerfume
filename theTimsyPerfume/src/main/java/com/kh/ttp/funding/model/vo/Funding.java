package com.kh.ttp.funding.model.vo;

import java.sql.Date;


import lombok.AllArgsConstructor;

import lombok.Data;
import lombok.NoArgsConstructor;
@Data @NoArgsConstructor
public class Funding {
	private int fundingNo;
	private int pdtNo;
	private int fundingViewCount;
	private Date cuttingDate;
	private int fundingFee;
	private int cuttingPrice;

}
