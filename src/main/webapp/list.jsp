<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="">
	<span>전체게시글</span> <input type="hidden" value="${category }"
		id="cate_code">

	<table id="test" class="list">
		<tr>
			<td colspan="4" style="text-align: right;"><select id="listcount" onchange="chanegeslect()">
					<option value="5">5</option>
					<option value="10">10</option>
					<option value="15">15</option>
					<option value="20">20</option>
			</select></td>
		</tr>
		<tr>
			<th>글번호</th>
			<th style="width: 75%;">제목</th>
			<th style="text-align: center;">작성자</th>
			<th>작성일</th>
		</tr>
		<tbody id="tbody">

		</tbody>
		<tr>
		<td colspan="4" style="text-align: right; "><select id=""><option value="title">제목</option>
		<option value="content">내용</option>
		<option value="all">내용+제목</option>
		<option value="user_nicname">작성자</option>
		</select><input type="text" name=""></td>
		
		</tr>
	</table>
	<div id="pagecount" class="pageDiv"
		style="text-align: center; padding: 50px;"></div>
</div>

<script>
	window.onload = function() {

		getBoardAll(1);
	}
	function cleartable() {
		let tbody = document.getElementById("tbody");
		for (var i = tbody.rows.length; i >= 0; i--) {
			tbody.deleteRow(tbody.rows.length - 1);
		}
	}

	function chanegeslect() {
		getBoardAll(1);
	}
	function getBoardAll(pageNum) {
		let cate_code = document.getElementById("cate_code").value;
		let listcount=document.getElementById("listcount").value;
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let data = xhr.responseText;
				let json = JSON.parse(data);
				cleartable();
				let tbody = document.getElementById("tbody");
				for (var i = 0; i < json.list.length; i++) {
					tbody.innrHTML = "";
					let tr = document.createElement('tr');
					tr.id = json.list[i].board_code;

					tr.innerHTML = "<td>" + (listcount * (pageNum - 1) + (i + 1))
							+ "</td><td onclick='detailurl(event)'>"
							+ json.list[i].title
							+ "</td><td style='text-align: center;' >"
							+ json.list[i].user_nicname + "</td><td>"
							+ json.list[i].regdate + "</td>"
					tbody.appendChild(tr);
				}

				//페이징
				let startPage = json.startPageNum;
				let endPage = json.endPageNum;
				let pageCount = json.totalPageCount;

				let pageHtml = "";
				if (startPage > 5) {
					pageHtml += "<a href='javascript:getBoardAll("
							+ (startPage - 1) + ")'><span>[이전]</span>"
				}
				for (let i = startPage; i <= endPage; i++) {
					if (i == pageNum) {
						pageHtml += "<a href='javascript:getBoardAll(" + i
								+ ")'><span style='color:blue'>[" + i
								+ "]</span>"
					} else {
						pageHtml += "<a href='javascript:getBoardAll(" + i
								+ ")'><span style='color:gray'>[" + i
								+ "]</span>"
					}
				}
				if (endPage < pageCount) {
					pageHtml += "<a href='javascript:getBoardAll("
							+ (endPage + 1) + ")'><span>[다음]</span>"
				}
				pagecount.innerHTML = pageHtml;

			}
		}
		xhr.open('get', 'testjson.json?pageNum=' + pageNum +'&listcount='+listcount +'&cate_code='
				+ cate_code, true);
		xhr.send();

	}

	function detailurl(event) {
		console.log(event.target.parentElement.id);
		location.href = "/myproject/user/boardDetail.do?board_code="
				+ event.target.parentElement.id;
	}
</script>