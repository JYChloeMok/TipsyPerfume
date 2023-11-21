package com.kh.ttp.product.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.common.template.Pagination;
import com.kh.ttp.funding.model.vo.Funding;
import com.kh.ttp.product.model.service.ProductService;
import com.kh.ttp.product.model.vo.FundingSelectVO;
import com.kh.ttp.product.model.vo.ProductVO;
import com.kh.ttp.productCategory.model.vo.ProductCategory;
import com.kh.ttp.productFile.model.vo.ProductFile;
import com.kh.ttp.productOption.model.vo.ProductOption;

@Controller
public class ProductController {

	@Autowired
	private ProductService productService;

	
	
	
	@RequestMapping("insertDrink.fun")
	public String drinkFundinginsert(MultipartFile upfile,HttpSession session,Model model,String pdtName,String pdtIntro,String pdtDescription,String pdtShipping, int cuttingPrice,int pdtPrice,Date cuttingDate,String pdtManufac,String pdtGroup,String pdtIngredient,int pdtStock,String pdtOptionFirst,String pdtOptionSecond) {
		System.out.println(upfile);
		//System.out.println(pdtName);
		//System.out.println(pdtIntro);
		//System.out.println(pdtDescription);
		//System.out.println(pdtShipping);
		//System.out.println(cuttingPrice);
		//System.out.println(pdtPrice);
		//System.out.println(cuttingDate);
		//System.out.println(pdtManufac);
		//System.out.println(pdtGroup);
		//System.out.println(pdtIngredient);
		ProductVO p = new ProductVO();
		p.setPdtName(pdtName);
		p.setPdtIntro(pdtIntro);
		p.setPdtDescription(pdtDescription);
		p.setPdtShipping(pdtShipping);
		p.setPdtPrice(pdtPrice);
		p.setPdtIngredient(pdtIngredient);
		p.setPdtStock(pdtStock);
		ProductCategory pc = new ProductCategory();
		pc.setPdtManufac(pdtManufac);
		pc.setPdtGroup(pdtGroup);
		
		
		ProductFile pf = new ProductFile();
		
		
		ProductOption po = new ProductOption();
		po.setPdtOptionFirst(pdtOptionFirst);
		po.setPdtOptionSecond(pdtOptionSecond);
		
		Funding f = new Funding();
		f.setCuttingDate(cuttingDate);
		f.setCuttingPrice(cuttingPrice);
		
		if(!upfile.getOriginalFilename().equals("")) {
			pf.setPdtFileOrigin(upfile.getOriginalFilename());
			pf.setPdtFileUpload(saveFile(upfile,session));
		}
		if(productService.drinkFundingInsert(p,pf,po,f,pc)>0) {
			session.setAttribute("alertMsg", "펀딩 상품 등록 완료.");
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
		return "/resources/uploadFiles/" + changeName;
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
		System.out.println(pdtNo);
		if(productService.increaseCount(pdtNo) > 0) {
		model.addAttribute("fundingDetailList",productService.newDrinkFundingDetail(pdtNo));
		model.addAttribute("pno",pdtNo);
		return "funding/newDrinkFundingDetail";
		}else {
			return "common/errorPage";
		}
		
	}
	@RequestMapping("updateForm.fd")
	public String updateFormPage(@RequestParam(value="pno") int pdtNo,Model model) {
		System.out.println(pdtNo);
		model.addAttribute("fdi",productService.selectDrinkFundingList(pdtNo));
		model.addAttribute("pdtNo",pdtNo);
		return "funding/updateDrinkFunding";
	}
	
	

}
