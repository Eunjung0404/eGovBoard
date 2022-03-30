package egovframework.example.security;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import egovframework.example.sample.service.UserService;

public class CustomUserDetailService implements UserDetailsService {

	@Resource(name = "userService")
	private UserService service;


	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		CustomUserDetail userDetail;
		try {
			userDetail = service.getAuth(username);
			//session.setAttribute("userinfo", userDetail);
			//System.out.println("유저이름"+username);
			if(userDetail==null)
			{
				  throw new UsernameNotFoundException(username);

			}
			return userDetail;
		} catch (Exception e) {
			// TODO Auto-generated catch blockF
			e.printStackTrace();
			return null;
		}

	}

}
