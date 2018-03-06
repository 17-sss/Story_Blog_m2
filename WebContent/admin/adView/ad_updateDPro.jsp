<%-- <%@page import="com.db.DiaryDBBean" %> --%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- <% request.setCharacterEncoding("EUC-KR"); %> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%-- <jsp:useBean id="diary" class="com.db.DiaryDataBean">
	<jsp:setProperty name="diary" property="*"/>
	</jsp:useBean>
	<% System.out.println(diary); %>
	
	<%
	try {
		DiaryDBBean diaPro = DiaryDBBean.getInstance();
		int chk = diaPro.updateDiary(diary);
		
		String pageNum = request.getParameter("pageNum");
			if (pageNum == null || pageNum == "") {
				pageNum = "1";
			}
		
	%>
	
	<% System.out.println("수정여부: " + chk);  %> --%>
	
	<c:if test="${chk==1}">
		<script type="text/javascript">
			alert("수정 완료");
			location.href="/Story_Blog_m2/story/admin/ad_timeline";
		</script>
	<meta http-equiv="Refresh" content="0;url=ad_updateDForm?pageNum=${pageNum}">
	</c:if>
	<c:if test="${chk!=1}">
		<script type="text/javascript">
			alert("수정 불가");
			history.go(-1);
		</script>
	</c:if>

	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
</head>
<body>


</body>
</html>