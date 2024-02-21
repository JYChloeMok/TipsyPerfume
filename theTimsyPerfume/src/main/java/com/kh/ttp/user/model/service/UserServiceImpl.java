package com.kh.ttp.user.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ttp.productSale.receiver.model.dao.ReceiverDao;
import com.kh.ttp.productSale.receiver.model.vo.ReceiverVO;
import com.kh.ttp.user.model.dao.UserDao;
import com.kh.ttp.user.model.vo.AuthVO;
import com.kh.ttp.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@EnableTransactionManagement
public class UserServiceImpl implements UserService {

	private final UserDao userDao;
	private final ReceiverDao receiverDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public User loginUser(User u) {
		return userDao.loginUser(sqlSession, u);
	}


	@Override
	@Transactional("transactionManager")
	public int insertUser(User u) {
			   userDao.insertUser(sqlSession, u);
		return userDao.insertUser1(sqlSession, u);
	}

	
	//아이디 체크
	@Override
	public int emailCheck(String checkEmail) {
		return userDao.emailCheck(sqlSession, checkEmail);
	}


	//마이페이지 보내기
	/*
	@Override
	 public List<ReceiverVO> selectReceiver(int userNo) {
	 
		//System.out.println(userNo);//2
		return receiverDao.selectReceiver(sqlSession, userNo);
	}
	*/
	
	//마이페이지 수정하기
	@Override
	public int updateUser(User u) {
		
		return userDao.updateUser(sqlSession, u);
	}

	//마이페이지>유저 삭제
	@Override
	public int deleteUser(String userEmail) {
		
		return userDao.deleteUser(sqlSession, userEmail);
	}


	
	//이메일인증----------------------------------------
	
	@Override
	public int sendMail(AuthVO authVo) {
		return userDao.insertSecret(sqlSession, authVo);
		
	}
	
	
	@Override
	public boolean validate(AuthVO authVo) {
		boolean result = userDao.validate(sqlSession, authVo);
		
		if(result != false) {
			userDao.deleteAuth(sqlSession, authVo);
		}
		
		return result;
	}

	
	
	
	
	
	
	
	
	
	
	
	
}
