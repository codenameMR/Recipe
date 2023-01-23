package com.cook.command;


import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.model.Recipe;
import com.cook.model.RecipeDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class UpdateCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String savePath = "D:/rec_storage";
		int sizeLimit = 1024*1024*15;
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		int rec_num = Integer.parseInt(multi.getParameter("rec_num"));
		String rec_title = multi.getParameter("rec_title");
		String rec_content = multi.getParameter("rec_content");
		String rec_category = multi.getParameter("rec_category");
		
		String rec_pic1 = multi.getFilesystemName("rec_pic1");
		String rec_pic2 = multi.getFilesystemName("rec_pic2");
		String rec_pic3 = multi.getFilesystemName("rec_pic3");
		
		// D:/rec_storage에서 이미지 파일 삭제
		File rec_file1;
		File rec_file2;
		File rec_file3;
		Recipe deletePic = RecipeDAO.getInstance().selectRecipe(rec_num);
		if (rec_pic1 == null && deletePic.getRec_pic1()!=null) {
			rec_file1 = new File(deletePic.getRec_pic1());
			rec_file1.delete();
		}
		if (rec_pic2 == null && deletePic.getRec_pic2()!=null) {
			rec_file2 = new File(deletePic.getRec_pic2());
			rec_file2.delete();
		}
		if (rec_pic3 == null && deletePic.getRec_pic3()!=null) {
			rec_file3 = new File(deletePic.getRec_pic3());
			rec_file3.delete();
		}
		
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
	   
		Recipe recipe = new Recipe();
		recipe.setRec_num(rec_num);
		recipe.setRec_title(rec_title);
		recipe.setRec_content(rec_content);
		recipe.setRec_category(rec_category);
		recipe.setRec_pic1(fileFullPath_rec_pic1);
		recipe.setRec_pic2(fileFullPath_rec_pic2);
		recipe.setRec_pic3(fileFullPath_rec_pic3);
		
		int result = 0;
		if (rec_category!="") 
		result = RecipeDAO.getInstance().updateRecipe(recipe);
		
		//마이페이지(내가 쓴 레시피글/좋아요한 레시피글)로 돌아가기
		String prePage = multi.getParameter("prePage");
		request.setAttribute("prePage", prePage);
		
		request.setAttribute("rec_num", rec_num);
		request.setAttribute("recipe", recipe);
		request.setAttribute("updateResult", result);
		
	}



}
