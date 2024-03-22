package com.kh.ttp.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.user.model.vo.UserDTO;

public class AdultValidationInterceptor extends HandlerInterceptorAdapter {
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		UserDTO user = LoginUser.getLoginUser(session);
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
