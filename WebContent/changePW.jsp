<%@page import="teamProject2.MemberInfo"%>
<%@page import="teamProject2.Dao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String userId = (String)session.getAttribute("userId");
String password = request.getParameter("password");
MemberInfo mi = new MemberInfo(userId, password);
Dao dao = Dao.getInstance();
int result = dao.updatePassword(mi);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<script>
alert("<%=result%>건 업데이트성공");
</script>
</body>
</html>