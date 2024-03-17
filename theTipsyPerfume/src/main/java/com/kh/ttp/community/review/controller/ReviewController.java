package com.kh.ttp.community.review.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.common.template.Pagination;
import com.kh.ttp.community.review.model.service.ReviewService;
import com.kh.ttp.community.review.model.vo.ReviewFileVO;
import com.kh.ttp.community.review.model.vo.ReviewVO;
import com.kh.ttp.productSale.common.ProductSaleUtil;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ReviewController {
	
	private final ReviewService reviewService;
	
	
	@GetMapping("review")
	public ModelAndView reviewList(@RequestParam(value = "page", defaultValue = "1")int page, String condition, ModelAndView mv) {
		int listCount = reviewService.countReviewList();
		PageInfo pi = Pagination.getPageInfo(listCount, page, 9, 5);
		ArrayList<ReviewVO> list = reviewService.seletcReviewList(pi);
		mv.addObject("list", list).
		addObject("pi", pi).
		addObject("condition",condition).
		setViewName("community/review");
		
		return mv;
	}
	@GetMapping("reviewViewer")
	public ModelAndView reviewViewer(int reviewNo, ModelAndView mv) {
		
		ReviewVO review = reviewService.selectReviewDetail(reviewNo);
		review.setReviewImages(reviewService.selectReviewImage(reviewNo));
		
		mv.addObject("review", review).
		setViewName("community/reviewDetail");
		
		return mv;
	}
	
	@GetMapping("reviewWrite")
	public ModelAndView reviewWriteForm(ModelAndView mv,int pdtNo,String pdtName) {
		mv.addObject("pdtNo",pdtNo);
		mv.addObject("pdtName",pdtName);
		mv.setViewName("community/reviewWrite");
		
		return mv;
	}
	@PostMapping("reviewWrite.do")
	public ModelAndView reviewWrite(ReviewVO re, MultipartFile uploadImg[], HttpSession session, ModelAndView mv) {
		re.setReviewContent(re.getReviewContent().replace("<", "&lt;"));
		re.setReviewContent(re.getReviewContent().replace(">", "&gt;"));
		
		ArrayList<ReviewFileVO> fileList = new ArrayList<ReviewFileVO>();
		for(int i=uploadImg.length;i>0;i--) {
			ReviewFileVO file = saveFile(uploadImg[i-1], uploadImg.length-i, session);
			fileList.add(file);
		}
		
		if(reviewService.insertReview(re, fileList)>0) {
			mv.setViewName("redirect:review");
		} else {
			mv.addObject("alertMsg", "게시물 작성 실패");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
	public ReviewFileVO saveFile(MultipartFile upfile, int index, HttpSession session) {
		String originName = upfile.getOriginalFilename();
		
		String curTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int ranNum = (int)(Math.random()*90000+10000);
		String ext =  originName.substring(originName.lastIndexOf("."));
		String changeName = curTime + ranNum + ext;
		String savePath = session.getServletContext().getRealPath("/resources/image/community/review/");
		
		try {
			upfile.transferTo(new File(savePath+changeName));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		ReviewFileVO file = new ReviewFileVO();
		file.setReviewFileOrigin(originName);
		file.setReviewFileUpload(changeName);
		file.setReviewFilePath("resources/image/community/review");
		file.setReviewFileIndex(index);
		
		return file;
	}
	
}
