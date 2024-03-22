package com.kh.ttp.user.model.service;

import com.kh.ttp.user.model.vo.AuthDTO;
import com.kh.ttp.user.model.vo.UserDTO;

public interface UserService {

	//로그인(select)
	UserDTO loginUser(UserDTO u);

	//회원가입(insert)
	int insertUser(UserDTO u);
	
	
	//회원정보 수정(update)
	int updateUser(UserDTO u);
	
	//회원 삭제(delete)
	int deleteUser(String userEmail);
	
	//-----------
	
	//아이디 중복 체크 서비스 
	int emailCheck(String checkEmail);
	
	//-----------
	
	//메일 인증
	int sendMail(AuthDTO authVo);
	
	boolean validate(AuthDTO AuthVo);

	

	//----------------------
	
	//마이페이지 보여주기
	//Receiver mypageUser(User u);
	//ReceiverVO selectReceiver(int userNo);

	

	
	
	
}
