package egovframework.example.sample.web;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import egovframework.example.sample.service.BoardService;
import egovframework.example.sample.service.BoardVO;
import egovframework.util.PageUtil;

@RestController
public class BoardJsonController {

	@Resource(name = "boardService")
	private BoardService boardService;

	@GetMapping(value = "/testjson.json", produces = { MediaType.APPLICATION_JSON_VALUE })
	public HashMap<String, Object> ListAll(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			@RequestParam(value = "listcount", defaultValue = "5") int listcount, String cate_code, String keyword,
			String field) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("cate_code", cate_code);
		pmap.put("field", field);
		pmap.put("keyword", keyword);
		int count = boardService.GetAllBoardCount(pmap);
		PageUtil pu = new PageUtil(pageNum, listcount, 5, count);
		pmap.put("startRow", pu.getStartRow());
		pmap.put("endRow", pu.getEndRow());

		List<?> list = boardService.SelectAllBoard(pmap);
		System.out.println(list);
		map.put("list", list);
		map.put("startPageNum", pu.getStartPageNum());
		map.put("endPageNum", pu.getEndPageNum());
		map.put("totalPageCount", pu.getTotalPageCount());
		map.put("pageNum", pageNum);
		return map;
	}

	@GetMapping(value = { "/getcategory.json", "/user/getcategory.json" }, produces = {
			MediaType.APPLICATION_JSON_VALUE })
	public HashMap<String, Object> listcategory() throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<?> list = boardService.SelectCategory();
		map.put("list", list);
		return map;
	}

	// 내 글 가져오기
	@GetMapping(value = "user/getMyBoard.json", produces = { MediaType.APPLICATION_JSON_VALUE })
	public HashMap<String, Object> getMyBoard(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			Principal principal) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> Pmap = new HashMap<String, Object>();
		int count = boardService.GetMyBoardCount(principal.getName());
		PageUtil pu = new PageUtil(pageNum, 10, 10, count);
		Pmap.put("startRow", pu.getStartRow());
		Pmap.put("endRow", pu.getEndRow());
		Pmap.put("user_id", principal.getName());
		List<?> list = boardService.GetMyBoard(Pmap);
		map.put("list", list);
		map.put("startPageNum", pu.getStartPageNum());
		map.put("endPageNum", pu.getEndPageNum());
		map.put("totalPageCount", pu.getTotalPageCount());
		map.put("pageNum", pageNum);
		return map;
	}

}
