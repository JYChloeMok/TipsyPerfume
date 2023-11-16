package com.kh.ttp.user.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ttp.user.model.dao.UserDao;
import com.kh.ttp.user.model.vo.AuthVO;
import com.kh.ttp.user.model.vo.User;

@Service
//@EnableTransactionManagement
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
	@Transactional
	public int insertUser(User u) {
		userDao.insertUser(sqlSession, u);
		return userDao.insertUser1(sqlSession, u);
	}

	
	//아이디 체크
	@Override
	public int emailCheck(String checkEmail) {
		return userDao.emailCheck(sqlSession, checkEmail);
	}


	@Override
	public void sendMail(AuthVO authVo) {
		userDao.insertSecret(sqlSession, authVo);
		
	}

	
	
}
