<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import
	url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css")
	;

* {
	box-sizing: border-box;
}

body {
	font-family: "Montserrat", sans-serif;
	margin: 0;
	padding: 0;
}

.wrapper {
	width: 100%;
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	background: #ebecf0;
	overflow: hidden;
}

.container {
	border-radius: 10px;
	box-shadow: -5px -5px 10px #fff, 5px 5px 10px #babebc;
	position: absolute;
	width: 768px;
	min-height: 480px;
	overflow: hidden;
}

form {
	background: #ebecf0;
	display: flex;
	flex-direction: column;
	padding: 0 50px;
	height: 100%;
	justify-content: center;
	align-items: center;
}

form input {
	background: #eee;
	padding: 16px;
	margin: 8px 0;
	width: 85%;
	border: 0;
	outline: none;
	border-radius: 20px;
	box-shadow: inset 7px 2px 10px #babebc, inset -5px -5px 12px #fff;
}

button {
	border-radius: 20px;
	border: none;
	outline: none;
	font-size: 12px;
	font-weight: bold;
	padding: 15px 45px;
	margin: 14px;
	letter-spacing: 1px;
	text-transform: uppercase;
	cursor: pointer;
	transition: transform 80ms ease-in;
}

.form_btn {
	box-shadow: -5px -5px 10px #fff, 5px 5px 8px #babebc;
}

.form_btn:active {
	box-shadow: inset 1px 1px 2px #babebc, inset -1px -1px 2px #fff;
}

.overlay_btn {
	background-color: #ff4b2b;
	color: #fff;
	box-shadow: -5px -5px 10px #ff6b3f, 5px 5px 8px #bf4b2b;
}

.sign-in-container {
	position: absolute;
	left: 0;
	width: 50%;
	height: 100%;
	transition: all 0.5s;
}

.sign-up-container {
	position: absolute;
	left: 0;
	width: 50%;
	height: 100%;
	opacity: 0;
	transition: all 0.5s;
}

.overlay-left {
	display: flex;
	flex-direction: column;
	padding: 0 50px;
	justify-content: center;
	align-items: center;
	position: absolute;
	right: 0;
	width: 50%;
	height: 100%;
	opacity: 0;
	background-color: #ff4b2b;
	color: #fff;
	transition: all 0.5s;
}

.overlay-right {
	display: flex;
	flex-direction: column;
	padding: 0 50px;
	justify-content: center;
	align-items: center;
	position: absolute;
	right: 0;
	width: 50%;
	height: 100%;
	background-color: #ff4b2b;
	color: #fff;
	transition: all 0.5s;
}

.container.right-panel-active .sign-in-container {
	transform: translateX(100%);
	opacity: 0;
}

.container.right-panel-active .sign-up-container {
	transform: translateX(100%);
	opacity: 1;
	z-index: 2;
}

.container.right-panel-active .overlay-right {
	transform: translateX(-100%);
	opacity: 0;
}

.container.right-panel-active .overlay-left {
	transform: translateX(-100%);
	opacity: 1;
	z-index: 2;
}

.social-links {
	margin: 20px 0;
}

form h1 {
	font-weight: bold;
	margin: 0;
	color: #000;
}

p {
	font-size: 16px;
	font-weight: bold;
	letter-spacing: 0.5px;
	margin: 20px 0 30px;
}

span {
	font-size: 12px;
	color: #000;
	letter-spacing: 0.5px;
	margin-bottom: 10px;
}

.social-links div {
	width: 40px;
	height: 40px;
	display: inline-flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	border-radius: 50%;
	box-shadow: -5px -5px 10px #fff, 5px 5px 8px #babebc;
	cursor: pointer;
}

.social-links a {
	color: #000;
}

.social-links div:active {
	box-shadow: inset 1px 1px 2px #babebc, inset -1px -1px 2px #fff;
}

.closebtn {
	display: inline;
	margin-right: 0;
	margin-left: 90%
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="container">
			<div class="sign-up-container">
				<form name="signUpForm" action="signUp.jsp" method="post"
					id="signUpForm">
					<h1>회원가입</h1>
					<div class="social-links"></div>
					<span></span> <input type="text" placeholder="이름" name="name"
						id="name"> <input type="text" placeholder="아이디"
						name="userId" id="userId"> <input type="password"
						placeholder="비밀번호" name="password" id="password"> <input
						type="submit" class="form_btn" name="SignUpBtn" value="회원가입">
				</form>
			</div>
			<div class="sign-in-container">
				<form action="signIn.jsp" method="post" id="signInForm">
					<h1>로그인</h1>
					<div class="social-links"></div>
					<span></span> <input type="text" placeholder="아이디" name="userId"
						id="userIdIn"> <input type="password" placeholder="비밀번호"
						name="password" id="passwordIn"> <input type="submit"
						class="form_btn" name="SignInBtn" value="로그인">
				</form>
			</div>
			<div class="overlay-container">
				<div class="overlay-left">
					<h1>
						돌아오신 것을<br> 환영합니다!
					</h1>
					<p>
						수 많은 회원들이<br>당신만의 레시피 공유를 기다립니다!
					</p>
					<button id="signIn" class="overlay_btn">로그인</button>
				</div>
				<div class="overlay-right">
					<h1>반가워요 :)</h1>
					<p>아직 회원이 아니신가요? 여기서 1분만에 가입을 완료해보세요!</p>
					<button id="signUp" class="overlay_btn">회원가입</button>
				</div>
			</div>
		</div>
	</div>
	<script>//나중에 로그인 안되면 바꿔보기
document.querySelector('#signUpForm').addEventListener('submit', function (e) {
	console.log("dsadas")
    if (document.querySelector('#userId').value == ''||document.querySelector('#password').value == ''||document.querySelector('#name').value == '') {
      e.preventDefault();
      alert('모든 정보를 입력 해주세요.');
    } 
  });
  
document.querySelector('#signInForm').addEventListener('submit', function (e) {
	console.log("dsadas")
    if (document.querySelector('#userIdIn').value == ''||document.querySelector('#passwordIn').value == '') {
      e.preventDefault();
      alert('모든 정보를 입력 해주세요.');
    } 
  });
 
</script>
	<script>
const signUpBtn = document.getElementById("signUp");
const signInBtn = document.getElementById("signIn");
const container = document.querySelector(".container");


signUpBtn.addEventListener("click", () => {
  container.classList.add("right-panel-active");
});

signInBtn.addEventListener("click", () => {
  container.classList.remove("right-panel-active");
});

</script>
</body>
</html>