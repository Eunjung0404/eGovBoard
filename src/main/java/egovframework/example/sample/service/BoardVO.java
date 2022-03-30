package egovframework.example.sample.service;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BoardVO {

	private String board_code;
	private String cate_code;
	private String user_id;
	private String user_nicname;
	private String title;
	private String content;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date regdate;
	public String getBoard_code() {
		return board_code;
	}
	public void setBoard_code(String board_code) {
		this.board_code = board_code;
	}
	public String getCate_code() {
		return cate_code;
	}
	public void setCate_code(String cate_code) {
		this.cate_code = cate_code;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_nicname() {
		return user_nicname;
	}
	public void setUser_nicname(String user_nicname) {
		this.user_nicname = user_nicname;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	@Override
	public String toString() {
		return "BoardVO [board_code=" + board_code + ", cate_code=" + cate_code + ", user_id=" + user_id
				+ ", user_nicname=" + user_nicname + ", title=" + title + ", content=" + content + ", regdate="
				+ regdate + "]";
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}


}
