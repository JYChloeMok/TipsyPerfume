package com.kh.ttp.community.board.model.vo;

import lombok.Data;

@Data
public class BoardFileVO {
	/*
	BOARD_FILE_NO
	BOARD_NO
	BOARD_FILE_ORIGIN
	BOARD_FILE_UPLOAD
	BOARD_FILE_PATH
	BOARD_FILE_INDEX
	*/
	private int boardFileNo;
	private int boardNo;
	private String boardFileOrigin;
	private String boardFileUpload;
	private String boardFilePath;
	private int boardFileIndex;
}
