package com.cook.command;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.model.Recipe;
import com.cook.model.RecipeDAO;

import teamProject2.LikeDao;


public class DeleteCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int rec_num= Integer.parseInt(request.getParameter("rec_num"));
		File rec_file1;
		File rec_file2;
		File rec_file3;
		Recipe recipe = RecipeDAO.getInstance().selectRecipe(rec_num);
		int resultRec = RecipeDAO.getInstance().deleteRecipe(rec_num);
		int resultLike = LikeDao.getInstance().DeleteRecAll(rec_num);
		boolean result = resultRec > 0 && resultLike > 0;
		
		// D:/rec_storage에서 이미지 파일 삭제
		if (result) {
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