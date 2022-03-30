<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/myproject/css/egovframework/sample.css">
<title><tiles:insertAttribute name="title" /></title>
</head>

<body>
	<div id="wrap">
		<div id="header" class="center">
			<!-- tiles_member.xml의 <defintion>의 하위 태그인
				<put-attribute>태그의 name이 header인 JSP를 표시하겠다 -->
			<tiles:insertAttribute name="header" />
		</div>
		<div id="content" class="center">
			<tiles:insertAttribute name="body" />
		</div>
		<div id="footer" class="center">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>

</html>
