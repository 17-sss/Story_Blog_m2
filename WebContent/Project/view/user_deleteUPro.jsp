<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<c:if test="${check==1}">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta http-equiv="Refresh" content="0; url=index">
	<script type="text/javascript">
		alert("Ż��Ǿ����ϴ�.. �ȳ���������.");
	</script>
</c:if>	

<c:if test="${check!=1}">
	<script type="text/javascript">
		alert("���� �Ұ�");
		history.go(-1);
	</script>
</c:if>
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>