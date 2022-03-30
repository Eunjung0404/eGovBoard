package egovframework.example.sample.service;

import java.sql.Date;

public class UserVO {

	private String user_id;
	private String user_nicname;
	private String user_name;
	private String user_pwd;
	private String user_phone;

	private String user_enabled;
	private Date user_regdate;

	@Override
	public String toString() {
		return "UserVO [user_id=" + user_id + ", user_nicname=" + user_nicname + ", user_name=" + user_name
				+ ", user_pwd=" + user_pwd + ", user_phone=" + user_phone + ", user_authority=" + ", user_enabled="
				+ user_enabled + ", user_regdate=" + user_regdate + "]";
	}

	public Date getUser_regdate() {
		return user_regdate;
	}

	public void setUser_regdate(Date user_regdate) {
		this.user_regdate = user_regdate;
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

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_pwd() {
		return user_pwd;
	}

	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_enabled() {
		return user_enabled;
	}

	public void setUser_enabled(String user_enabled) {
		this.user_enabled = user_enabled;
	}
}
