package com.kh.ttp.community.common.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.ttp.community.common.model.vo.CommentVO;

public interface CommentService {

	public ArrayList<CommentVO> selectCommentList(HashMap<String, Integer>map);
	public int insertComment(CommentVO comment);
}
