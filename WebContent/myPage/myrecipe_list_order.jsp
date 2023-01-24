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
if(request.getAttribute("myRecipeList")!=null) { //내가 쓴 레시피 
	viewList = (List<Recipe>)request.getAttribute("myRecipeList");
} 
String[] order_name = {"최신순","오래된순","조회순","좋아요순"};
int order = 0;
if (request.getAttribute("order") != null) {
	order = (Integer)request.getAttribute("order");
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
	  	<div style="height:20px"></div>
	  		<h1>내가 쓴 레시피</h1>
	  		<hr> <br>
	  		<div class="d-flex justify-content-end"> 
			   	<label>정렬하기&nbsp;&nbsp;</label>
		  		<form id="orderform" name="orderform">
		  			<input type="hidden" name="writer_id" value="<%=userId%>">
		    		<select onchange="orderlist()" name="order"> 
			 	 	<%for(int i = 0; i < order_name.length; i++) { 
		    			if (i == order) {  %> 
		       				<option value="<%=i%>" selected><%=order_name[i]%></option> 
		         		<% } else { %>
		    				<option value="<%=i%>" ><%=order_name[i]%> </option>  	
		    			<%} 
		      		 } %>
		      	 	</select>
	      		</form>	
      		</div>
      		
      		<br>
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
						<!-- <th scope="col">게시글 번호</th> -->
						<th scope="col">제목</th>
						<th scope="col">글쓴이</th>
						<th scope="col">조회수</th>
						<th scope="col">좋아요수</th>
						<th scope="col">카테고리</th>
						<th scope="col">등록일</th>
					</tr>
				</thead>
				<%
				if (viewList != null) {
					for (Recipe recipe : viewList) {
				%>
				<tbody>
				<tr>
					<%-- <td><%=recipe.getRec_num()%></td> --%>
					<td><a href="myRecipeView.do?rec_num=<%=recipe.getRec_num()%>&prePage=myrecipe"><%=recipe.getRec_title()%></a></td>
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
		 	 <% } %>
				</tbody>
			</table>
			
			<nav aria-label="Page navigation">
			  <ul class="pagination justify-content-center my">
			      <% if (startPage == 1) {%>
				      <li class="page-item disabled"><a class="page-link" href="#"
				          tabindex="-1" aria-disabled="true">Previous</a></li>
			      <% } else {%>
				      <li class="page-item"><a class="page-link my" href="javascript:goPage('<%=userId%>','<%=order%>','<%=startPage - 1%>')"
				          tabindex="-1"
				          aria-disabled="true">Previous</a></li>
			      <% }%>
			      
			      <% for (int i = startPage; i <= endPage; i++) {%>
				      <%if (tempPage == i) { %>
					      <li class="page-item active">
						      <a class="page-link" href="javascript:goPage('<%=userId%>','<%=order%>','<%=i%>')"
						      ><%=i%></a>
						  </li>
				      <%} else { %>
					      <li class="page-item">
						      <a class="page-link my" href="javascript:goPage('<%=userId%>','<%=order%>','<%=i%>')"
						      ><%=i%></a>
						  </li>
				      <%} 
			       } %>
			      
			      <%  // 마지막 페이지 숫자와 startPage에서 pageLength 더해준 값이 일치할 때
			          // (즉 마지막 페이지 블럭일 때)
			          if (totalPages == endPage) {
			      %>
			      	<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
			      <% } else { %>
				  	 <li class="page-item">
				    	<a class="page-link my" 
				    	href="javascript:goPage('<%=userId%>','<%=order%>','<%=endPage + 1%>')">Next</a>
				    </li>
			     <% } %>
			  </ul>
			</nav>				
</body>
</html>
