package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.domain.AuthoritiesVO;
import com.itwillbs.domain.CodeVO;
import com.itwillbs.domain.Criteria;
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
		
		logger.info("이메일 dao (result) :" + result);
				
				return result;
	}

	//전화번호 중복
	@Override
	public int phoneCheck(String user_phone) throws Exception {
		int result = sqlSession.selectOne(NAMESPACE + "phoneCheck", user_phone);
		
		logger.info("전화번호 dao (result):" + result);
		
		return result;
	}
	
	

	//운영자,관리자,사원 전체 리스트 출력
	@Override
	public List<UsersVO> employeeListAll(Criteria cri) throws Exception {
		logger.info("employeeListAll() 실행");
		
		return sqlSession.selectList(NAMESPACE+"employeeListAll", cri);
	}
	

	@Override
	public int getTotalUserCount(Criteria cri) throws Exception {
		logger.debug("getTotalUserCount() 실행 ");
		
		return sqlSession.selectOne(NAMESPACE + "totalUserCount", cri);
	}


	//사용자등록
	@Override
	public int addEmp(UsersVO usersVo) throws Exception {
		logger.info("dao -> 사용자 등록");
		
		String userName = sqlSession.selectOne(NAMESPACE+"addEmpUsername");
		logger.info("userName" + userName);
		
		AuthoritiesVO authVo = usersVo.getAuthList();
		
		usersVo.setUsername(userName);
		authVo.setUsername(userName);
		
		sqlSession.insert(NAMESPACE+"addEmp", usersVo);
		sqlSession.insert(NAMESPACE+"addEmpAuth", authVo);
		
		logger.info("dao -> 사용자 등록");
		return 1;
	}

	//사용자 수정
	@Override
		public void updateEmp(UsersVO usersVo) throws Exception {
		    logger.info("dao --> 사용자 업데이트");

		    sqlSession.update(NAMESPACE + "updateEmp", usersVo);
		    logger.info("dao -> 사용자 정보 업데이트 완료");

		    // 권한 정보 업데이트
		    AuthoritiesVO authVo = usersVo.getAuthList();
		    if (authVo != null) {
		        authVo.setUsername(usersVo.getUsername());  // authVo에 username 설정
		        sqlSession.update(NAMESPACE + "updateEmpAuth", authVo);
		        logger.info("dao -> 권한 정보 업데이트 완료");
		    } else {
		        logger.warn("권한 정보를 업데이트할 수 없습니다.");
		    }
		}
		    
		    
	//사용자 삭제
	@Override
	public void deleteEmp(List<String> users) throws Exception {
		logger.info("dao -> 사용자 삭제");

		sqlSession.update(NAMESPACE+"deleteEmpAuth", users);
		sqlSession.delete(NAMESPACE+"deleteEmp", users);
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
		logger.info("service-> dao saveGroupCode() 실행");
		
		sqlSession.insert(NAMESPACE +"saveGroupCode",codeVo);
	}

	//공통 품목코드 수정(update) 
	@Override
	public void updateCode(CodeVO codeVo) throws Exception {
		logger.info("serviece -> dao => updateCode() 실행");
	
		sqlSession.update(NAMESPACE+"updateCode", codeVo);
	}

	
	//공통코드 삭제
	@Override
	public void deleteCode(List<String> Codes) throws Exception {
		
		logger.info("service -> dao / deleteCode() 실행");

		sqlSession.delete(NAMESPACE + "deleteCode", Codes);
		 
	}

	
	//==============================================================
	 // 그룹 코드에 따라 품목 정보를 출력
	@Override
	public List<ItemCodeVO> itemCodeListAll(String group_code) throws Exception {
		logger.info(" service --> DAO itemCodeListAll() 실행 ");
		
		return sqlSession.selectList(NAMESPACE + "itemCodeListAll", group_code);
	}

	//공통 품목코드 수정(update) 
	@Override
	public void updateItemCode(ItemCodeVO icVo) {
		logger.info("service --> DAO 공통 품목 코드 (수정) 실행 ");
		
		sqlSession.update(NAMESPACE + "updateItemCode", icVo);
	}

	//공통 품목코드 삭제
	@Override
	public void deleteItemCode(List<String> itemCodes) throws Exception {
		logger.info("service--> DAO 공통 품목 코드(삭제) 실행");
		
		sqlSession.delete(NAMESPACE + "deleteItemCode", itemCodes);
	}

	//공통 품목코드 등록
	@Override
	public void saveItemCode(ItemCodeVO icVo) throws Exception {
		logger.info("service ->DAO 공통 품목 코드(등록) 실행");
		
		sqlSession.insert(NAMESPACE + "saveItemCode",icVo);
	}

	//공통 품목코드 유효성&중복검사
	@Override
	public ItemCodeVO getItemCodeAndCheck(String s_cate_item_code) throws Exception {
		logger.info("service -> DAO 공통 품목코드 유효성&중복검사 실행");
		
		return sqlSession.selectOne(NAMESPACE + "getItemCodeAndCheck", s_cate_item_code);
	}

	
	  









}