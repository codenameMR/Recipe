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
  <!--  구글 폰트  -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<style>
.navbar-custom {
background-color: burlywood;
height: 150px;
padding-left:400px;
}
#cookIcon {
	margin-left: 10px;
	width: 70px;
	height: 70px;
}
#homeLogo {
	font-family: 'Gugi', cursive;
	font-size: 50px;
	margin-left: 10px;
	margin-top: 10px;
}
.barFont {
	font-size:25px;
}
.barSeparator {
	margin-top: 7px;
	font-size: 25px;
	color: white;
}
</style>
</head>
	
<body>
<nav class="navbar navbar-custom navbar-expand-lg navbar-dark">

    <div class="container">
      <a class="navbar-brand" href="/recipeteamPJ/index.jsp" />
      	<img src="/recipeteamPJ/css/cooker.png" alt="cooker" id="cookIcon">
      </a>
      <a class="navbar-brand nav-a" href="/recipeteamPJ/index.jsp" id="homeLogo"/>천개의 레시피</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link barFont" href="/recipeteamPJ/index.jsp" > Home
            	<span class="sr-only">(current)</span>
            </a>
          </li>
        
          <li class="nav-item">
          	<label class="barSeparator">&nbsp;|&nbsp;</label>
          </li>
          
          <%
			// 로그인 안 되었을 경우 - 로그인, 회원가입 버튼을 보여준다.
			if(session.getAttribute("userId")==null){ 
		  %>
          <li class="nav-item">
            <a class="nav-link barFont" href="/recipeteamPJ/signUpNInForm.jsp" />로그인/회원가입</a>
          </li>
          
          <%
			// 로그인 되었을 경우 - 로그아웃, 내정보 버튼을 보여준다.
			} else { 
		  %>
		  <li class="nav-item">
            <a class="nav-link barFont" href="/recipeteamPJ/logOut.jsp">
           		로그아웃 
            </a>
          </li>
          
          <li class="nav-item">
          	<label class="barSeparator">&nbsp;|&nbsp;</label>
          </li>
          
          <li class="nav-item">
            <a class="nav-link barFont" href="/recipeteamPJ/myPage/myPage.jsp">
            	마이페이지 
            </a>
          </li>
		  <%}%>	
        </ul>
      </div>
    </div>
</nav>    
</body>
</html>