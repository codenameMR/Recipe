<%@page import="java.io.File"%>
<%@page import="com.cook.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%--  <%
	String realFolder= request.getServletContext().getRealPath("/storage");   //storage 폴더의 실제 주소
	System.out.println("실제폴더"+realFolder);
	//업로드
	MultipartRequest multi = new MultipartRequest(request,realFolder,5*1024*1024,"UTF-8", new DefaultFileRenamePolicy());  //똑같은 이름의 파일이 들어오면 파일 뒤에 번호를 붙여줌
	
	//데이터 받기----<주의 하기> request 가 아닌 multi 로 값을 받는다. 
    //폼에서 전송한 파라미터의 이름을 인자로 받아서 그 파라미터의 값을 반환한다. 
	String subject=multi.getParameter("subject");
	String content=multi.getParameter("content");	

	//사용자가 직접 저장한 파일 명을 반환
	String originalFileName1=multi.getOriginalFileName("upload1");    
    //기존에 업로드한 파일들 중에 이름이 겹칠 경우 뒤에 번호가 붙는데, 그렇게 변환된 파일 이름을 반환
    String fileName1 = multi.getFilesystemName("upload1");   
    //서버상에 업로드된 파일에 대한 파일 객체를 반환한다. 
	File file1= multi.getFile("upload1");
	
	long fileSize1= 0;
	if(file1!=null)fileSize1=file1.length();
	%>  --%>

<%
	int result = (Integer)request.getAttribute("result");
	Recipe recipe = (Recipe)request.getAttribute("recipe");
%>

<% if (result == 0&& recipe.getRec_category()=="" ) { %>
	<script>
		alert("카테고리를 선택해주세요.");
		history.back();
	</script>
<%} else if (result ==0 ){%> 
   	<script>
 	  	alert("레시피 등록 실패");
   		history.back();
   	</script>
<%} else { %>
	<script>
		alert("레시피 등록 성공");
		location.href = "recipeView.do?rec_num=<%=recipe.getRec_num()%>";
	</script>
<% } %>

