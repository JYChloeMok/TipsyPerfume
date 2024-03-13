package com.kh.ttp.adminManage.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttp.adminManage.model.service.AdminService;
import com.kh.ttp.adminManage.model.vo.AdminVo;
import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.common.template.Pagination;

@Controller
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	//admin폼 보내기
	@RequestMapping("adminForm.me")
	public String adminForm() {
		return "adminManage/adminMain";
	}
	
	/*
	//adminAlcoholMain폼 보내기
	@RequestMapping("adminAlcoholList.me")
	public String selectAlcoholList() {
		return "adminManage/AdminAlcoholMain";
	}
	*/
	
	//adminAlcoholMain폼 보내기
		@RequestMapping("list.bo")
		public String selectAlcoholList(@RequestParam(value="cPage", defaultValue="1")
														int currentPage, Model model) {
			
			System.out.println(currentPage);
			PageInfo pi = Pagination.getPageInfo(adminService.selectListCount(),
												currentPage, 5, 5);
			
			model.addAttribute("list", adminService.selectList(pi));
			model.addAttribute("pi", pi);
			return "adminManage/AdminAlcoholMain";
		}
	
	
	
	//enroll폼 보내기
	@RequestMapping("adminAlcoholEnrollForm.me")
	public String adminEnrollForm() {
		return "adminManage/adminAlcoholEnrollForm";
	}
	
	
	//enroll해주는 거..4테이블 합체.insert와 join.
	/*
	@RequestMapping("adminAlcoholEnroll.me")
	public String adminInsert(AdminVo a,
								MultipartFile upfile,  //여러개의 첨부파일을 전달받을 시 MultipartFile[]로
								HttpSession session,
								Model model,
								String pdtName,String pdtIntro,String pdtDescription,String pdtShipping, int cuttingPrice,int pdtPrice,Date cuttingDate,String pdtManufac,String pdtGroup,String pdtIngredient,int pdtStock,String pdtOptionFirst,String pdtOptionSecond) {
		
		if(!upfile.getOriginalFilename().contentEquals("") ) {
			a.setPdtFileOrigin(upfile.getOriginalFilename());
			a.setPdtFileUpload(saveFile(upfile, session));
			
		}
		if(adminService.insertAlcohol(a) > 0) { // 성공 -> 게시글 목록을 보여주기
			session.setAttribute("alertMsg", "게시글 작성 성공!");
			return "redirect:list.bo";
		} else {
			model.addAttribute("errorMsg", "게시글 작성 실패");
			return "common/errorPage";
		}
		
		
		
	}

	//이렇게 꺼내서 쓰면 좋다(중복일 경우)
		public String saveFile(MultipartFile upfile, HttpSession session) {
			// 파일명 수정 작 후 서버에 업로드시키기("bono.jpg" => 20231103012398.jpg)
						String originName = upfile.getOriginalFilename();
						
						// "20231103102244"(년월일시분초)
						String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
						
						// 23432(5자리 랜덤값)
						int ranNum = (int)Math.random() * 90000 + 10000;
						
						// 확장자
						String ext = originName.substring(originName.lastIndexOf("."));
						
						String changeName = currentTime + ranNum + ext;
						
						String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
						
						
							try {
								upfile.transferTo(new File(savePath + changeName));
							} catch (IllegalStateException | IOException e) {
								e.printStackTrace();
							}
						return "resources/uploadFiles/" + changeName;
			
		}
	*/
	
	
	
	
	
	
	
	
	
}
