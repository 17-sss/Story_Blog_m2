<%@page import="com.db.DiaryDataBean"%>
<%@page import="com.db.DiaryDBBean"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<% request.setCharacterEncoding("EUC-KR"); %>

<%  String diaryid = request.getParameter("diaryid");
	String subject = request.getParameter("subject");
	/* 
	String email = request.getParameter("email"); == X 오답
	diary.setEmail((String)session.getAttribute("sessionID"));  == X 오답 
	*/
	/* getDiaries(startRow, endRow, "email", diaryid); 
	(String)session.getAttribute("sessionID") 이걸 email 안에 쓰기. */
	
	if (diaryid==null) diaryid = "Main"; 
	if (subject==null) subject = "하루의 끝";
%>

<%
	int pageSize= 5;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null || pageNum =="") {
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	int count = 0;
	int number = 0;
	List diaryList = null;
	DiaryDBBean dbPro = DiaryDBBean.getInstance();
	count = dbPro.getDiaryCount(diaryid, (String)session.getAttribute("sessionID"));
	//게시판에 있는 글 수 count
	if (count > 0) {
		diaryList = dbPro.getDiaries(startRow, endRow, (String)session.getAttribute("sessionID"), diaryid);
	}
	number = count - (currentPage - 1) * pageSize;
	
	System.out.println(count+":"+diaryList); //Test
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<title>Story Blog - User</title>
</head>
<body>
<!-- 전체 틀 div ★ -->  
<div>&nbsp;

<!-- 타임라인 (이페이지에서는 사진 X) -->
<div style="margin-top:54px; margin-left: 10%;"><br>
	<!-- <div class="w3-col m8 w3-row" style="margin-left: 22%; margin-top: 5%; margin-bottom: 3%;"> -->

<!-- 타임라인 margin -->
<div style="margin-left: 10%; margin-right: 10%;">

		<!-- 하루의 끝 - form 전송 -->
		<form action="/Story_Blog/Project/view/user_write.jsp" method="post">
				
			<!-- 하루의 끝 -->
			<div class="w3-row-padding">
				<div class="w3-col m12">
					<div class="w3-card w3-round w3-white">
						<div class="w3-container w3-padding">
							<h6 class="w3-text-gray">오늘 하루를 요약해보세요.</h6>
							<input class="w3-input w3-border w3-text-grey" name="subject" type="text" style="font-size: 9pt;" value="<%=subject %>"><br>
							<button type="submit" class="w3-button w3-theme w3-pink w3-right" 
								onclick="location.href='/Story_Blog/Project/view/user_write.jsp'">글쓰기</button>
								<input type="hidden" name="diaryid" value="<%= diaryid %>">
								<input type="hidden" name="subject" value="<%= subject %>">
						</div>
					</div>
				</div>
			</div>
			<!-- end. 하루의 끝 -->
				
		</form>
		<!-- end. 하루의 끝 - form 전송 -->
			
		
		<!-- 일기가 없을 때 -->	
	    <%
        if(count==0){
        %>
        <div class="w3-container w3-card w3-white w3-round w3-margin">
       		<h3 class="w3-center">일기 수:<%=count %></h3>

	        <div class="w3-center w3-container">
	       		<p class="w3-pink">일기를 써주세요!!</p>
	       	</div>	
        </div>
	       
	    <% }else{ %>
	    
	    <!-- 일기가 있을 때 -->
	    <div class="w3-container w3-card w3-white w3-round w3-margin">
	    	<h3 class="w3-center">일기 수:<%=count %></h3>
	    </div>
	    
        <!-- 일기 (타임라인) -->
        <% for (int i=0;i<diaryList.size();i++) { 
        	DiaryDataBean diary=(DiaryDataBean) diaryList.get(i);%>
		<div class="w3-container w3-card w3-white w3-round w3-margin">
			<br> 
			<img src="<%=request.getContextPath()%>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right"
				style="width: 60px"> 
			
			<span class="w3-right w3-text-gray"><%=sdf.format(diary.getCdate()) %><%-- <%=diary.getCdate() %> --%></span>
			
			<b>제목:</b> <%=diary.getSubject()%>
			
			<div style="margin-top: 6px;">
				<form method="post" style="display: inline-block; margin-left: 10px;" class="w3-right" action="<%=request.getContextPath() %>/Project/view/user_deleteDPro.jsp">
					<input type="submit" class="w3-button w3-red w3-small" value="삭제">
					
					<!-- hidden으로  deleteDPro에 넘기기!!!  -->
               		<%-- <input type="hidden" name="email" value="<%=diary.getEmail() %>"> --%>
               		<input type="hidden" name="diaryid" value="<%=diary.getDiaryid()%>">
               		<input type="hidden" name="num" value="<%=diary.getNum() %>">
               		<!--  -->
				</form>
					
				<form method="post" style="display: inline-block;" class="w3-right" action="<%=request.getContextPath() %>/Project/view/user_updateDForm.jsp">
					 <input type="submit" class="w3-button w3-blue w3-small" value="수정">
					 
					 <!-- hidden으로  updateDForm에 넘기기!!!  -->
               		<%-- <input type="hidden" name="email" value="<%=diary.getEmail() %>"> --%>
               		<input type="hidden" name="diaryid" value="<%=diary.getDiaryid()%>">
               		<input type="hidden" name="num" value="<%=diary.getNum() %>">
               		<!--  -->
				</form>
			</div>
					
			<p class="w3-text-gray" style="font-size: 9pt;"><%=diary.getEmail()%></p>
			<hr class="w3-clear">
			<p><%=diary.getContent() %></p>
					
		</div>
		<% } %>
		<!-- end. 일기 (타임라인) -->	
		
      	
</div>
<!-- end. 타임라인 margin -->
</div>
<!-- end. 타임라인 -->

</div>
<!-- end. 전체 틀 div ★ -->

<!-- 일기 페이지 -->
<div class = "w3-center">
	<% int bottomLine = 3; 
		if(count > 0) {
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine; //곱셈, 나눗셈먼저.
			int endPage = startPage + bottomLine -1;
			if (endPage > pageCount) endPage = pageCount;
			if (startPage > bottomLine) { %>
			<a href="user_timeline.jsp?pageNum=<%= startPage - bottomLine %>">[이전]</a>
			<% } %>
			<% for (int i = startPage; i <= endPage; i++) { %>
			<a href="user_timeline.jsp?pageNum=<%=i%>"> <%
			if (i != currentPage) out.print("["+i+"]");
			else out.print("<font color='red'>["+i+"]</font>");%></a>
			<% }
				if(endPage < pageCount) {	%>
				<a href="user_timeline.jsp?pageNum=<%=startPage + bottomLine %>">[다음]</a>
				<% 
			}
		}
		
	%>
<% } %>
</div>
<!-- end. 일기 페이지 -->


</body>
</html>