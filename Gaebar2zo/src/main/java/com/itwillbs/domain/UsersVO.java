package com.itwillbs.domain;

import java.util.List;

import lombok.Data;

/**
 * spring db에 저장된 tbl_member 테이블의 정보를 저장
 * 
 */
@Data
public class UsersVO {
	
	private String username;
	private String user_per_name;
	private String password;
	private String user_email;

	private String user_pos;
	private String user_phone;
	private String enabled;

	// 조인을 수행하는 테이블의 정보를 저장
//	private AuthVO authVO; 1:1 구조

	private AuthoritiesVO authList; // 1:N구조
//	private List<AuthoritiesVO> authList; // 1:N구조
	

}
