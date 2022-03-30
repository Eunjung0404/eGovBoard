<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form:form method="post" action="boardUpdate.do" acceptCharset="UTF-8"
	enctype="multipart/form-data">
	<table>
		<tr>
			<td><input type="hidden" name="board_code"
				value="${vo.board_code }"></td>
		</tr>
		<tr>
			<th>게시판</th>
			<td><select name="cate_code">

					<c:forEach var="i" items="${catelist }">
						<c:choose>
							<c:when test="${vo.cate_code eq i.cate_code }">
								<option value="${i.cate_code }" selected="selected">${i.category }</option>
							</c:when>
							<c:otherwise>
								<option value="${i.cate_code }">${i.category }</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
			</select></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="title" value="${vo.title }"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea name="content">${vo.content }</textarea></td>
		</tr>
		<tr>
			<th>이미지파일</th>
			<td><input type="file" name="imgfile" multiple></td>
		</tr>

		<tr>
			<td><button type="submit">수정</button></td>
		</tr>

	</table>
</form:form>