package com.kh.ttp.user.controller;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ttp.user.model.service.UserService1;
import com.kh.ttp.user.model.vo.User;

@Controller
public class AjaxUserController1 {
	
	@Autowired
	private UserService1 userService;
	
	/**
	 * HttpSession의 Attribute영역에 로그인 한 유저의 정보가 있다면<br>
	 * 유저번호(userNo, 유저 테이블의 PK)로 해당 유저가 성인인증을 완료했는지 조회한다<br>
	 * 그 후 결과에 따라 아래와 같이 문자열을 리턴한다
	 * @param session : 로그인한 유저가 있는지 확인할 용도의 HttpSession
	 * @return
	 * 문자열 반환<br>
	 * YYYY : 로그인O 성인인증O / YYNN : 로그인O 성인인증X / NNNN : 로그인X 성인인증X
	 */
	@ResponseBody
	@GetMapping(value="ajaxAdultValidation.ur", produces="html/text; charset=UTF-8")
	public String ajaxAdultValidation(HttpSession session) {
		if(session.getAttribute("loginUser") != null) {
			int userNo = ((User)session.getAttribute("loginUser")).getUserNo();
			return userService.isUserAdult(userNo) ? "YYYY" : "YYNN";
		} else {
			return "NNNN";
		}
	}
	
	
	
	
	
}
