<%@page import="teamProject2.LikeDao"%>
<%@page import="com.cook.model.RecipeDAO"%>
<%@page import="teamProject2.RecLike"%>
<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%
request.setCharacterEncoding("utf-8");
Recipe recipe = (Recipe) request.getAttribute("recipe");

String login_id = "";
HttpSession session = request.getSession();
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
	String savePath = "D:/rec_storage";
	int length = savePath.length();
	if (recipe.getRec_pic1() != null)
	rec_pic1 = recipe.getRec_pic1().substring(length);
	if (recipe.getRec_pic2() != null)
	rec_pic2 = recipe.getRec_pic2().substring(length);
	if (recipe.getRec_pic3() != null)
	rec_pic3 = recipe.getRec_pic3().substring(length);
	
	//login_id와 rec_num을 좋아요 db에서 검색 
	//결과가 null이면, 좋아요 버튼 보이기->좋아요버튼에서는 likedao에 좋아요 db추가 실행
	//결과가 있으면, 좋아요취소 버튼 보이기->취소버튼에서는 likedao에서 좋아요 db삭제 실행
	RecLike existingRecLike = LikeDao.getInstance().searchRecLike(login_id, rec_num);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>레시피공유-레공</title>
	
  <!-- Bootstrap core CSS -->
  <link href="/recipeteamPJ/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom styles for this template -->
  <link href="/recipeteamPJ/css/shop-homepage.css" rel="stylesheet">
  <!--  [이미지 모달창 참조 ] https://lokeshdhakar.com/projects/lightbox2/#examples -->
  <link href="/recipeteamPJ/css/lightbox.css" rel="stylesheet" />
	<style>
	.imgView img {
		width: 100px;
		height: 100px;
		object-fit: cover;
	}
	#btn {
		border:none;
		background-color:white;
	}
	#btn:focus {
	 border:none;
	 outline:none;
	}
	#btn img {
		width: 30px;
		height: 30px;
	}
	</style>
</head>

<body style="padding-top: 0px; font-family: 'Noto Sans KR', sans-serif;">
  <!-- 상단 Navigation -->
  <jsp:include page="../header.jsp" />

  <!-- 중앙 Page Content -->
  <div class="container" id="center" style="height:1500px; padding-top:10px;">
    <div class="row"> <!-- 왼쪽(게시판)과 오른쪽(내용) 정렬 -->
	
      <div class="col-lg-3"> <!-- 왼쪽 (게시판) -->
        <jsp:include page="../board.jsp" />
      </div> <!-- /.col-lg-3 왼쪽(게시판) 끝-->
      
	  <div class="col-lg-9" id ="center_right"> <!-- 오른쪽(내용) -->
			<div style="height: 20px"></div>
			<h2> <%=rec_title%> </h2>
			<hr>
			<strong>종류 : </strong> <%=rec_category%><br>
			<strong>글쓴이 : </strong> <%=writer_id%><br>
			<strong>조회수 : </strong> <%=rec_views%><br> 
			<strong>등록일 :</strong> <%=rec_date%><br> 
			<strong>내용 : </strong> <%=rec_content%><br>
			<div style="height: 15px"></div>
			<div class=imgView>
				<% if (rec_pic1 != "") { %>
				<a href="/recipeteamPJ/rec_pic/<%=rec_pic1%>" data-lightbox="rec_pic">
				<img src="/recipeteamPJ/rec_pic/<%=rec_pic1%>" alt="게시글 <%=rec_num%>의 picture1" >
				</a>
				<% } if (rec_pic2 != "") { %>
				<a href="/recipeteamPJ/rec_pic/<%=rec_pic2%>" data-lightbox="rec_pic" >
				<img src="/recipeteamPJ/rec_pic/<%=rec_pic2%>"
					alt="게시글 <%=rec_num%>의 picture2"  >
				</a>
				<% } if (rec_pic3 != "") { %>
				<a href="/recipeteamPJ/rec_pic/<%=rec_pic3%>" data-lightbox="rec_pic" >
				<img src="/recipeteamPJ/rec_pic/<%=rec_pic3%>"
					alt="게시글  <%=rec_num%>의 picture3"  >
				<% } %>
				</a>
			</div>

			<hr>
			<strong>좋아요수 : </strong> <label id=likeNum> <%=rec_likes%></label><br>
			<div id="likeBtn">
				<%
					if (login_id.equals("")) {
						// 좋아요 버튼 안 보여준다.	
					} else if (!login_id.equals("") && existingRecLike == null) {
				%>
				<form id=likeform>
					<input type="hidden" name="rec_num" value="<%=rec_num%>">
					<button type="button" id="btn" onClick="like()">
						<img id="heart"
							src="https://cdn-icons-png.flaticon.com/512/812/812327.png"
							alt="좋아요">
					</button>
				</form>
				<%
					} else if (!login_id.equals("") && existingRecLike != null) {
				%>
				<form id=cancelLikeform>
					<input type="hidden" name="rec_num" value="<%=rec_num%>">
					<button type="button" id="btn" onClick="cancelLike()">
						<img id="heart"
							src="https://cdn-icons-png.flaticon.com/512/803/803087.png"
							alt="좋아요 취소">
					</button>
				</form>
				<%
					}
				%>
			</div>

			<hr>
			<form action="recipeBoard.do" style="display: inline">
				<button type="submit" onclick="location.href='recipeBoard.do'">목록으로</button>
			</form>

			<%
				if (login_id.equals(writer_id)) {
			%>
			<button type="button" onclick="location.href='recipeUpdate.do?rec_num=<%=rec_num%>'">수정하기</button>
			<button type="button" onclick="chkDelete(<%=rec_num%>)" style="display: inline">삭제하기</button>
			<%
				} else {
			%>
			<button type="button" disabled>수정하기</button>
			<button type="button" disabled>삭제하기</button>
			<%} %>

			<% if ( login_id.equals("") ) { %>
			<button type="button" onclick="signin()">글쓰기</button>
			<% } else { %>
			<button type="button" onclick="location.href='recipeWrite.do'">글쓰기</button>
			<% } %>
	   </div> <!--/.col-lg-9 오른쪽(내용) 끝--> 	
      
     </div> <!-- /.row 왼쪽,오른쪽 정렬 끝--> 
       
  </div>
  <!-- /.container 중앙 끝 -->
	
  <!-- Footer 하단-->
  <jsp:include page="../footer.jsp" />

  <!-- Bootstrap core JavaScript -->
  <script src="/recipeteamPJ/vendor/jquery/jquery.min.js"></script>
  <script src="/recipeteamPJ/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/recipeteamPJ/js/lightbox.js"></script>
  <script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>  
</body>
	<script type="text/javascript">
		function signin() {
			alert("로그인이 필요한 기능입니다");
		}
		
	    function chkDelete(rec_num) {
	    	let ok = confirm("해당 글을 삭제하시겠습니까?");
	        if (ok) {
	        	location.href = "recipeDelete.do?rec_num=" + rec_num;
	        }
	    }
		
		
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
							<button type="button"id="btn" onClick="cancelLike()">
			   	 			<img id="heart" src="https://cdn-icons-png.flaticon.com/512/803/803087.png" alt="좋아요">
				   	 		</button>
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
								<button type="button" id="btn" onClick="like()">
								<img id="heart" src="https://cdn-icons-png.flaticon.com/512/812/812327.png" alt="좋아요 취소">
								</button>
							</form>`);
						$('#likeNum').html(data);
					}
				});
			}
	</script>
</html>
