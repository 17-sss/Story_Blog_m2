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

<!-- 상단 바, 사이드 바 간격 -->
	<div style="margin-top:54px; margin-left: 10%;"><br>
		
		<!-- 양 옆 간격 -->
		<div style="margin-left: 10%; margin-right: 10%;">

			<!-- 하루의 끝 - form 전송 -->
			<form action="/Story_Blog/Project/view/user_write.jsp" method="post">
				
				<!-- 하루의 끝 -->
				<div class="w3-row-padding">
					<div class="w3-col m12">
						<div class="w3-card w3-round w3-white">
							<div class="w3-container w3-padding">
								<h6 class="w3-text-gray">오늘 하루를 요약해보세요.</h6>
								<input class="w3-input w3-border" name="subject" type="text" placeholder="하루의 끝"><br>
								<button type="submit" class="w3-button w3-theme w3-pink w3-right" 
									onclick="location.href='/Story_Blog/Project/view/user_write.jsp'">글쓰기</button>
							</div>
						</div>
					</div>
				</div>
				<!-- end. 하루의 끝 -->
				
			</form>
			<!-- end. 하루의 끝 - form 전송 -->
			
				
			<!-- 일기 1 -->
       		<div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        		<img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
        		<span class="w3-right w3-text-gray">2018년 02월 07일 PM 11:55</span>
        		<h4>Kirby</h4><br>
        		<hr class="w3-clear">
        		<p>너무 졸립다. 오늘도 수고했다</p>
        		
       		<!-- 사진 추가 예시 -->
       				<div class="w3-row-padding" style="margin:0 -16px">
        				<div class="w3-half">
        					<img src="<%=request.getContextPath() %>/Project/img/cat1.jpg" style="width:100%" alt="cat1" class="w3-margin-bottom">
        				</div>
        				<div class="w3-half">
        					<img src="<%=request.getContextPath() %>/Project/img/cat2.jpg" style="width:100%" alt="cat2" class="w3-margin-bottom">
        				</div>
        			</div>
        	<!-- end. 사진 추가 예시 -->	
       
       		</div>
        	<!-- end. 일기 1  -->
        	
        	<!-- 일기 2 -->
        	<div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        		<img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
        		<span class="w3-right w3-text-gray">2018년 02월 07일 PM 11:55</span>
        		<h4>Kirby</h4><br>
        		<hr class="w3-clear">
        		<p>너무 졸립다. 오늘도 수고했다</p>
        	</div>
        	<!-- end. 일기 2  -->

			</div>
		<!-- end. 양 옆 간격 -->
		
	</div>
<!-- end. 상단 바, 사이드 바 간격 -->


</div>
<!-- end. 전체 틀 div ★ --> 
</body>
</html>