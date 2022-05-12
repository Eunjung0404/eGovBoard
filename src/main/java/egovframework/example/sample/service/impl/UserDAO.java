package egovframework.example.sample.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.example.sample.service.AuthorityVO;
import egovframework.example.sample.service.UserVO;
import egovframework.example.security.CustomUserDetail;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("userDAO")
public class UserDAO extends EgovAbstractDAO {

	public String InsertUser(UserVO vo) throws Exception {

		return (String) insert("userDAO.InsertUser", vo);
	}

	// 권한추가
	public String InsertAuth(AuthorityVO vo) throws Exception {
		return (String) insert("userDAO.InsertAuth", vo);
	}

	// 권한가져오기
	public CustomUserDetail getAuthority(String user_id) throws Exception {
		return (CustomUserDetail) select("userDAO.getAuth", user_id);
	}

	// 사용자 정보 가져오기
	public UserVO GetUserInfo(String user_id) throws Exception {
		return (UserVO) select("userDAO.getuserNicname", user_id);
	}

	// 유저정보 수정
	public int UpdateUser(UserVO vo) throws Exception {
		return update("userDAO.userUpdate", vo);
	}

	// 유저 비밀번호 수정
	public int UpdateUserPwd(UserVO vo) throws Exception {
		return update("userDAO.userPwdUpdate", vo);
	}
}
