package egovframework.example.sample.web;

import java.io.File;

import java.security.Principal;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.service.UserService;
import egovframework.example.sample.service.UserVO;

@Controller
public class MyPageController {
	@Autowired
	private ServletContext sc;

	@Resource(name = "userService")
	private UserService userService;

	@GetMapping(value = { "/user/mypage.do", "mypage.do" })
	public String mypage(Principal principal, Model model) throws Exception {
		// 유저정보 가져오기
		UserVO vo = userService.GetUserInfo(principal.getName());
		model.addAttribute("vo", vo);
		return "user/myPage.tiles";
	}

	/*
	 * java.io.IOException: Unexpected output data 오류 원인 -path 경로가 존재하지 않는 경우에도 발생
	 * 확인 필요
	 */
	@PostMapping("user/userUpdate.do")
	public String UpdateUser(UserVO vo, MultipartHttpServletRequest multiRequest) throws Exception {
		UserVO userinfo = userService.GetUserInfo(vo.getUser_id());
		MultipartFile file = multiRequest.getFile("profilefile");

		String path = sc.getRealPath("images/profile");
		System.out.println(path);
		if (!file.isEmpty()) {

			String originalname = file.getOriginalFilename();
			String saveName = vo.getUser_id() + originalname;

			File f = new File(path + "\\" + vo.getUserprofile_img());
			if (f.exists() && vo.getUserprofile_img() != "profile_default.png") {
				f.delete();
				System.out.println("기존 프로필사진 삭제");
			}
			try {
				file.transferTo(new File(path + "\\" + saveName));
				vo.setUserprofile_img(saveName);
				userService.UpdateUser(vo);
			} catch (IllegalStateException e) {
				e.getMessage();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (file.isEmpty()) {

			System.out.println(userinfo.getUserprofile_img());
			vo.setUserprofile_img(userinfo.getUserprofile_img());
			userService.UpdateUser(vo);
		}

		return "redirect:mypage.do";
	}

}
