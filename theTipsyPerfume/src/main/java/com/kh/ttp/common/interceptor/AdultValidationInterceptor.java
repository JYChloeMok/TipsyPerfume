package com.kh.ttp.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.ttp.user.model.vo.User;

public class AdultValidationInterceptor extends HandlerInterceptorAdapter {
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("loginUser");
		if(user != null && "Y".equals(user.getAdultStatus())) {
			return true;
		} else {
			session.setAttribute("adultResult", "N");
			response.sendRedirect(request.getHeader("referer"));
			return false;
		}
	}
	
	//System.out.println(request.getHeader("referer") + "리퍼페이지");
}
