package com.kh.ttp.community.common.model.vo;

import lombok.Data;

@Data
public class CommentVO {
	private int commentNo;
	private String userNo;
	private int boardNo;
	private int reviewNo;
	private String commentContent;
	private String commentCreateDate;
	private String commentModifyDate;
	private int commentGroup;
	private int commentIndex;
	private int commentDepth;
	private String commentState;
	
	private int groupCount;
}
