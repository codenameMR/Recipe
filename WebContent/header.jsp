<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
  <!-- Bootstrap core CSS -->
  <link href="/recipeteamPJ/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom styles for this template -->
  <link href="/recipeteamPJ/css/shop-homepage.css" rel="stylesheet">
</head>
	 
<body>
    <div class="container">
      <a class="navbar-brand" href="/recipeteamPJ/index.jsp">홈페이지</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active">
            <a class="nav-link" href="/recipeteamPJ/index.jsp">Home
              <span class="sr-only">(current)</span>
            </a>
          </li>
          <%
			// 로그인 안 되었을 경우 - 로그인, 회원가입 버튼을 보여준다.
			if(session.getAttribute("userId")==null){ 
		  %>
          <li class="nav-item">
            <a class="nav-link" href="signUpNInForm.jsp">로그인/회원가입</a>
          </li>
          
          <%
			// 로그인 되었을 경우 - 로그아웃, 내정보 버튼을 보여준다.
			} else { 
		  %>
		  <li class="nav-item">
            <a class="nav-link" href="logOut.jsp">로그아웃</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="myPage.jsp">내정보</a>
          </li>
		  <%}%>	
        </ul>
      </div>
    </div>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script type="text/javascript">
	</script>
    
</body>
</html>