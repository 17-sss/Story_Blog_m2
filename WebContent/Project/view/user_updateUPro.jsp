<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${chk==1}">
	
	<script type="text/javascript">
		alert("���� �Ǿ����ϴ�.");
		location.href="/Story_Blog_m2/story/user_main";
	</script>
	<%-- <meta http-equiv="Refresh" content="0;url=updateUserForm?email=${email}&pwd=${pwd}&pageNum=${pageNum}"> --%>
	</c:if>
	
	<c:if test="${chk!=1}">
	<script type="text/javascript">
		alert("���� �Ұ�");
		history.go(-1);
	</script>
	</c:if>
</body>
</html>