<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	boolean result = (Boolean)request.getAttribute("delResult");
%>
<% if (result == false) { %>
	<script>
		alert("삭제 실패");
		history.back();
	</script>
<% } else { %>
	<script>
		alert("삭제 성공");
		location.href = "recipeBoard.do";
	</script>
<% } %>