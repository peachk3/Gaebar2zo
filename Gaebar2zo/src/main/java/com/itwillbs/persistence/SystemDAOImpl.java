package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.CodeVO;
import com.itwillbs.domain.ItemCodeVO;
import com.itwillbs.domain.UsersVO;

@Repository
public class SystemDAOImpl implements SystemDAO{

	private static final Logger logger = LoggerFactory.getLogger(SystemDAOImpl.class);

	@Inject
	public SqlSession sqlSession;

	public static final String NAMESPACE="com.itwillbs.mapper.systemMapper.";

	//이메일 중복
	@Override
	public int emailCheck(String user_email) throws Exception {
		int result = sqlSession.selectOne(NAMESPACE + "emailCheck", user_email);
		
		logger.info("result :" + result);
				
				return result;
	}

	//전화번호 중복
	@Override
	public int phoneCheck(String user_phone) throws Exception {
		int result = sqlSession.selectOne(NAMESPACE + "phoneCheck", user_phone);
		
		logger.info("result(service-> dao) :" + result);
		
		return result;
	}
	
	

	//운영자,관리자,사원 전체 리스트 출력
	@Override
	public List<UsersVO> employeeListAll() throws Exception {
		logger.debug("employeeListAll() 실행");
		
		return sqlSession.selectList(NAMESPACE+"employeeListAll");
	}


	//==============================================================
	//공통코드 전체 리스트 출력
	@Override
	public List<CodeVO> codeListAll() throws Exception {
		logger.info("codeListAll() 실행");
		
		return sqlSession.selectList(NAMESPACE + "codeListAll");
	}

	//공통코드 등록
	@Override
	public void saveGroupCode(CodeVO codeVo) throws Exception {
		logger.debug("service-> dao saveGroupCode() 실행");
		
		sqlSession.insert(NAMESPACE +"saveGroupCode",codeVo);
	}

	//공통 품목코드 수정(update) 
	@Override
	public void updateCode(CodeVO codeVo) throws Exception {
		logger.debug("serviece -> dao => updateCode() 실행");
	
		sqlSession.update(NAMESPACE+"updateCode", codeVo);
	}

	
	//공통코드 삭제
	@Override
	public void deleteCode(List<String> Codes) throws Exception {
		
		logger.debug("service -> dao / deleteCode() 실행");

		sqlSession.delete(NAMESPACE + "deleteCode", Codes);
		 
	}

	
	//==============================================================
	 // 그룹 코드에 따라 품목 정보를 출력
	@Override
	public List<ItemCodeVO> itemCodeListAll(String group_code) throws Exception {
		logger.debug(" service --> DAO itemCodeListAll() 실행 ");
		
		return sqlSession.selectList(NAMESPACE + "itemCodeListAll", group_code);
	}

	//공통 품목코드 수정(update) 
	@Override
	public void updateItemCode(ItemCodeVO icVo) {
		logger.debug("service --> DAO 공통 품목 코드 (수정) 실행 ");
		
		sqlSession.update(NAMESPACE + "updateItemCode", icVo);
	}

	//공통 품목코드 삭제
	@Override
	public void deleteItemCode(List<String> itemCodes) throws Exception {
		logger.debug("service--> DAO 공통 품목 코드(삭제) 실행");
		
		sqlSession.delete(NAMESPACE + "deleteItemCode", itemCodes);
	}

	//공통 품목코드 등록
	@Override
	public void saveItemCode(ItemCodeVO icVo) throws Exception {
		logger.debug("service ->DAO 공통 품목 코드(등록) 실행");
		
		sqlSession.insert(NAMESPACE + "saveItemCode",icVo);
	}

	//공통 품목코드 유효성&중복검사
	@Override
	public ItemCodeVO getItemCodeAndCheck(String s_cate_item_code) throws Exception {
		logger.debug("service -> DAO 공통 품목코드 유효성&중복검사 실행");
		
		return sqlSession.selectOne(NAMESPACE + "getItemCodeAndCheck", s_cate_item_code);
	}

	
	  









}