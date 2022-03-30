package egovframework.example.sample.service;

import java.util.HashMap;
import java.util.List;

import egovframework.example.sample.vo.BoardImgVo;
import egovframework.example.sample.vo.CategoryVo;

public interface BoardService {
   public String InsertBoard(BoardVO vo) throws Exception; 
   
   public List<?> SelectCategory() throws Exception;
   public List<?> SelectAllBoard(HashMap<String, Object> map) throws Exception;
   public int GetAllBoardCount(HashMap<String, Object> map) throws Exception;
   public BoardVO SelectBoardDetail(String board_code) throws Exception;
   public String GetTopBoardCode() throws Exception;
   public String InsertBoardImg(BoardImgVo vo) throws Exception;
   public String GetCategory(String cate_code) throws Exception;
   public List<?> GetImgName(String board_code) throws Exception;
   public int DeleteBoard(String board_code) throws Exception;
   public int DeleteBoardImg(String board_code) throws Exception;
   public int UpdateBoard(BoardVO vo) throws Exception;
} 
