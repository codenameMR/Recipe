<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%
request.setCharacterEncoding("utf-8");

//로그인 id
HttpSession session = request.getSession();
String userId = (String)session.getAttribute("userId");

//카테고리
String[] rec_categories = {"한식","중식","일식","양식","기타"};
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>레시피공유-레공</title>

<!-- Bootstrap core CSS -->
<link href="/recipeteamPJ/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="/recipeteamPJ/css/shop-homepage.css" rel="stylesheet">

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

.imgPreview {
	width: 600px;
	min-height: 150px;
	padding: 10px;
	border: 1px dotted #ccc;
}
</style>
</head>

<body>
  <!-- 상단 Navigation -->
  <jsp:include page="../header.jsp" />

  <!-- 중앙 Page Content -->
  <div class="container" id="center" style="height:1500px; padding-top:10px;">
    <div class="row"> <!-- 왼쪽(게시판)과 오른쪽(내용) 정렬 -->
	
      <div class="col-lg-3"> <!-- 왼쪽 (게시판) -->
        <jsp:include page="../board.jsp"/>
      </div> <!-- /.col-lg-3 왼쪽(게시판) 끝-->
      
	  <div class="col-lg-9" id ="center_right"> <!-- 오른쪽(내용) --> 
	   	<div class="wrap">
	   	<div style="height:20px"></div>
		<h1>레시피 글쓰기</h1>
		<br>
		<form action="recipeWriteOk.do" method="post" enctype="multipart/form-data" style="display:inline;">
			<!-- memberID 파라미터 전달 용 숨은 input태그 -->
			<input type="hidden" name="user_id" value="<%=userId%>">
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
					<label><%=session.getAttribute("userId")%></label>
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
					<input id="rec_pic_file1" class="btn" name="rec_pic1" type="file"
						 accept=".gif, .jpg, .png">
			</div>
			<div>
					<strong>이미지 첨부2 </strong> 
					<input id="rec_pic_file2" class="btn" name="rec_pic2" type="file"
						 accept=".gif, .jpg, .png">
			</div>
			<div>
				<strong>이미지 첨부3 </strong> 
				<input id="rec_pic_file3" class="btn" name="rec_pic3" type="file"
						 accept=".gif, .jpg, .png">
			</div>
			<br>
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
			<br>
			<input type="submit" value="등록하기">
		</form>

		<button type="button" id="tolistBtn" onclick="location.href='recipeBoard.do'">목록으로</button>
	</div>
	  </div> <!--/.col-lg-9 오른쪽(내용) 끝--> 	
      
     </div> <!-- /.row 왼쪽,오른쪽 정렬 끝--> 
       
  </div>
  <!-- /.container 중앙 끝 -->
	
  <!-- Footer 하단-->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Your Website 2019</p>
    </div>
    <!-- /.container 하단 끝 -->
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="/recipeteamPJ/vendor/jquery/jquery.min.js"></script>
  <script src="/recipeteamPJ/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  
</body>

</html>
