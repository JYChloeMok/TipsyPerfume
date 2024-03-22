package com.kh.ttp.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.user.model.vo.UserDTO;

public class AdminInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		//UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		UserDTO loginUser = LoginUser.getLoginUser(session);
		System.out.println(loginUser);
		if(loginUser != null && loginUser.getMemberType().equals("A")) {
			return true;
		} else {
			session.setAttribute("alertMsg", "로그인을 해주세요");
			response.sendRedirect(request.getContextPath());
			return false;
		}
	}
}
