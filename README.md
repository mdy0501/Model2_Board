# Model2_BBS
#### 1. JSP/Servlet을 이용해 MVC 패턴의 게시판을 만들어본다.
#### 2. 본 내용은 [Seoul Wiz](https://www.youtube.com/watch?v=APJAJeePl4g&list=PLieE0qnqO2kTyzAlsvxzoulHVISvO8zA9&index=33) 동영상 강의를 참고하여 실습을 진행하였습니다.


<br>
<br>

## 1. 동작화면
![01](https://github.com/mdy0501/Model2_Board/blob/master/graphics/01.png)
![02](https://github.com/mdy0501/Model2_Board/blob/master/graphics/02.png)
![03](https://github.com/mdy0501/Model2_Board/blob/master/graphics/03.png)
![04](https://github.com/mdy0501/Model2_Board/blob/master/graphics/04.png)
![05](https://github.com/mdy0501/Model2_Board/blob/master/graphics/05.png)
![06](https://github.com/mdy0501/Model2_Board/blob/master/graphics/06.png)
![07](https://github.com/mdy0501/Model2_Board/blob/master/graphics/07.png)



<br>
<br>

## 2. 구조
#### [1] FrontController
- com.mdy.model_bbs.frontcontroller
  - BFrontController.java

#### [2] Command
- com.mdy.model2_bbs.command
  - BCommand.java
  - BContentCommand.java
  - BDeleteCommand.java
  - BListCommand.java
  - BModifyCommand.java
  - BReplyCommand.java
  - BReplyViewCommand.java
  - BWriteCommand.java

#### [3] DTO
- com.mdy.model2_bbs.dto
  - BDto.java

#### [4] DAO
- com.mdy.model2_bbs.dao
  - BDao.java

<br>

![MVC_01](https://github.com/mdy0501/Model2_BBS/blob/master/graphics/MVC_01.png)
![MVC_02](https://github.com/mdy0501/Model2_BBS/blob/master/graphics/MVC_02.png)
![MVC_03](https://github.com/mdy0501/Model2_BBS/blob/master/graphics/MVC_04.png)





<br>
<br>

## 3-1. Java Source code
#### [1] FrontController (com.mdy.model2_bbs.frontcontroller)

##### 1.1. BFrontController.java
```java
package com.mdy.model2_bbs.frontcontroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mdy.model2_bbs.command.BCommand;
import com.mdy.model2_bbs.command.BContentCommand;
import com.mdy.model2_bbs.command.BDeleteCommand;
import com.mdy.model2_bbs.command.BListCommand;
import com.mdy.model2_bbs.command.BModifyCommand;
import com.mdy.model2_bbs.command.BReplyCommand;
import com.mdy.model2_bbs.command.BReplyViewCommand;
import com.mdy.model2_bbs.command.BWriteCommand;

@WebServlet("*.do")
public class BFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BFrontController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		actionDo(request, response);

	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("actionDo");

		request.setCharacterEncoding("EUC-KR");

		String viewPage = null;
		BCommand command = null;

		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String com = uri.substring(conPath.length());

		if(com.equalsIgnoreCase("/write_view.do")) {
			viewPage = "write_view.jsp";
		} else if(com.equals("/write.do")) {
			command = new BWriteCommand();
			command.execute(request, response);
			viewPage = "list.do";
		} else if(com.equals("/list.do")) {
			command = new BListCommand();
			command.execute(request, response);
			viewPage = "list.jsp";
		} else if(com.equals("/content_view.do")) {
			command = new BContentCommand();
			command.execute(request, response);
			viewPage = "content_view.jsp";
		} else if(com.equals("/modify.do")) {
			command = new BModifyCommand();
			command.execute(request, response);
			viewPage = "list.do";
		} else if(com.equals("/delete.do")) {
			command = new BDeleteCommand();
			command.execute(request, response);
			viewPage = "list.do";
		} else if(com.equals("/reply_view.do")) {
			command = new BReplyViewCommand();
			command.execute(request, response);
			viewPage = "reply_view.jsp";
		} else if(com.equals("/reply.do")) {
			System.out.println("###### reply.do");
			command = new BReplyCommand();
			command.execute(request, response);
			viewPage = "list.do";
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}

```

<br>
<br>

#### [2] Command (com.mdy.model2_bbs.command)

##### 2.1. BCommand.java
```java
package com.mdy.model2_bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface BCommand {

	void execute(HttpServletRequest request, HttpServletResponse response);

}
```

<br>

##### 2.2. BContentCommand.java
```java
package com.mdy.model2_bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mdy.model2_bbs.dao.BDao;
import com.mdy.model2_bbs.dto.BDto;

public class BContentCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		String bId = request.getParameter("bId");
		BDao dao = new BDao();
		BDto dto = dao.contentView(bId);

		request.setAttribute("content_view", dto);
	}

}
```

<br>

##### 2.3. BDeleteCommand.java
```java
package com.mdy.model2_bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mdy.model2_bbs.dao.BDao;

public class BDeleteCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		String bId = request.getParameter("bId");
		System.out.println("###### bId : " + bId);
		BDao dao = new BDao();
		dao.delete(bId);
	}

}
```

<br>

##### 2.4. BListCommand.java
```java
package com.mdy.model2_bbs.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mdy.model2_bbs.dao.BDao;
import com.mdy.model2_bbs.dto.BDto;

public class BListCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		BDao dao = new BDao();
		ArrayList<BDto> dtos = dao.list();
		request.setAttribute("list", dtos);
	}
}
```

<br>

##### 2.5. BModifyCommand.java
```java
package com.mdy.model2_bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mdy.model2_bbs.dao.BDao;

public class BModifyCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		String bId = request.getParameter("bId");
		String bName = request.getParameter("bName");
		String bTitle = request.getParameter("bTitle");
		String bContent = request.getParameter("bContent");

		BDao dao = new BDao();
		dao.modify(bId, bName, bTitle, bContent);

	}

}
```

<br>

##### 2.6. BReplyCommand.java
```java
package com.mdy.model2_bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mdy.model2_bbs.dao.BDao;

public class BReplyCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		String bId = request.getParameter("bId");
		String bName = request.getParameter("bName");
		String bTitle = request.getParameter("bTitle");
		String bContent = request.getParameter("bContent");
		String bGroup = request.getParameter("bGroup");
		String bStep = request.getParameter("bStep");
		String bIndent = request.getParameter("bIndent");

		BDao dao = new BDao();
		dao.reply(bId, bName, bTitle, bContent, bGroup, bStep, bIndent);

	}

}
```

<br>

##### 2.7. BReplyViewCommand.java
```java
package com.mdy.model2_bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mdy.model2_bbs.dao.BDao;
import com.mdy.model2_bbs.dto.BDto;

public class BReplyViewCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		String bId = request.getParameter("bId");
		BDao dao = new BDao();
		BDto dto = dao.reply_view(bId);

		request.setAttribute("reply_view", dto);
	}

}
```

<br>

##### 2.8. BWriteCommand.java
```java
package com.mdy.model2_bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mdy.model2_bbs.dao.BDao;

public class BWriteCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		String bName = request.getParameter("bName");
		String bTitle = request.getParameter("bTitle");
		String bContent = request.getParameter("bContent");

		BDao dao = new BDao();
		dao.write(bName, bTitle, bContent);
	}

}
```

<br>
<br>


#### [3] DTO (com.mdy.model2_bbs.dto)

##### 3.1. BDto.java
```java
package com.mdy.model2_bbs.dto;

import java.sql.Timestamp;

public class BDto {

	int bId;
	String bName;
	String bTitle;
	String bContent;
	Timestamp bDate;
	String bDateFmt;
	int bHit;
	int bGroup;
	int bStep;
	int bIndent;

	public BDto() {

	}

	public BDto(int bId, String bName, String bTitle, String bContent, String bDateFmt, int bHit, int bGroup, int bStep, int bIndent) {
		this.bId = bId;
		this.bName = bName;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bDateFmt = bDateFmt;
		this.bHit = bHit;
		this.bGroup = bGroup;
		this.bStep = bStep;
		this.bIndent = bIndent;
	}

	public int getbId() {
		return bId;
	}

	public void setbId(int bId) {
		this.bId = bId;
	}

	public String getbName() {
		return bName;
	}

	public void setbName(String bName) {
		this.bName = bName;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
	}

	public Timestamp getbDate() {
		return bDate;
	}

	public void setbDate(Timestamp bDate) {
		this.bDate = bDate;
	}

	public String getbDateFmt() {
		return bDateFmt;
	}

	public void setbDateFmt(String bDateFmt) {
		this.bDateFmt = bDateFmt;
	}

	public int getbHit() {
		return bHit;
	}

	public void setbHit(int bHit) {
		this.bHit = bHit;
	}

	public int getbGroup() {
		return bGroup;
	}

	public void setbGroup(int bGroup) {
		this.bGroup = bGroup;
	}

	public int getbStep() {
		return bStep;
	}

	public void setbStep(int bStep) {
		this.bStep = bStep;
	}

	public int getbIndent() {
		return bIndent;
	}

	public void setbIndent(int bIndent) {
		this.bIndent = bIndent;
	}

}
```

<br>
<br>


#### [4] DAO (com.mdy.model2_bbs.dao)

##### 4.1. BDao.java
```java
package com.mdy.model2_bbs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mdy.model2_bbs.dto.BDto;

public class BDao {

	DataSource dataSource;

	public BDao() {

		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle11g");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void write(String bName, String bTitle, String bContent) {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		try {
			connection = dataSource.getConnection();
			connection.setAutoCommit(false);

			String query = "insert into mvc_board (bId, bName, bTitle, bContent, bHit, bGroup, bStep, bIndent) values (mvc_board_seq.nextval, ?, ?, ?, 0, mvc_board_seq.currval, 0, 0)";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, bName);
			preparedStatement.setString(2, bTitle);
			preparedStatement.setString(3, bContent);

			int rn = preparedStatement.executeUpdate();

			if(rn == 1) {
				System.out.println("##### WRITE Success!");
				connection.commit();
			} else {
				System.out.println("##### WRITE Fail!");
				connection.rollback();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(preparedStatement != null) preparedStatement.close();
				if(connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public ArrayList<BDto> list() {

		ArrayList<BDto> dtos = new ArrayList<BDto>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {
			connection = dataSource.getConnection();

			String query = "select bId, bName, bTitle, bContent, TO_CHAR(bDate, 'YYYY-MM-DD HH24:MI:SS') AS bDateFmt, bHit, bGroup, bStep, bIndent from mvc_board order by bGroup desc, bStep asc";
			preparedStatement = connection.prepareStatement(query);
			resultSet = preparedStatement.executeQuery();

			while(resultSet.next()) {
				int bId = resultSet.getInt("bId");
				String bName = resultSet.getString("bName");
				String bTitle = resultSet.getString("bTitle");
				String bContent = resultSet.getString("bContent");
				String bDateFmt = resultSet.getString("bDateFmt");
				System.out.println(" ###### list " + bDateFmt);
				int bHit = resultSet.getInt("bHit");
				int bGroup = resultSet.getInt("bGroup");
				int bStep = resultSet.getInt("bStep");
				int bIndent = resultSet.getInt("bIndent");

				BDto dto = new BDto(bId, bName, bTitle, bContent, bDateFmt, bHit, bGroup, bStep, bIndent);
				dtos.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(resultSet != null) resultSet.close();
				if(preparedStatement != null) preparedStatement.close();
				if(connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return dtos;
	}

	public BDto contentView(String strID) {

		upHit(strID);

		BDto dto = null;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {

			connection = dataSource.getConnection();

			String query = "select bId, bName, bTitle, bContent, TO_CHAR(bDate, 'YYYY-MM-DD HH24:MI:SS') AS bDateFmt, bHit, bGroup, bStep, bIndent from mvc_board where bId = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, Integer.parseInt(strID));
			resultSet = preparedStatement.executeQuery();

			if(resultSet.next()) {
				int bId = resultSet.getInt("bId");
				String bName = resultSet.getString("bName");
				String bTitle = resultSet.getString("bTitle");
				String bContent = resultSet.getString("bContent");
				String bDateFmt = resultSet.getString("bDateFmt");
//				Timestamp bDate = resultSet.getTimestamp("bDate");
				int bHit = resultSet.getInt("bHit");
				int bGroup = resultSet.getInt("bGroup");
				int bStep = resultSet.getInt("bStep");
				int bIndent = resultSet.getInt("bIndent");

				dto = new BDto(bId, bName, bTitle, bContent, bDateFmt, bHit, bGroup, bStep, bIndent);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(resultSet != null) resultSet.close();
				if(preparedStatement != null) preparedStatement.close();
				if(connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return dto;
	}

	public void modify(String bId, String bName, String bTitle, String bContent) {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		try {
			connection = dataSource.getConnection();
			connection.setAutoCommit(false);

			String query = "update mvc_board set bName = ?, bTitle = ?, bContent = ? where bId = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, bName);
			preparedStatement.setString(2, bTitle);
			preparedStatement.setString(3, bContent);
			preparedStatement.setInt(4, Integer.parseInt(bId));
			int rn = preparedStatement.executeUpdate();

			if(rn == 1) {
				System.out.println("##### UPDATE Success!");
				connection.commit();
			} else {
				System.out.println("##### UPDATE Fail!");
				connection.rollback();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(preparedStatement != null) preparedStatement.close();
				if(connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public void delete(String bId) {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		try {
			connection = dataSource.getConnection();
			connection.setAutoCommit(false);
			String query = "delete from mvc_board where bId = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, Integer.parseInt(bId));
			int rn = preparedStatement.executeUpdate();

			if(rn == 1) {
				System.out.println("##### DELETE Success!!!");
				connection.commit();
			} else {
				System.out.println("##### DELETE Fail!!!");
				connection.rollback();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(preparedStatement != null) preparedStatement.close();
				if(connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public BDto reply_view(String str) {
		BDto dto = null;

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {

			connection = dataSource.getConnection();
			String query = "select bId, bName, bTitle, bContent, TO_CHAR(bDate, 'YYYY-MM-DD HH24:MI:SS') AS bDateFmt, bHit, bGroup, bStep, bIndent from mvc_board where bId = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1,  Integer.parseInt(str));
			resultSet = preparedStatement.executeQuery();

			if(resultSet.next()) {
				int bId = resultSet.getInt("bId");
				String bName = resultSet.getString("bName");
				String bTitle = resultSet.getString("bTitle");
				String bContent = resultSet.getString("bContent");
//				Timestamp bDate = resultSet.getTimestamp("bDate");
				String bDateFmt = resultSet.getString("bDateFmt");
				int bHit = resultSet.getInt("bHit");
				int bGroup = resultSet.getInt("bGroup");
				int bStep = resultSet.getInt("bStep");
				int bIndent = resultSet.getInt("bIndent");

				dto = new BDto(bId, bName, bTitle, bContent, bDateFmt, bHit, bGroup, bStep, bIndent);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(preparedStatement != null) preparedStatement.close();
				if(connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return dto;
	}


	public void reply(String bId, String bName, String bTitle, String bContent, String bGroup, String bStep, String bIndent) {

		replyShape(bGroup, bStep);

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		try {
			connection = dataSource.getConnection();
			String query = "insert into mvc_board (bId, bName, bTitle, bContent, bGroup, bStep, bIndent) values (mvc_board_seq.nextval, ?, ?, ?, ?, ?, ?)";
			preparedStatement = connection.prepareStatement(query);

			preparedStatement.setString(1, bName);
			preparedStatement.setString(2, bTitle);
			preparedStatement.setString(3, bContent);
			preparedStatement.setInt(4, Integer.parseInt(bGroup));
			preparedStatement.setInt(5, Integer.parseInt(bStep) + 1);
			preparedStatement.setInt(6, Integer.parseInt(bIndent) + 1);

			int rn = preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(preparedStatement != null) preparedStatement.close();
				if(connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}


	private void replyShape(String strGroup, String strStep) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		try {
			connection = dataSource.getConnection();
			String query = "update mvc_board set bStep = bStep + 1 where bGroup = ? and bStep > ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, Integer.parseInt(strGroup));
			preparedStatement.setInt(2, Integer.parseInt(strStep));

			int rn = preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(preparedStatement != null) preparedStatement.close();
				if(connection != null) connection.close();
			} catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}


	private void upHit(String bId) {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		try {
			connection = dataSource.getConnection();
			String query = "update mvc_board set bHit = bHit + 1 where bId = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1,  bId);

			int rn = preparedStatement.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(preparedStatement != null) preparedStatement.close();
				if(connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

}
```

<br>
<br>


## 3-2. JSP Source code

##### 1. index.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	response.sendRedirect("/list.do");
%>
```

<br>

##### 2. list.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<table width = "500" cellpadding = "0" cellspacing = "0" border = "1">
		<tr>
			<td>번호</td>
			<td>이름</td>
			<td>제목</td>
			<td>날짜</td>
			<td>히트</td>
		</tr>
		<c:forEach items = "${list}" var = "dto">
		<tr>
			<td>${dto.bId}</td>
			<td>${dto.bName}</td>
			<td>
				<c:forEach begin="1" end="${dto.bIndent}">-</c:forEach>
				<a href = "content_view.do?bId=${dto.bId}">${dto.bTitle}</a>
			</td>
			<td>${dto.bDateFmt}</td>
			<td>${dto.bHit}</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan = "5"> <a href="write_view.do">글작성</a> </td>
		</tr>
	</table>

</body>
</html>
```

<br>

##### 3. content_view.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
function fnDeleteAction(bId) {
	if(confirm("정말 삭제하시겠습니까?")) {
		location.href="delete.do?bId="+bId;
	} else {
		return;
	}
}
</script>
</head>
<body>

	<table width = "500" cellpadding = "0" cellspacing = "0" border = "1">
		<form action = "modify.do" method = "post">
			<input type = "hidden" name = "bId" value = "${content_view.bId}">
			<tr>
				<td> 번호 </td>
				<td> ${content_view.bId} </td>
			</tr>
			<tr>
				<td> 히트 </td>
				<td> ${content_view.bHit} </td>
			</tr>
			<tr>
				<td> 이름 </td>
				<td> <input type="text" name="bName" value="${content_view.bName}"> </td>
			</tr>
			<tr>
				<td> 제목 </td>
				<td> <input type="text" name="bTitle" value="${content_view.bTitle}"> </td>
			</tr>
			<tr>
				<td> 내용 </td>
				<td> <textarea rows="10" name="bContent"> ${content_view.bContent}</textarea></td>
			</tr>
			<tr>
				<td colspan="2"> <input type="submit" value="수정"> &nbsp;&nbsp;
				<a href="list.do">목록보기</a>&nbsp;&nbsp;
				<a href="#" onclick="javascript:fnDeleteAction('${content_view.bId}')">삭제</a>&nbsp;&nbsp;
				<a href="/reply_view.do?bId=${content_view.bId}">답변</a>
				</td>
			</tr>
		</form>
	</table>

</body>
</html>
```

<br>

##### 4. write_view.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<table width="500" cellpadding="0" cellspacing="0" border="1">
		<form action="write.do" method="post">
			<tr>
				<td> 이름 </td>
				<td> <input type = "text" name = "bName" size = "50"> </td>
			</tr>
			<tr>
				<td> 제목 </td>
				<td> <input type = "text" name = "bTitle" size = "50"></td>
			</tr>
			<tr>
				<td> 내용 </td>
				<td> <textarea name = "bContent" rows = "10" ></textarea></td>
			</tr>
			<tr>
				<td colspan="2"> <input type = "submit" value = "입력"> &nbsp;&nbsp; <a href = "list.do"> 목록보기 </a></td>
			</tr>
		</form>
	</table>

</body>
</html>
```

<br>

##### 5. reply_view.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<table width = "500" cellpadding = "0" cellspacing = "0" border = "1">
		<form action="/reply.do" method="post">
			<input type = "hidden" name = "bId" value = "${reply_view.bId}">
			<input type = "hidden" name = "bGroup" value = "${reply_view.bGroup}">
			<input type = "hidden" name = "bStep" value = "${reply_view.bStep}">
			<input type = "hidden" name = "bIndent" value = "${reply_view.bIndent}">
			<tr>
				<td> 번호 </td>
				<td> ${reply_view.bId}</td>
			</tr>
			<tr>
				<td> 히트 </td>
				<td> ${reply_view.bHit}</td>
			</tr>
			<tr>
				<td> 이름 </td>
				<td> <input type = "text" name = "bName" value = "${reply_view.bName}"></td>
			</tr>
			<tr>
				<td> 제목 </td>
				<td> <input type = "text" name = "bTitle" value = "${reply_view.bTitle}"></td>
			</tr>
			<tr>
				<td> 내용 </td>
				<td> <textarea rows="10" name = "bContent"> ${reply_view.bContent }</textarea> </td>
			</tr>
			<tr>
				<td colspan="2"> <input type="submit" value = "답변 "> <a href="/list.do">목록 </a></td>
			</tr>
		</form>
	</table>

</body>
</html>
```

<br>
<br>


## 3-3. 설정 파일

##### 1. `Servers` - `context.xml`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--><!-- The contents of this file will be loaded for each web application --><Context>

    <!-- Default set of monitored resources. If one of these changes, the    -->
    <!-- web application will be reloaded.                                   -->
    <WatchedResource>WEB-INF/web.xml</WatchedResource>
    <WatchedResource>${catalina.base}/conf/web.xml</WatchedResource>

    <!-- Uncomment this to disable session persistence across Tomcat restarts -->
    <!--
    <Manager pathname="" />
    -->

    <!-- Uncomment this to enable Comet connection tacking (provides events
         on session expiration as well as webapp lifecycle) -->
    <!--
    <Valve className="org.apache.catalina.valves.CometConnectionManagerValve" />
    -->

    <Resource
    	auth = "Container"
    	driverClassName = "oracle.jdbc.driver.OracleDriver"
    	url = "jdbc:oracle:thin:@localhost:1521:orcl"
    	username = "daniel"
    	password = "daniel"
    	name = "jdbc/Oracle11g"
    	type = "javax.sql.DataSource"
    	maxActive = "50"
    	maxWait = "1000"
   	/>
</Context>
```



<br>
<br>

## 4. 확인할 사항
1. `WebContent` - `WEB-INF` - `lib` 안에 ojdbc6.jar 파일을 넣지 않아 오류 발생
2. `Servers` - `Tomcat v8.0 Server at localhost-config` - `context` 안에 아래의 내용을 넣지 않음.

```xml
<Resource
    	auth = "Container"
    	driverClassName = "oracle.jdbc.driver.OracleDriver"
    	url = "jdbc:oracle:thin:@localhost:1521:orcl"
    	username = "daniel"
    	password = "daniel"
    	name = "jdbc/Oracle11g"
    	type = "javax.sql.DataSource"
    	maxActive = "50"
    	maxWait = "1000"
/>
```
 - Oracle DB 연동시, SID 잘 확인할 것 (orcl)


 <br>
 <br>


## 5. 참고사항

##### 1. index.jsp 파일 생성
- 서버를 실행하면 기본적으로 index.jsp가 실행되게끔 WebContent - WEB-INF - web.xml 에 설정이 되어 잇다.
- 그래서 index.jsp 파일을 만들고, 여기서 response.sendRedirect를 이용해 원하는 페이지를 첫페이지로 만들 수 있다.
```jsp
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	response.sendRedirect("/list.do");
%>
```

<br>

##### 2. AutoCommit 처리
- CRUD 중에 Read를 제외한 Create, Update, Delete 는 setAutoCommit 처리를 해줘야 한다.
- 기본적으로 AutoCommit이 true로 설정되기 때문에 setAutoCommit(false)로 해주고, 반환값인 rn에 따라 분기 처리를 해줘야 한다.
```java
try {

  ...

    connection.setAutoCommit(false);
    int rn = preparedStatement.executeUpdate();

    if(rn == 1){
      connection.commit();
    } else {
      connection.rollback();
    }

  ...

} ...


```





<br>

##### 3. root 디렉토리 변경
- (1) 프로젝트 파일 오른쪽 마우스 클릭 - Properties - Web Project Settings - Context root 를 / 로 설정해준다. (원래는 프로젝트 이름이 설정되어 있다.)
  - 이렇게 하면 localhost.com:8080 다음에 프로젝트 이름없이 링크를 들어갈 수 있다. (localhost.com:8080/list.jsp)

- (2) `Servers` - `server.xml` 안에서
```
...
  <Context docBase="model2_bbs" path="/" reloadable="true" source="org.eclipse.jst.jee.server:model2_bbs"/></Host>
...
```
- path 에 프로젝트 이름이 설정되어 있는데 / 로 바꿔준다.
  - path="model2_bbs"   ->   path="/"


<br>

##### 4. SQL 구문
```SQL
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS 날짜
    , TO_CHAR(1000000, '999,999,999') AS 돈
    , TO_CHAR(TO_DATE('20170918'), 'YYYY-MM-DD') AS 문자열_날짜
FROM DUAL;
```

```SQL
SELECT ROWNUM RNUM, BID, BNAME, BTITLE, BCONTENT, BDATE, BHIT, BGROUP, BSTEP, BINDENT FROM MVC_BOARD ORDER BY ROWNUM DESC;
```
- numbering할 경우, ROWNUM 사용


<br>



##### 5. UTF-8 설정
- UTF-8 설정
  - Window - Preferences - Web
   (1) CSS Files - Encoding을 UTF-8 설정
   (2) HTML Files - Encoding을 UTF-8 설정
   (3) JSP FIles - Encoding을 UTF-8 설정
  - Window - Preferences - XML
   (1) XML Files - Encoding을 UTF-8 설정


<br>


##### 6. 인코딩이 깨질 경우
- `Servers` - `server.xml`에서 아래 코드에 URIEncoding="UTF-8" 이 들어가 있는지 확인해볼 것.
```xml

...

<Connector URIEncoding="UTF-8" connectionTimeout="20000" port="8080" protocol="HTTP/1.1" redirectPort="8443"/>

<Connector URIEncoding="UTF-8" port="8009" protocol="AJP/1.3" redirectPort="8443"/>

...

```
