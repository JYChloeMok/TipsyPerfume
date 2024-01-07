package com.kh.ttp.common.util;

import javax.servlet.http.HttpSession;

import com.kh.ttp.user.model.vo.User;

public class LoginUser {
	
	/**
	 * 세션의 attribute영역에 loginUser키의 값을 추출해 User객체로 반환
	 * 로그인 인터셉터를 거치지 않는 메소드의 경우 추가적인 null처리가 필요함
	 */
	public static User getLoginUser(HttpSession session) {
		return (User)session.getAttribute("loginUser");
	}

}
