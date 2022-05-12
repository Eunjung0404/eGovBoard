package egovframework.example.sample.service.impl;

import java.security.Principal;
import java.security.Security;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.example.sample.service.AuthorityVO;
import egovframework.example.sample.service.UserService;
import egovframework.example.sample.service.UserVO;
import egovframework.example.security.CustomUserDetail;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("userService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService {

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Resource(name = "userDAO")
	private UserDAO userdao;

	@Override
	public String InsertUser(UserVO vo) throws Exception {
		// 암호화 하여 저장
		String pwd = vo.getUser_pwd();

		AuthorityVO auth = new AuthorityVO();
		auth.setUser_id(vo.getUser_id());
		vo.setUser_pwd(passwordEncoder.encode(pwd));

		if (vo.getUser_id().equals("admin")) {
			auth.setAuthority("ROLE_ADMIN");

		} else {
			auth.setAuthority("ROLE_USER");

		}
		userdao.InsertUser(vo);
		userdao.InsertAuth(auth);
		return "success";

	}

	@Override
	public CustomUserDetail getAuth(String user_id) throws Exception {
		return userdao.getAuthority(user_id);
	}

	@Override
	public UserVO GetUserInfo(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return userdao.GetUserInfo(user_id);
	}

	@Override
	public int UpdateUser(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		return userdao.UpdateUser(vo);
	}

	@Override
	public boolean CheckUserPassword(Principal principal, String pwd) throws Exception {

		UserVO vo = userdao.GetUserInfo(principal.getName());
		if (passwordEncoder.matches(pwd, vo.getUser_pwd())) {

			return true;
		}

		return false;
	}

	@Override
	public int UpdateUserPassword(String user_pwd, UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		String pwd = passwordEncoder.encode(user_pwd);
		vo.setUser_pwd(pwd);

		return userdao.UpdateUserPwd(vo);
	}

}
