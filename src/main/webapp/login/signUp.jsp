<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#profile {
	width: 200px;
	height: 200px;
	border-radius: 70%;
	overflow: hidden;
}

#profileimg {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

#signuptable {
	width: 500px;
}

#signuptable th {
	width: 100px;
}

#signuptable input {
	width: 100%;
}

#profile_td {
	padding-left: 100px;
}

#signup {
	margin-top: 50px;
}
</style>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<div id="title">
	<h1>회원가입</h1>
</div>
<div id="signup">
	<form:form method="post" action="signUP.do"
		enctype="multipart/form-data" onsubmit="return signupformCheck()">
		<table id="signuptable">
			<tr>
				<th>프로필</th>
				<td colspan="1"><div id="profile_td">
						<div id="profile">
							<img src="${cp }/images/profile/profile_default.png"
								alt="프로필이미지" id="profileimg">

						</div>
						<button type="button" onclick="fileupload()">프로필 변경</button>
					</div></td>

			</tr>
			<tr>
				<th>ID</th>
				<td id="input_td"><input type="text" name="user_id" id="userId"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td id="input_td"><input type="text" name="user_pwd"
					id="userPwd"></td>
			</tr>
			<tr>
				<th>비밀번호확인</th>
				<td id="input_td"><input type="text" id="userPwdcheck"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td id="input_td"><input type="text" name="user_name"
					id="userName"></td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td id="input_td"><input type="text" name="user_nicname"
					id="userNicname"></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td id="input_td"><input type="text" name="user_phone"
					id="userPhone"></td>
			</tr>
			<tr>
				<th colspan="2"><button type="submit">가입</button></th>
			</tr>
		</table>
		<div id="filediv"></div>
	</form:form>

</div>
<script>
	let filediv = document.getElementById("filediv");

	function fileupload() {
		filediv.innerHTML = "";
		let fileinput = document.createElement("input");
		fileinput.setAttribute("type", "file");
		fileinput.setAttribute("name", "imgfile");
		filediv.appendChild(fileinput);
		fileinput.addEventListener('change', function(e) {

			console.log(e.target.files);
			var reader = new FileReader();
			var u = reader.readAsDataURL(e.target.files[0]);
			console.log(u);

			reader.onload = function(event) {
				let profileimg = document.getElementById("profileimg");
				profileimg.src = event.target.result;
				console.log(event.target.result);

			};

		});
		fileinput.style.display = "none";
		fileinput.click();

	}
	//데이터 공백 검사
	function nullDataCheck(data, name) {
		if (data.length == 0) {
			alert(name + " 입력해주세요")
			return false;
		}
		return true;
	}
	//유효성 검사
	function signupformCheck() {

		let userId = document.getElementById("userId").value;
		let userPwd = document.getElementById("userPwd").value;
		let userName = document.getElementById("userName").value;
		let userNicname = document.getElementById("userNicname").value;
		let userPhone = document.getElementById("userPhone").value;
		//아이디
		var idRegExp = /^[a-zA-z0-9]{4,10}$/;
		if (!nullDataCheck(userId, "아이디를")) {
			return false;

		}
		if (!idRegExp.test(userId)) {
			alert("아이디는 4자이상 10자 이하인 영문 대소문자와 숫자의 조합으로 입력해주세요");
			return false;
		}
		//비밀번호
		if (!nullDataCheck(userPwd, "비밀번호를")) {
			return false;

		}
		//이름
		if (!nullDataCheck(userName, "이름을")) {
			return false;

		}
		//닉네임
		if (!nullDataCheck(userNicname, "닉네임을")) {
			return false;

		}
		if (!nullDataCheck(userPhone, "연락처를")) {
			return false;
		}

		return true

	}
</script>
