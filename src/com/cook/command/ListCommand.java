package com.cook.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.model.Recipe;
import com.cook.model.RecipeDAO;


public class ListCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//기본
		List<Recipe> recipeList = RecipeDAO.getInstance().selectAllRecipe();
       
		//검색
		String search_class = request.getParameter("search_class"); 
		String search_word = request.getParameter("search_word"); 
		List<Recipe> searchedLst = null;
//		System.out.println(search_class);
//		System.out.println(search_word);
		if (search_class!=null && search_word!=null) {
			search_class = request.getParameter("search_class");
			search_word = request.getParameter("search_word");
			searchedLst = RecipeDAO.getInstance().SearchRecipe(search_word, search_class);
			recipeList = searchedLst;
		}
		request.setAttribute("search_word", search_word);
		request.setAttribute("search_class", search_class);
		
		//정렬
		String orderStr = request.getParameter("num");
		//System.out.println(orderStr);
		int order = 0;
		if (orderStr != null) {
			order = Integer.parseInt(orderStr);
		}
		recipeList = RecipeDAO.getInstance().selectAllByOrder(order, recipeList);
		
		request.setAttribute("order", order);
		request.setAttribute("recipeList", recipeList);
	
	}
}


