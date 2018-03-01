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
        // 인코딩 처리
        request.setCharacterEncoding("euc-kr"); 
        
        // 로그인 화면에 입력된 아이디와 비밀번호를 가져온다
        String email= request.getParameter("email");
        String pwd = request.getParameter("pwd");
        
     	// DB에서 아이디, 비밀번호 확인
        UserDBBean dbPro = UserDBBean.getInstance();
        int check = dbPro.loginCheck(email, pwd);
        
        // URL 및 로그인관련 전달 메시지
        String msg = "";
        
        if(check == 1)    // 로그인 성공
        { 
            // 세션에 현재 아이디 세팅
            session.setAttribute("sessionID", email);
            /* msg = "MainForm.jsp"; */
            msg="/Story_Blog/Project/view/user_main.jsp";
        }
        else if(check == 0) // 비밀번호가 틀릴경우
        {
            msg = "index.jsp?msg=0";
        }
        else    // 아이디가 틀릴경우
        {
            msg = "index.jsp?msg=-1";
        }
         
        // sendRedirect(String URL) : 해당 URL로 이동
        // URL뒤에 get방식 처럼 데이터를 전달가능
        response.sendRedirect(msg);
    %>

</body>
</html>