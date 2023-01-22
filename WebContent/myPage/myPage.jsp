<%@page import="teamProject2.*"%>
<%@page import="com.cook.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%
request.setCharacterEncoding("utf-8");
//비밀번호 수정 
Dao dao = Dao.getInstance();
HttpSession session = request.getSession();
String userId = (String)session.getAttribute("userId");
MemberInfo mi = new MemberInfo(userId);
String[] memberInfo = dao.memberMyPage(mi);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>레시피공유-마이페이지</title>
	
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
          <a href="myPage.jsp" class="list-group-item">회원정보 수정</a>
          <a href="myRecipeList.do?writer_id=<%=userId%>" class="list-group-item">내가 쓴 레시피</a>
          <a href="myRes.jsp" class="list-group-item">내가 쓴 맛집</a>
          <a href="myRecipeLike.do?like_id=<%=userId%>" class="list-group-item">좋아요한 레시피</a>
          <a href="myResLike.jsp" class="list-group-item">좋아요한 맛집</a>
        </div>
      </div> <!-- /.col-lg-3 왼쪽(게시판) 끝-->
      
	  <div class="col-lg-9" id ="center_right"> <!-- 오른쪽(내용) --> 
	  	<div style="height:20px"></div>
	  	<h1>회원정보 수정</h1>
	  	<hr>
	  	<form action="changePW.jsp" id="updatePWForm">
		  <label>이름 :&nbsp;</label><label id="id"><%=memberInfo[2] %></label><br>
		  <label>아이디 :&nbsp;</label><label id="name"><%=memberInfo[0] %></label><br>
		  <label>비밀번호 :&nbsp;</label><input id="password" name="password" placeholder="*******"required>
		  <input type="button" id="changepw" value="비밀번호 변경">
		  <div id="statement">
		  </div>
  		</form>
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
  $('#changepw').click(function() {
		$.ajax({
			url : '/recipeteamPJ/changePW.jsp',
			type : 'get',
			data: $("#updatePWForm").serialize(),
			success : function(val) {
				$('#statement').html(val);
			}
		});
	});
</script>
</html>
