package com.cook.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.model.*;

import teamProject2.LikeDao;

public class MyRecipeLikeCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		RecipeDAO recipeDao = RecipeDAO.getInstance();
		LikeDao likeDao = LikeDao.getInstance();
		
		//정렬
		String orderStr = request.getParameter("order");
		//System.out.println(orderStr);
		int order = 0;
		if (orderStr != null) {
			order = Integer.parseInt(orderStr);
		}
		
		//내가 좋아요한 레시피 
		List<Recipe> myLikeRecList = null;
		String like_id = request.getParameter("like_id");
		if(like_id != null) {
			myLikeRecList = likeDao.myLike(like_id);
			myLikeRecList = recipeDao.selectAllByOrder(order, myLikeRecList);
		}
		
		//------------페이징-----------//
		String tempPage = request.getParameter("tempPage");
		// cPage(현재 페이지)
		int cPage = 1;
		if (tempPage == null || tempPage.length() == 0) {
		    cPage = 1;
		}
		try {
		    cPage = Integer.parseInt(tempPage);
		} catch (NumberFormatException e) {
		    cPage = 1;
		}
		
		// 전체 데이터 개수 (데이터가 아예 없는 경우도 고려해 예외처리) 
		int totalRows = recipeDao.getCountRows(myLikeRecList);
		
		// 한 페이지에서 보여줄 데이터 개수 
		int rowsByPage = 5;
		// 총 페이지 수 
		int totalPages = totalRows % rowsByPage == 0 ? totalRows / rowsByPage : (totalRows / rowsByPage) + 1;
		if (totalPages == 0) {
		    totalPages = 1;
		}
		if (cPage > totalPages) {
		    cPage = 1;
		}
		// 여기까지 cPage(현재 속한 페이지) 전처리 작업이 끝 
		
		//정제된 cPage 변의 startData,endData(각 페이지에서 데이터 시작점,끝점) 구함
		int startData = ((cPage - 1) * rowsByPage) + 1; //기본 1
		int endData = startData + rowsByPage - 1;		//기본 5
		// 구해낸 각 페이지의 startData, endData를 가지고 데이터 뽑아냄
		List<Recipe> myLikeRecipesByPage = recipeDao.selectRecipeByPage(startData, endData, myLikeRecList);
		
		// 페이지(자체) 처음과 끝을 지정하는 부분
		int blockLength = 5;
		int currentBlock = cPage % blockLength == 0 ? cPage / blockLength : (cPage / blockLength) + 1;
		//정수(int)/정수(int) : 소수점이하는 버림(내림).
		//페이지 블록의 시작페이지, 끝 페이지 
		int startPage = (currentBlock - 1) * blockLength + 1;
		int endPage = startPage + blockLength - 1;
		// 마지막 페이지 묶음에서 총 페이지수를 넘어가면 끝 페이지를 마지막 페이지 숫자로 지정
		if (endPage > totalPages) {
		    endPage = totalPages;
		}
		
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("totalPages", totalPages);
		request.setAttribute("tempPage", cPage);
		
		request.setAttribute("order", order);
		request.setAttribute("myLikeRecList", myLikeRecipesByPage);
	}

}
