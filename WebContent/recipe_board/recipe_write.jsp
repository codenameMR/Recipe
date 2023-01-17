<%@page import="java.io.File"%>
<%@page import="com.cook.model.RecipeDAO"%>
<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int result = (Integer)request.getAttribute("result");
	Recipe recipe = (Recipe)request.getAttribute("recipe");
%>

<% if (result ==0 ){%> 
   	<script>
 	  	alert("레시피 등록 실패");
   		history.back();
   	</script>
<%} else { %>
	<script>
		alert("레시피 등록 성공");
		location.href = "index.jsp";
	</script>
<% } %>

