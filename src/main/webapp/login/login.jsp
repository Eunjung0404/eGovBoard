<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div>
	<form:form action="login.do" method="post">
		<table>
			<tr>
				<th>ID</th>
				<td><input type="text" name="username"
					placeholder="아이디를 입력해주세요"><span id="errormsg" style="color:red;font-size: 10px;">${requestScope.msg }</span></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="text" name="password"
					placeholder="비밀번호를 입력해주세요"></td>
			</tr>

			<tr>
				<th colspan="2"><button type="submit">로그인</button></th>
			</tr>
			
		</table>
	</form:form>

</div>