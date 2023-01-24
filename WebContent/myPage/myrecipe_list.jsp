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
	order = (Integer) request.getAttribute("order");
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
  <title>레시피공유-마이페이지</title>
	
  <!-- Bootstrap core CSS -->
  <link href="/recipeteamPJ/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom styles for this template -->
  <link href="/recipeteamPJ/css/shop-homepage.css" rel="stylesheet">
  
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

<body style="padding-top: 0px;">
  <!-- 상단 Navigation -->
  <jsp:include page="../header.jsp" />

  <!-- 중앙 Page Content -->
  <div class="container" id="center" style="height:1500px; padding-top:10px;">
    <div class="row"> <!-- 왼쪽(게시판)과 오른쪽(내용) 정렬 -->
	
      <div class="col-lg-3"> <!-- 왼쪽 (게시판) -->
         <jsp:include page="../board.jsp" />
      </div> <!-- /.col-lg-3 왼쪽(게시판) 끝-->
      
	  <div class="col-lg-9" id ="center_right"> <!-- 오른쪽(내용) --> 
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
					<td>
						<a href="myRecipeView.do?rec_num=<%=recipe.getRec_num()%>&prePage=myrecipe"><%=recipe.getRec_title()%></a>
					</td>
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
			
			<!-- 페이지 -->
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
			      <% } else {%>
				  	<li class="page-item">
				    	<a class="page-link my" 
				    	href="javascript:goPage('<%=userId%>','<%=order%>','<%=endPage + 1%>')">Next</a>
				    </li>
			      <% }%>
			  </ul>
			</nav>			
			
	  </div> <!--/.col-lg-9 오른쪽(내용) 끝--> 	
     </div> <!-- /.row 왼쪽,오른쪽 정렬 끝--> 
       
  </div>
  <!-- /.container 중앙 끝 -->

  <!-- Bootstrap core JavaScript -->
  <script src="/recipeteamPJ/vendor/jquery/jquery.min.js"></script>
  <script src="/recipeteamPJ/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
//정렬하기
function orderlist() {
	var formData = $("#orderform").serialize();
	//console.log(formData1);
	$.ajax({
		url : 'myRecipeListOrder.do',
		type : 'POST',
		data : formData,
		success : function(data) {
			$('#center_right').html(data);
		}
	});
}

function goPage(userId, order, tempPage){
    let pageForm = document.createElement('form');
    
    let obj_order;
    obj_order = document.createElement('input');
    obj_order.setAttribute('type', 'hidden');
    obj_order.setAttribute('name', 'order');
    obj_order.setAttribute('value', order);
    
    let obj_page;
    obj_page = document.createElement('input');
    obj_page.setAttribute('type', 'hidden');
    obj_page.setAttribute('name', 'tempPage');
    obj_page.setAttribute('value', tempPage);
    
    let obj_id;
    obj_id = document.createElement('input');
    obj_id.setAttribute('type', 'hidden');
    obj_id.setAttribute('name', 'writer_id');
    obj_id.setAttribute('value', userId);
    
    pageForm.appendChild(obj_order);
    pageForm.appendChild(obj_page);
    pageForm.appendChild(obj_id);
    
    pageForm.setAttribute('method', 'post');
    pageForm.setAttribute('action', 'myRecipeList.do');
    document.body.appendChild(pageForm);
    pageForm.submit();
}
</script>
</html>
