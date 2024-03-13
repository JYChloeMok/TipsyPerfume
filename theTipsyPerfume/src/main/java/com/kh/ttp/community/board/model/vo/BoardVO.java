package com.kh.ttp.community.board.model.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int boardNo;
	private String boardWriterNo;
	private String boardWriter;
	private String boardTitle;
	private String boardContent;
	private String boardCreateDate;
	private String boardModifyDate;
	private String boardCtgyCode;
	private String boardCtgyName;
	private String boardState;
	private String boardCount;
	
	private String commentCount;
	private String likeCount;
	private String dislikeCount;
}
