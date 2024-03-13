package com.kh.ttp.adminManage.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data  @NoArgsConstructor
public class AdminVo {

	//상품(product)
	private int pdtNo;
	private int pdtCategNo;
	private String pdtName;
	private int pdtPrice;
	private int pdtStock;
	private String pdtDate;
	private String pdtIntro;
	private String pdtDescription;
	private String pdtIngredient;
	private String pdtShipping;
	private int pdtCount;
	private int pdtDiscount;
	private String pdtStatus;
	private String pdtGpStatus;
	
	
	//상품 카테고리
	private String pdtCteg; //주류 향수 구분 주류 : A 향수 : F
	private String pdtFamily;	// 기성제품 커스텀 제품 기성 : B  커스텀 :C 
	private String pdtManufac; //브랜드 OR 제조자 이름
	private String pdtGroup; // 제품군 분류
	
	
	//상품 이미지 파일
	private int pdtFileNo;
	private int pdtFileIndex;
	private String pdtFilePath;
	private String pdtFileOrigin;
	private String pdtFileUpload;
	
	
	//상품 옵션
	private int pdtOptionNo;
	private String pdtOptionFirst;
	private String pdtOptionSecond;
	
	
	
	
}
