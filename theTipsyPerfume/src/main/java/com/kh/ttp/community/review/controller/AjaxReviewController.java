package com.kh.ttp.community.review.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.kh.ttp.community.common.model.vo.RecommendVO;
import com.kh.ttp.community.review.model.service.ReviewService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
public class AjaxReviewController {
	
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
}
