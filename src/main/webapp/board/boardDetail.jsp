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

#commentDiv {
	border: 1px solid gray;
	height: 200px;
	border-radius: 5px;
	overflow: auto;
	padding: 16px 24px;
}
</style>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<table>
	<tr>
		<td>${Category}</td>
	</tr>
	<tr id="title">
		<td colspan="6" id="title"><h1>${vo.title}</h1></td>
	</tr>
	<tr id="ect">

		<td>by.${vo.user_nicname}</td>

		<td>${vo.regdate}</td>

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

	<tr style="height:100px;"></tr>
	<tr style="border-collapse: separate; border-spacing: 0 10px;">
		<td>댓글..</td>
	</tr>

	<tr>
		<td colspan="6">
			<div contenteditable="true" id="commentDiv"></div>
		</td>

	</tr>
	<tr>
		<td colspan="6" style="text-align: right;"><button type="button">등록</button></td>
	</tr>




</table>
<script>
	//불러온 데이터 img수정하기..
</script>