<%@page import="com.cook.model.RecipeDAO"%>
<%@page import="teamProject2.RecLike"%>
<%@page import="teamProject2.LikeDao"%>
<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
Recipe recipe = (Recipe) request.getAttribute("recipe");
String login_id = "";
if (session.getAttribute("userId") != null) {
login_id = (String)session.getAttribute("userId");
}

if (recipe == null ) {
%>
<script>
	alert("해당 정보가 삭제되었거나 존재하지 않습니다.");
</script>
<%
	return; //if 문 아래 소스코드 실행 x.
}
%>

<%	String writer_id = recipe.getUser_id();

	int rec_num = recipe.getRec_num();
	String rec_title = recipe.getRec_title();
	String rec_content = recipe.getRec_content();
	String rec_date = recipe.getRec_date();
	int rec_views = recipe.getRec_views();
	int rec_likes = recipe.getRec_likes();
	String rec_category = recipe.getRec_category();
	
	String rec_pic1 = "";
	String rec_pic2 = "";
	String rec_pic3 = "";
	if (recipe.getRec_pic1() != null)
	rec_pic1 = recipe.getRec_pic1().substring(14);
	if (recipe.getRec_pic2() != null)
	rec_pic2 = recipe.getRec_pic2().substring(14);
	if (recipe.getRec_pic3() != null)
	rec_pic3 = recipe.getRec_pic3().substring(14);
	
	//login_id와 rec_num을 좋아요 db에서 검색 
	//결과가 null이면, 좋아요 버튼 보이기->좋아요버튼에서는 likedao에 좋아요 db추가 실행
	//결과가 있으면, 좋아요취소 버튼 보이기->취소버튼에서는 likedao에서 좋아요 db삭제 실행
	RecLike existingRecLike = LikeDao.getInstance().searchRecLike(login_id, rec_num);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>레시피 글 상세 보기</title>
<style>
.imgView img{
	width:100px; 
	height:100px;
}
</style>
</head>
<body>
	<h1>레시피 제목 : <%=rec_title%></h1>
	<hr>
	<strong>종류 : </strong> <%=rec_category%><br>
	<strong>글쓴이 : </strong> <%=writer_id%><br>
	<strong>내용 : </strong> <%=rec_content%><br>
	<strong>조회수 : </strong> <%=rec_views%><br>
	<strong>좋아요수 : </strong> <label id=likeNum> <%=rec_likes%> </label><br>
	<strong>등록일 :</strong> <%=rec_date%><!-- <br><br> -->
	<div class=imgView> 
		<%if(rec_pic1 != "") {%>
		<img src="/projectCook1/rec_pic/<%=rec_pic1%>" alt="게시글 <%=rec_num%>의 picture1">
		<%} if(rec_pic2 != "") {%>
		<img src="/projectCook1/rec_pic/<%=rec_pic2%>" alt="게시글 <%=rec_num%>의 picture2">
		<%} if(rec_pic3 != "") {%>
		<img src="/projectCook1/rec_pic/<%=rec_pic3%>" alt="게시글  <%=rec_num%>의 picture3">
		<%} %>
	</div>
	
	
	<form action="recipeWriteOk.do" method="post" enctype="multipart/form-data">
	<br><hr><br>
	<button type="button" id="tolistBtn">목록으로</button>
	<% if ( login_id.equals(writer_id) ) { %>
		<button type="button" onClick="updateRec(<%=rec_num%>)">수정하기</button>
		<button type="button" onClick="deleteRec(<%=rec_num%>)">삭제하기</button>
	<%} else {%>
		<button type="button" disabled>수정하기</button>
		<button type="button" disabled>삭제하기</button>
	<%} %>
	</form>
	<button type="button" id="writeBtn">신규등록</button>
	
	<div id="likeBtn">
	<%if(login_id == "") {%>
		<button type="button" disabled>좋아요</button>
	<% } else if(existingRecLike == null) {%>
		<form id=likeform>
			<input type="hidden" name="rec_num" value="<%=rec_num%>">
			<button type="button" onClick="like()">좋아요</button>
		</form>	
    <%} else if(existingRecLike != null ){ %>
   	 	<form id=cancelLikeform>
   		 	<input type="hidden" name="rec_num" value="<%=rec_num%>">
   	 		<button type="button" onClick="cancelLike()">좋아요 취소</button>
   		</form>
    <% } %>
    </div>
    
</body>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script type="text/javascript">
		function like() {
			let likeData = $("#likeform").serialize();
			$('#likeNum').empty();
				$.ajax({
					url : 'recipe_board/rec_like.jsp',
					type : 'POST',
					data : likeData,
					success : function(data) {
						console.log(data);
						$('#likeBtn').empty();
						$('#likeBtn').html(`<form id=cancelLikeform>
								<input type="hidden" name="rec_num" value="<%=rec_num%>">
					   	 		<button type="button" onClick="cancelLike()">좋아요 취소</button>
					   		</form>`);
						$('#likeNum').html(data);
						
					}
				});
			}
		
		function cancelLike() {
			let likeData = $("#cancelLikeform").serialize();
			$('#likeNum').empty();
				$.ajax({
					url : 'recipe_board/rec_cancel_like.jsp',
					type : 'POST',
					data : likeData,
					success : function(data) {
						console.log(data);
						$('#likeBtn').empty();
						$('#likeBtn').html(`<form id=likeform>
								<input type="hidden" name="rec_num" value="<%=rec_num%>">
								<button type="button" onClick="like()">좋아요</button>
							</form>`);
						$('#likeNum').html(data);
					}
				});
			}
	  
// 		  $('#like').on("click", function() {
<%-- 				<% --%>
// 				RecLike newRecLike = new RecLike(login_id, rec_num);
// 				int resultLike = LikeDao.getInstance().InsertRec(newRecLike);
// 				RecipeDAO.getInstance().likeRec(recipe);
// 				if (resultLike>0) {
<%-- 				%>  --%>
// 					alert("좋아요 성공");
// 					window.location.href="index.jsp";
<%-- 				<%}else {%> --%>
// 					alert("좋아요 실패");
<%-- 				<%}%> --%>
// 		    });
	  
	  <%-- $('#cancelLike').on("click", function() {
		  <%
			if(existingRecLike != null) {
			int resultCancelLike = LikeDao.getInstance().DeleteRec(existingRecLike);
			int result = RecipeDAO.getInstance().minusLikeRec(recipe);
			System.out.println(result);
				if (resultCancelLike>0 ) {
			%> 
			alert("좋아요 취소 성공");
			window.location.href="index.jsp";
				<%}else {%>
			alert("좋아요 취소 실패");
				<%}
 			}%>
	    });
	 --%>

	</script>
</html>