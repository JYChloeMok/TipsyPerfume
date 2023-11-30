package com.kh.ttp.product.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.common.template.Pagination;
import com.kh.ttp.community.review.model.service.ReviewService;
import com.kh.ttp.community.review.model.vo.ReviewVO;
import com.kh.ttp.funding.model.vo.Funding;
import com.kh.ttp.orderKinds.model.vo.Receiver;
import com.kh.ttp.product.model.service.ProductService;
import com.kh.ttp.product.model.vo.CartVO;
import com.kh.ttp.product.model.vo.FundingSelectVO;
import com.kh.ttp.product.model.vo.OrderDetailVO;
import com.kh.ttp.product.model.vo.OrderVO;
import com.kh.ttp.product.model.vo.PayVO;
import com.kh.ttp.product.model.vo.ProductVO;
import com.kh.ttp.productCategory.model.vo.ProductCategory;
import com.kh.ttp.productFile.model.vo.ProductFile;
import com.kh.ttp.productOption.model.vo.ProductOption;
import com.kh.ttp.user.model.vo.User;

@Controller
public class ProductController {

	@Autowired
	private ProductService productService;
	@Autowired
	private ReviewService reviewService;
	
	
	
	
	
	
	
	@PostMapping("insertDrink.fun")
	public String drinkFundinginsert(MultipartFile upfile,HttpSession session,ProductVO product,ProductCategory productCategory
			,ProductFile productFile, ProductOption productOption,Funding funding			) {
		
		
		
		if(!upfile.getOriginalFilename().equals("")) {
			productFile.setPdtFileOrigin(upfile.getOriginalFilename());
			productFile.setPdtFileUpload(saveFile(upfile,session));
		}
		if(productService.drinkFundingInsert(product,productFile,productOption,funding,productCategory)>0) {
			session.setAttribute("alertMsg", "펀딩 상품 등록 완료.");
			return "redirect:funding.list";
		} else {
			return "common/errorPage";
		}
		
		
		
		
		
		
	}
	@RequestMapping("updateDrink.fun")
	public String updateDrinkFunding(MultipartFile upfile,HttpSession session,Model model,
									ProductVO product,ProductCategory productCategory,ProductFile productFile,ProductOption productOption,
									Funding funding) {
		
		
		
		if(!upfile.getOriginalFilename().equals("")) {
			productFile.setPdtFileOrigin(upfile.getOriginalFilename());
			productFile.setPdtFileUpload(saveFile(upfile,session));
		}
		if(productService.updateDrinkFunding(product,productFile,productOption,funding,productCategory)>0) {
			session.setAttribute("alertMsg", "펀딩 상품 업데이트 완료.");
			return "redirect:funding.list";
		} else {
			return "common/errorPage";
		}
		
		
		
	}
	private String saveFile(MultipartFile upfile, HttpSession session) {
		String originName = upfile.getOriginalFilename();
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
		int ranNum = (int)(Math.random() * 9000) + 1000;
		
		String ext = originName.substring(originName.lastIndexOf("."));
		String changeName = currentTime + ranNum +ext;
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			
			e.printStackTrace();
		}
		return changeName;
	}
	@RequestMapping("funding.list")
	private String selectFundingList(Model model) {
		ArrayList<FundingSelectVO> nfs = productService.selectNewFundingList();
		ArrayList<FundingSelectVO> hfs = productService.selectHotFundingList();
		model.addAttribute("drinkFundingList", nfs);
		model.addAttribute("drinkHotFundingList",hfs);
		
		return "funding/fundingList";
	}
	@RequestMapping("newDrinkFunding.list")
	public String newDrinkFundingListPage(@RequestParam(value="cPage", defaultValue="1")int currentPage ,Model model) {
		PageInfo pi = Pagination.getPageInfo(productService.newDrinkFundingListCount(),currentPage,12,10);
		model.addAttribute("totalNewDrinkFunding",productService.newDrinkFundingList(pi));
		model.addAttribute("pi",pi);
		
		return "funding/newDrinkFundingList";
	}
	@RequestMapping("hotDrinkFunding.list")
	public String hotDrinkFundingListPage(@RequestParam(value="cPage", defaultValue="1")int currentPage ,Model model) {
		PageInfo pi = Pagination.getPageInfo(productService.newDrinkFundingListCount(),currentPage,12,10);
		model.addAttribute("totalHotDrinkFunding",productService.hotDrinkFundingList(pi));
		model.addAttribute("pi",pi);
		return "funding/hotDrinkFundingList";
	}
	@RequestMapping("detail.fList")
	public String newDrinkFundingDetail(@RequestParam(value="pno") int pdtNo,Model model) {
		
		
		if(productService.increaseCount(pdtNo) > 0) {
			FundingSelectVO ps= productService.newDrinkFundingDetail(pdtNo);
			int listCount = reviewService.countFundingReview(pdtNo);
			PageInfo pi = Pagination.getPageInfo(listCount, 1, 4, 5);
			ArrayList<ReviewVO> reviewList = reviewService.selectReviewFunding(pi,pdtNo);
			java.util.Date d = ps.getCuttingDate();
			//System.out.println("date : "+d);
			//System.out.println("bo : " + (d.compareTo(new java.util.Date())>=0));//java.sql.Date를 java.util.Date로 강제 형변환 후 
			//compareTo로 ps.cuttingDate(마감날짜) 와 new Date(현재날짜) 를 비교해서 마감 날짜가 현재 날짜보다 크면 true로 반환 작으면 false 
			model.addAttribute("cutting",(d.compareTo(new java.util.Date())>=0));
			model.addAttribute("fundingDetailList", ps);
			model.addAttribute("pno",pdtNo);
			model.addAttribute("reviewList",reviewList);
			model.addAttribute("pi",pi);
			model.addAttribute("listCount",listCount);
			return "funding/newDrinkFundingDetail";
		}else {
				return "common/errorPage";
			}
		
	}
	@RequestMapping("updateForm.fd")
	public String updateFormPage(@RequestParam(value="pno") int pdtNo,Model model) {
		
		model.addAttribute("fdi",productService.selectDrinkFundingList(pdtNo));
		model.addAttribute("pdtNo",pdtNo);
		return "funding/updateDrinkFunding";
	}
	@RequestMapping("delete.fd")
	public String deleteDrinkFunding(@RequestParam(value="pno") int pdtNo,Model model,HttpSession session) {
			if(productService.deleteDrinkFunding(pdtNo)>0) {
				session.setAttribute("alertMsg", "삭제 성공");
				return "redirect:funding.list";
			}
				return "common/errorPage";
	}
	@RequestMapping("purchase.fd")
	public String buyDrinkFunding(Model model,int pno,String pdtName,int pdtPrice,String pdtShipping,String pdtFileUpload) {
		model.addAttribute("pdtNo", pno);
		model.addAttribute("pdtName",pdtName);
		model.addAttribute("pdtPrice",pdtPrice);
		model.addAttribute("pdtShipping",pdtShipping);
		model.addAttribute("pdtFileUpload",pdtFileUpload);
		
		return "funding/buyDrinkFunding";
		
	}
	@RequestMapping("funding.fd")
	public String confirmFundingDrink(HttpSession session,OrderDetailVO orderDetail,OrderVO order,User user,ProductVO product,PayVO pay,
			Funding funding,Receiver receiver,int selectAddress) {
		int orderPrice =  (product.getPdtPrice()*product.getOrderQuantity())+funding.getFundingFee();//(상품가격 *상품개수)+후원비
		
		
		
		pay.setPayTotal(orderPrice);
		//System.out.println(selectAddress);
		System.out.println(receiver);
		
		if(selectAddress==2 ) {
			productService.insertReceiver(receiver);
		}
		
		if(productService.confirmFundingDrink(orderDetail,order,user,product,pay,funding,receiver)>0) {
			
			return "common/buyConfirmPage";
		}else {
			return "common/errorPage";
		}
		
		
	}
	@PostMapping("fundingBasket.insert")
	public String insertFundingBasket(CartVO cart,Model model) {
		productService.insertFundingBasket(cart);
		return "redirect:funding.list";
	}
	@GetMapping("cartMain.f")
	public String fundingCart(int userNo) {
			System.out.println(userNo);
		return "funding/fundingBascket";
	}
	
		
	
	

}
