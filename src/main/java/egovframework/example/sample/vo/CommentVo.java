package egovframework.example.sample.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CommentVo {
	private String comm_code;
	private String board_code;
	private String user_id;
	private String user_nicname;
	private String comment;
	private String commdepth;
	private String commgroup;
	private String state;
	@JsonFormat(pattern="yyyy-MM-dd  HH:mm", timezone = "Asia/Seoul")
	private Date regdate;
}



