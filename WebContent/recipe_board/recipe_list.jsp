<%@page import="com.cook.model.RecipeDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
List<Recipe> recipeList = (List<Recipe>) request.getAttribute("recipeList");
//Object에서 List<Recipe>로 타입변환

String[] rec_class = {"최신순","오래된순","조회순","좋아요순"};
int order = 0;
if (request.getAttribute("order") != null) {
	order = (Integer) request.getAttribute("order");
}

String search_word = "";
if(request.getAttribute("search_word") != null) {
search_word = (String) request.getAttribute("search_word");
}

String search_class = "";
if(request.getAttribute("search_class") != null) {
search_class = (String) request.getAttribute("search_class");
}
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
    <%if (search_word=="" || search_class=="") {%> 
    	<form name="orderform">
    		<select onchange="orderlist()" name="num" > 
	 	 	<%for(int i = 0; i < rec_class.length; i++) { 
    			if (i == order) {  %> 
       				<option value="<%=i%>" selected><%=rec_class[i]%></option> 
         		<% } else { %>
    				<option value="<%=i%>" > <%=rec_class[i]%> </option>  	
    			<%} 
      		 } %>
      	 	</select>
      	 </form>
    <%} else if (search_word!="" && search_class!="") { %>
    	<form name="orderform2" id="orderform2">
    		<input type="hidden" name="search_word" value=<%=search_word%>>
     		<input type="hidden" name="search_class" value=<%=search_class%>>
    		<select onchange="orderlist2()" name="num"> 
	 		<%for(int i = 0; i < rec_class.length; i++) { 
    			if (i == order) {  %> 
       				<option value="<%=i%>" selected><%=rec_class[i]%></option> 
         		<% } else { %>
    				<option value="<%=i%>" > <%=rec_class[i]%> </option>  	
    			<%}
     		}%>
     		</select>	
		</form>
    <%} %>  
		
	
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
	<%if(session.getAttribute("userId")==null) {%>
		<button id="writeBtn" disabled>글쓰기</button>	
	<%} else { %>
		<button id="writeBtn">글쓰기</button>	
	<%} %>
	<br>
	
	<div style="height:10px"></div>
	
	<form name="searchform" id="searchform">
	<% if(search_word == "") { %>
		<input type=text placeholder="검색어 입력" name="search_word" required>
	<% } else { %>
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



