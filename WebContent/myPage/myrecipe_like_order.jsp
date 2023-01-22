<%@page import="java.util.List"%>
<%@page import="teamProject2.*"%>
<%@page import="com.cook.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%
request.setCharacterEncoding("utf-8");
HttpSession session = request.getSession();
String userId = (String)session.getAttribute("userId");

List<Recipe> viewList = null; 
if (request.getAttribute("myLikeRecList")!=null) { //내가 좋아요 누른 레시피 
	viewList = (List<Recipe>)request.getAttribute("myLikeRecList");
}

String[] order_name = {"최신순","오래된순","조회순","좋아요순"};
int order = 0;
if (request.getAttribute("order") != null) {
	order = (Integer)request.getAttribute("order");
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <style>
  	table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
    	text-align: center;
	}
	table {
		width: 100%;
	}
	label{
	font-size: 30px;
	}
  </style>
</head>

<body>
	  	<div style="height:20px"></div>
	  		<h1>좋아요한 레시피</h1>
	  		<hr> 
	  		<label>정렬하기</label>
	  		<form id="orderform" name="orderform">
	  			<input type="hidden" name="like_id" value="<%=userId%>">
	    		<select onchange="orderlist()" name="order"> 
		 	 	<%for(int i = 0; i < order_name.length; i++) { 
	    			if (i == order) {  %> 
	       				<option value="<%=i%>" selected><%=order_name[i]%></option> 
	         		<% } else { %>
	    				<option value="<%=i%>"><%=order_name[i]%> </option>  	
	    			<%} 
	      		 } %>
	      	 	</select>
      		</form>	
      	
      		<br>
		  	<table>
			<tr>
				<th>게시글 번호</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>조회수</th>
				<th>좋아요수</th>
				<th>카테고리</th>
				<th>등록일</th>
			</tr>
			<%
			if (viewList != null) {
				for (Recipe recipe : viewList) {
			%>
			<tr>
				<td><%=recipe.getRec_num()%></td>
				<td><a href="myRecipeView.do?rec_num=<%=recipe.getRec_num()%>&prePage=mylike"><%=recipe.getRec_title()%></a></td>
				<td><%=recipe.getUser_id()%></td>
				<td><%=recipe.getRec_views()%></td>
				<td><%=recipe.getRec_likes()%></td>
				<td><%=recipe.getRec_category()%></td>
				<td><%=recipe.getRec_date()%></td>
			</tr>
			<%
				}
			} 
			%>
</body>
</html>
