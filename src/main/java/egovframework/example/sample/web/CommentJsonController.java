package egovframework.example.sample.web;

import java.security.Principal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import egovframework.example.sample.service.BoardService;
import egovframework.example.sample.service.CommentService;
import egovframework.example.sample.service.UserService;
import egovframework.example.sample.service.UserVO;
import egovframework.example.sample.vo.CommentVo;

@RestController
public class CommentJsonController {

	@Resource(name = "commentService")
	private CommentService commentService;

	@Resource(name = "userService")
	private UserService userService;

	@PostMapping(value = "user/commentInsert.json", produces = { MediaType.APPLICATION_JSON_VALUE })
	public String InsertComment(Principal principal, String board_code, String comment) throws Exception {
		UserVO userinfo = userService.GetUserInfo(principal.getName());
		CommentVo vo = new CommentVo();
		vo.setBoard_code(board_code);
		vo.setCommdepth("0");
		vo.setComment(comment);
		vo.setCommgroup("0");
		vo.setUser_id(userinfo.getUser_id());
		vo.setUser_nicname(userinfo.getUser_nicname());
		System.out.println(board_code);
		commentService.InsertComment(vo);

		return "";
	}

	@GetMapping(value = "user/commentList.json", produces = { MediaType.APPLICATION_JSON_VALUE })
	public HashMap<String, Object> SelectList(String board_code) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<?> list = commentService.SelectCommentList(board_code);
		ArrayList<UserVO> userlist = new ArrayList<UserVO>();
		for (int i = 0; i < list.size(); i++) {
			CommentVo comm = (CommentVo) list.get(i);
			UserVO user = userService.GetUserInfo(comm.getUser_id());
			userlist.add(user);
		}
		map.put("list", list);
		map.put("userlist", userlist);
		return map;
	}

}
