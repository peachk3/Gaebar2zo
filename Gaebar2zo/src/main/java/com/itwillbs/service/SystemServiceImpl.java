package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.domain.CodeVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.ItemCodeVO;
import com.itwillbs.domain.UsersVO;
import com.itwillbs.persistence.SystemDAO;

@Service
public class SystemServiceImpl implements SystemService{

	private static final Logger logger = LoggerFactory.getLogger(SystemServiceImpl.class);
	
	@Inject
	private SystemDAO sdao;

	@Inject
	PasswordEncoder passwordEncoder;
	
	//이메일 중복 체크
	@Override
	public int emailCheck(String user_email) throws Exception {

		 int result = sdao.emailCheck(user_email);
		logger.info("이메일 result " + result);
		
		return result;
	}
	
	//전화번호 중복 체크

	@Override
	public int phoneCheck(String user_phone) throws Exception {
		
		int result = sdao.phoneCheck(user_phone);
		
		logger.debug("전화번호 result :" + result);
		
		return result;
	}



	//운영자,관리자,사원 전체 리스트 출력
	@Override
	public List<UsersVO> employeeListAll(Criteria cri) throws Exception {
		logger.info("운영자/관리자/사원 전체 리스트 출력");
	
		return sdao.employeeListAll(cri);
	}
	
	//사용자 등록 --> 검색 --> 조회되는 리스트 수
	@Override
	public int getTotalUserCount(Criteria cri) throws Exception {
		logger.debug(" getTotalItemCount() 실행");
		
		return sdao.getTotalUserCount(cri);
	}

	
	
	//사용자 등록
	@Override
	@Transactional
	public int addEmp(UsersVO usersVo ) throws Exception {
		logger.info("service -> 사용자 등록");
		
		String pw = usersVo.getPassword();
		String epw =passwordEncoder.encode(pw);
		usersVo.setPassword(epw);
		
		
		return sdao.addEmp(usersVo);
	}
	
	//사용자 수정
	@Transactional
	@Override
	public void updateEmp(UsersVO usersVo) throws Exception {
		logger.info("service--> 사용자 업데이트");
		
		sdao.updateEmp(usersVo);
	}
	
	
	
	
	//사용자 삭제
	@Override
	@Transactional
	public void deleteEmp(List<String> users) throws Exception {
		logger.info("service --> 사용자 삭제");
		
		sdao.deleteEmp(users);
	}
	//=============================================================================

	//공통코드 전체 리스트 출력
	@Override
	public List<CodeVO> codeListAll() throws Exception {
		logger.info("공통 코드Code ");
	
		return sdao.codeListAll();
	}



	// 공통 코드 등록
	@Override
	public void saveGroupCode(CodeVO codeVo) throws Exception {
		logger.debug("공통 코드 등록");
		
		sdao.saveGroupCode(codeVo);
	}

	//공통 코드 수정
	@Override
	public void updateCode(CodeVO codeVo) throws Exception {
		logger.debug("공통 코드 업데이트");
		
		sdao.updateCode(codeVo);
	}
	
	
	
	//공통 코드 삭제
	@Override
	public void deleteCode(List<String> Codes) throws Exception {
		logger.debug("공통 코드 삭제");
		
		 sdao.deleteCode(Codes);
	}
	



	//=============================================================================
	// 공통코드에 따라 품목 정보를 출력
	@Override
	public List<ItemCodeVO> itemCodeListAll(String group_code) throws Exception {
		logger.debug("itemCodeListAll(String group_code) 실행 ");
		
		return sdao.itemCodeListAll(group_code);
	}

	

	//공통 품목 코드 수정(update)
	@Override
	public void updateItemCode(ItemCodeVO icVo) throws Exception {
		logger.debug("공통 품목코드 수정 ");
		
		sdao.updateItemCode(icVo);
		
	}

	//공통 품목코드 삭제
	@Override
	public void deleteItemCode(List<String> itemCodes) throws Exception {
		logger.debug("공통 품목코드 삭제");
		
		sdao.deleteItemCode(itemCodes);
	}

	//공통 품목코드 등록
	@Override
	public void saveItemCode(ItemCodeVO icVo) throws Exception {
		logger.debug("공통 품목코드 등록");
		
		sdao.saveItemCode(icVo);
	}
	
	//공통 품목 중복체크&유효성
	@Override
	public boolean checkItemCode(String s_cate_item_code) throws Exception {
		
		ItemCodeVO icVo = sdao.getItemCodeAndCheck(s_cate_item_code);
		logger.debug("service : 공통 품목 중복체크 & 유효성");
		return icVo != null;
	}




	
	
	  
}
	

	





