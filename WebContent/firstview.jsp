<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
	<head>
		<title>첫화면</title>
	</head>
	<body>		
	<%
		if(session.getAttribute("sessionID") == null) // 로그인이 안되었을 때
		{ 
	%>	
		<div style="height:300px"></div>
		<h3>welcome</h3>
	<%
		}
		else // 로그인 했을 경우
		{
	%>
			<font size=6><%=session.getAttribute("sessionID") %></font>
			<font size=6>님 환영합니다.</font>
	<%	} %>
	</body>
</html>



