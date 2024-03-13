package com.kh.ttp.community.pedia.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.community.pedia.model.vo.PediaVO;

@Repository
public class PediaDAO {

	public ArrayList<PediaVO> selectPediaList(SqlSessionTemplate sqlSession, HashMap map) {
		return (ArrayList)sqlSession.selectList("pediaMapper.selectPediaList", map);
	}
	
	public PediaVO selectPediaInfo(SqlSessionTemplate sqlSession, HashMap map) {
		return sqlSession.selectOne("pediaMapper.selectPediaInfo", map);
	}

}
