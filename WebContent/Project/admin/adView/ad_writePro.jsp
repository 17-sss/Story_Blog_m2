<%-- <%@ page import="com.db.DiaryDBBean" %> --%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%-- <% request.setCharacterEncoding("EUC-KR"); %>
<%
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null || pageNum == "") {
		pageNum = "1";	}
	
	
	
	String diaryid = request.getParameter("diaryid");
	if (diaryid==null) diaryid = "Main";
%>

<jsp:useBean id="diary" class="com.db.DiaryDataBean">
<jsp:setProperty name="diary" property="*"/>
</jsp:useBean>


<% System.out.println(diary); %> --%>
<%-- <%
	DiaryDBBean dbPro = DiaryDBBean.getInstance();
    
	diary.setIp(request.getRemoteAddr());
	
	diary.setEmail((String)session.getAttribute("sessionID")); 
	dbPro.insertDiary(diary);
	response.sendRedirect("user_timeline.jsp?pageNum="+pageNum+"&diaryid="+diaryid);
%> --%>
</body>
</html>