<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="./css/write_view.css" />
<title>글 작성 페이지</title>
<style type="text/css">

.btnWrite{
	height:40px;
	width:100px;
	font-size:20px;
	font-weight: bold;
}

</style>

</head>
<body>
	<table class="writeTB" width="700" cellpadding="0" cellspacing="0" border="1">
		<form action="write.do" method="post">
			<tr>
				<th> 이름 </th>
				<td> <input type="text" name="bName" size="80" style="height:25px;"> </td>
			</tr>
			<tr>
				<th> 제목 </th>
				<td> <input type="text" name="bTitle" size="80" style="height:25px;" ></td>
			</tr>
			<tr>
				<th> 내용 </th>
				<td> <textarea name="bContent" rows="10" size="80" style="height:200px; width:600px"></textarea></td>
			</tr>
			<tr>
				<!-- <td colspan="2"> <input type="submit" value="입력"> &nbsp;&nbsp; <a href="list.do"> 목록보기 </a></td> -->
				<td colspan="2"> <button type="submit" class="btnWrite">입력</button> &nbsp;&nbsp; <a href="list.do"> 목록보기 </a></td>
			</tr>
		</form>
	</table>

</body>
</html>