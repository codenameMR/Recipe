<%@page import="teamProject2.MemberInfo"%>
<%@page import="teamProject2.Dao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
request.setCharacterEncoding("utf-8");
Dao dao = Dao.getInstance();
String name = request.getParameter("name");
String userId = request.getParameter("userId");
String password = request.getParameter("password");
MemberInfo mi = new MemberInfo(userId, name, password);
 if(dao.memberSignUpIdCheck(mi) == 0){
dao.memberSignUp(mi);
%>
<script>
alert("회원 가입이 완료 되었습니다. 다시 로그인 해주세요.");
window.location.href="signUpNInForm.jsp";
</script>
<%
} else if (dao.memberSignUpIdCheck(mi) == 1){ %>
<script>
alert("이미 존재하는 아이디 입니다.");
window.location.href="signUpNInForm.jsp";
</script>
<% }%>
</body>
</html>