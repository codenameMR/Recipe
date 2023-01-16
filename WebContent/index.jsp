<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%
// 	String contentPage = request.getParameter("contentPage");
// 	if (contentPage == null)
// 		contentPage = "firstView.jsp";
 %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Shop Homepage - Start Bootstrap Template</title>

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
          <a href="#" class="list-group-item" id="recipe_board">레시피 게시판</a>
          <a href="#" class="list-group-item">맛집 게시판</a>
          <a href="#" class="list-group-item">게시판3</a>
           <a href="#" class="list-group-item">게시판4</a>
            <a href="#" class="list-group-item">게시판5</a>
        </div>
      </div> <!-- /.col-lg-3 왼쪽(게시판) 끝-->

      <div class="col-lg-9" id ="center_right"> <!-- 오른쪽 (내용) -->
	  </div> <!-- /.col-lg-9 오른쪽(내용) 끝--> 	
      
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
		$('#recipe_board').click(function() {
			$.ajax({
				url : 'recipelist.do',
				type : 'get',
				success : function(data) {
 					console.log(data);
					$('#center_right').html(data);
				}
			});
		});
		
		$('.home').click(function() {
			$('#center_right').empty();
		})
				
		$(document).on("click","#writeBtn", function() {
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
		
		$(document).on("click","#tolistBtn", function() {
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
		
		//ajax로 불러온 도큐먼트 이벤트 설정하는 방법
//  		$(document).on("click","#view", function(){
// 			$('#center_right').empty();
			
// 			$.ajax({
// 				url : 'recipeView.do?rec_num='+rec_num
// 				type : 'get',
// 				success : function(data) {
// 					console.log(data);
// 					$('#center_right').html(data);
// 				}
// 			});
			
// 		}); 
		
		//정렬
		function orderlist() {
			var o = document.orderform;
			console.log(o.num.value);
			if (o.num.value === ""){ //공란이면
				alert("옵션을 선택해주세요.")
			} else {
				$.ajax({
	 				url : 'recipelist.do?num='+o.num.value,
	  				success : function(data) {
 					$('#center_right').html(data);
  					}
  				});
			}
		}
	
		//검색
		$(document).on("click","#searchBtn", function() {
			//$('#center_right').empty();
			$.ajax({
				url : 'recipeSerch.do',
				type : 'post',
				success : function(data) {
 					console.log(data);
					$('#center_right').html(data);
				}
			});
		})
 		
 	</script>

	
</html>