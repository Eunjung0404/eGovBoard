package egovframework.example.sample.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.example.sample.vo.CommentVo;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
@Repository("commentDAO")
public class CommentDAO extends EgovAbstractDAO{
	// 댓글달기
	public String InsertComment(CommentVo vo) throws Exception {
		return (String) insert("commentDAO.insertComment", vo);
	}

	// 댓글 읽기
	public List<?> SelectCommentList(String board_code) throws Exception {
		return list("commentDAO.selectCommentList", board_code);
	}
}
