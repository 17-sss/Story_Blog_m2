<%@page import="com.db.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<title>Insert title here</title>
</head>
<% String email = request.getParameter("email"); 
	UserDBBean dbPro = UserDBBean.getInstance();
	boolean result = dbPro.confirmEmail(email);
%>
<% if (result) { %>
<body>
	<div class="w3-container w3-pink w3-center w3-round" style="height: 150px;">
		<div class="w3-container w3-white w3-round" style="padding: 4%; margin: 40px 0% 0% 0%;">
			<span>�̹� ������� �̸��� �Դϴ�.</span>
		</div>
	</div>
	<%
		} else {
	%>
	<div class="w3-container w3-pink w3-center w3-round" style="height: 150px;">
		<div class="w3-container w3-white w3-round" style="padding: 4%; margin: 40px 0% 0% 0%;">
			<span><b><%=email%></b>�� ����Ͻ� �� �ִ� �̸��� �Դϴ�.</span>
		</div>
	</div>
	<% } %>
</body>
</html>