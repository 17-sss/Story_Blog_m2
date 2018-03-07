<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

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

<!-- ���� (�������������� ���� O) -->
<div style="margin-top:54px; margin-left: 10%;"><br>
	<!-- <div class="w3-col m8 w3-row" style="margin-left: 22%; margin-top: 5%; margin-bottom: 3%;"> -->

<!-- ���� margin -->
<div style="margin-left: 10%; margin-right: 10%;">
	    
        <!-- �ϱ� (����) -->
		<div class="w3-container w3-card w3-white w3-round w3-margin">
			<br> 
			<img src="/Story_Blog_m2/userSave/${filename}" alt="${filename}" class="w3-left w3-circle w3-margin-right"
				style="width: 60px; height: 60px"> 
			<!-- ��¥ ��� -->
			<span class="w3-right w3-text-gray">${diary.cdate}</span>
			<!-- ���� ��� -->
			<b>����:</b> ${diary.subject}
			<!-- ����, ���� -->
			<div style="margin-top: 6px;">
				<form method="post" style="display: inline-block; margin-left: 10px;" class="w3-right" action="<%=request.getContextPath() %>/story/user_deleteDPro">
					<input type="submit" class="w3-button w3-red w3-small" value="����">
					
					<!-- hidden����  deleteDPro�� �ѱ��!!!  -->
               		<%-- <input type="hidden" name="email" value="<%=diary.getEmail() %>"> --%>
               		<input type="hidden" name="diaryid" value="${diary.diaryid}">
               		<input type="hidden" name="num" value="${diary.num}">
               		<!--  -->
				</form>
					
				<form method="post" style="display: inline-block; margin-left: 10px;" class="w3-right" action="<%=request.getContextPath() %>/story/user_updateDForm">
					<input type="submit" class="w3-button w3-blue w3-small" value="����">
					<input type="button" style="display: inline-block; margin-left: 10px;" class="w3-button w3-right w3-yellow w3-small" value="���" onclick="location.href='/Story_Blog_m2/story/user_gallery'" >
					
					<!-- hidden����  updateDForm�� �ѱ��!!!  -->
               		<input type="hidden" name="diaryid" value="${diary.diaryid}">
               		<input type="hidden" name="num" value="${diary.num}">
               		<!--  -->
				</form>
				
				
			</div>
			<!-- end. ����, ���� -->
			
			<!-- �̸��� ��� -->		
			<p class="w3-text-gray" style="font-size: 9pt;">${diary.email}</p>
			<hr class="w3-clear">
			<!-- ���� ��� -->
			<p>${diary.content}</p>

			<!-- �̹��� ��� -->
			<c:if test="${diary.filename!=null}">
			<%-- <div>
				<p><img src="/Story_Blog_m2/fileSave/${diary.filename}"width="700px" height="auto"></p>
			</div> --%>
				<div class="w3-third w3-container w3-margin w3-border w3-card w3-center" style="width: 600px; height:auto;">
					<img src="/Story_Blog_m2/fileSave/${diary.filename}" width="500px" height="auto" alt="${diary.filename}"
						class="w3-hover-opacity w3-margin" onclick="location.href=''">
					<br>
					<div class="w3-container w3-white">
						<p>${diary.cdate}</p>
					</div>
				</div>
			</c:if>
		
		</div>

			
		<!-- end. �ϱ� (Ÿ�Ӷ���) -->	
      	
</div>
<!-- end. ���� margin -->
</div>
<!-- end. ���� -->

</div>
<!-- end. ��ü Ʋ div �� -->



</body>
</html>