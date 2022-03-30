package egovframework.example.sample.service;

import egovframework.example.security.CustomUserDetail;

public interface UserService {

	//회원가입
	 public String InsertUser(UserVO vo) throws Exception; 
	 //권한가져오기
	 public CustomUserDetail getAuth(String user_id)  throws Exception;
	 //회원정보가져오기
	 public UserVO GetUserInfo(String user_id) throws Exception;

}
