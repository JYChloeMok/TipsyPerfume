package com.kh.ttp.community.notice.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.common.template.Pagination;
import com.kh.ttp.community.notice.model.service.NoticeService;
import com.kh.ttp.community.notice.model.vo.NoticeVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class NoticeController {
	
	private final NoticeService noticeService;
	
	@GetMapping("noticeWrite")
	public String noticeWriteForm() {
		return "community/noticeWrite";
	}
	@PostMapping("noticeWrite.do")
	public ModelAndView noticeWrite(NoticeVO no, MultipartFile thumbnailFile, MultipartFile imgFile, HttpSession session, ModelAndView mv) {
		no.setNoticeTitle(no.getNoticeTitle().replace("<", "&lt;"));
		no.setNoticeTitle(no.getNoticeTitle().replace(">", "&gt;"));
		no.setNoticeContent(no.getNoticeContent().replace("<", "&lt;"));
		no.setNoticeContent(no.getNoticeContent().replace(">", "&gt;"));
		
		no.setNoticeThumbnailFile(saveFile(thumbnailFile, session));
		no.setNoticeFile(saveFile(imgFile, session));
		if(noticeService.insertNotice(no)>0) {
			mv.setViewName("redirect:notice");
		} else {
			mv.addObject("alertMsg", "공지 변경 실패");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
	@GetMapping("notice")
	public ModelAndView noticeList(@RequestParam(value = "page", defaultValue = "1")int page, ModelAndView mv) {
		int listCount = noticeService.countNoticeList();
		PageInfo pi = Pagination.getPageInfo(listCount, page, 10, 5);
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		ArrayList<NoticeVO> list = noticeService.selectNoticeList(rowBounds);
		
		mv.addObject("list", list).
		addObject("pi", pi).
		setViewName("community/notice");
		return mv;
	}
	@GetMapping("noticeDetail")
	public ModelAndView noticeDetail(int noticeNo, HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		if(noticeCountUp(noticeNo, request, response)) {
			NoticeVO notice = noticeService.selectNoticeDetail(noticeNo);
			mv.addObject("notice", notice).
			setViewName("community/noticeDetail");
		} else {
			mv.addObject("alertMsg", "조회 실패");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	private boolean noticeCountUp(int noticeNo, HttpServletRequest request, HttpServletResponse response) {
		boolean success = false;
		Cookie oldCookie = null;
		Cookie[] cookies = request.getCookies();
		if(cookies!=null) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("noticeViews")) {
					oldCookie = cookie;
				}
			}
		}
		if(oldCookie!=null) {
			if(oldCookie.getValue().contains("["+noticeNo+"]")) {
				success = true;
			} else {
				if(noticeService.increaseNoticeCount(noticeNo)>0) {
					oldCookie.setValue(oldCookie.getValue()+"["+noticeNo+"]");
					oldCookie.setMaxAge(60*60*24);
					response.addCookie(oldCookie);
					success = true;
				} else {
					success = false;
				}
			}
		} else {
			if(noticeService.increaseNoticeCount(noticeNo)>0) {
				Cookie newCookie = new Cookie("noticeViews", "["+noticeNo+"]");
				newCookie.setMaxAge(60*60*24);
				response.addCookie(newCookie);
				success = true;
			} else {
				success = false;
			}
		}
		return success;
	}
	
	@GetMapping("noticeEnd")
	public ModelAndView noticeEnd(int noticeNo, ModelAndView mv) {
		if(noticeService.noticeEnd(noticeNo)>0) {
			mv.setViewName("redirect:notice");
		} else {
			mv.addObject("alertMsg", "종료 실패");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	@GetMapping("noticeRestart")
	public ModelAndView noticeRestart(int noticeNo, ModelAndView mv) {
		if(noticeService.noticeRestart(noticeNo)>0) {
			mv.setViewName("redirect:notice");
		} else {
			mv.addObject("alertMsg", "재시작 실패");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	@GetMapping("noticeUpdate")
	public ModelAndView noticeUpdateForm(int noticeNo, ModelAndView mv) {
		if(noticeService.increaseNoticeCount(noticeNo)>0) {
			NoticeVO notice = noticeService.selectNoticeDetail(noticeNo);
			mv.addObject("notice", notice).
			setViewName("community/noticeUpdate");
		} else {
			mv.addObject("alertMsg", "조회 실패");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	@PostMapping("noticeUpdate.do")
	public ModelAndView noticeUpdate(NoticeVO no, MultipartFile thumbnailFile, MultipartFile imgFile, HttpSession session, ModelAndView mv) {
		no.setNoticeTitle(no.getNoticeTitle().replace("<", "&lt;"));
		no.setNoticeTitle(no.getNoticeTitle().replace(">", "&gt;"));
		no.setNoticeContent(no.getNoticeContent().replace("<", "&lt;"));
		no.setNoticeContent(no.getNoticeContent().replace(">", "&gt;"));
		
		if(!thumbnailFile.getOriginalFilename().equals("")) {
			new File(session.getServletContext().getRealPath(no.getNoticeThumbnailFile())).delete();
			no.setNoticeThumbnailFile(saveFile(thumbnailFile, session));
		}
		if(!imgFile.getOriginalFilename().equals("")) {
			new File(session.getServletContext().getRealPath(no.getNoticeFile())).delete();
			no.setNoticeFile(saveFile(imgFile, session));
		}
		if(noticeService.updateNotice(no)>0) {
			mv.setViewName("redirect:noticeDetail?noticeNo="+no.getNoticeNo());
		} else {
			mv.addObject("alertMsg", "공지 변경 실패");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
	private String saveFile(MultipartFile upfile, HttpSession session) {
		String originName = upfile.getOriginalFilename();
		
		String curTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int ranNum = (int)(Math.random()*90000+10000);
		String ext =  originName.substring(originName.lastIndexOf("."));
		String changeName = "notice_"+curTime + ranNum + ext;
		String savePath = session.getServletContext().getRealPath("/resources/image/community/notice/");
		
		try {
			upfile.transferTo(new File(savePath+changeName));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		return "resources/image/community/notice/"+changeName;
	}
}
