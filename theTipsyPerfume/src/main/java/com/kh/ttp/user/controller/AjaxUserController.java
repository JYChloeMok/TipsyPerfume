package com.kh.ttp.user.controller;

import java.util.ArrayList;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.ttp.user.model.vo.UserDTO;

@Controller
public class AjaxUserController {

	@ResponseBody
	@RequestMapping(value="ajax1.do", produces="application/json; charset=UTF-8")
	public String ajaxMethod1(String name, int age) {
		JSONObject jObj = new JSONObject();
		jObj.put("name", name);
		jObj.put("age", age);
		return jObj.toJSONString(); // StringBuilder를 사용해서 요소들을 문자열로 만든 뒤 toString한 메소드를 반환 / JSONArray에서도 사용가능
	}
	
	@ResponseBody
	@RequestMapping(value="ajax2.do", produces="application/json; charset=UTF-8")
	public String ajaxMethod2(int num) {
		UserDTO m = new UserDTO();
		return new Gson().toJson(m);
	}
	
	@ResponseBody
	@RequestMapping(value = "ajax3.do", produces="application/json; charset=UTF-8")
	public String ajaxMethod3() {
		
		//ArrayList<User> list = UserService.selectUserList();
		ArrayList<UserDTO> list = new ArrayList();
		
		list.add(new UserDTO());
		list.add(new UserDTO());
		list.add(new UserDTO());
		
		return new Gson().toJson(list);
	}
	
	
	
	
	
}
