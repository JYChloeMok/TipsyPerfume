package com.kh.ttp.community.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.common.template.Pagination;
import com.kh.ttp.community.board.model.service.BoardService;
import com.kh.ttp.community.common.model.vo.RecommendVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
public class AjaxBoardController {
	
	private final BoardService boardService;
	
	
	@PostMapping(value="/uploadBoardImageFile", produces = "application/json")
	@ResponseBody
	public JsonObject uploadBoardImageFile(@RequestParam("file") MultipartFile multipartFile, HttpSession session) {
		JsonObject jsonObject = new JsonObject();
		
		String fileRoot = session.getServletContext().getRealPath("/resources/image/community/board/");
		String originalFileName = multipartFile.getOriginalFilename();
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		String savedFileName = UUID.randomUUID() + extension;
		File targetFile = new File(fileRoot + savedFileName);	
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "resources/image/community/board/"+savedFileName);
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		
		return jsonObject;
	}
	@GetMapping(value = "boardRecommend", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String ajaxReviewRecommend(RecommendVO rc) {
		
		String msg="";
		String flag = boardService.selectRecommend(rc);
		if(rc.getLikeFlag().equals("L")) {
			if(flag!=null && flag.equals("L")) {
				msg="이미 추천한 게시글 입니다.";
			} else {
				if(boardService.boardRecommend(rc)>0) {
					msg="게시글을 추천 했습니다.";
				} else {
					msg="Error!";
				}
			}
		} else {
			if(flag!=null && flag.equals("D")) {
				msg="이미 비추천한 게시글 입니다.";
			} else {
				if(boardService.boardRecommend(rc)>0) {
					msg="게시글을 비추천 했습니다.";
				} else {
					msg="Error!";
				}
			}
		}
		return msg;
	}
	@GetMapping(value = "loadBoardRecommend", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String ajaxCountRecommend(int contentNo) {
		return new Gson().toJson(boardService.countRecommend(contentNo));
	}
	
	@GetMapping(value = "boardList", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String ajaxBoardList(int page, int boardNo, String boardCtgy) {
		int listCount = boardService.countBoardList(boardCtgy);
		PageInfo pi = Pagination.getPageInfo(listCount, page, 5, 5);
		HashMap map = new HashMap();
		map.put("boardNo",boardNo);
		map.put("boardCtgy",boardCtgy);
		
		return new Gson().toJson(boardService.selectDetailBoardList(map, pi));
	}
}
