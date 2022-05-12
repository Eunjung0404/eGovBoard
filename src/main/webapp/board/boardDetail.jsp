<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<style>
#title {
	height: 100px;
	border-bottom: 1px solid gray;
}

#ect {
	height: 50px;
}

#ect td {
	width: 10px;
}

.commentdiv {
	border-bottom: 1px solid black;
	padding: 20px;
}

.commentarea {
	margin-top: 20px;
	width: 1000px;
}

#comment {
	width: 1000px;
}

#commentfield {
	border-top: 1px solid black;
	margin-top: 50px;
}

#ifwriter {
	font-size: 10px;
	padding-left: 10px;
	color: blue;
}

.recommbtn {
	padding: 10px;
	position: relative;
	left: 95%;
}

.commwriterbtndiv {
	position: relative;
	left: 10%;
	bottom: 125px;
}

#profilediv {
	width: 50px;
	height: 50px;
	border-radius: 70%;
	overflow: hidden;
}

#profile {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

#userinfo {
	display: flex;
	align-items: center;
}
</style>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<input type="hidden" value="${username}" id="user">
<input type="hidden" value="${vo.board_code}" id="board_code">
<table>
	<tr>
		<td><a href="/myproject/boardlist.do?cate_code=${vo.cate_code}">${Category}</a></td>
	</tr>
	<tr id="title">
		<td colspan="6" id="title"><h1>${vo.title}</h1></td>
	</tr>
	<tr id="ect">

		<td>by.${vo.user_nicname}<input type="hidden"
			value="${vo.user_nicname}" id="writer"></td>

		<td>${vo.regdate}</td>
		<td>조회수:${vo.board_count}</td>
		<c:if test="${username eq vo.user_id }">


			<td><a
				href="${cp }/user/boardUpdate.do?board_code=${vo.board_code}">수정</a></td>
			<td><a
				href="${cp }/user/boardDelete.do?board_code=${vo.board_code}">삭제</a></td>

		</c:if>
	</tr>
	<tr>

		<td colspan="6"><div>${vo.content }</div></td>
	</tr>

	<tr style="height: 100px;"></tr>
	<tr style="border-collapse: separate; border-spacing: 0 10px;">
		<td>댓글..</td>
	</tr>

	<tr>
		<td colspan="6"><textarea rows="6" id="comment"
				placeholder="댓글을 입력해주세요"></textarea> <input type="hidden"
			name="${_csrf.parameterName}" value="${_csrf.token}" id="token" />
	</tr>
	<tr>
		<td colspan="6" style="text-align: right;"><button type="button"
				onclick="insertjson()">등록</button></td>
	</tr>




</table>

<div id="commentfield"></div>
<script>
	window.onload = function() {

		selectComment();
	}
	//불러온 데이터 img수정하기..
	let boardCode = document.getElementById("board_code").value;
	let commentdiv = document.getElementById("commentfield");
	let writer = document.getElementById("writer").value;
	let user = document.getElementById("user").value;
	//댓글 등록하기
	function insertjson() {
		let parameter = "";
		let token = document.getElementById("token").value;
		let comment = document.getElementById("comment").value;
		let data = new FormData();
		data.append('board_code', boardCode);
		data.append('comment', comment);

		console.log(header + "," + token);
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {

				document.getElementById("comment").value = "";

				console.log(parameter);
				selectComment();
			}
		}
		xhr.open('post', 'commentInsert.json', true);
		xhr.responseType = "json";
		xhr.setRequestHeader('X-CSRF-TOKEN', token);
		xhr.send(data);
	}

	function selectComment() {

		let xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let data = xhr.responseText;
				let json = JSON.parse(data);
				commentdiv.innerHTML = "";
				for (var i = 0; i < json.list.length; i++) {

					if (json.list[i].commdepth == 0) {
						let div = document.createElement("div");
						div.id = json.list[i].comm_code;
						div.className = "commentarea";
						let ifwriter = "";
						if (json.list[i].user_nicname == writer) {

							ifwriter = "글쓴이";
						}
						let userinfo = document.createElement("div");
						userinfo.id = "userinfo";
						userinfo.innerHTML = "<div id='profilediv'><img id='profile' src=/myproject/images/boardimg/"+json.userlist[i].userprofile_img
								+ "></div><span class='nicname'>"
								+ json.list[i].user_nicname + "</span>";
						if (json.list[i].user_nicname == writer) {

							ifwriter = "글쓴이";
							userinfo.innerHTML += "<span id='ifwriter'>"
									+ ifwriter + "</span><span>"
									+ json.list[i].regdate + "</span>";
						} else {
							userinfo.innerHTML += " <span>"
									+ json.list[i].regdate + "</span>";
						}
						if (json.list[i].user_id == user) {
							userinfo.innerHTML += "<div><button type='button'>수정</button>"
									+ "<button type='button'>삭제</button><div>";
							console.log("추가!");
						}
						div.appendChild(userinfo);

						div.innerHTML += "<div class='commentdiv'>"
								+ json.list[i].comment
								+ "<input type='hidden' value='"+json.list[i].commdepth+"'>"
								+ "<br><button type='button' class='recommbtn'>답글</button></div>";
						console.log(json.list[i].user_id + "==" + user);

						commentdiv.appendChild(div);

					}
				}
			}

		}
		xhr.open('get', 'commentList.json?board_code=' + boardCode, true);
		xhr.send();
	}
	//대댓글 insertform 생성~!
	function createRecomment(event) {

	}
</script>