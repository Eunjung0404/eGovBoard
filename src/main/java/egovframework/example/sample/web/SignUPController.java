package egovframework.example.sample.web;

import javax.annotation.Resource;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.sample.service.UserService;
import egovframework.example.sample.service.UserVO;

@Controller
public class SignUPController {

	@Resource(name = "userService")
	private UserService service;

	@GetMapping(value = "/signUP.do")
	public String signUPpage() {
		
		return "login/signUp.tiles";
	}



	@RequestMapping(value = "/signUP.do")
	public String Userinsert(UserVO vo) throws Exception {

		vo.setUser_nicname(vo.getUser_name());
		System.out.println(vo.toString());
		String result = service.InsertUser(vo);
		if (result == "success") {
			System.out.println("회원가입성공");
		} else {
			System.out.println("회원가입실패..");
		}
		return "";
	}
}
