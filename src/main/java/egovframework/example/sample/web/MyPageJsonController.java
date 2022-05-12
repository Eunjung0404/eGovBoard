package egovframework.example.sample.web;

import java.security.Principal;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import egovframework.example.sample.service.UserService;
import egovframework.example.sample.service.UserVO;

@RestController
public class MyPageJsonController {

	@Resource(name = "userService")
	private UserService userService;

	// 사용자 정보 가져오기
	@GetMapping(value = "user/getuserinfo.json", produces = { MediaType.APPLICATION_JSON_VALUE })
	public HashMap<String, Object> getuserinfo(Principal principal) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		UserVO vo = userService.GetUserInfo(principal.getName());
		map.put("vo", vo);
		return map;
	}
	// 아이디 중복체크
	// 닉네임 중복체크ㄴ

	// 비밀번호 변경
	@PostMapping(value = "user/updatePwd.json")
	public String UpdatePwd(Principal principal, String currentPwd, String newPwd) throws Exception {
		String msg = "";
		if (userService.CheckUserPassword(principal, currentPwd)) {
			UserVO vo = userService.GetUserInfo(principal.getName());
			userService.UpdateUserPassword(newPwd, vo);
			msg = "비밀번호 변경에 성공했습니다.";
		} else {
			msg = "기존 비밀번호가 맞지않습니다.";
		}
		return msg;
	}

}
