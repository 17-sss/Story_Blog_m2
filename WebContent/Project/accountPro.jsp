<%-- <%@page import="com.db.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% 
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null || pageNum == "") {
		pageNum = "1";
	}
	
%>
<jsp:useBean id="user" class="com.db.UserDataBean">
<jsp:setProperty name="user" property="*"/>
</jsp:useBean>
<% System.out.println(user); %>
<%
	UserDBBean dbPro = UserDBBean.getInstance();
	user.setIp(request.getRemoteAddr());
	dbPro.insertUser(user);
	response.sendRedirect("index.jsp");
%>
</body>
</html> --%>