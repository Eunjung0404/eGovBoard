<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

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
<h1>글작성</h1>
<form:form name="frm" method="post" action="boardSave.do"
	acceptCharset="UTF-8" enctype="multipart/form-data"
	onsubmit="return checkSubmit()">
	<sec:csrfInput />
	<table class="insertTable">
		<tr>
			<td><input type="hidden" name="user_id" style="width: 100%"
				value="${username}"></td>
			<td><input type="hidden" name="user_nicname" style="width: 100%"
				value="${sessionScope.nicname}"></td>
		</tr>

		<tr>
			<td style="width: 10%;"><select name="cate_code" id="cateCode">
					<option value="" disabled selected>카테고리</option>
					<c:forEach var="i" items="${list}">
						<option value="${i.cate_code} ">${i.category}</option>
					</c:forEach>
			</select></td>
			<td><input type="text" name="title" style="width: 100%"
				placeholder="제목을 입력해 주세요" id="title"></td>
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
					onkeyup="parameterSet()"></div></td>
		</tr>
		<tr>
			<th>이미지파일</th>
		</tr>
		<tr>
			<td colspan="2"><div id="imgdiv">이미지</div></td>
		</tr>

		<tr>
			<th colspan="2"><button type="submit">등록</button></th>
		</tr>
		<tr>
			<td id="test"></td>
			<td><input type="hidden" name="content" value=""
				id="contentInput"></td>
		</tr>

	</table>
</form:form>

<script type="text/javascript">
	let test = document.getElementById("test");
	const editor = document.getElementById("editor");
	//document.designMode = "on";
	//파일이미지 미리보기

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

	//데이터 공백 검사
	function nullDataCheck(id, name) {
		let data = document.getElementById(id).value;
		if (data.length == 0) {
			alert(name)
			return false;
		}
		return true;
	}
	//유효성 검사 
	function checkSubmit() {
		if (!nullDataCheck('cateCode', '카테고리를 선택해주세요')) {
			return false;
		}
		if (!nullDataCheck('title', '제목을 입력해주세요')) {
			return false;
		}

		return true;
	}
</script>