package egovframework.example.sample.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.sample.service.CommentService;
import egovframework.example.sample.vo.CommentVo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
@Service("commentService")
public class CommentserviceImpl extends EgovAbstractServiceImpl implements CommentService {
	@Resource(name="commentDAO")
	private CommentDAO commentDAO;
	
	@Override
	public String InsertComment(CommentVo vo) throws Exception {
		// TODO Auto-generated method stub
		return commentDAO.InsertComment(vo);
	}

	@Override
	public List<?> SelectCommentList(String board_code) throws Exception {
		// TODO Auto-generated method stub
		return commentDAO.SelectCommentList(board_code);
	}

}
