<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.db.UserDBBean" %>
<%@ page import="com.db.UserDataBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	/* int num = Integer.parseInt(request.getParameter("num")); */
	String email=request.getParameter("email");
	String pwd=request.getParameter("pwd");
	
	try {
		UserDBBean userPro = UserDBBean.getInstance();
		UserDataBean user = userPro.getUser(email, pwd);
	 
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<title>Insert title here</title>
	<style type="text/css">
		.bgimg {
			    background-image: url("/Story_Blog/Project/img/back2_babypink.jpg");
			    min-height: 100%;
			    background-position: center;
			    background-size: cover;		
			}
	</style>
</head>
<body class=bgimg>
<div>&nbsp;
	<div class="w3-container" style="margin-top:54px; margin-left: 10%;">
		<div class="w3-container w3-center w3-white w3-round" style="margin: 16px;">
			<h3 class="w3-center">회 원 수 정</h3>
			<form method="post" action="<%=request.getContextPath() %>/admin/updateUserPro.jsp" onsubmit="return checkValue()"
			style="padding: 3%;">
			
				<div class="w3-button w3-pink w3-right" onclick="location.href='accountList.jsp'" style="margin-bottom: 10px;">목록</div>
				
			
			   
				<div class="w3-row w3-section">
				  <div class="w3-col" style="width:100px">이메일</div>
				    <div class="w3-rest">
				      <input class="w3-input w3-border"  name="email" type="text" value ="<%=request.getParameter("email")%>">
				    </div>
				</div>
		
				<div class="w3-row w3-section">
				  <div class="w3-col" style="width:100px">이름</div>
				    <div class="w3-rest">
				      <input class="w3-input w3-border"  name="name" type="text" value="<%=user.getName() %>">
				    </div>
				</div>
		
				<div class="w3-row w3-section">
				  <div class="w3-col" style="width:100px">비밀번호</div>
				    <div class="w3-rest">
				      <input class="w3-input w3-border"  name="pwd" type="text" value="<%=user.getPwd() %>">
				    </div>
				</div>
		
				<div class="w3-row w3-section">
				  <div class="w3-col" style="width:100px">전화번호</div>
				    <div class="w3-rest">
				      <input class="w3-input w3-border"  name="tel" type="text" value="<%=user.getTel() %>">
				    </div>
				</div>
		
				<div class="w3-row w3-section">
				  <div class="w3-col" style="width:100px">생일</div>
				    <div class="w3-rest">
				      <input class="w3-input w3-border"  name="birth" type="text" value="<%=user.getBirth()%>">
				    </div>
				</div>
				
				<%	String pageNum = request.getParameter("pageNum");
						if (pageNum == null || pageNum == "") { 
							pageNum = "1"; 
				} %>
				
				<div class="w3-right">
				
					<input type="hidden" name="email" value="<%= user.getEmail() %>">
					<input type="hidden" name="pwd" value="<%= user.getPwd() %>">
					<input type="hidden" name="pageNum" value="<%= pageNum %>">
					<input type="hidden" name="num" value="<%=user.getNum() %>">
					
					<input type="submit" value="Send" class="w3-button w3-large w3-pink">
				</div>
			 
			   
		     
		</form>
		</div>
	</div>
</div>



<% } catch (Exception e) {} %>
</body>
</html>