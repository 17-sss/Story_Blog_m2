<%@page import="com.db.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("EUC-KR"); %>

<jsp:useBean id="user" class="com.db.UserDataBean">
<jsp:setProperty name="user" property="*"/>
</jsp:useBean>
	<% System.out.println(user); %>
	<%
	try {
		UserDBBean userPro = UserDBBean.getInstance();
		int chk = userPro.updateUser(user);
		
		/* int num = Integer.parseInt(request.getParameter("num")); */
		String email = request.getParameter("email");
		String pwd= request.getParameter("pwd");
		String pageNum = request.getParameter("pageNum");
			if (pageNum == null || pageNum == "") {
				pageNum = "1";
			}
		
	%>
	
	<%
	System.out.println("��������: " + chk);
	if(chk ==1) { 
	%>
	
	<script type="text/javascript">
		alert("���� �Ϸ�");
		location.href="/Story_Blog/admin/accountList.jsp";
	</script>
	<meta http-equiv="Refresh" content="0;url=updateUserForm.jsp?email=<%=email%>&pwd=<%=pwd%>&pageNum=<%=pageNum%>">
	<%-- <meta http-equiv="Refresh" content="0;url=accountList.jsp?pageNum=<%=pageNum%>"> --%>

	<% } else { %>
	<script type="text/javascript">
		alert("���� �Ұ�");
		history.go(-1);
	</script>

	<% } %>
<% } catch (Exception e) {e.printStackTrace();} %>
</body>
</html>