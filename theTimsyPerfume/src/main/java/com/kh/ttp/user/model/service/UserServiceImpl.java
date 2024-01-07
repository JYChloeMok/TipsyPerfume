package com.kh.ttp.user.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ttp.productSale.order.model.vo.ReceiverVO;
import com.kh.ttp.user.model.dao.UserDao;
import com.kh.ttp.user.model.vo.AuthVO;
import com.kh.ttp.user.model.vo.User;

@Service
@EnableTransactionManagement
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
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
	@Override
	public ReceiverVO selectReceiver(int userNo) {
		//System.out.println(userNo);//2
		return userDao.selectReceiver(sqlSession, userNo);
	}

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
