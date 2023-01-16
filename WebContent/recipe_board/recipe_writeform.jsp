<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String[] rec_categories = {"한식","중식","일식","양식","기타"};
String ctx = request.getContextPath();    //콘텍스트명 얻어오기.
%>
<!DOCTYPE html>
<html lang="ko">
<html>
<head>
<meta charset="UTF-8">
<title>레시피 등록</title>
<!-- <link rel="stylesheet" href="/css/styleRecipeWirte.css"> -->
<style>
.fileuploder {
	font-weight: normal;
	font-size: 16px;
}
.fileuploder .btn {
    display: inline-block;
    padding: .5em .75em;
    font-size: 15px;
	line-height: normal; 
    vertical-align: middle;
/*     background-color: #e2e2e2; */
    cursor: pointer;
    border: 1px solid #ebebeb;
    border-bottom-color: #e2e2e2;
    border-radius: .25em;
}

/* .fileuploder input[type="file"] { */
/*     position: absolute; */
/*     width: 1px; */
/*     height: 1px; */
/*     padding: 0; */
/*     margin: -1px; */
/*     overflow: hidden; */
/*     clip: rect(0, 0, 0, 0); */
/*     border: 0; */
/* } */

.imgPreview {
    width: 600px;
	min-height:150px;
	padding:10px;
    border:1px dotted #ccc;
}
</style>
</head>
<body>
	<div class="wrap">
		<h1>레시피 글쓰기</h1>
		<form action="recipeWriteOk.do" method="post" enctype="multipart/form-data">
			<!-- memberID 파라미터 전달 용 숨은 input태그 -->
			<input type="hidden" name="user_id" value="${sessionScope.memberID}">
			<dl>
				<dt>제목</dt>
				<dd>
					<input type="text" placeholder="제목을 입력하세요" name="rec_title"
						required>
				</dd>
			</dl>
			
			<dl>
				<dt>글쓴이(id)</dt>
				<dd>
					<input type="text" placeholder="아이디 입력" name="user_id"
						required>
				</dd>
			</dl>
			
			<dl>
				<dt>내용</dt>
				<dd>
					<textarea name="rec_content" placeholder="내용을 입력하세요"
						style="width:600px; height:200px;" required></textarea>
				</dd>
			</dl>

			<!--input type file 테그 속성중에 multiple이라는 속성 -->
			<!-- 해당 속성을 선택하면 파일이 여러개 선택 되는데, 해당 데이터가 배열로 리턴된다. -->
			<div>
					<strong>이미지 첨부1 </strong> 
<!-- 					<label class="btn" for="rec_pic_file1">파일등록</label> -->
					<input id="rec_pic_file1" class="btn" name="rec_pic1" type="file"
						 accept=".gif, .jpg, .png"
						onchange="fileUpload()">
			</div>

			<div>
					<strong>이미지 첨부2 </strong> 
<!-- 					<label class="btn" for="rec_pic_file2">파일등록</label> -->
					<input id="rec_pic_file2" class="btn" name="rec_pic2" type="file"
						 accept=".gif, .jpg, .png"
						onchange="fileUpload()">
			</div>
			
			<div>
				<strong>이미지 첨부3 </strong> 
<!-- 					<label class="btn" for="rec_pic_file3">파일등록</label> -->
				<input id="rec_pic_file3" class="btn" name="rec_pic3" type="file"
						 accept=".gif, .jpg, .png"
						onchange="fileUpload()">
			</div>

			<div>
				<strong>카테고리</strong>
				   <select name="rec_category">
				   		<optgroup label="선택">
    					<%
    					for (String categoryName : rec_categories) {
    					%>
    					  <option value="<%=categoryName%>"><%=categoryName%></option>  	
    					  <%} %>
  				   </select>
			</div>

			<input type="submit" value="등록하기">
		</form>

		<br>
		<button type="button" id="tolistBtn">목록으로</button>
	</div>
</body>

<script type="text/javascript">
</script>
</html>