package egovframework.example.sample.web;

import java.io.File;
import java.security.Principal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.service.BoardService;
import egovframework.example.sample.service.BoardVO;
import egovframework.example.sample.vo.BoardImgVo;
import egovframework.example.sample.vo.CategoryVo;
import egovframework.example.security.CustomUserDetail;

@Controller
public class BoardController {
	@Autowired
	private ServletContext sc;
	HttpSession session;
	@Resource(name = "boardService")
	private BoardService boardService;

	@RequestMapping(value = "/user/boardInsert.do")
	public String boardInsetpage(Model model, Principal principal, Authentication authentication) throws Exception {
		// CustomUserDetail ut=(CustomUserDetail)session.getAttribute("userinfo");
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		List<?> list = boardService.SelectCategory();
		// principal.getName();
		for (int i = 0; i < list.size(); i++) {
			CategoryVo vo = (CategoryVo) list.get(i);
			System.out.println(vo.getCategory());
		}
		System.out.println(userDetails.getUsername());
		model.addAttribute("list", list);
		model.addAttribute("username", principal.getName());
		return "board/boardinsert.tiles";
	}

	@PostMapping(value = "/user/boardSave.do")
	public String boardInset(BoardVO vo, MultipartHttpServletRequest multipartRequest) throws Exception {
		System.out.println("테스트!");
		boardService.InsertBoard(vo);
		String board_code = boardService.GetTopBoardCode();
		System.out.println("pk번호" + board_code);
		List<MultipartFile> filelist = multipartRequest.getFiles("imgfile");
		// String src=multipartRequest.getParameter("src");

		System.out.println(filelist.size());
		String path = sc.getRealPath("/images/boardimg");
		System.out.println(path);
		//filelist가 들어오면 파일 저장...
		if (filelist.size() > 0) {
			for (MultipartFile mf : filelist) {

				String originFileName = mf.getOriginalFilename();
				long fileSize = mf.getSize();
				System.out.println("파일사이즈" + fileSize);
				String safeFile = board_code + originFileName;
				try {
					mf.transferTo(new File(path + "\\" + safeFile));
					BoardImgVo imgvo = new BoardImgVo("", board_code, safeFile);
					boardService.InsertBoardImg(imgvo);
					System.out.println("성공!");
				} catch (IllegalStateException e) {
					e.getMessage();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		return "main.tiles";
	}

	@RequestMapping(value = "/user/boardDetail.do")
	public String boardDetail(String board_code, Model model, Principal principal) throws Exception {
		BoardVO vo = boardService.SelectBoardDetail(board_code);
		List<?> imgname = boardService.GetImgName(board_code);
		String category = boardService.GetCategory(vo.getCate_code());

		String content=StringEscapeUtils.unescapeHtml(vo.getContent());
		vo.setContent(content);
		System.out.println(imgname);
		model.addAttribute("vo", vo);
		model.addAttribute("username", principal.getName());
		model.addAttribute("Category", category);
		model.addAttribute("imgName", imgname);
		return "board/boardDetail.tiles";
	}

	@GetMapping(value = "/user/boardUpdate.do")
	public String boardUpdateForm(String board_code, Model model) throws Exception {
		BoardVO vo = boardService.SelectBoardDetail(board_code);
		List<?> catelist = boardService.SelectCategory();
		model.addAttribute("vo", vo);
		model.addAttribute("catelist", catelist);
		return "board/boardUpdateForm.tiles";
	}

	@PostMapping(value = "/user/boardUpdate.do")
	public String boardUpdate(BoardVO vo, MultipartHttpServletRequest multipartRequest) throws Exception {
		boardService.UpdateBoard(vo);
		// 파일 잇는지 확인
		String path = sc.getRealPath("/images/boardimg");
		List<MultipartFile> filelist = multipartRequest.getFiles("imgfile");
		if (filelist.size() > 0) {
			// 기존파일 삭제
			List<?> list = boardService.GetImgName(vo.getBoard_code());
			for (int i = 0; i < list.size(); i++) {
				File file = new File(path + "\\" + list.get(i));
				if (file.exists()) {
					file.delete();

				}
			}
			// DB파일삭제
			boardService.DeleteBoardImg(vo.getBoard_code());
			for (MultipartFile mf : filelist) {

				String originFileName = mf.getOriginalFilename();
				long fileSize = mf.getSize();
				System.out.println("파일사이즈" + fileSize);
				String safeFile = vo.getBoard_code() + originFileName;
				try {
					mf.transferTo(new File(path + "\\" + safeFile));
					BoardImgVo imgvo = new BoardImgVo("", vo.getBoard_code(), safeFile);
					boardService.InsertBoardImg(imgvo);
					System.out.println("성공!");
				} catch (IllegalStateException e) {
					e.getMessage();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return "main.tiles";
	}

	@GetMapping(value = "/user/boardDelete.do")
	public String DeleteBoard(String board_code) throws Exception {
		String path = sc.getRealPath("/images/boardimg");
		// 기존파일 삭제
		List<?> list = boardService.GetImgName(board_code);
		if (list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				File file = new File(path + "\\" + list.get(i));
				if (file.exists()) {
					file.delete();

				}
			}
		}

		
		boardService.DeleteBoardImg(board_code);
		boardService.DeleteBoard(board_code);

		return "redirect:main.do";

	}

	@GetMapping(value="boardlist.do")
	public String boardlist(String cate_code,Model model) throws Exception
	{
		model.addAttribute("category",cate_code);
		return "list.tiles";
	}
	
	
}
