package com.kh.ttp.user.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao1 {

	public boolean isUserAdult(SqlSessionTemplate sqlSession, int userNo) {
		return ((int)sqlSession.selectOne("userMapper.isUserAdult", userNo) > 0) ? true : false;
	}
	
}
