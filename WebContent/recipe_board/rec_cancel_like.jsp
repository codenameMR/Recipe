<%@page import="com.cook.model.RecipeDAO"%>
<%@page import="teamProject2.LikeDao"%>
<%@page import="teamProject2.RecLike"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String login_id = "";
if (session.getAttribute("userId") != null) {
login_id = (String)session.getAttribute("userId");
}
int rec_num = Integer.parseInt(request.getParameter("rec_num"));
RecLike existingLike = new RecLike(login_id, rec_num);

int resultCancelLike = LikeDao.getInstance().DeleteRec(existingLike);
int afterCancelLikes = RecipeDAO.getInstance().minusLikeRec(rec_num);
%>
<%=afterCancelLikes%>