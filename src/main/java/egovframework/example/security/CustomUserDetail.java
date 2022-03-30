package egovframework.example.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.SessionAttribute;

import egovframework.example.sample.service.AuthorityVO;
import egovframework.example.sample.service.UserVO;

@SuppressWarnings("serial")
public class CustomUserDetail implements UserDetails {
	private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;

	// DB에서 가져와 저장
	private String userid;
	private String userpwd;
	private String userenabled;
	private String usernicname;


	

	// 가져 온 데이터 리스트로 담기
	private String userauthority;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {

		System.out.println(userid);
		System.out.println(userpwd);
		System.out.println(userenabled);
		System.out.println(userauthority);
		ArrayList<GrantedAuthority> auths = new ArrayList<GrantedAuthority>();
		if (userid == "admin") {
			auths.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
		} else {
			auths.add(new SimpleGrantedAuthority("ROLE_USER"));
		
		}

		// 사용자 권한을 담은 컬렉션 객체를 리턴한다
		return auths;
	}


	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return userpwd;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return userid;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	// enabled 값이 0인 회원은 로그인 불가!
	@Override
	public boolean isEnabled() {
		if (userenabled.equals("0")) {
			return false;
		} else {
			return true;
		}
	}

}
