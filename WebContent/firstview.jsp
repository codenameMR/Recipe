<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
	<head>
		<title>ùȭ��</title>
	</head>
	<body>		
	<%
		if(session.getAttribute("sessionID") == null) // �α����� �ȵǾ��� ��
		{ 
	%>	
		<div style="height:300px"></div>
		<h3>welcome</h3>
	<%
		}
		else // �α��� ���� ���
		{
	%>
			<font size=6><%=session.getAttribute("sessionID") %></font>
			<font size=6>�� ȯ���մϴ�.</font>
	<%	} %>
	</body>
</html>



