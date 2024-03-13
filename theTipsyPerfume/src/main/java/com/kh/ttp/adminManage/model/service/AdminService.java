package com.kh.ttp.adminManage.model.service;

import java.util.ArrayList;

import com.kh.ttp.adminManage.model.vo.AdminVo;
import com.kh.ttp.common.model.vo.PageInfo;

public interface AdminService {

	// 게시글 목록 조회 + 페이징처리
	// 게시글 총 개수 조회 
	int selectListCount();

	// 게시글 리스트 조회
	ArrayList<AdminVo> selectList(PageInfo pi);

	//int insertAlcohol(AdminVo a);
	
	
	
	
	
	
	
	
	

}
