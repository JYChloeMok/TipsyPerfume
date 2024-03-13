package com.kh.ttp.community.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.community.board.model.dao.BoardDAO;
import com.kh.ttp.community.board.model.vo.BoardFileVO;
import com.kh.ttp.community.board.model.vo.BoardVO;
import com.kh.ttp.community.common.model.vo.RecommendVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {
	
	private final BoardDAO boardDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public int countBoardList(String boardCtgy) {
		return boardDao.countBoardList(sqlSession, boardCtgy);
	}

	@Override
	public ArrayList<BoardVO> selectBoardList(String boardCtgy, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return boardDao.selectBoardList(sqlSession, boardCtgy, rowBounds);
	}
	
	@Override
	public int increaseBoardCount(int boardNo) {
		return boardDao.increaseBoardCount(sqlSession, boardNo);
	}

	@Override
	public BoardVO selectBoard(int boardNo) {
		return boardDao.selectBoard(sqlSession, boardNo);
	}

	@Override
	public String selectRecommend(RecommendVO rc) {
		return boardDao.selectRecommend(sqlSession, rc);
	}

	@Override
	public int boardRecommend(RecommendVO rc) {
		int result = boardDao.updateRecommend(sqlSession, rc);
		if(result==0) {
			result = boardDao.insertRecommend(sqlSession, rc);
		}
		return result;
	}

	@Override
	public RecommendVO countRecommend(int contentNo) {
		return boardDao.countRecommend(sqlSession, contentNo);
	}

	@Override
	public String selectCtgyName(String boardCtgy) {
		return boardDao.selectCtgyName(sqlSession, boardCtgy);
	}

	@Override
	@Transactional
	public int insertBoard(BoardVO bo, ArrayList<BoardFileVO> fileList) {
		int result1 = boardDao.insertBoard(sqlSession, bo);
		int result2 = 1;
		if(!fileList.isEmpty()) {
			result2 = boardDao.insertBoardFile(sqlSession, fileList);
		}
		return result1 * result2;
	}

	@Override
	public int updateBoard(BoardVO bo) {
		return boardDao.updateBoard(sqlSession, bo);
	}

	@Override
	public int deleteBoard(int boardNo) {
		return boardDao.deleteBoard(sqlSession,boardNo);
	}

	@Override
	public ArrayList<BoardVO> selectDetailBoardList(HashMap map, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return boardDao.selectDetailBoardList(sqlSession, map, rowBounds);
	}


}
