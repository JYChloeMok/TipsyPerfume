package com.kh.ttp.user.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ttp.user.model.dao.UserDao;
import com.kh.ttp.user.model.vo.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public User loginUser(User u) {
		
		return userDao.loginUser(sqlSession, u);
	}

}