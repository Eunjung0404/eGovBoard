package egovframework.example.sample.service.impl;


import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.sample.service.BoardService;
import egovframework.example.sample.service.BoardVO;
import egovframework.example.sample.vo.BoardImgVo;
import egovframework.example.sample.vo.CategoryVo;
import egovframework.example.sample.vo.CommentVo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("boardService")
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {

	@Resource(name="boardDAO")
	private BoardDAO boardDAO;
	
	@Override
	public String InsertBoard(BoardVO vo) throws Exception {
		return boardDAO.InsertBoard(vo);
	}

	@Override
	public List<?> SelectCategory() throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.SelectCategory();
	}

	@Override
	public List<?> SelectAllBoard(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.SelectAllBoard(map);
	}

	@Override
	public int GetAllBoardCount(HashMap<String, Object> map) throws Exception {
		return boardDAO.GetAllBoardCount(map);
	}

	@Override
	public BoardVO SelectBoardDetail(String board_code) throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.SelectBoardDetail(board_code);
	}

	@Override
	public String GetTopBoardCode() throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.GetTopBoardCode();
	}

	@Override
	public String InsertBoardImg(BoardImgVo vo) throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.InsertBoardImg(vo);
	}

	@Override
	public String GetCategory(String cate_code) throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.GetCategory(cate_code);
	}

	@Override
	public List<?> GetImgName(String board_code) throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.GetImgName(board_code);
	}

	@Override
	public int DeleteBoard(String board_code) throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.DeleteBoard(board_code);
	}

	@Override
	public int DeleteBoardImg(String board_code) throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.DeleteBoardImg(board_code);
	}

	@Override
	public int UpdateBoard(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.UpdateBoard(vo);
	}

	@Override
	public int ADDCount(String board_code) throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.ADDCount(board_code);
	}

	@Override
	public List<?> GetMyBoard(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.GetMyBoard(map);
	}

	@Override
	public int GetMyBoardCount(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.GetMyBoardCount(user_id);
	}



}
