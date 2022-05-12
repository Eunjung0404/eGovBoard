<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
div#editor {
	padding: 16px 24px;
	border: 1px solid #D6D6D6;
	border-radius: 4px;
	height: 800px;
	overflow: auto;
}

#editor img {
	max-width: 100%;
}

#editBox span {
	background-color: gray;
	padding: 2px;
	border-radius: 5px;
	color: white;
}

#editBox span:hover {
	background-color: black;
}
</style>

<c:set var="cp" value="${pageContext.request.contextPath}" />
<form:form method="post" action="boardUpdate.do" acceptCharset="UTF-8"
	enctype="multipart/form-data">
	<table>
		<tr>
			<td><input type="hidden" name="board_code"
				value="${vo.board_code }"></td>
		</tr>
		<tr>
			<td style="width: 10%;"><select name="cate_code">

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
			<td><input type="text" name="title" style="width: 100%"
				value="${vo.title }"></td>
		</tr>

		<tr>
			<td colspan="2">
				<div id="editBox">
					<select id="btn-HTML">
						<option value="h1">제목1</option>
						<option value="h2">제목4</option>
						<option value="h3">제목3</option>
						<option value="h4">본문1</option>
						<option value="h5">본문2</option>
						<option value="" selected="selected">본문3</option>
					</select>

					<button type="button" id="btn-bold">
						<b>B</b>
					</button>
					<button type="button" id="btn-italic">
						<i>I</i>
					</button>
					<button type="button" id="btn-underline">
						<u>U</u>
					</button>
					<button type="button" id="btn-strike">
						<s>S</s>
					</button>
					<select id="btn-list">
						<option>-목록화-</option>
						<option value="insertOrderedList">OL</option>
						<option value="insertUnorderedList">UL</option>
					</select>
					<button type="button" id="btn-justifyCenter">
						<img src="${cp }/images/icon/center.png">
					</button>
					<button type="button" id="btn-justifyLeft">
						<img src="${cp }/images/icon/left.png">
					</button>

					<button type="button" id="btn-justifyRight">
						<img src="${cp }/images/icon/right.png">
					</button>
					<button type="button" id="btn-image" onclick="imgupload()">
						<img src="${cp }/images/icon/image.png">
					</button>

				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2"><div id="editor" contenteditable="true"
					onkeyup="parameterSet()">${vo.content }</div></td>
		</tr>
		<tr>
			<td id="test"></td>
			<td><input type="hidden" name="content" value="${vo.content }"
				id="contentInput"></td>
		</tr>
		<tr>
			<td><button type="submit">수정</button></td>
		</tr>

	</table>
</form:form>

<script type="text/javascript">
	let test = document.getElementById("test");
	const editor = document.getElementById("editor");
	//document.designMode = "on";
	//파일이미지 미리보기
	window.addEventListener('load', function() {
		let content = editor.innerText;
		editor.innerHTML = content;
	});
	function imgupload() {
		let fileinput = document.createElement("input");
		fileinput.setAttribute("type", "file");
		fileinput.setAttribute("name", "imgfile");
		test.appendChild(fileinput);
		//파일이미지 미리보기
		fileinput.addEventListener('change', function(e) {

			console.log(e.target.files);
			var reader = new FileReader();
			var u = reader.readAsDataURL(e.target.files[0]);
			console.log(u);
			reader.onload = function(event) {

				let previewImage = document.createElement("img");
				previewImage.setAttribute("src", e.target.result);
				editor.appendChild(previewImage);
				console.log("url=" + event.target.result)
				previewImage.src = event.target.result;
				parameterSet();
			};

		});
		fileinput.style.display = "none";
		fileinput.click();

	}

	function parameterSet() {
		//console.log(editor.innerHTML);
		let contentinput = document.getElementById("contentInput");
		contentinput.value = editor.innerHTML;
	}

	const btnBold = document.getElementById('btn-bold');
	const btnItalic = document.getElementById('btn-italic');
	const btnUnderline = document.getElementById('btn-underline');
	const btnStrike = document.getElementById('btn-strike');
	const btnList = document.getElementById('btn-list');
	const btnHTML = document.getElementById('btn-HTML');
	const btnjustifyCenter = document.getElementById('btn-justifyCenter');
	const btnjustifyLeft = document.getElementById('btn-justifyLeft');
	const btnjustifyRight = document.getElementById('btn-justifyRight');
	btnBold.addEventListener('click', function() {
		setStyle('bold', '');
	});
	btnItalic.addEventListener('click', function() {
		setStyle('italic', '');
	});
	btnUnderline.addEventListener('click', function() {
		setStyle('underline', '');
	});
	btnStrike.addEventListener('click', function() {
		setStyle('strikeThrough', '')
	});
	btnList.addEventListener('change', function(e) {
		setStyle(e.target.value, '');
	});
	btnHTML.addEventListener('change', function(e) {
		setStyle("formatBlock", e.target.value);
	});
	btnjustifyCenter.addEventListener('click', function(e) {
		setStyle("justifyCenter", '');
	});
	btnjustifyLeft.addEventListener('click', function(e) {
		setStyle("justifyLeft", '');
	});
	btnjustifyRight.addEventListener('click', function(e) {
		setStyle("justifyRight", '');
	});
	function setStyle(style, option) {
		document.execCommand(style, false, option);
		focusEditor();
		parameterSet();
	} // 버튼 클릭 시 에디터가 포커스를 잃기 때문에 다시 에디터에 포커스를 해줌 
	function focusEditor() {
		editor.focus({
			preventScroll : true
		});
	}
</script>