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
		request.setCharacterEncoding("UTF-8"); 
		Dao dao = Dao.getInstance();
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		MemberInfo mi = new MemberInfo(userId, password);

		if (dao.memberSignInCheck(mi).equals(password)) {
			session.setAttribute("userId", userId);
	%><script>
		alert("로그인 성공");
	</script>
	<%
	response.sendRedirect("index.jsp");
		} else {
	%>
	<script>
		alert("아이디 혹은 비밀번호가 다릅니다.");
		window.location.href="signUpNInForm.jsp";
	</script>
	<%
		}
	%>
</body>
</html>