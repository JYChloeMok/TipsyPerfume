package com.kh.ttp.community.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.community.board.model.vo.BoardFileVO;
import com.kh.ttp.community.board.model.vo.BoardVO;
import com.kh.ttp.community.common.model.vo.RecommendVO;

@Repository
public class BoardDAO {

	public int countBoardList(SqlSessionTemplate sqlSession, String boardCtgy) {
		return sqlSession.selectOne("boardMapper.countBoardList", boardCtgy);
	}

	public ArrayList<BoardVO> selectBoardList(SqlSessionTemplate sqlSession, String boardCtgy, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardList", boardCtgy, rowBounds);
	}

	public int increaseBoardCount(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.increaseBoardCount", boardNo);
	}
	
	public BoardVO selectBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("boardMapper.selectBoard", boardNo);
	}

	public String selectRecommend(SqlSessionTemplate sqlSession, RecommendVO rc) {
		return sqlSession.selectOne("boardMapper.selectRecommend", rc);
	}

	public int updateRecommend(SqlSessionTemplate sqlSession, RecommendVO rc) {
		return sqlSession.update("boardMapper.updateRecommend", rc);
	}

	public int insertRecommend(SqlSessionTemplate sqlSession, RecommendVO rc) {
		return sqlSession.insert("boardMapper.insertRecommend", rc);
	}

	public RecommendVO countRecommend(SqlSessionTemplate sqlSession, int contentNo) {
		return sqlSession.selectOne("boardMapper.countRecommend", contentNo);
	}

	public String selectCtgyName(SqlSessionTemplate sqlSession, String boardCtgy) {
		return sqlSession.selectOne("boardMapper.selectCtgyName", boardCtgy);
	}

	public int insertBoard(SqlSessionTemplate sqlSession, BoardVO bo) {
		return sqlSession.insert("boardMapper.insertBoard", bo);
	}

	public int updateBoard(SqlSessionTemplate sqlSession, BoardVO bo) {
		return sqlSession.update("boardMapper.updateBoard", bo);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.deleteBoard", boardNo);
	}

	public int insertBoardFile(SqlSessionTemplate sqlSession, ArrayList<BoardFileVO> fileList) {
		return sqlSession.insert("boardMapper.insertBoardFile", fileList);
	}

	public ArrayList<BoardVO> selectDetailBoardList(SqlSessionTemplate sqlSession, HashMap map, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectDetailBoardList", map, rowBounds);
	}


}
