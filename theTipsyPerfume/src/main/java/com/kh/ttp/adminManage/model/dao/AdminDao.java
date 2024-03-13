package com.kh.ttp.adminManage.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.adminManage.model.vo.AdminVo;

@Repository
public class AdminDao {
	
	public  int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminMapper.selectListCount");
	}

	public  ArrayList<AdminVo> selectList(SqlSessionTemplate sqlSession, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectList", null, rowBounds);
	}

	//public int insertAlcohol(SqlSessionTemplate sqlSession, AdminVo a) {
	//	return sqlSession.insert("boardMapper.insertAlcohol", a);
	//}
	
	
	

}
