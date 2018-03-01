<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<title>Story Blog - ADMIN</title>
</head>
<body>
<!-- 전체 틀 div ★ -->  
<div>&nbsp;

<!-- 타임라인 (이페이지에서는 사진 X) -->
<div style="margin-top:54px; margin-left: 10%;"><br>
	<!-- <div class="w3-col m8 w3-row" style="margin-left: 22%; margin-top: 5%; margin-bottom: 3%;"> -->

<!-- 타임라인 margin -->
<div style="margin-left: 10%; margin-right: 10%;">

		<!-- 일기 6 -->
		<div class="w3-container w3-card w3-white w3-round w3-margin"><br>
	        <img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
	        <span class="w3-right w3-text-gray">2018년 02월 07일 PM 11:55</span>
	        <h4>Kirby</h4><br>
	        <hr class="w3-clear">
	        <p>너무 졸립다. 오늘도 수고했다</p>
	    </div>
	    <!-- end. 일기 6 -->
    
    	<!-- 일기 5 -->
	    <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
	        <img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
	        <span class="w3-right w3-text-gray">2018년 02월 07일 PM 11:55</span>
	        <h4>Kirby</h4><br>
	        <hr class="w3-clear">
	        <p>너무 졸립다. 오늘도 수고했다</p>
	    </div>
   		 <!-- end. 일기 5 -->
	
		<!-- 일기 4 -->
       <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
        <span class="w3-right w3-text-gray">2018년 02월 07일 PM 11:55</span>
        <h4>Kirby</h4><br>
        <hr class="w3-clear">
        <p>너무 졸립다. 오늘도 수고했다</p>
       </div>
       <!-- end. 일기 4  -->	
	
	
		
	  <!-- 일기 3  -->
	  <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
        <span class="w3-right w3-text-gray">2018년 02월 06일 PM 10:30</span>
        <h4>Kirby</h4><br>
        <hr class="w3-clear">
        <p>신난다. 날씨 거지같다.</p>
       </div>
       <!-- end. 일기 3  -->
       
       <!-- 일기 2 -->
       <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
        <span class="w3-right w3-text-gray">2018년 02월 05일 PM 11:00</span>
        <h4>Kirby</h4><br>
        <hr class="w3-clear">
        <p>잘자</p>
       </div>
       <!-- end. 일기 2  -->
       
        <!-- 일기 1 -->
       <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
        <span class="w3-right w3-text-gray">2018년 02월 04일 PM 11:25</span>
        <h4>Kirby</h4><br>
        <hr class="w3-clear">
        <p>수고했다.</p>
      </div>
      	<!-- end. 일기 1  -->	
</div>
<!-- end. 타임라인 margin -->
</div>
<!-- end. 타임라인 -->

</div>
<!-- end. 전체 틀 div ★ -->  
</body>
</html>