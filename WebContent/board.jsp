<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userId = (String)session.getAttribute("userId");
String path = request.getServletPath();

//updateform
/* String prePage = "";
if(request.getAttribute("prePage")!=null) {
	prePage=(String)request.getAttribute("prePage");
} 
System.out.println(prePage); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <!-- Bootstrap core CSS -->
  <link href="/recipeteamPJ/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom styles for this template -->
  <link href="/recipeteamPJ/css/shop-homepage.css" rel="stylesheet">
  <!-- 구글 폰트 --> 
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Gugi&family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
  <style>
  body {
  font-family: 'Noto Sans KR', sans-serif;"
  }
  .list-group-item {
   color: coral;
  }
  h1 {
   color: #666;
  }
  </style>
</head>
<body>
<h1 class="my-4">게시판</h1>
<div class="list-group">
<% if(path.equals("/index.jsp") || path.equals("/recipe_board/recipe_board.jsp") ||
		path.equals("/recipe_board/recipe_view.jsp") || path.equals("/recipe_board/recipe_writeform.jsp")
		|| path.equals("/recipe_board/recipe_updateform.jsp") )  {%>
  <a href="recipeBoard.do" class="list-group-item">레시피 게시판</a>
  <a href="restaurant/list.jsp" class="list-group-item">맛집 게시판</a>
  <a href="#" class="list-group-item">게시판3</a>
  <a href="#" class="list-group-item">게시판4</a>
  <a href="#" class="list-group-item">게시판5</a>
<%} else { %>
 <a href="myPage.jsp" class="list-group-item">회원정보 수정</a>
 <a href="myRecipeList.do?writer_id=<%=userId%>" class="list-group-item">내가 쓴 레시피</a>
 <a href="myRes.jsp" class="list-group-item">내가 쓴 맛집</a>
 <a href="myRecipeLike.do?like_id=<%=userId%>" class="list-group-item">좋아요한 레시피</a>
 <a href="myResLike.jsp" class="list-group-item">좋아요한 맛집</a>
<%} %>
</div>
</body>
<script>
</script>
</html>