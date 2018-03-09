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
       		<h3 class="w3-center">���� �հ�:${countT}</h3>

	        <div class="w3-center w3-container">
	       		<p class="w3-pink">������ ÷���ؼ� �ϱ⸦ ���ּ���!!</p>
	       	</div>	
        </div>
        </c:if>
       
	    
	    <!-- ����) �ϱⰡ ���� �� -->
	    <c:if test="${count!=0}">
	    <div class="w3-container w3-card w3-white w3-round w3-margin">
       		<h3 class="w3-center">���� �հ�:${countT}</h3>
       	</div>
	    
        <!-- ����) �ϱ� (����) -->
        <div class="w3-row-padding">
        <c:forEach var="diary" items="${diaryList}">
			
			<!-- ����) �̹��� ��� (���� 1) -->
			<c:if test="${diary.filename0!=null}">
				
				<div class="w3-third w3-container w3-margin-bottom">
					<div class="w3-container w3-white w3-padding w3-center">
						<img src="/Story_Blog_m2/fileSave/${diary.filename0}" alt="${diary.filename0}" style="width: auto; height:200px;">
						<div class="w3-container w3-white">
							<p>
								<a href="<%=request.getContextPath()%>/story/user_content?num=${diary.num}&pageNum=${currentPage}"><b>${diary.subject}</b></a>
							</p>
							<p>
								<span>${diary.cdate}</span>
								<span style="margin-left: 13%;">
									<c:if test="${diary.filename1!=null}">
										<span class="w3-left w3-red w3-border" style="font-size: 4pt;">
										&nbsp;+&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename1==null}">
										<span class="w3-left w3-red w3-border" style="font-size: 4pt;">
										&nbsp;-&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename2!=null}">
										<span class="w3-left w3-yellow w3-border" style="font-size: 4pt;">
										&nbsp;+&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename2==null}">
										<span class="w3-left w3-yellow w3-border" style="font-size: 4pt;">
										&nbsp;-&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename3!=null}">
										<span class="w3-left w3-green w3-border" style="font-size: 4pt;">
										&nbsp;+&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename3==null}">
										<span class="w3-left w3-green w3-border" style="font-size: 4pt;">
										&nbsp;-&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename4!=null}">
										<span class="w3-left w3-white w3-border" style="font-size: 4pt;">
										&nbsp;+&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename4==null}">
										<span class="w3-left w3-white w3-border" style="font-size: 4pt;">
										&nbsp;-&nbsp;
										</span>
									</c:if>
								</span>
							</p>
							
						</div>
					</div>
				</div>
					
			</c:if>
			
			<!-- ����) �̹��� null ��� (���� 1) -->
			<c:if test="${diary.filename0==null}">
				<div class="w3-third w3-container w3-margin-bottom">
					<div class="w3-container w3-white w3-padding w3-center">
						<img src="/Story_Blog_m2/Project/img/no_image.png" alt="${diary.filename0}" style="width: auto; height:200px;">
						<div class="w3-container w3-white">
							<p>
								<a href="<%=request.getContextPath()%>/story/user_content?num=${diary.num}&pageNum=${currentPage}"><b>${diary.subject}</b></a>
							</p>
							<p>
								<span>${diary.cdate}</span>
								<span style="margin-left: 13%;">
									<c:if test="${diary.filename1!=null}">
										<span class="w3-left w3-red w3-border" style="font-size: 4pt;">
										&nbsp;+&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename1==null}">
										<span class="w3-left w3-red w3-border" style="font-size: 4pt;">
										&nbsp;-&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename2!=null}">
										<span class="w3-left w3-yellow w3-border" style="font-size: 4pt;">
										&nbsp;+&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename2==null}">
										<span class="w3-left w3-yellow w3-border" style="font-size: 4pt;">
										&nbsp;-&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename3!=null}">
										<span class="w3-left w3-green w3-border" style="font-size: 4pt;">
										&nbsp;+&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename3==null}">
										<span class="w3-left w3-green w3-border" style="font-size: 4pt;">
										&nbsp;-&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename4!=null}">
										<span class="w3-left w3-white w3-border" style="font-size: 4pt;">
										&nbsp;+&nbsp;
										</span>
									</c:if>
									<c:if test="${diary.filename4==null}">
										<span class="w3-left w3-white w3-border" style="font-size: 4pt;">
										&nbsp;-&nbsp;
										</span>
									</c:if>
								</span>
							</p>
						</div>
					</div>
				</div>
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