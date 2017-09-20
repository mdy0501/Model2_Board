package com.mdy.model2_board.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mdy.model2_board.dao.BDao;
import com.mdy.model2_board.dto.BDto;

public class BListCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
		try {
			request.setCharacterEncoding("UTF-8");
			
			BDao dao = new BDao();
			ArrayList<BDto> dtos = dao.list();
			request.setAttribute("list", dtos);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}