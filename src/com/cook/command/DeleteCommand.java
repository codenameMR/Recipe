package com.cook.command;


import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.model.Recipe;
import com.cook.model.RecipeDAO;


public class DeleteCommand implements Command {


	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		int rec_num= Integer.parseInt(request.getParameter("rec_num"));
		File rec_file1;
		File rec_file2;
		File rec_file3;
		Recipe recipe = RecipeDAO.getInstance().selectRecipe(rec_num);
		result = RecipeDAO.getInstance().deleteRecipe(rec_num);
		
		// D:/rec_storage에서 이미지 파일 삭제
		if (result > 0) {
			if (recipe.getRec_pic1() != null){
				rec_file1 = new File(recipe.getRec_pic1()); 
				rec_file1.delete();
			}
			if (recipe.getRec_pic2() != null) {
				rec_file2 = new File(recipe.getRec_pic2());
				rec_file2.delete();
			}
			if (recipe.getRec_pic3() != null) {
				rec_file3 =new File(recipe.getRec_pic3());
				rec_file3.delete();
			}
		}		
		request.setAttribute("delResult", result);
		
	}

}