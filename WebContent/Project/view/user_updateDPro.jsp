<%@page import="com.db.DiaryDBBean" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:useBean id="diary" class="com.db.DiaryDataBean">
	<jsp:setProperty name="diary" property="*"/>
	</jsp:useBean>
	<% System.out.println(diary); %>
	
	<%
	try {
		DiaryDBBean diaPro = DiaryDBBean.getInstance();
		int chk = diaPro.updateDiary(diary);
		
		/* 
		// 다필요없음....
		int num = Integer.parseInt(request.getParameter("num"));
		String content = request.getParameter("content");
		String subject = request.getParameter("subject");
		String email = request.getParameter("email");
		diary.setEmail((String)session.getAttribute("sessionID"));  */
		
		/* String diaryid = request.getParameter("diaryid");
		if (diaryid==null) diaryid="Main"; */
		
		String pageNum = request.getParameter("pageNum");
			if (pageNum == null || pageNum == "") {
				pageNum = "1";
			}
		
	%>
	
	<% System.out.println("수정여부: " + chk);  %>
	
	<% if (chk==1)  { %>
		<script type="text/javascript">
			alert("수정 완료");
			location.href="/Story_Blog/Project/view/user_timeline.jsp";
		</script>
	<meta http-equiv="Refresh" content="0;url=user_updateDForm.jsp?pageNum=<%=pageNum%>">
	
	<% } else { %>
		<script type="text/javascript">
			alert("수정 불가");
			history.go(-1);
		</script>
	<% } %>
<% } catch (Exception e) {e.printStackTrace();} %>	

	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
</head>
<body>


</body>
</html>