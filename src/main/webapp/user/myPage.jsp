<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
.mymenu {
	position: absolute;
	left: 5%;
}

#Mypage {
	display: flex;
}

#profile {
	width: 200px;
	height: 200px;
	border-radius: 70%;
	overflow: hidden;
}

#profileimg, #profileimg_updateform {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

#profile_td {
	width: 250px;
}

#userinfo {
	padding: 100px;
}

.userinfo_table {
	width: 800px;
}

.none {
	display: none;
}

.show {
	display: block;
}
</style>
<input type="hidden" name="${_csrf.parameterName}"
	value="${_csrf.token}" id="token" />
<c:set var="cp" value="${pageContext.request.contextPath}" />
<div id="Mypage">
	<div class="mymenu">
		<ul>
			<li><button type="button" onclick="showDiv('userinfo')">내
					정보</button></li>
			<li><button type="button" onclick="showDiv('userinfo_update')">내
					정보 수정</button></li>
			<li><button type="button" onclick="showDiv('pwdUpdateDiv')">비밀번호
					변경</button></li>
			<li><button type="button" onclick="showDiv('myBoard')">작성한 글 확인</button></li>
			<li>작성한 댓글확인</li>
			<li>작성한 문의 글 확인</li>
		</ul>

	</div>
	<div id="userinfo" class="none show">
		<h1>내 정보</h1>
		<table class="userinfo_table">
			<tr>

				<td id="profile_td" rowspan="3"><div id="profile">
						<img src="${cp }/images/profile/${vo.userprofile_img}"
							alt="프로필이미지" id="profileimg">
					</div></td>

				<td>닉네임</td>
				<td>${vo.user_nicname }</td>

			</tr>
			<tr>
				<td>아이디</td>
				<td>${vo.user_id }</td>

			</tr>
			<tr>
				<td>가입일</td>
				<td>${vo.user_regdate }</td>

			</tr>


		</table>

	</div>
	<div id="userinfo_update" class="none">
		<h1>내 정보 변경</h1>
		<form:form method="post" action="userUpdate.do"
			enctype="multipart/form-data" onsubmit="return submitCheck()">
			<table id="signuptable">
				<tr>
					<th>프로필</th>
					<td colspan="1"><div id="profile_td">
							<div id="profile">
								<img src="" alt="프로필이미지" id="profileimg_updateform">

							</div>
							<button type="button" onclick="fileupload()">프로필 변경</button>
						</div></td>

				</tr>
				<tr>
					<th>ID</th>
					<td id="input_td">${vo.user_id }<input type="hidden"
						name="user_id" value="${vo.user_id }"></td>
				</tr>


				<tr>
					<th>이름</th>
					<td id="input_td"><input type="text" name="user_name"
						id="userName" value=""></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td id="input_td"><input type="text" name="user_nicname"
						id="userNicname" value=""></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td id="input_td"><input type="text" name="user_phone"
						id="userPhone" value=""></td>
				</tr>
				<tr>
					<th colspan="2"><button type="submit">수정</button></th>
				</tr>
			</table>
			<div id="filediv">

				<input type="file" name="profilefile" style="display: none;"
					id="profileInput">
			</div>
		</form:form>

	</div>
	<div id="pwdUpdateDiv" class="none">
		<span>현재 비밀번호</span><input type="password" name="currentPwd"
			id="currentPwd"> <span>변경할 비밀번호</span><input type="password"
			name="newPwd" id="newPwd"> <span>비밀번호 확인</span><input
			type="password" name="checkNewPwd" id="checkNewPwd">
		<button type="button" onclick="updatePwd()">변경</button>
	</div>
	<div id="myBoard" class="none">
		<table id="test" class="list">

			<tr>
				<th>번호</th>
				<th style="width: 70%;">제목</th>
				<th style="text-align: center;">작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<tbody id="tbody">

			</tbody>
		</table>
		<div id="pagecount" class="pageDiv"
			style="text-align: center; padding: 50px;"></div>
	</div>
