package egovframework.example.sample.web;

import java.security.Principal;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.sample.service.UserService;
import egovframework.example.sample.service.UserVO;

@Controller
public class LoginController {

	@Resource(name = "userService")
	private UserService service;

	HttpSession session;

	@RequestMapping("/loginpage.do")
	public String loginForm() {

		return "login/login.tiles";
	}

	@RequestMapping("home.do")
	public String login(Principal principal,HttpServletRequest request) throws Exception {

		System.out.println("테스트용~" + principal.getName());
		String userid=principal.getName();
		UserVO vo=service.GetUserInfo(userid);
		session=request.getSession();
		session.setAttribute("nicname",vo.getUser_nicname());
		System.out.println("테스트"+(String)session.getAttribute("nicname"));
		return "redirect:/test.do";
	}

}
