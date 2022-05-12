package egovframework.example.sample.service;

import java.security.Principal;

import egovframework.example.security.CustomUserDetail;

public interface UserService {

	// 회원가입
	public String InsertUser(UserVO vo) throws Exception;

	// 권한가져오기
	public CustomUserDetail getAuth(String user_id) throws Exception;

	// 회원정보가져오기
	public UserVO GetUserInfo(String user_id) throws Exception;

	// 회원정보 수정
	public int UpdateUser(UserVO vo) throws Exception;

	// 회원 비밀번호 체크
	public boolean CheckUserPassword(Principal principal, String pwd) throws Exception;

	// 회원 비밀번호 변경
	public int UpdateUserPassword(String user_pwd,UserVO vo) throws Exception;
}
