<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
.menu {
	list-style: none;
}

#submenu {
	display: flex;
}

#mainmenu {
	display: flex;
}

#dropmenu li {
	float: none;
}

#dropmenu {
	display: none;
}

.header  a {
	text-decoration: none;
	color: white;
}

.header  a:visited {
	color: white;
}

li:hover {
	color: gray;
}

a:hover {
	color: gray;
}

#sub {
	background-color: black;
	height: 30px;
	color: white;
	display: flex;
	justify-content: flex-end;
}

#main {
	background-color: black;
	height: 100px;
	color: white;
	display: flex;
	justify-content: center;
}

.title {
	text-align: center;
}
</style>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<div class="header" style="width: 100%">
	<div class="title">
		<h1>COMMUNITY</h1>
	</div>
	<div id="sub">
		<ul class="menu" id="submenu">
			<sec:authorize access="isAnonymous()">
				<li><a href="${cp}/loginpage.do ">로그인</a></li>
				<li><a href="${cp}/signUP.do ">회원가입</a></li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal.username" var="username" />
				<li><span style="font-size: 10px;"><sec:authentication
							property="principal.username" />님 반갑습니다.</span></li>

				<script>
					function logout() {
						var f = document.Frm;
						f.action = "${cp}/logout.do";
						f.method = "post";
						f.submit();
					}
				</script>
				<form:form method="post" name="Frm" id="Frm">
					<li class="nav-item"><a href="javascript:logout()"
						class="nav-link text-white px-2">로그아웃</a></li>
				</form:form>
				<li><a href="${cp }/user/mypage.do">MYPAGE</a></li>
			</sec:authorize>
		</ul>
	</div>

	<div id="main">
		<uL class="menu" id="mainmenu">
			<li id="cate" onmouseover="dropmenuShow()" onmouseout="dropmenuOut()">게시판

				<div id="dropmenu"></div>
			</li>
			<li>공지사항</li>
			<li>문의사항</li>
		</uL>
	</div>

</div>
<script>
	window.addEventListener('load', function() {
		getcategory();
	});
	function getcategory() {
		let dropmenu = document.getElementById("dropmenu");
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {

			if (xhr.readyState == 4 && xhr.status == 200) {
				let data = xhr.responseText;
				let json = JSON.parse(data);
				for (var i = 0; i < json.list.length; i++) {
					dropmenu.innerHTML += "<li><a href='/myproject/boardlist.do?cate_code="
							+ json.list[i].cate_code
							+ "'>"
							+ json.list[i].category + "</a></li>"
				}
			}
		}
		xhr.open('get', 'getcategory.json', true);
		xhr.send();
	}

	function dropmenuShow() {
		let dropmenu = document.getElementById("dropmenu");
		dropmenu.style.display = "block";

	}

	function dropmenuOut() {
		let dropmenu = document.getElementById("dropmenu");
		dropmenu.style.display = "none";

	}
</script>