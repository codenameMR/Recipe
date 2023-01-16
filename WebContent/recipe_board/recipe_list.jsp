<%@page import="com.cook.model.RecipeDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
List<Recipe> recipeList = (List<Recipe>) request.getAttribute("recipeList");
//Object에서 List<Recipe>로 타입변환
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>전체 레시피 목록</title>
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
    	text-align: center;
}
table {
	width: 100%;
}
</style>
</head>

<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<h1>전체 레시피 목록</h1>
    <hr><br>
    <label>정렬하기</label>
    <form action="recipelist.do" name="orderform">
    <select onchange="orderlist()" name="num" >  <!--order(option의 value) -->
		<option value="0">최신순</option>
		<option value="1">오래된 순</option>
		<option value="2">조회순</option>
		<option value="3">좋아요순</option>
	</select>
	</form>
	<div style="height:20px;"></div>
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
		if (recipeList != null) {
			for (Recipe recipe : recipeList) {
		%>
		<tr>
			<td><%=recipe.getRec_num()%></td>
			<td><a href="javascript:void(0)" onclick="view(<%=recipe.getRec_num()%>)"><%=recipe.getRec_title()%></a></td>
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
	</table>
	<br>
	<button id="writeBtn">글쓰기</button>	
	<br>
	
	<div style="height:10px"></div>
	
	<form name="searchform" id="searchform">
	<% if(request.getAttribute("search_word") == null) { %>
	<input type=text placeholder="검색어 입력" name="search_word" required>
	<% } else {
		String search_word = (String) request.getAttribute("search_word"); %>
	<input type=text placeholder="<%=search_word%>" name="search_word" required>	
	<% } %>
	<select name="search_class" >  <!--order(option의 value) -->
		<option value="rec_title">글제목</option>
		<option value="user_id">글쓴이</option>
		<option value="rec_content">글내용</option>
		<option value="rec_category">카테고리</option>
	</select>
	<input type="button" value="검색하기" onClick="searchRec()">
	</form>
</body>

<script type="text/javascript">
</script>


</html>



