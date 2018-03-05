<%-- <%@page import="com.db.UserDataBean"%>
<%@page import="java.util.List"%>
<%@page import="com.db.UserDBBean"%>
<%@page import="java.text.SimpleDateFormat"%> --%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- <% request.setCharacterEncoding("EUC-KR"); %> --%>

<%-- <%
	int pageSize= 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null || pageNum =="") {
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;  
	//사칙연산은 곱셈먼저.. +1은 맨나중에! 왼쪽에서부터 오른쪽으로 차례대로 계산
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	List usList = null;
	UserDBBean dbPro = UserDBBean.getInstance();
	count = dbPro.getUserCount();
	//게시판에 있는 글 수 count
	if (count > 0) {
		usList = dbPro.getUsers(startRow, endRow); 
	}
	number = count - (currentPage - 1) * pageSize;
%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<title>Story Blog - Userlist</title>
	<style type="text/css">
	.bgimg {
		    background-image: url("/Story_Blog_m2/Project/img/back2_babypink.jpg");
		    min-height: 100%;
		    background-position: center;
		    background-size: cover;		
		}
	</style>
	
</head>
<body class="bgimg">
<div>&nbsp;
	<div class="w3-container" style="margin-top:54px; margin-left: 10%;">
	       <c:if test="${count==0}">
	       
	         <%-- <%if(count==0){%> --%>
	       <div class="w3-container w3-white w3-round w3-margin">
	       		
	          	<h3 class="w3-center">전체 회원 수:${count}</h3>

	        <div class="w3-center w3-container">
	       		<p class="w3-pink">회원이 없습니다....</p>
	       	</div>	
	       </div>
	       </c:if>
	       
	       <c:if test="${count!=0}">
	       <%-- <% }else{ %> --%>
	       <div class="w3-container w3-margin w3-white w3-round">
	       		<h3 class="w3-center">전체 회원 수:${count}</h3>
	       
	       <table class="w3-table w3-bordered" width="900">
	       <tr class="w3-pink w3-center">
	       <td align="center" width="50">번호</td>
	       <td align="center" width="100">회원 이메일</td>
	       <td align="center" width="100">회원 비번</td>
	       <td align="center" width="100">회원 이름</td>
	       <td align="center" width="100">회원 Tel</td>
	       <td align="center" width="100">회원 생일</td>
	       <td align="center" width="100">가입일</td>
	       <td align="center" width="100">IP</td>
	       <td align="center" width="100">수정/삭제</td>
	       </tr>
	 
	        <c:forEach var="user" items="${usList}">
	       <%-- <% for (int i=0;i<usList.size();i++){UserDataBean user=(UserDataBean) usList.get(i);%> --%>
	          <tr height="30">
	          <td align="center" width="50">${number}</td>
	          <c:set var="number" value="${number-1}" />
	        	    <td align="center" width="100">${user.email}</td>
	        	    <td align="center" width="100">${user.pwd}</td>
	          		<td align="center" width="100">${user.name}</td>
	             	<td align="center" width="100">${user.tel}</td>
	             	<td align="center" width="100">${user.birth}</td>
	                <td align="center" width="100">${user.cdate}</td>
	                <td align="center" width="100">${user.ip}</td>
	               	<td align="center" width="100">
	               		<!-- 수정 삭제 만들기  -->
	               		<form method="post" action="<%=request.getContextPath() %>/story/admin/updateUserForm">
		  					<input type="submit" class="w3-button w3-white w3-hover-white" value="수정">
		  					<input type="hidden" name="email" value="${user.email}">
							<input type="hidden" name="pwd" value="${user.pwd}">
						</form>
	  					
						
						<form method="post" action="<%=request.getContextPath() %>/story/admin/deleteUserPro">
							<input type="submit" class="w3-button w3-pink w3-hover-pink" value="삭제">
							
							<!-- hidden으로 email, pwd가져오기!!!  -->
		               		<input type="hidden" name="email" value="${user.email}">
							<input type="hidden" name="pwd" value="${user.pwd}">
		               		<!--  -->
	               		</form>
	               	</td>
	          </tr>
	          <%-- <%} %> --%>
	          </c:forEach>
	           
	       </table>
	       
	       <div class = "w3-center w3-white w3-margin">
	       		<c:if test="${count>0}"> 
					<c:if test="${startPage > bottomLine}">
						<a href="accountList?pageNum=${startPage - bottomLine}">[이전]</a>
					</c:if>
		
					<c:forEach var="i" begin="${startPage}" end="${endPage}">
						<a href="accountList?pageNum=${i}"> <c:if test="${i != currentPage}">[${i}]</c:if>
							<c:if test="${i == currentPage}">
								<font color='red'>[${i}]</font>
							</c:if>
						</a>
					</c:forEach>
		
					<c:if test="${endPage < pageCount}">
						<a href="accountList?pageNum=${startPage + bottomLine}">[다음]</a>
					</c:if>
				</c:if>
			</div>
			
	     </div>
	    <%--  <%} %> --%>
	     </c:if>
	           
	</div>
</div>

</body>
</html>