</div>
<script>
	function showDiv(id) {
		setUserUpdateForm();
		MyBoardAll(1);
		//window.location.reload();
		let showdiv = document.getElementsByClassName("none show");
		console.log(showdiv.length);

		for (var i = 0; i < showdiv.length; i++) {
			showdiv[i].className = "none";
			console.log(i);
		}
		let div = document.getElementById(id);
		div.className += " show";

	}

	//수정폼 세팅 
	function setUserUpdateForm() {
		let userName = document.getElementById("userName");
		let userNicname = document.getElementById("userNicname");
		let userPhone = document.getElementById("userPhone");
		let profileimgUpdateform = document
				.getElementById("profileimg_updateform");
		let src = "/myproject/images/profile/";
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {

				let data = xhr.responseText;
				let json = JSON.parse(data);
				profileimgUpdateform.src = src + json.vo.userprofile_img;
				userName.value = json.vo.user_name;
				userNicname.value = json.vo.user_nicname;
				userPhone.value = json.vo.user_phone;

			}
		}
		xhr.open('get', 'getuserinfo.json', true);
		xhr.send();
	}
	let filediv = document.getElementById("filediv");

	function fileupload() {

		let fileinput = document.getElementById("profileInput");
		fileinput.addEventListener('change', function(e) {

			console.log(e.target.files);
			var reader = new FileReader();
			var u = reader.readAsDataURL(e.target.files[0]);
			console.log(u);

			reader.onload = function(event) {
				let profileimg = document
						.getElementById("profileimg_updateform");
				profileimg.src = event.target.result;
				console.log(event.target.result);

			};

		});
		fileinput.click();

	}
	//정규식
	var korean = /^[ㄱ-ㅎㅏ-ㅣ가-힣]{1,10}$/;
	var NicnameRegExp = /^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]){2,20}$/;
	var phoneRegExp = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
	//데이터 있는지 체크 
	function isDataCheck(id, string) {
		let data = document.getElementById(id).value;
		if (data.length == 0) {
			alert(string + " 입력해주세요")
			return false;
		}
		return true;
	}
	//이름 
	function checkName() {
		let userName = document.getElementById("userName");
		if (!isDataCheck('userName', '이름을')) {
			return false;
		}
		if (!korean.test(userName.value)) {
			alert("이름은 1자이상10자 이하인 한글로 입력해주세요")
			return false;

		}
		return true
	}
	//닉네임
	function checkNicName() {
		let userNicname = document.getElementById("userNicname");
		if (!isDataCheck('userNicname', '닉네임을')) {
			return false;
		}
		if (!NicnameRegExp.test(userNicname.value)) {
			alert("닉네임은 2자이상20자 이하인 영문 한글 숫자 조합으로 입력해주세요.특수문자는 포함하실 수 없습니다.")
			return false;

		}

		return true
	}

	//연락처
	function checkPhone() {
		let userPhone = document.getElementById("userPhone");
		if (!isDataCheck('userPhone', '닉네임을')) {
			return false;
		}
		if (!phoneRegExp.test(userPhone.value)) {
			alert("연락처 입력이 잘못되었습니다.")
			return false;

		}

		return true
	}
	//onsubmit

	function submitCheck() {
		if (!checkNicName()) {
			return false;
		}
		if (!checkPhone()) {
			return false;
		}
		if (!checkName()) {
			return false;
		}

		return true;
	}

	//비밀번호 변경
	function updatePwd() {
		let token = document.getElementById("token").value;
		let currentPwd = document.getElementById("currentPwd").value;
		let newPwd = document.getElementById("newPwd").value;
		let data = new FormData();
		data.append('currentPwd', currentPwd);
		data.append('newPwd', newPwd);
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let data = xhr.response;
				let json = JSON.parse(data);
				console.log(json);
			}
		}
		xhr.open('post', 'updatePwd.json', true);
		xhr.responseType = "json";
		xhr.setRequestHeader('X-CSRF-TOKEN', token);
		xhr.send(data);
	}
	function cleartable() {
		let tbody = document.getElementById("tbody");
		for (var i = tbody.rows.length; i >= 0; i--) {
			tbody.deleteRow(tbody.rows.length - 1);
		}
	}

	function MyBoardAll(pageNum) {

		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let data = xhr.responseText;
				let json = JSON.parse(data);
				cleartable();
				let tbody = document.getElementById("tbody");
				for (var i = 0; i < json.list.length; i++) {
					tbody.innrHTML = "";
					let tr = document.createElement('tr');
					tr.id = json.list[i].board_code;

					tr.innerHTML = "<td>"
							+ ((pageNum - 1) + (i + 1))
							+ "</td><td onclick='detailurl(event)'>"
							+ json.list[i].title
							+ "</td><td style='text-align: center;' >"
							+ json.list[i].user_nicname + "</td><td>"
							+ json.list[i].regdate
							+ "</td><td style='text-align: center;'>"
							+ json.list[i].board_count + "</td>"
					tbody.appendChild(tr);
				}

				//페이징
				let startPage = json.startPageNum;
				let endPage = json.endPageNum;
				let pageCount = json.totalPageCount;

				let pageHtml = "";
				if (startPage > 5) {
					pageHtml += "<a href='javascript:MyBoardAll("
							+ (startPage - 1) + ")'><span>[이전]</span>"
				}
				for (let i = startPage; i <= endPage; i++) {
					if (i == pageNum) {
						pageHtml += "<a href='javascript:MyBoardAll(" + i
								+ ")'><span style='color:blue'>[" + i
								+ "]</span>"
					} else {
						pageHtml += "<a href='javascript:MyBoardAll(" + i
								+ ")'><span style='color:gray'>[" + i
								+ "]</span>"
					}
				}
				if (endPage < pageCount) {
					pageHtml += "<a href='javascript:MyBoardAll("
							+ (endPage + 1) + ")'><span>[다음]</span>"
				}
				pagecount.innerHTML = pageHtml;

			}
		}
		xhr.open('get', 'getMyBoard.json?pageNum=' + pageNum, true);
		xhr.send();

	}
</script>
