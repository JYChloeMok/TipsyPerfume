package com.kh.ttp.community.common.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class RecommendVO {
	private int userNo;
	private int contentNo;
	private String likeFlag;
	
	private String likeCount;
	private String dislikeCount;
}
