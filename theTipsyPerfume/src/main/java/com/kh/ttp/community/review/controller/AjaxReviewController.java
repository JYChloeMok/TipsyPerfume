package com.kh.ttp.community.review.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.kh.ttp.community.common.model.vo.RecommendVO;
import com.kh.ttp.community.review.model.service.ReviewService;
import com.kh.ttp.community.review.model.vo.ReviewVO;
import com.kh.ttp.productSale.common.ProductSaleUtil;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
public class AjaxReviewController {
	
	private final ProductSaleUtil productUtil;
	private final ReviewService reviewService;
	
	@GetMapping(value = "reviewRecommend", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String ajaxReviewRecommend(RecommendVO rc) {
		
		String msg="";
		String flag = reviewService.selectRecommend(rc);
		if(rc.getLikeFlag().equals("L")) {
			if(flag!=null && flag.equals("L")) {
				msg="이미 추천한 게시글 입니다.";
			} else {
				if(reviewService.reviewRecommend(rc)>0) {
					msg="게시글을 추천 했습니다.";
				} else {
					msg="Error!";
				}
			}
		} else {
			if(flag!=null && flag.equals("D")) {
				msg="이미 비추천한 게시글 입니다.";
			} else {
				if(reviewService.reviewRecommend(rc)>0) {
					msg="게시글을 비추천 했습니다.";
				} else {
					msg="Error!";
				}
			}
		}
		return msg;
	}
	@GetMapping(value = "loadReviewRecommend", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String ajaxCountRecommend(int contentNo) {
		return new Gson().toJson(reviewService.countRecommend(contentNo));
	}
	
	
	/**
	 * 상품 번호(pdtNo), rowNum(rowNum)을 이용해<br>
	 * pdtNo번 상품의 최신 작성순 리뷰 탑 rowNum개를 조회하는 메소드<br>
	 * rowNum은 최대 10까지 가능
	 * @param pdtNo : 상품번호
	 * @param rowNum : 로우넘버
	 * @return
	 * ResponseEntity반환, 리뷰 정보가 담긴 리스트가 들어있음
	 */
	@GetMapping("reviews/{pdtNo}/row-num/{rowNum}")
	public ResponseEntity ajaxSelectRecentReviewTop(@PathVariable(name="pdtNo") int pdtNo,
													@PathVariable(name="rowNum") int rowNum) {
		if(pdtNo < 1) {
			return productUtil.makeAjaxErrorResult("pdtNo는 1 이상이어야 합니다");
		}
		if(10 < rowNum || rowNum < 1) {
			return productUtil.makeAjaxErrorResult("rowNum은 1이상 10이하의 숫자만 설정 가능합니다");
		}
		HashMap<String, Integer> pMap = new HashMap();
		pMap.put("pdtNo", pdtNo);
		pMap.put("rowNum", rowNum);
		return ResponseEntity.<List<ReviewVO>>ok() // 200ok코드와 함께 빌더객체 반환 (빌더객체 제네릭으로 ResponseEntity타입 지정 가능)
							 .headers(productUtil.makeHeader("application", "json", "UTF-8"))
							 .body(reviewService.selectRecentReviewWithRownum(pMap));
	}
	// 빌더사용 : 코드 가독성, 잘못된 코드번호 전달로 인한 런타임오류 방지, ResponseBody보다 많은 표현 가능하며 요구사항 변경에도 더 유연함
	/*
	return ResponseEntity.<List<ReviewVO>>ok() // 200ok코드와 함께 빌더객체 반환 (빌더객체 제네릭으로 ResponseEntity타입 지정 가능)
						 .headers(productUtil.makeHeader("application", "json", "UTF-8"))
						 .body(reviewService.selectRecentReviewWithRownum(pMap));
	*/
	/*
		return new ResponseEntity<List<ReviewVO>>(reviewService.selectRecentReviewWithRownum(pMap),
												  productUtil.makeHeader("application", "json", "UTF-8"),
												  HttpStatus.OK);
	 */
	/*
	 * return ResponseEntity.<String>badRequest()
	 * .headers(productUtil.makeHeader("text", "html", "UTF-8"))
	 * .body("ERROR, rowNum은 10까지 설정 가능합니다");
	 */
}
