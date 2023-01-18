<%@page import="teamProject2.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
request.setCharacterEncoding("utf-8");
Dao dao = Dao.getInstance();
String userId = (String)session.getAttribute("userId");
MemberInfo mi = new MemberInfo(userId);
String[] memberInfo = dao.memberMyPage(mi);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
label{
font-size: 30px;
}

</style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <jsp:include page="header.jsp" />
  </nav>
  <form action="changePW.jsp" id="updatePWForm">
   <div class="container" id="center" style="height:1200px">
  <label>이름 : </label><label id="id"><%=memberInfo[2] %></label><br>
  <label>아이디 : </label><label id="name"><%=memberInfo[0] %></label><br>
  <label>비밀번호 : </label><input id="password" name="password" placeholder="*******">
  <input type="button" id="changepw" value="비밀번호 변경">
  <div id="statement">
  </div>
  </div>
  </form>
  <script>
  $('#changepw').click(function() {
		$.ajax({
			url : 'changePW.jsp',
			type : 'get',
			data: $("#updatePWForm").serialize(),
			success : function(val) {
				$('#statement').html(val);
			}
		});
	});
  </script>
</body>
</html>