package com.mdy.model2_board.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mdy.model2_board.dao.BDao;

public class BWriteCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		try {
			request.setCharacterEncoding("UTF-8");
			String bName = request.getParameter("bName");
			String bTitle = request.getParameter("bTitle");
			String bContent = request.getParameter("bContent");
			System.out.println("##### BWriteCommand " + bName + " : " + bTitle + " : " + bContent);
			
			BDao dao = new BDao();
			dao.write(bName, bTitle, bContent);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
