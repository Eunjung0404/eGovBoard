<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<head>

</head>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<div class="header">
	<div class="title">
		<h1>COMMUNITY</h1>
	</div>
	<div class="menu submenu">
		<ul>
			<sec:authorize access="isAnonymous()">
				<li><a href="${cp}/loginpage.do ">로그인</a></li>
				<li><a href="${cp}/signUP.do ">회원가입</a></li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal.username" var="username" />
				<li class="nav-item"><span
					class="nav-link text-white fs-6 px-2"><sec:authentication
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
				<li>내정보</li>
			</sec:authorize>
		</ul>
	</div>

	<div class="menu mainmenu">
		<uL>
			<li id="cate">게시판</li>
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
		let cate = document.getElementById("cate");
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {

			if (xhr.readyState == 4 && xhr.status == 200) {
				let data = xhr.responseText;
				let json = JSON.parse(data);
				for (var i = 0; i < json.list.length; i++) {
					cate.innerHTML += "<li><a href='/myproject/boardlist.do?cate_code="
							+ json.list[i].cate_code
							+ "'>"
							+ json.list[i].category + "</a></li>"
				}
			}
		}
		xhr.open('get', 'getcategory.json', true);
		xhr.send();
	}
</script>