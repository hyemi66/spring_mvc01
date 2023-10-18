package net.daum.vo;

import lombok.Data;

@Data
public class AuthVO { // tbl_member_auth 테이블의 레코드 값 가져와서 저장할 빈클래스
	private String userid;
	private String auth;
}
