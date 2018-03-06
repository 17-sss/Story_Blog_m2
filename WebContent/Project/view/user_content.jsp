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
<!-- 전체 틀 div ★ -->  
<div>&nbsp;

<!-- 메인 (이페이지에서는 사진 O) -->
<div style="margin-top:54px; margin-left: 10%;"><br>
	<!-- <div class="w3-col m8 w3-row" style="margin-left: 22%; margin-top: 5%; margin-bottom: 3%;"> -->

<!-- 메인 margin -->
<div style="margin-left: 10%; margin-right: 10%;">
	    
        <!-- 일기 (메인) -->
		<div class="w3-container w3-card w3-white w3-round w3-margin">
			<br> 
			<img src="<%=request.getContextPath()%>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right"
				style="width: 60px"> 
			<!-- 날짜 출력 -->
			<span class="w3-right w3-text-gray">${diary.cdate}</span>
			<!-- 제목 출력 -->
			<b>제목:</b> ${diary.subject}
			<!-- 수정, 삭제 -->
			<div style="margin-top: 6px;">
				<form method="post" style="display: inline-block; margin-left: 10px;" class="w3-right" action="<%=request.getContextPath() %>/story/user_deleteDPro">
					<input type="submit" class="w3-button w3-red w3-small" value="삭제">
					
					<!-- hidden으로  deleteDPro에 넘기기!!!  -->
               		<%-- <input type="hidden" name="email" value="<%=diary.getEmail() %>"> --%>
               		<input type="hidden" name="diaryid" value="${diary.diaryid}">
               		<input type="hidden" name="num" value="${diary.num}">
               		<!--  -->
				</form>
					
				<form method="post" style="display: inline-block; margin-left: 10px;" class="w3-right" action="<%=request.getContextPath() %>/story/user_updateDForm">
					<input type="submit" class="w3-button w3-blue w3-small" value="수정">
					<input type="button" style="display: inline-block; margin-left: 10px;" class="w3-button w3-right w3-yellow w3-small" value="목록" onclick="location.href='/Story_Blog_m2/story/user_gallery'" >
					
					<!-- hidden으로  updateDForm에 넘기기!!!  -->
               		<input type="hidden" name="diaryid" value="${diary.diaryid}">
               		<input type="hidden" name="num" value="${diary.num}">
               		<!--  -->
				</form>
				
				
			</div>
			<!-- end. 수정, 삭제 -->
			
			<!-- 이메일 출력 -->		
			<p class="w3-text-gray" style="font-size: 9pt;">${diary.email}</p>
			<hr class="w3-clear">
			<!-- 내용 출력 -->
			<p>${diary.content}</p>

			<!-- 이미지 출력 -->
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

			
		<!-- end. 일기 (타임라인) -->	
      	
</div>
<!-- end. 메인 margin -->
</div>
<!-- end. 메인 -->

</div>
<!-- end. 전체 틀 div ★ -->



</body>
</html>