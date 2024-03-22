package com.kh.ttp.user.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data @AllArgsConstructor @Builder
public class AuthDTO {

	public String authEmail, authCode, authDate;
}
