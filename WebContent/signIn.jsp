<%@page import="teamProject2.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		Dao dao = Dao.getInstance();
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		MemberInfo mi = new MemberInfo(userId, password);

		if (dao.memberSignInCheck(mi).equals(password)) {
	%><script>
		alert("로그인 성공");
		window.location.href="signUpNInForm.jsp";
	</script>
	<%
		} else {
	%>
	<script>
		alert("로그인 실패");
		window.location.href="signUpNInForm.jsp";
	</script>
	<%
		}
	%>
</body>
</html>