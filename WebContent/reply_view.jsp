<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link rel="stylesheet" type="text/css" href="./css/reply_view.css" />

<title>답변</title>
</head>
<style>
/* body {background:red;} */

.btnReply{
	height:40px;
	width:100px;
	font-size:20px;
	font-weight:bold;
}

</style>
<body>

	<table class="replyTB" width = "700" cellpadding = "0" cellspacing = "0" border = "1">
		<form action="/reply.do" method="post">
			<input type = "hidden" name = "bId" value = "${reply_view.bId}">
			<input type = "hidden" name = "bGroup" value = "${reply_view.bGroup}">
			<input type = "hidden" name = "bStep" value = "${reply_view.bStep}">
			<input type = "hidden" name = "bIndent" value = "${reply_view.bIndent}">
			<tr>
				<th> 번호 </th>
				<td> ${reply_view.bId}</td>
			</tr>
			<tr>
				<th> 히트 </th>
				<td> ${reply_view.bHit}</td>
			</tr>
			<tr>
				<th> 이름 </th>
				<td> <input type = "text" name = "bName" value = "${reply_view.bName}" size="80" style="height:25px;"></td>
			</tr>
			<tr>
				<th> 제목 </th>
				<td> <input type = "text" name = "bTitle" value = "${reply_view.bTitle}" size="80" style="height:25px;"></td>
			</tr>
			<tr>
				<th> 내용 </th>
				<td> <textarea rows="10" name = "bContent" size="80" style="height:200px; width:600px"> ${reply_view.bContent }</textarea> </td>
			</tr>
			<tr>
				<td colspan="2"> 
				<button type="submit" class="btnReply">답변</button> 
				<a href="/list.do">목록 </a></td>
			</tr>
		</form>
	</table>

</body>
</html>