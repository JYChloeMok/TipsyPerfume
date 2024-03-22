package com.kh.ttp.common.util;

import javax.servlet.http.HttpSession;

import com.kh.ttp.user.model.vo.UserDTO;

public class LoginUser {
	
	/**
	 * 세션의 attribute영역에 loginUser키의 값을 추출해 User객체로 반환
	 * 호출부에서 null체크 필요
	 */
	public static UserDTO getLoginUser(HttpSession session) {
		return (UserDTO)session.getAttribute("loginUser");
	}
	
}
