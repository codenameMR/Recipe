<%@page import="teamProject2.LikeDao"%>
<%@page import="com.cook.model.RecipeDAO"%>
<%@page import="teamProject2.RecLike"%>
<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%
request.setCharacterEncoding("utf-8");
Recipe recipe = (Recipe) request.getAttribute("recipe");

if (recipe == null ) {
%>
<script>
	alert("해당 정보가 삭제되었거나 존재하지 않습니다.");
	history.back();
</script>
<%
	return;  //if 문 아래 소스코드 실행 x.
}
%>

<%
String[] rec_categories = {"한식","중식","일식","양식","기타"};
int rec_num = recipe.getRec_num();
String user_id= recipe.getUser_id();
String rec_title = recipe.getRec_title();
String rec_content = recipe.getRec_content();
String rec_date = recipe.getRec_date();
int rec_views = recipe.getRec_views();
int rec_likes = recipe.getRec_likes();
String rec_category = recipe.getRec_category();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>레시피공유-레공</title>
	
  <!-- Bootstrap core CSS -->
  <link href="/recipeteamPJ/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom styles for this template -->
  <link href="/recipeteamPJ/css/shop-homepage.css" rel="stylesheet">
</head>

<body>
  <!-- 상단 Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <jsp:include page="../header.jsp" />
  </nav>

  <!-- 중앙 Page Content -->
  <div class="container" id="center" style="height:1200px">
    <div class="row"> <!-- 왼쪽(게시판)과 오른쪽(내용) 정렬 -->
	
      <div class="col-lg-3"> <!-- 왼쪽 (게시판) -->
        <h1 class="my-4">게시판</h1>
        <div class="list-group">
          <a href="recipeBoard.do" class="list-group-item">레시피 게시판</a>
          <a href="../restaurant/list.jsp" class="list-group-item">맛집 게시판</a>
          <a href="#" class="list-group-item">게시판3</a>
          <a href="#" class="list-group-item">게시판4</a>
          <a href="#" class="list-group-item">게시판5</a>
        </div>
      </div> <!-- /.col-lg-3 왼쪽(게시판) 끝-->
      
	  <div class="col-lg-9" id ="center_right"> <!-- 오른쪽(내용) --> 
		<div style="height:20px"></div>
		<h1><%=rec_title %> 수정</h1>
		<hr>
		<form name="frm" action="recipeUpdateOk.do" method="post"  enctype="multipart/form-data">
			<input type="hidden" name="rec_num" value="<%=rec_num %>"/>
			<strong>제목 : </strong>
			<input type="text" name="rec_title" value="<%=rec_title %>" required/><br>
			<strong>글쓴이(id) : </strong> <%=user_id%><br>
			<input type="hidden" name="user_id" value="<%=user_id%>">
			<strong>내용 : </strong>
			<textarea name="rec_content" 
							style="width: 300px; height: 200px;" required><%=rec_content%></textarea><br>
			<strong>카테고리 : </strong>
			<select name="rec_category">
	    			<%for(String categoryName : rec_categories) { 
	    				  	if (categoryName.equals(recipe.getRec_category())) {  %> 
	       				  <option value="<%=rec_category%>" selected><%=rec_category%></option> 
	         			   <% } else { %>
	    					<option value="<%=categoryName%>" > <%=categoryName%> </option>  	
	    				   <%} 
	    				}%>
			</select><br>				
			<strong>조회수 : </strong> <%=rec_views%><br>
			<strong>좋아요수 : </strong> <%=rec_likes%><br>
			<strong>등록일 :</strong> <%=rec_date%><br>
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
			
			<input type="submit" value="수정하기"/>	
		</form>
		
		<br><hr><br>
		<button id="tolistBtn" onclick="location.href='recipeBoard.do'">목록으로</button>
	
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
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script type="text/javascript">

	</script>
</html>
