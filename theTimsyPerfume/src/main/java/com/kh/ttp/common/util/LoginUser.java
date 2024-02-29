package com.kh.ttp.common.util;

import javax.servlet.http.HttpSession;

import com.kh.ttp.user.model.vo.User;

public class LoginUser {
	
	/**
	 * 세션의 attribute영역에 loginUser키의 값을 추출해 User객체로 반환
	 * 호출부에서 null체크 필요
	 */
	public static User getLoginUser(HttpSession session) {
		return (User)session.getAttribute("loginUser");
	}
	
}
