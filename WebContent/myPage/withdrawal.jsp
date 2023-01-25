<%@page import="teamProject2.Dao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String userId = (String)session.getAttribute("userId");

Dao dao = Dao.getInstance();
int result = dao.withdrawal(userId);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
if(<%=result %> == 1){
alert("회원탈퇴가 정상적으로 완료 되었습니다.")
<%
session.removeAttribute("userId");
//response.sendRedirect("/recipeteamPJ/index.jsp");
%>
location.href = '/recipeteamPJ/index.jsp';
} else {
	alert("알 수 없는 오류입니다. 다시 시도해 주세요.")
}
</script>
</body>
</html>