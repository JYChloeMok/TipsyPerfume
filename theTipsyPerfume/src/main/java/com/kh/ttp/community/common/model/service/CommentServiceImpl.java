package com.kh.ttp.community.common.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ttp.community.common.model.dao.CommentDAO;
import com.kh.ttp.community.common.model.vo.CommentVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CommentServiceImpl implements CommentService {

	private final CommentDAO commentDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<CommentVO> selectCommentList(HashMap<String, Integer> map) {
		return commentDao.selectCommentList(sqlSession, map);
	}
	@Override
	@Transactional
	public int insertComment(CommentVO comment) {
		commentDao.increaseCommentIndex(sqlSession, comment.getCommentGroup());
		return commentDao.insertComment(sqlSession, comment);
	}

}
