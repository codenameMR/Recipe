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

<body style="padding-top: 0px;">
  <!-- 상단 Navigation -->
  <jsp:include page="../header.jsp" />

  <!-- 중앙 Page Content -->
  <div class="container" id="center" style="height:1500px; padding-top:10px;">
    <div class="row"> <!-- 왼쪽(게시판)과 오른쪽(내용) 정렬 -->
	
      <div class="col-lg-3"> <!-- 왼쪽 (게시판) -->
       <jsp:include page="../board.jsp" />
      </div> <!-- /.col-lg-3 왼쪽(게시판) 끝-->
      
	  <div class="col-lg-9" id ="center_right"> <!-- 오른쪽(내용) --> 
	  	<div style="height:20px"></div>
	  	<h1>회원정보 수정</h1>
	  	<hr>
	  	<form id="updatePWForm">
		  <label>이름 :&nbsp;</label><label id="id"><%=memberInfo[2] %></label><br>
		  <label>아이디 :&nbsp;</label><label id="name"><%=memberInfo[0] %></label><br>
		  <label>비밀번호 :&nbsp;</label><input type="password" id="password" name="password" placeholder="*******"required>
		  <input type="button" id="changepw" value="비밀번호 변경"><hr>
		  <input type="button" id="withdrawal" value="회원탈퇴">
		  <div id="statement">
		  </div>
  		</form>
	  </div> <!--/.col-lg-9 오른쪽(내용) 끝--> 	
      
     </div> <!-- /.row 왼쪽,오른쪽 정렬 끝--> 
       
  </div>
  <!-- /.container 중앙 끝 -->
	
  <!-- Footer 하단-->
  <jsp:include page="../footer.jsp" />

  <!-- Bootstrap core JavaScript -->
  <script src="/recipeteamPJ/vendor/jquery/jquery.min.js"></script>
  <script src="/recipeteamPJ/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
  $('#withdrawal').click(function() {
	  if(window.confirm("정말 회원을 탈퇴하시겠습니까?")){
		$.ajax({
			url : '/recipeteamPJ/myPage/withdrawal.jsp',
			type : 'get',
			data: $("#updatePWForm").serialize(),
			success : function(val) {
				$('#statement').html(val);
			}
		});
	  }
	});
  
  
  
  $('#changepw').click(function() {
		$.ajax({
			url : '/recipeteamPJ/myPage/changePW.jsp',
			type : 'get',
			data: $("#updatePWForm").serialize(),
			success : function(val) {
				$('#statement').html(val);
			}
		});
	});
</script>
</html>
