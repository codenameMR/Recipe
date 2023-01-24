<%@page import="com.cook.model.RecipeDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
List<Recipe> recipeList = (List<Recipe>) request.getAttribute("recipeList");
//Object에서 List<Recipe>로 타입변환

//정렬기능
String[] rec_class = {"최신순","오래된순","조회순","좋아요순"};
int order = 0;
if (request.getAttribute("order") != null) {
	order = (Integer) request.getAttribute("order");
}
//검색기능
String search_word = "";
if(request.getAttribute("search_word") != null) {
search_word = (String) request.getAttribute("search_word");
}

String[] search_classes = {"글제목","글쓴이","글내용","카테고리"};
String[] search_values = {"rec_title","user_id","rec_content","rec_category"};
String search_class = "";
if(request.getAttribute("search_class") != null) {
search_class = (String) request.getAttribute("search_class");
}

//페이징 처리 
int startPage = (Integer)request.getAttribute("startPage");
int endPage = (Integer)request.getAttribute("endPage");
int totalPages = (Integer)request.getAttribute("totalPages");
int tempPage = 1;
if (request.getAttribute("tempPage")!=null) {
	tempPage = (Integer)request.getAttribute("tempPage");
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
table a {
 color:orangered;
}
.my.page-link {
	color:coral;
}
.my.pagination > .active > a, 
.my.pagination > .active > span, 
.my.pagination > .active > a:hover, 
.my.pagination > .active > span:hover, 
.my.pagination > .active > a:focus, 
.my.pagination > .active > span:focus {
  background: coral;
  border-color: coral;
}
</style>
</head>

<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<div style="height:20px"></div>
	<h1>전체 레시피 목록</h1>
    <hr> <br>
    <div class="d-flex justify-content-end"> 
	<label>정렬하기&nbsp;&nbsp;</label>
    <%if (search_word=="" || search_class=="") {%> 
    	<form name="orderform">
    		<select onchange="orderlist()" name="order" > 
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
    		<select onchange="orderlist2()" name="order"> 
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
	</div>	
	
	<div style="height:20px;"></div>
	<table class="table">
		<colgroup>
			<!-- <col width="5%"> -->
			<col width="45%">
			<col width="12%">
			<col width="7%">
			<col width="7%">
			<col width="7%">
			<col width="18%">
		</colgroup>	
		<thead class="thead-light">
			<tr>
				<!-- <th>게시글 번호</th> -->
				<th>제목</th>
				<th>글쓴이</th>
				<th>조회수</th>
				<th>좋아요수</th>
				<th>카테고리</th>
				<th>등록일</th>
			</tr>
		</thead>
		<%
		if (recipeList != null) {
			for (Recipe recipe : recipeList) {
		%>
		<tbody>
			<tr>
				<%-- <td><%=recipe.getRec_num()%></td> --%>
				<td><a href="recipeView.do?rec_num=<%=recipe.getRec_num()%>"><%=recipe.getRec_title()%></a></td>
				<td><%=recipe.getUser_id()%></td>
				<td><%=recipe.getRec_views()%></td>
				<td><%=recipe.getRec_likes()%></td>
				<td><%=recipe.getRec_category()%></td>
				<td><%=recipe.getRec_date()%></td>
			</tr>
		<%
			}
		} else {
		%>
		<tr><td colspan="6">데이터가 존재하지 않습니다.</td></tr>
		<%} %>
		</tbody>
	</table>
	
	<br>
	<%if(session.getAttribute("userId")==null) {%>
		<button type="button" onclick="signin()">글쓰기</button>	
	<%} else { %>
		<button type="button" onclick="location.href='recipeWrite.do'">글쓰기</button>	
	<%} %>
	<br>
	
	<nav aria-label="Page navigation">
	  <ul class="pagination justify-content-center my">
	      <% if (startPage == 1) {%>
		      <li class="page-item disabled"><a class="page-link" href="#"
		          tabindex="-1" aria-disabled="true">Previous</a></li>
	      <% } else {%>
		      <li class="page-item"><a class="page-link my" href="javascript:goPage('<%=search_class%>','<%=search_word%>','<%=order%>','<%=startPage - 1%>')"
		          tabindex="-1"
		          aria-disabled="true">Previous</a></li>
	      <% }%>
	      
	      <% for (int i = startPage; i <= endPage; i++) {%>
		      <%if (tempPage == i) { %>
			      <li class="page-item active">
				      <a class="page-link" href="javascript:goPage('<%=search_class%>','<%=search_word%>','<%=order%>','<%=i%>')"
				      ><%=i%></a>
				  </li>
		      <%} else { %>
			      <li class="page-item">
				      <a class="page-link my" href="javascript:goPage('<%=search_class%>','<%=search_word%>','<%=order%>','<%=i%>')"
				      ><%=i%></a>
				  </li>
		      <%} 
	       }%>
	      
	      <%  // 마지막 페이지 숫자와 startPage에서 pageLength 더해준 값이 일치할 때
	          // (즉 마지막 페이지 블럭일 때)
	          if (totalPages == endPage) {
	      %>
	      	<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
	      <% } else {%>
		  	<li class="page-item">
		    	<a class="page-link my" 
		    	href="javascript:goPage('<%=search_class%>','<%=search_word%>','<%=order%>','<%=endPage + 1%>')">Next</a>
		    </li>
	      <% }%>
	  </ul>
	</nav>	
	
	<!-- 검색 -->
	<div style="height:10px"></div>
	<div class="d-flex justify-content-center">
		<form name="searchform" id="searchform">
		<% if(search_word == "") { %>
			<input type=text placeholder="검색어 입력" name="search_word" required>
		<% } else { %>
			<input type=text placeholder="<%=search_word%>" name="search_word" required>	
		<% } %>
		<select name="search_class" >  <!--order(option의 value) -->
			<% for (int i=0; i<4; i++) { 
				if (search_class.equals(search_values[i])) {
			%>
			<option value="<%=search_values[i]%>" selected><%=search_classes[i]%></option>
			<%  } else { %>
			<option value="<%=search_values[i]%>"><%=search_classes[i]%></option>
			<%  } 
			} %>	
		</select>
		<input type="button" value="검색하기" onClick="searchRec()">
		</form>
	</div> 
	<!-- 검색 끝 -->
</body>

<script type="text/javascript">
function signin() {
	alert.("로그인이 필요한 기능입니다");
}
</script>


</html>



