package com.kh.ttp.common.util;

import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.view.RedirectView;

import com.kh.ttp.user.model.vo.User;

public class LoginUser {
	
	/**
	 * 세션의 attribute영역에 loginUser키의 값을 추출해 User객체로 반환
	 * 실수로 로그인 인터셉터를 사용하지 않아 NPE이 발생할 경우를 대비해 null일 시 로그인 페이지로 redirect
	 */
	public static Object getLoginUser(HttpSession session) {
		User user = (User)session.getAttribute("loginUser");
		if(user == null) {
			RedirectView redirectView = new RedirectView("loginForm.me");
			return redirectView;
		}
		return (User)session.getAttribute("loginUser");
	}
	
}
