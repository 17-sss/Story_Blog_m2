<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> -->
	<title>Story Blog - Sign Up</title>
	<% 
		String email = request.getParameter("email");
		int num=0;
		
		if (request.getParameter("num")!=null) {
			num = Integer.parseInt(request.getParameter("num"));
		}
	%>
	<style type="text/css">
		body,h1 {font-family: "consolas", sans-serif}
		body, html {height: 100%}
		.bgimg {
		    background-image: url("/Story_Blog_m2/Project/img/back1.jpg");
		    min-height: 100%;
		    background-position: center;
		    background-size: cover;
		}
		.formpad {
			padding: 10% 10% 10% 10%;
			
		}
	
	</style>
	<script type="text/javascript">
	/* �̸���, ��� üũ */
    function checkValue()
    {
		var form = document.userInfo;
		
        if(!form.email.value){
            alert("�̸����� �Է��ϼ���.");
            return false;
        }
        if(!form.name.value){
            alert("�̸��� �Է��ϼ���.");
            return false;
        }
        
      
        if(!form.pwd.value){
            alert("��й�ȣ�� �Է��ϼ���.");
            return false;
        }
        
        if(form.pwd.value != form.passchk.value){
        	alert("��й�ȣ Ȯ�ζ��� ��й�ȣ�� �����ϰ� �Է��ϼ���.");
            return false;
        } 
        
       /*  if(form.idDuplication.value != "idCheck"){
            alert("���̵� �ߺ�üũ�� ���ּ���.");
            return false;
        } */
        else {
        	alert("������ �Ϸ�Ǿ����ϴ�.");
        }

    }
    /* end. �̸���, ��� üũ */
	
    /* �̸��� �ߺ�Ȯ�� ȭ�� ���� */
    /* function openIdChk() {
    	windows.name = "parentForm";
    	windows.open("/Story_Blog/Project/IdCheckForm.jsp", "chkForm", 
    			"width=500, height=300, resizable = no, scrollbars = no");
    }
    
    function inputIdChk() {
		document.userInfo.idDuplication.value = "idUncheck";
	} */

	function confirmEmail() {
		if (document.userInfo.email.value == "") {
			alert("�̸����� �Է��ϼ���. (�ߺ�Ȯ��)");
			return;
		}
		url = "confirmEmail?email=" + document.userInfo.email.value;
		open(url, "confirm", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizeble=no, width=400, height=150");
	}
</script>


</head>
<body>
<div class="bgimg formpad">
<form method="post" name="userInfo" class="w3-container w3-card-4 w3-white w3-text-pink w3-margin w3-animate-bottom w3-round" 
action="<%=request.getContextPath()%>/story/accountPro" onsubmit="return checkValue()">

<h2 class="w3-center">Sign Up</h2>
<h6 class="w3-right">*�� �ʼ� �Է��Դϴ�.</h6>

<!-- �̸��� (���̵�) -->
<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"></div>
    <div class="w3-rest">
    
	   <div>
	     <input class="w3-input w3-border"  name="email" type="email" placeholder="E-mail (ID)*" style="display: inline-block;">	
	     	<%-- <input type="hidden" name="email" value="<%= email %>"> --%>
	     <input class="w3-button w3-blue w3-right" type="button" value="�ߺ�Ȯ��" onclick="confirmEmail(this.form)" style="font-size: 8pt;  display: inline-block;">
	   </div>
     <!-- <input class="w3-input w3-border"  name="email" type="email" placeholder="E-mail (ID)*" onkeydown="inputIdChk()">
     	  <input type="button" value="�ߺ�Ȯ��" onclick="openIdChk()">
      	  <input type="hidden" name="idDuplication" value="idUncheck"> -->
    </div>
</div>

<!-- �̸�  -->
<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"></div>
    <div class="w3-rest">
      <input class="w3-input w3-border"  name="name" type="text" placeholder="Name*">
    </div>
</div>

<!-- �н����� -->
<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"></div>
    <div class="w3-rest">
      <input class="w3-input w3-border"  name="pwd" type="password" placeholder="Password*">
    </div>
</div>

<!-- �н����� Ȯ��  -->
<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"></div>
    <div class="w3-rest">
      <input class="w3-input w3-border"  name="passchk" type="password" placeholder="Password Check*">
    </div>
</div>

<!-- ����ó  -->
<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"></div>
    <div class="w3-rest">
	   <input class="w3-input w3-border"  name="tel" type="tel" placeholder="Phone">
    </div>
</div>

<!-- ���� �Է� -->
<div class="w3-row w3-section">
	<div class="w3-rest w3-input w3-border">
		 Birthday: 
			&nbsp;<input name="birth" type="date">
	</div>
</div>

<p class="w3-center">
<input type="submit" value="Send" class="w3-button w3-pink">
<input type="button" value="Back" class="w3-button w3-red" OnClick="window.location='/Story_Blog_m2/story/index'">  

</p>
</form>
</div>

</body>
</html>