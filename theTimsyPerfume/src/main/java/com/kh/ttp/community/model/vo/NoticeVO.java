package com.kh.ttp.community.model.vo;

import lombok.Data;

@Data
public class NoticeVO {
	private int noticeNo;
	private String noticeCtgy;
	private String noticeTitle;
	private String noticeContent;
	private String noticeCreateDate;
	private String noticeFile;
	private int noticeCount;
	private String noticeState;
}
