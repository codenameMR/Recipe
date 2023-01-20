<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String user_id=(String)session.getAttribute("userId");
  	System.out.println(user_id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 <title>게시판</title>
 </head>
 <body>
<table>
<form name=writeform method=post action="write_ok.jsp">
<input type="hidden" name="user_id" value="<%=user_id%>">
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
      <td><input name="title" size="50" maxlength="100" required></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">내용</td>
      <td><textarea name="content" cols="50" rows="13" required></textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">지역</td>
      <td><select name="loc">
      	<option value="서울">서울</option>
      	<option value="경기">경기</option>
      	<option value="강원">강원</option>
      	<option value="경상도">경상도</option>
      	<option value="전라도">전라도</option>
      	<option value="제주">제주</option>
      </select></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
		<td>사진1<input type="file" class="real-upload" accept="image/*" multiple></td>
	 </tr>
	 <tr>
		<td>사진2<input type="file" class="real-upload" accept="image/*" multiple></td>
	 </tr>
	 <tr>
		<td>사진3<input type="file" class="real-upload" accept="image/*" multiple></td>
	 </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
<!--      <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr> -->
     <tr align="center">
      <td>&nbsp;</td>
      <td colspan="2"><input type="submit" value="등록" OnClick="javascript:writeCheck();">
      <td>&nbsp;</td>
     </tr>
     
    </table>
   </td>
  </tr>
  </form>
 </table>
</body>
 </html>