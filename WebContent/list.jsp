<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="./css/main.css" />
<title>리스트</title>
<style type="text/css">
body {font-size:20px;}
.master-title{
	color: navy;
	font-size: 60px;
}
.master-description{
	color:green;
	font-size: 30px;
}

.btnGoWrite{
	height:50px;
	width:150px;
	font-size: 20px;
	font-weight: bold;
}


</style>
</head>
<!-- <body style="background:green"> -->
<body>
	<!-- 전체를 감싸는 태그 -->
	<div id="page-wrapper">
		<!-- header -->
		<header id="main-header">
			<h1 class="master-title">Dong-Yeon's Board</h1>
			<h1 class="master-description">MVC패턴을 적용한 Model2 게시판 입니다.</h1>
		</header>

		<!-- navigation -->
		<nav id="main-navigation">
		
		</nav>
		
		<!-- content(본문) -->
		<div id="content">
			<table class="bluetop" width="1000" height="150" cellpadding = "0" cellspacing = "0" border = "2">
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>제목</th>
			<th>날짜</th>
			<th>히트</th>
		</tr>
		<c:forEach items="${list}" var="dto">
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
<!-- 			<td colspan = "5"> <a href="write_view.do">글작성</a> </td> -->
			<td colspan = "5"> </td>
		</tr>
	</table>
		<button type="button" class="btnGoWrite" onclick="location.href='/write_view.do'">글 작성</button>
		</div>	
	</div>
</body>
</html>