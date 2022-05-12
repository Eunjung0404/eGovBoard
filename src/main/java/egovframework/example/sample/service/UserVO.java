package egovframework.example.sample.service;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserVO {

	private String user_id;
	private String user_nicname;
	private String user_name;
	private String user_pwd;
	private String user_phone;

	private String user_enabled;
	private Date user_regdate;
	private String userprofile_img;
	private String state;

}
