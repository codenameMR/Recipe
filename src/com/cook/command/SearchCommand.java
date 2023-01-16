package com.cook.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.model.Recipe;
import com.cook.model.RecipeDAO;

public class SearchCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String search_class = request.getParameter("search_class");
		String search_word = request.getParameter("search_word");
//		System.out.println(search_class);
//		System.out.println(search_word);
		
		List<Recipe> searchedLst = RecipeDAO.getInstance().SearchRecipe(search_word, search_class);
		
		request.setAttribute("recipeList", searchedLst);
		request.setAttribute("search_word", search_word);
		
	
	}

}
