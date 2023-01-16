package com.cook.command;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.model.Recipe;
import com.cook.model.RecipeDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class WriteCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 파일이 저장될 서버의 경로. 되도록이면 getRealPath를 이용하자.
		//(1)String savePath = "C:/JavaProgramming/source/projectName/WebContent/storage";
		//(2)String savePath = request.getServletContext().getRealPath("storage");
		//(3)
		String savePath = "D:/rec_storage";
		
		// 파일 크기 15MB로 제한
		int sizeLimit = 1024*1024*15;
		 
		//  ↓ request 객체,               ↓ 저장될 서버 경로,       ↓ 파일 최대 크기,    ↓ 인코딩 방식,       ↓ 같은 이름의 파일명 방지 처리
		// (HttpServletRequest request, String saveDirectory, int maxPostSize, String encoding, FileRenamePolicy policy)
		// 아래와 같이 MultipartRequest를 생성만 해주면 파일이 업로드 된다.(파일 자체의 업로드 완료)
		MultipartRequest multi=new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		 
		// --------------------------아래는 전송 받은 데이터들을 DB테이블에 저장시키기 위한 작업들.--------------------------
		// <form> 태그에서 enctype을 "multipart/form-data"로 선언하고
		// submit한 데이터들은 request객체가 아닌 MultipartRequest객체로 불러와야 한다.
		String id = multi.getParameter("user_id");
		String title = multi.getParameter("rec_title");
		String content = multi.getParameter("rec_content");
		String category = multi.getParameter("rec_category");
		 
		// 전송받은 데이터가 파일(<input type="file">)일 경우 getFilesystemName()으로 파일 이름을 받아올 수 있다.
		String rec_pic1 = multi.getFilesystemName("rec_pic1");
		String rec_pic2 = multi.getFilesystemName("rec_pic2");
		String rec_pic3 = multi.getFilesystemName("rec_pic3");
		 
		// 업로드한 파일의 전체 경로를 DB에 저장하기 위함
		String fileFullPath_rec_pic1 = "";
		String fileFullPath_rec_pic2 = "";
		String fileFullPath_rec_pic3 = "";
		
		if (rec_pic1 != null) 
		 fileFullPath_rec_pic1 = savePath + "/" + rec_pic1;
		if(rec_pic2 !=null)
		 fileFullPath_rec_pic2 = savePath + "/" + rec_pic2;
		if (rec_pic3 != null)
		fileFullPath_rec_pic3 = savePath + "/" + rec_pic3;
		 
		Recipe newRecipe = new Recipe();
		newRecipe.setUser_id(id);
		newRecipe.setRec_title(title);
		newRecipe.setRec_content(content);
		newRecipe.setRec_category(category);
		newRecipe.setRec_pic1(fileFullPath_rec_pic1);
		newRecipe.setRec_pic2(fileFullPath_rec_pic2);
		newRecipe.setRec_pic3(fileFullPath_rec_pic3);
		
		int result = 0;
		if (category !="") 
		result = RecipeDAO.getInstance().insertRecipeBoard(newRecipe);
	
		request.setAttribute("result", result);
		request.setAttribute("recipe", newRecipe);	 //auto-generated key(rec_num)을 얻기위해서 
	}



}