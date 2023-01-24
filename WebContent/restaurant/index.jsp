<%@page import="teamProject2.LikeDao"%>
<%@page import="com.cook.model.RecipeDAO"%>
<%@page import="teamProject2.RecLike"%>
<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>레시피공유</title>
	
  <!-- Bootstrap core CSS -->
  <link href="/recipeteamPJ/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom styles for this template -->
  <link href="/recipeteamPJ/css/shop-homepage.css" rel="stylesheet">
  <!-- 구글 폰트 --> 
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Gugi&family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
</head>

<body style="padding-top: 0px; font-family: 'Noto Sans KR', sans-serif;">
  <!-- 상단 Navigation -->
  <jsp:include page="../header.jsp" />

  <!-- 중앙 Page Content -->
  <div class="container" id="center" style="height:1500px; padding-top:20px;">
    <div class="row"> <!-- 왼쪽(게시판)과 오른쪽(내용) 정렬 -->
	
      <div class="col-lg-3"> <!-- 왼쪽 (게시판) -->
      	<jsp:include page="../board.jsp" />
      </div> <!-- /.col-lg-3 왼쪽(게시판) 끝-->
      
	  <div class="col-lg-9" id ="center_right"> <!-- 오른쪽(내용) --> 
	  </div> <!--/.col-lg-9 오른쪽(내용) 끝--> 	
       
      </div> <!-- /.row 왼쪽,오른쪽 정렬 끝--> 
       
  </div>
  <!-- /.container 중앙 끝 -->
	
  <!-- Footer 하단--> 
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Your Website 2019</p>
    </div>
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
