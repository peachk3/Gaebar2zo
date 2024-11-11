package com.itwillbs.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.CodeVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.ItemCodeVO;
import com.itwillbs.domain.UsersVO;

@Service
public interface SystemService {
	//이메일 중복
	int emailCheck(String user_email) throws Exception;
	
	//전화번호 중복
	int phoneCheck(String user_phone) throws Exception;
	
	//================================================
	//운영자,관리자,사원 전체 리스트 출력
	List<UsersVO> employeeListAll(Criteria cri) throws Exception;
	int getTotalUserCount(Criteria cri) throws Exception;
	
	//사용자 등록
	int addEmp(UsersVO usersVo) throws Exception;
	
	//사용자 수정
	void updateEmp(UsersVO usersVo) throws Exception;
	
	//사용자 삭제
	void deleteEmp(List<String> users) throws Exception;
	//================================================
	//공통코드 전체 리스트 출력 
	List<CodeVO> codeListAll() throws Exception;
	
	// 공통 코드 등록
	void saveGroupCode(CodeVO codeVo) throws Exception;
	
	//공통 코드 수정
	void updateCode(CodeVO codeVo) throws Exception;
	
	// 공통 코드 삭제
	void deleteCode(List<String> Codes) throws Exception;
	
	//================================================
	// 그룹 코드에 따라 품목 정보를 조회하는 로직
	List<ItemCodeVO> itemCodeListAll(String group_code) throws Exception;
	
	//공통 품목 코드 수정 
	void updateItemCode(ItemCodeVO icVo) throws Exception;
	
	//공통 품목 코드 삭제
	void deleteItemCode(List<String> itemCodes) throws Exception;
	
	//공통 품목 코드 등록 
	void saveItemCode(ItemCodeVO icVo) throws Exception;
	
	//공통 품목 중복체크&유효성
	boolean checkItemCode(String s_cate_item_code) throws Exception;


}