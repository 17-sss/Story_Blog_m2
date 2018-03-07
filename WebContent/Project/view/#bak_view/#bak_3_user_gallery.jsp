<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<title>Story Blog - User</title>
	<style>
		img {margin-bottom: -7px}
		.w3-row-padding img {margin-bottom: 12px}
	</style>
	<script>
		function myFunction() {
		    var x = document.getElementById("myGrid");
		    if (x.className === "w3-row") {
		        x.className = "w3-row-padding";
		    } else { 
		        x.className = x.className.replace("w3-row-padding", "w3-row");
		    }
		}
	</script>
</head>
<body>
<!-- 전체 틀 div ★ -->  
<div>&nbsp;

<!-- 메인 (이페이지에서는 사진만) -->
<div style="margin-top:54px; margin-left: 10%;"><br>
	<!-- <div class="w3-col m8 w3-row" style="margin-left: 22%; margin-top: 5%; margin-bottom: 3%;"> -->

<!-- 메인 margin -->
<div style="margin-left: 10%; margin-right: 10%;">

		<!-- 하루의 끝 - form 전송 -->
		<form action="/Story_Blog_m2/story/user_write" method="post">
				
			<!-- 하루의 끝 -->
			<div class="w3-row-padding">
				<div class="w3-col m12">
					<div class="w3-card w3-round w3-white">
						<div class="w3-container w3-padding">
							<h6 class="w3-text-gray">오늘 하루를 요약해보세요.</h6>
							<input class="w3-input w3-border w3-text-grey" name="subject" type="text" style="font-size: 9pt;" value="${subject}"><br>
							<button type="submit" class="w3-button w3-theme w3-pink w3-right" 
								onclick="location.href='/Story_Blog_m2/story/user_write'">글쓰기</button>
								<input type="hidden" name="diaryid" value="${diaryid}">
								<input type="hidden" name="subject" value="${subejct}">
						</div>
					</div>
				</div>
			</div>
			<!-- end. 하루의 끝 -->
				
		</form>
		<!-- end. 하루의 끝 - form 전송 -->
			
		
		<!-- 사진) 일기가 없을 때 -->	
        <c:if test="${count==0}">
        <div class="w3-container w3-card w3-white w3-round w3-margin">
       		<h3 class="w3-center">사진 수:${count}</h3>

	        <div class="w3-center w3-container">
	       		<p class="w3-pink">사진을 첨부해서 일기를 써주세요!!</p>
	       	</div>	
        </div>
        </c:if>
       
	    
	    <!-- 사진) 일기가 있을 때 -->
	    <c:if test="${count!=0}">
	    <div class="w3-container w3-card w3-white w3-round w3-margin">
       		<h3 class="w3-center">사진 수:${count}</h3>
       	</div>
	    
        <!-- 사진) 일기 (메인) -->
        <div class="w3-row" id="myGrid" style="margin-bottom:128px">
        <!-- <div class="w3-row-padding">  --><!-- <div class="w3-container w3-card w3-white w3-round w3-margin w3-center"> -->
        <c:forEach var="diary" items="${diaryList}">

			<!-- 사진) 이미지 출력 -->
			<c:if test="${diary.filename!=null}">
				  <div class="w3-third">
				     <img src="/Story_Blog_m2/fileSave/${diary.filename}" style="width:100%">
				     <div class="w3-container w3-white">
						<p>
							<a href="<%=request.getContextPath()%>/story/user_content?num=${diary.num}&pageNum=${currentPage}"><b>${diary.subject}</b></a>
						</p>
						<p>${diary.cdate}</p>
					</div>
				  </div>
			</c:if>
			
		</c:forEach>
		</div>
		</c:if>
			
		<!-- end. 사진) 일기 (타임라인) -->	
		
		<!-- 사진) 일기 페이지 -->
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
<!-- end. 사진) 일기 페이지 -->
		
      	
</div>
<!-- end. 메인 margin -->
</div>
<!-- end. 메인 -->

</div>
<!-- end. 전체 틀 div ★ -->



</body>
</html>