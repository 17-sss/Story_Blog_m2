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

<!-- ���� (�������������� ������) -->
<div style="margin-top:54px; margin-left: 10%;"><br>
	<!-- <div class="w3-col m8 w3-row" style="margin-left: 22%; margin-top: 5%; margin-bottom: 3%;"> -->

<!-- ���� margin -->
<div style="margin-left: 10%; margin-right: 10%;">

		<!-- �Ϸ��� �� - form ���� -->
		<form action="/Story_Blog_m2/story/user_write" method="post">
				
			<!-- �Ϸ��� �� -->
			<div class="w3-row-padding">
				<div class="w3-col m12">
					<div class="w3-card w3-round w3-white">
						<div class="w3-container w3-padding">
							<h6 class="w3-text-gray">���� �Ϸ縦 ����غ�����.</h6>
							<input class="w3-input w3-border w3-text-grey" name="subject" type="text" style="font-size: 9pt;" value="${subject}"><br>
							<button type="submit" class="w3-button w3-theme w3-pink w3-right" 
								onclick="location.href='/Story_Blog_m2/story/user_write'">�۾���</button>
								<input type="hidden" name="diaryid" value="${diaryid}">
								<input type="hidden" name="subject" value="${subejct}">
						</div>
					</div>
				</div>
			</div>
			<!-- end. �Ϸ��� �� -->
				
		</form>
		<!-- end. �Ϸ��� �� - form ���� -->
			
		
		<!-- ����) �ϱⰡ ���� �� -->	
        <c:if test="${count==0}">
        <div class="w3-container w3-card w3-white w3-round w3-margin">
       		<h3 class="w3-center">���� ��:${count}</h3>

	        <div class="w3-center w3-container">
	       		<p class="w3-pink">������ ÷���ؼ� �ϱ⸦ ���ּ���!!</p>
	       	</div>	
        </div>
        </c:if>
       
	    
	    <!-- ����) �ϱⰡ ���� �� -->
	    <c:if test="${count!=0}">
	    <div class="w3-container w3-card w3-white w3-round w3-margin">
       		<h3 class="w3-center">���� ��:${count}</h3>
       	</div>
	    
        <!-- ����) �ϱ� (����) -->
        <div class="w3-row-padding"> <!-- <div class="w3-container w3-card w3-white w3-round w3-margin w3-center"> -->
        <c:forEach var="diary" items="${diaryList}">

			<!-- ����) �̹��� ��� -->
			<c:if test="${diary.filename!=null}">
				<div class="w3-third w3-container w3-margin-bottom">
					<img src="/Story_Blog_m2/fileSave/${diary.filename}" alt="${diary.filename}" style="width: 100%; vertical-align:top;">
					<div class="w3-container w3-white">
						<p>
							<a href="<%=request.getContextPath()%>/story/user_content?num=${diary.num}&pageNum=${currentPage}"><b>${diary.subject}</b></a>
						</p>
						<p>${diary.cdate}</p>
					</div>
				</div>
			<%-- <div class="w3-third w3-container w3-padding w3-border w3-card w3-center"
					style="width:; height:auto; vertical-align:top;">
					<img src="/Story_Blog_m2/fileSave/${diary.filename}" width="" height="auto" alt="${diary.filename}"
						class="w3-margin" onclick="location.href=''">
						<!-- ���� �ּҷ� �̵� ����� -->
						<br>
						<a href="<%=request.getContextPath()%>/story/user_content?num=${diary.num}&pageNum=${currentPage}">${diary.subject}</a>
					<div class="w3-container w3-white">
						<p>${diary.cdate}</p>
					</div>
				</div> --%>
			</c:if>
			
		</c:forEach>
		</div>
		</c:if>
			
		<!-- end. ����) �ϱ� (Ÿ�Ӷ���) -->	
		
		<!-- ����) �ϱ� ������ -->
		<div class = "w3-center w3-container w3-card w3-white w3-round w3-margin">
			<c:if test="${count>0}"> 
				<c:if test="${startPage > bottomLine}">
					<a href="user_gallery?pageNum=${startPage - bottomLine}">[����]</a>
				</c:if>
				
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<a href="user_gallery?pageNum=${i}"> <c:if test="${i != currentPage}">[${i}]</c:if>
						<c:if test="${i == currentPage}">
							<font color='red'>[${i}]</font>
						</c:if>
					</a>
				</c:forEach>
				
				<c:if test="${endPage < pageCount}">
						<a href="user_gallery?pageNum=${startPage + bottomLine}">[����]</a>
		
					</c:if>
				</c:if>
		</div>
<!-- end. ����) �ϱ� ������ -->
		
      	
</div>
<!-- end. ���� margin -->
</div>
<!-- end. ���� -->

</div>
<!-- end. ��ü Ʋ div �� -->



</body>
</html>