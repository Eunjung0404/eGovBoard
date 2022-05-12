package egovframework.example.sample.service;

import java.util.List;

import egovframework.example.sample.vo.CommentVo;

public interface CommentService {
	// 댓글
	public String InsertComment(CommentVo vo) throws Exception;

	// 댓글 리스트
	public List<?> SelectCommentList(String board_code) throws Exception;
}
