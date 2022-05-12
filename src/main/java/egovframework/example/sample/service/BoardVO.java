package egovframework.example.sample.service;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@AllArgsConstructor
@NoArgsConstructor
@Data
public class BoardVO {

	private String board_code;
	private String cate_code;
	private String user_id;
	private String user_nicname;
	private String title;
	private String content;
	@JsonFormat(pattern="yyyy-MM-dd" ,timezone = "Asia/Seoul")
	private Date regdate;
	private String state;
	private String board_count;
	

}
