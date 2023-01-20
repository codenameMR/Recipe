<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<script language = "javascript">  // 자바 스크립트 시작 //자바스크립트를 이용한 유효성검사

function writeCheck()
  {
   var form = document.writeform;
   
  form.submit();
  }
 </script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 <title>게시판</title>
 </head>
 <body>
<table>
<form name=writeform method=post action="write_ok.jsp">
<!-- 이 곳에 쓰인 값들을 write_ok.jsp에 보내야 하는데  데이터전달에는 주소에 값을 붙여서 보내는 Get방식과 
파일형식으로 보내는 Post방식중  Post방식을 사용-->

  <tr>
   <td>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
      <td>글쓰기</td>
     </tr>
    </table>
   <table>
     <tr>
      <td>&nbsp;</td>
      <td align="center">제목</td>
      <td><input name="title" size="50" maxlength="100"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">아이디</td>
      <td><input name="user_id" size="50" maxlength="50"></td>
      <td>&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">내용</td>
      <td><textarea name="content" cols="50" rows="13"></textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">지역</td>
      <td><input name="loc" size="50" maxlength="50"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
		<td>사진1<input type="file" class="real-upload" accept="image/*" required multiple></td>
	 </tr>
	 <tr>
		<td>사진2<input type="file" class="real-upload" accept="image/*" required multiple></td>
	 </tr>
	 <tr>
		<td>사진3<input type="file" class="real-upload" accept="image/*" required multiple></td>
	 </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
<!--      <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr> -->
     <tr align="center">
      <td>&nbsp;</td>
      <td colspan="2"><input type=button value="등록" OnClick="javascript:writeCheck();">
      <td>&nbsp;</td>
     </tr>
     
    </table>
   </td>
  </tr>
  </form>
 </table>
</body>
 </html>