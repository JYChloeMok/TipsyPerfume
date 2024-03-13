package com.kh.ttp.community.common.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.community.common.model.vo.CommentVO;

@Repository
public class CommentDAO {
	
	public ArrayList<CommentVO> selectCommentList(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		return (ArrayList)sqlSession.selectList("commentMapper.selectCommentList", map);
	}

	public int increaseCommentIndex(SqlSessionTemplate sqlSession, int commentGroup) {
		return sqlSession.update("commentMapper.increaseCommentIndex", commentGroup);
	}
	
	public int insertComment(SqlSessionTemplate sqlSession, CommentVO comment) {
		return sqlSession.insert("commentMapper.insertComment", comment);
	}
}
