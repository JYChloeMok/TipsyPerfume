package com.kh.ttp.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//true 리턴 시 => 기존 요청 호출대로 Handler를 정상 실행(Controller 메소드 호출)
		// false 리턴 시 => Controller 실행 x
		
		//현재 요청을 보낸 사람이 로그인이 되어있을 경우 => Controller를 호출 
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") != null) {
			return true;
		} else {
			session.setAttribute("alertMsg", "로그인이 필요한 서비스입니다.");
			response.sendRedirect(request.getContextPath());
			return false;
		}
	}
		

}
