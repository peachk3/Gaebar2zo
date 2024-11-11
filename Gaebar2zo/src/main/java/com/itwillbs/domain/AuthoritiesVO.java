package com.itwillbs.domain;


import lombok.Data;
/**
 *  spring db 에 저장되어있는 tbl_member_auth 테이블의 정보를 저장
 *
 */
@Data
public class AuthoritiesVO {
	
	private String username;
	private String authority;
		
	
}
//	private List<UsersVO> updateEmpList;
