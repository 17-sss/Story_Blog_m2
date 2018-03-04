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
	String email = request.getParameter("email"); == X ����
	diary.setEmail((String)session.getAttribute("sessionID"));  == X ���� 
	*/
	/* getDiaries(startRow, endRow, "email", diaryid); 
	(String)session.getAttribute("sessionID") �̰� email �ȿ� ����. */
	
	if (diaryid==null) diaryid = "Main"; 
	if (subject==null) subject = "�Ϸ��� ��";
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
	//�Խ��ǿ� �ִ� �� �� count
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
<!-- ��ü Ʋ div �� -->  
<div>&nbsp;

<!-- Ÿ�Ӷ��� (�������������� ���� X) -->
<div style="margin-top:54px; margin-left: 10%;"><br>
	<!-- <div class="w3-col m8 w3-row" style="margin-left: 22%; margin-top: 5%; margin-bottom: 3%;"> -->

<!-- Ÿ�Ӷ��� margin -->
<div style="margin-left: 10%; margin-right: 10%;">

		<!-- �Ϸ��� �� - form ���� -->
		<form action="/Story_Blog/Project/view/user_write.jsp" method="post">
				
			<!-- �Ϸ��� �� -->
			<div class="w3-row-padding">
				<div class="w3-col m12">
					<div class="w3-card w3-round w3-white">
						<div class="w3-container w3-padding">
							<h6 class="w3-text-gray">���� �Ϸ縦 ����غ�����.</h6>
							<input class="w3-input w3-border w3-text-grey" name="subject" type="text" style="font-size: 9pt;" value="<%=subject %>"><br>
							<button type="submit" class="w3-button w3-theme w3-pink w3-right" 
								onclick="location.href='/Story_Blog/Project/view/user_write.jsp'">�۾���</button>
								<input type="hidden" name="diaryid" value="<%= diaryid %>">
								<input type="hidden" name="subject" value="<%= subject %>">
						</div>
					</div>
				</div>
			</div>
			<!-- end. �Ϸ��� �� -->
				
		</form>
		<!-- end. �Ϸ��� �� - form ���� -->
			
		
		<!-- �ϱⰡ ���� �� -->	
	    <%
        if(count==0){
        %>
        <div class="w3-container w3-card w3-white w3-round w3-margin">
       		<h3 class="w3-center">�ϱ� ��:<%=count %></h3>

	        <div class="w3-center w3-container">
	       		<p class="w3-pink">�ϱ⸦ ���ּ���!!</p>
	       	</div>	
        </div>
	       
	    <% }else{ %>
	    
	    <!-- �ϱⰡ ���� �� -->
	    <div class="w3-container w3-card w3-white w3-round w3-margin">
	    	<h3 class="w3-center">�ϱ� ��:<%=count %></h3>
	    </div>
	    
        <!-- �ϱ� (Ÿ�Ӷ���) -->
        <% for (int i=0;i<diaryList.size();i++) { 
        	DiaryDataBean diary=(DiaryDataBean) diaryList.get(i);%>
		<div class="w3-container w3-card w3-white w3-round w3-margin">
			<br> 
			<img src="<%=request.getContextPath()%>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right"
				style="width: 60px"> 
			
			<span class="w3-right w3-text-gray"><%=sdf.format(diary.getCdate()) %><%-- <%=diary.getCdate() %> --%></span>
			
			<b>����:</b> <%=diary.getSubject()%>
			
			<div style="margin-top: 6px;">
				<form method="post" style="display: inline-block; margin-left: 10px;" class="w3-right" action="<%=request.getContextPath() %>/Project/view/user_deleteDPro.jsp">
					<input type="submit" class="w3-button w3-red w3-small" value="����">
					
					<!-- hidden����  deleteDPro�� �ѱ��!!!  -->
               		<%-- <input type="hidden" name="email" value="<%=diary.getEmail() %>"> --%>
               		<input type="hidden" name="diaryid" value="<%=diary.getDiaryid()%>">
               		<input type="hidden" name="num" value="<%=diary.getNum() %>">
               		<!--  -->
				</form>
					
				<form method="post" style="display: inline-block;" class="w3-right" action="<%=request.getContextPath() %>/Project/view/user_updateDForm.jsp">
					 <input type="submit" class="w3-button w3-blue w3-small" value="����">
					 
					 <!-- hidden����  updateDForm�� �ѱ��!!!  -->
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
		<!-- end. �ϱ� (Ÿ�Ӷ���) -->	
		
      	
</div>
<!-- end. Ÿ�Ӷ��� margin -->
</div>
<!-- end. Ÿ�Ӷ��� -->

</div>
<!-- end. ��ü Ʋ div �� -->

<!-- �ϱ� ������ -->
<div class = "w3-center">
	<% int bottomLine = 3; 
		if(count > 0) {
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine; //����, ����������.
			int endPage = startPage + bottomLine -1;
			if (endPage > pageCount) endPage = pageCount;
			if (startPage > bottomLine) { %>
			<a href="user_timeline.jsp?pageNum=<%= startPage - bottomLine %>">[����]</a>
			<% } %>
			<% for (int i = startPage; i <= endPage; i++) { %>
			<a href="user_timeline.jsp?pageNum=<%=i%>"> <%
			if (i != currentPage) out.print("["+i+"]");
			else out.print("<font color='red'>["+i+"]</font>");%></a>
			<% }
				if(endPage < pageCount) {	%>
				<a href="user_timeline.jsp?pageNum=<%=startPage + bottomLine %>">[����]</a>
				<% 
			}
		}
		
	%>
<% } %>
</div>
<!-- end. �ϱ� ������ -->


</body>
</html>