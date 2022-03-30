<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div>
	<form:form method="post" action="signUP.do">
		<table>
			<tr>
				<th>ID</th>
				<td><input type="text" name="user_id"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="text" name="user_pwd"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="user_name"></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td><input type="text" name="user_phone"></td>
			</tr>
			<tr>
				<th colspan="2"><button type="submit">가입</button></th>
			</tr>
		</table>

	</form:form>
</div>
