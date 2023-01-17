<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%
request.setCharacterEncoding("utf-8");

int delResult = 0;
if (request.getAttribute("delResult") != null) {
	delResult = (Integer)request.getAttribute("delResult");
}

int insertResult = 0;
if (request.getAttribute("insertResult") != null) {
insertResult = (Integer)request.getAttribute("insertResult");
}

int updateResult = 0;
if (request.getAttribute("updateResult") != null) {
updateResult = (Integer)request.getAttribute("updateResult");
}
//Recipe recipe = (Recipe)request.getAttribute("recipe");
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
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom styles for this template -->
  <link href="css/shop-homepage.css" rel="stylesheet">
</head>

<body>
  <!-- 상단 Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <jsp:include page="header.jsp" />
  </nav>

  <!-- 중앙 Page Content -->
  <div class="container" id="center" style="height:1200px">
    <div class="row"> <!-- 왼쪽(게시판)과 오른쪽(내용) 정렬 -->

      <div class="col-lg-3"> <!-- 왼쪽 (게시판) -->
        <h1 class="my-4">게시판</h1>
        <div class="list-group">
          <a href="javascript:void(0)" class="list-group-item" id="recipe_board">레시피 게시판</a>
          <a href="#" class="list-group-item">맛집 게시판</a>
          <a href="#" class="list-group-item">게시판3</a>
           <a href="#" class="list-group-item">게시판4</a>
            <a href="#" class="list-group-item">게시판5</a>
        </div>
      </div> <!-- /.col-lg-3 왼쪽(게시판) 끝-->
	  <div class="col-lg-9" id ="center_right"> <!-- 오른쪽(내용) --> 
 
	  </div> <!--/.col-lg-9 오른쪽(내용) 끝--> 	
      
     </div> <!-- /.row 왼쪽,오른쪽 정렬 끝--> 
       

  </div>
  <!-- /.container 중앙 끝 -->
	
  <!-- Footer 하단-->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Your Website 2019</p>
    </div>
    <!-- /.container 하단 끝 -->
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script type="text/javascript">
	//홈버튼 누르면 오른쪽 내용 비우기.
	$('.home').click(function() {
		$('#center_right').empty();
	})
	
	//---------------------recipe_board 관련 ajax-----------------------//
		//recipe_board 게시판
		$('#recipe_board').click(function() {
			$.ajax({
				url : 'recipelist.do',
				type : 'get',
				success : function(data) {
					//console.log(data);
					$('#center_right').html(data);
				}
			});
		});

		//레시피 게시판  정렬
		function orderlist() {
			var o = document.orderform;
			console.log("orderlist1")
			//console.log(o.num.value);
				$.ajax({
					url : 'recipelist.do?num=' + o.num.value,
					success : function(data) {
						$('#center_right').html(data);
					}
				});
		}

		//레시피 게시판 검색 (post)
		function searchRec() {
			//let sendData = "username="+$('input[name=username]').val();   //폼의 이름 값을 변수 안에 담아줌
			let formData = $("#searchform").serialize();
			//console.log(formData);
				$.ajax({
					url : 'recipelist.do',
					type : 'POST',
					data : formData,
					success : function(data) {
						$('#center_right').html(data);
					}
				});
			}
		//레시피 게시판 검색후 정렬
		function orderlist2() {
			let formData2 = $("#orderform2").serialize();
			//console.log("orderlist2");
			//console.log(formData2);
			$.ajax({
				url : 'recipelist.do',
				type : 'POST',
				data : formData2,
				success : function(data) {
					$('#center_right').html(data);
				}
			});
		}
	
		//목록으로
		$(document).on("click", "#tolistBtn", function() {
			//$('#center_right').empty();
			$.ajax({
				url : 'recipelist.do',
				type : 'get',
				success : function(data) {
					console.log(data);
					$('#center_right').html(data);
				}
			});
		})
		
		//글쓰기(wirteform.jsp)
		$(document).on("click", "#writeBtn", function() {
			//$('#center_right').empty();
			$.ajax({
				url : 'recipeWrite.do',
				type : 'get',
				success : function(data) {
					console.log(data);
					$('#center_right').html(data);
				}
			});

		})
		
 		//글쓰기(wirteform.jsp)
		function writeRec() {
			let formData = $("#searchform").serialize();
			console.log(formData);
				$.ajax({
					url : 'recipeWrite.do',
					type : 'POST',
					data : formData,
					success : function(data) {
						$('#center_right').html(data);
					}
				});
			}

		//레시피 글 1개(view.jsp) 보기  
		function view(rec_num) {
			$.ajax({
				url : 'recipeView.do?rec_num=' + rec_num,
				type : 'get',
				success : function(data) {
					console.log(data);
					$('#center_right').html(data);
				}
			})
		}
		//레시피 글(view)> 해당 글 수정하기
		function updateRec(rec_num) {
			$.ajax({
				url : 'recipeUpdate.do?rec_num=' + rec_num,
				type : 'get',
				success : function(data) {
					console.log(data);
					$('#center_right').html(data);
				}
			})
		}
		//레시피 글(view)> 해당 글 삭제하기
		function deleteRec(rec_num) {
			let del = confirm("해당 글을 삭제하시겠습니까?");
			if (del) {
				$.ajax({
					url : 'recipeDeleteOk.do?rec_num=' + rec_num,
					type : 'get',
					success : function(data) {
						console.log(data);
						$('#center_right').html(data);
					}
				})
			
			}
		}
		
	</script>
	<!-- 레시피 게시글 삭제  -->
	<% if (request.getAttribute("delResult")!=null && delResult == 0){ %>
		<script>	
			alert("삭제 실패");
		</script>	
	<% } else if (request.getAttribute("delResult")!=null && delResult > 0){ %>
		<script>
			alert("삭제 성공");
			$.ajax({
				url : 'recipelist.do',
				type : 'get',
				success : function(data) {
					console.log(data);
					$('#center_right').html(data);
				}
			});
		</script>	
	<% } %>
		<!-- 레시피 게시글 등록  -->
	<% if (request.getAttribute("insertResult")!=null && insertResult == 0){ %>
		<script>	
			alert("레시피 게시글 등록 실패");
		</script>	
	<% } else if (request.getAttribute("insertResult")!=null && insertResult > 0){ %>
		<script>
			alert("레시피 게시글 등록 성공");
			$.ajax({
				url : 'recipelist.do',
				type : 'get',
				success : function(data) {
					console.log(data);
					$('#center_right').html(data);
				}
			});
		</script>	
	<% } %>
			<!-- 레시피 게시글 수정  -->
	<% if (request.getAttribute("updateResult")!=null && updateResult == 0){ %>
		<script>	
			alert("레시피 게시글 수정 실패");
		</script>	
	<% } else if (request.getAttribute("updateResult")!=null && updateResult > 0){ %>
		<script>
			alert("레시피 게시글 수정 성공");
			$.ajax({
				url : 'recipelist.do',
				type : 'get',
				success : function(data) {
					console.log(data);
					$('#center_right').html(data);
				}
			});
		</script>	
	<% } %>
	
</html>
