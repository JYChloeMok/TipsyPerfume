package com.kh.ttp.community.pedia.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ttp.community.pedia.model.dao.PediaDAO;
import com.kh.ttp.community.pedia.model.vo.PediaVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class PediaServiceImpl implements PediaService {
	
	private final PediaDAO pediaDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<PediaVO> selectPediaList(HashMap map) {
		return pediaDao.selectPediaList(sqlSession, map);
	}

	@Override
	public PediaVO selectPediaInfo(HashMap map) {
		return pediaDao.selectPediaInfo(sqlSession, map);
	}

}
