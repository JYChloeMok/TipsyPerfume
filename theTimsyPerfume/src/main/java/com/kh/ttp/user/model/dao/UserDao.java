package com.kh.ttp.user.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.user.model.vo.AuthVO;
import com.kh.ttp.user.model.vo.User;

@Repository
public class UserDao {

	public User loginUser(SqlSessionTemplate sqlSession, User u) {	
		//return sqlSession.selectOne("userMapper.loginUser", u);
		User us = sqlSession.selectOne("userMapper.loginUser", u);
		//System.out.println("dao: "+us);
		return us;
	}
	
	public int insertUser(SqlSessionTemplate sqlSession, User u) {
		return sqlSession.insert("userMapper.insertUser", u);
	}
	
	public int insertUser1(SqlSessionTemplate sqlSession, User u) {
		return sqlSession.insert("userMapper.insertUser2", u);
	}
	
	
	public int emailCheck(SqlSessionTemplate sqlSession, String checkEmail) {
		
		return sqlSession.selectOne("userMapper.emailCheck", checkEmail);
	}

	public int insertSecret(SqlSessionTemplate sqlSession, AuthVO authVo) {
		return sqlSession.insert("userMapper.insertSecret", authVo);
		
	}

	public int updateUser(SqlSessionTemplate sqlSession, User u) {
		
		return sqlSession.update("userMapper.updateUser", u);
	}

	public int deleteUser(SqlSessionTemplate sqlSession, String userEmail) {
		
		return sqlSession.update("userMapper.deleteUser", userEmail);
	}

	public boolean validate(SqlSessionTemplate sqlSession, AuthVO authVo) {
		AuthVO result = sqlSession.selectOne("userMapper.validate", authVo);
		return result != null;
	}

	public void deleteAuth(SqlSessionTemplate sqlSession, AuthVO authVo) {
		sqlSession.delete("userMapper.deleteAuth", authVo);
		
	}

	

	

	
	
	
	
	
}
