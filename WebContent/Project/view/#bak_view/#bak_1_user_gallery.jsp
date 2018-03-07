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


<!-- 상단 바, 사이드바  간격 -->
<div style="margin-top:54px; margin-left: 10%; margin-bottom: 3%;"><br>
	<!-- <div class="w3-col m8 w3-row" style="margin-left: 22%; margin-top: 5%; margin-bottom: 3%;"> -->


<!-- 갤러리 컨테이너 + 컨텐츠 여백  -->
<div style="margin-left: 10%; margin-right: 10%;" class="w3-card w3-round w3-white">

	   <!-- 갤러리 여백 조정  -->
	   <div class="w3-row-padding" style="padding: 30px; ">
	    <c:forEach var="diary" items="${diaryList}">
	    <!-- 사진  -->
	    <div class="w3-third w3-container w3-margin w3-border w3-card" style="width: 30%;">
	      <img src="/Story_Blog_m2/fileSave/${diary.filename}" width="400px" height="auto" alt="${diary.filename}" style="width:50%" class="w3-hover-opacity">
	      <div class="w3-container w3-white">
	        <p>${diary.cdate}</p>
	      </div>
	    </div>
	    <!-- end. 사진  -->
	    </c:forEach>
	  </div>
	  <!-- end. 갤러리 여백 조정  -->
	  
	  <!-- 갤러리 페이지 -->
		<div class = "w3-center w3-container w3-card w3-white w3-round w3-margin">
			<c:if test="${count>0}"> 
				<c:if test="${startPage > bottomLine}">
					<a href="user_gallery?pageNum=${startPage - bottomLine}">[이전]</a>
				</c:if>
				
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<a href="user_gallery?pageNum=${i}"> <c:if test="${i != currentPage}">[${i}]</c:if>
						<c:if test="${i == currentPage}">
							<font color='red'>[${i}]</font>
						</c:if>
					</a>
				</c:forEach>
				
				<c:if test="${endPage < pageCount}">
						<a href="user_gallery?pageNum=${startPage + bottomLine}">[다음]</a>
		
					</c:if>
				</c:if>
		</div>
		<!-- end. 갤러리 페이지 -->
	    
</div>
<!-- end. 갤러리 컨테이너 + 컨텐츠 여백  -->

</div>
<!-- end. 상단 바, 사이드바  간격 -->



</div>
<!-- end. 전체 틀 div ★ -->  
</body>
</html>