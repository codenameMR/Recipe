   <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Page Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
      .background {
        position: fixed; 
        top: 0;
        left: 0;
        width: 100%;
        height: 100vh;
        background-color: rgba(0, 0, 0, 0.3);
        z-index: 1000;

        /* 숨기기 */
        z-index: -1;
        opacity: 0;
      }

      .show{
        opacity: 1;
        z-index: 1000;
        transition: all 0.5s;
      }

      .window {
        position: relative;
        width: 100%;
        height: 100%;
      }

      .popup {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-20%, -20%);
        background-color: #ffffff;
        box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);

        /* 임시 지정 */
        width: 100px;
        height: 100px;

        /* 초기에 약간 아래에 배치 */
        transform: translate(-10%, -10%);
      }

      .show .popup {
        transform: translate(-80%, -80%);
        transition: all 0.5s;
      }
      
      #close {
      position : absolute;
      }
    </style>
  </head>
  <body>
  <h1>sdaffafafafs</h1>
    <button id="show">팝업열기</button>
    <div class="background">
      <div class="window">
        <div class="popup">
          <button id="close">팝업닫기</button>
        </div>
        <div class="a">
          <div></div>
        </div>
      </div>
    </div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	
    <script>
      function show() {
        document.querySelector(".background").className = "background show";
      }

      function close() {
        document.querySelector(".background").className = "background";
      }

      document.querySelector("#show").addEventListener("click", show);
      document.querySelector("#close").addEventListener("click", close);
      
    
      $.ajax({
          url : './signUpNIn.jsp',
          success : function(data) {
              $('.a').html(data);
          }
      });
	</script>
	</body>
</html>