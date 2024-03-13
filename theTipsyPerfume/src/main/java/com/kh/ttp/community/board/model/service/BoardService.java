package com.kh.ttp.community.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.community.board.model.vo.BoardFileVO;
import com.kh.ttp.community.board.model.vo.BoardVO;
import com.kh.ttp.community.common.model.vo.RecommendVO;

public interface BoardService {
	public int countBoardList(String boardCtgy);
	public ArrayList<BoardVO> selectBoardList(String boardCtgy, PageInfo pi);
	
	public int increaseBoardCount(int boardNo);
	public BoardVO selectBoard(int boardNo);
	
	public String selectRecommend(RecommendVO rc);
	public int boardRecommend(RecommendVO rc);
	public RecommendVO countRecommend(int contentNo);
	
	public String selectCtgyName(String boardCtgy);
	
	public int insertBoard(BoardVO bo, ArrayList<BoardFileVO> fileList);
	public int updateBoard(BoardVO bo);
	public int deleteBoard(int boardNo);
	public ArrayList<BoardVO> selectDetailBoardList(HashMap map, PageInfo pi);
}
