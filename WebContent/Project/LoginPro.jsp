<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.db.UserDBBean"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
    <%
        // ���ڵ� ó��
        request.setCharacterEncoding("euc-kr"); 
        
        // �α��� ȭ�鿡 �Էµ� ���̵�� ��й�ȣ�� �����´�
        String email= request.getParameter("email");
        String pwd = request.getParameter("pwd");
        
     	// DB���� ���̵�, ��й�ȣ Ȯ��
        UserDBBean dbPro = UserDBBean.getInstance();
        int check = dbPro.loginCheck(email, pwd);
        
        // URL �� �α��ΰ��� ���� �޽���
        String msg = "";
        
        if(check == 1)    // �α��� ����
        { 
            // ���ǿ� ���� ���̵� ����
            session.setAttribute("sessionID", email);
            /* msg = "MainForm.jsp"; */
            msg="/Story_Blog/Project/view/user_main.jsp";
        }
        else if(check == 0) // ��й�ȣ�� Ʋ�����
        {
            msg = "index.jsp?msg=0";
        }
        else    // ���̵� Ʋ�����
        {
            msg = "index.jsp?msg=-1";
        }
         
        // sendRedirect(String URL) : �ش� URL�� �̵�
        // URL�ڿ� get��� ó�� �����͸� ���ް���
        response.sendRedirect(msg);
    %>

</body>
</html>