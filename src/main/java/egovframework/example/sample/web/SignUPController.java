package egovframework.example.sample.web;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.service.UserService;
import egovframework.example.sample.service.UserVO;

@Controller
public class SignUPController {
	@Autowired
	private ServletContext sc;
	HttpSession session;
	@Resource(name = "userService")
	private UserService service;

	@GetMapping(value = "/signUP.do")
	public String signUPpage() {

		return "login/signUp.tiles";
	}

	
	@RequestMapping(value = "/signUP.do")
	public String Userinsert(UserVO vo, MultipartHttpServletRequest multipartRequest) throws Exception {

		MultipartFile mf = multipartRequest.getFile("imgfile");
		String path = sc.getRealPath("/images/profile");
		System.out.println(path);
		if (mf != null) {
			String originFileName = mf.getOriginalFilename();
			String safeFile = vo.getUser_id() + originFileName;

			try {

				mf.transferTo(new File(path + "\\" + safeFile));
				vo.setUserprofile_img(safeFile);
				service.InsertUser(vo);

			} catch (IllegalStateException e) {
				e.getMessage();
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {
			vo.setUserprofile_img("profile_default.png");
			service.InsertUser(vo);
		}

		return "redirect:loginpage.do";
	}
}
