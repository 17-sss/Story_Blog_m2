<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>������ �α׾ƿ� ó��</title>
</head>
<body>
    <%
        session.invalidate(); // ��缼������ ����
        response.sendRedirect("/Story_Blog/Project/index.jsp"); // �α��� ȭ������ �ٽ� ���ư���.
    %>
</body>
</html>