package egovframework.example.sample.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

import egovframework.example.sample.service.BoardVO;
import egovframework.example.sample.vo.BoardImgVo;
import egovframework.example.sample.vo.CategoryVo;
import egovframework.example.sample.vo.CommentVo;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("boardDAO")
public class BoardDAO extends EgovAbstractDAO {

	public String InsertBoard(BoardVO vo) throws Exception {

		return (String) insert("boardDAO.InsertBoard", vo);

	}

	public List<?> SelectCategory() throws Exception {

		return list("boardDAO.SelectCategory");
	}

	public List<?> SelectAllBoard(HashMap<String, Object> map) throws Exception {
		return list("boardDAO.SelectBoardlist", map);
	}

	public int GetAllBoardCount(HashMap<String, Object> map) throws Exception {
		return (int) select("boardDAO.GetAllBoardCount", map);
	}

	public BoardVO SelectBoardDetail(String board_code) throws Exception {
		return (BoardVO) select("boardDAO.GetBoardDetail", board_code);
	}

	public String GetTopBoardCode() throws Exception {
		return (String) select("boardDAO.GetTopBoardCode");
	}

	public String InsertBoardImg(BoardImgVo vo) throws Exception {
		return (String) insert("boardDAO.InsertBoardImg", vo);
	}

	public String GetCategory(String cate_code) throws Exception {
		return (String) select("boardDAO.getCategory", cate_code);
	}

	public List<?> GetImgName(String board_code) throws Exception {
		return list("boardDAO.getImgNames", board_code);
	}

	public int DeleteBoard(String board_code) throws Exception {
		return update("boardDAO.deleteBoard", board_code);
	}

	public int DeleteBoardImg(String board_code) throws Exception {
		return delete("boardDAO.deleteBoardImg", board_code);
	}

	public int UpdateBoard(BoardVO vo) throws Exception {
		return update("boardDAO.updsateBoard", vo);
	}

	// count++
	public int ADDCount(String board_code) throws Exception {
		return update("boardDAO.ADDCount", board_code);
	}
	

	
	//내가 작성한 글 가져오기
	public List<?> GetMyBoard(HashMap<String, Object> map) throws Exception{
		return list("boardDAO.getMyboard",map);
	}
	//내가 작성한 글 갯수 가져오기 
	public int GetMyBoardCount(String user_id) throws Exception{
		return (int) select("boardDAO.getMyboardCount",user_id);
	}
}
