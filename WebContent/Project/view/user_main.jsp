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

<!-- ��� ��, ���̵� �� ���� -->
	<div style="margin-top:54px; margin-left: 10%;"><br>
		
		<!-- �� �� ���� -->
		<div style="margin-left: 10%; margin-right: 10%;">

			<!-- �Ϸ��� �� - form ���� -->
			<form action="/Story_Blog/Project/view/user_write.jsp" method="post">
				
				<!-- �Ϸ��� �� -->
				<div class="w3-row-padding">
					<div class="w3-col m12">
						<div class="w3-card w3-round w3-white">
							<div class="w3-container w3-padding">
								<h6 class="w3-text-gray">���� �Ϸ縦 ����غ�����.</h6>
								<input class="w3-input w3-border" name="subject" type="text" placeholder="�Ϸ��� ��"><br>
								<button type="submit" class="w3-button w3-theme w3-pink w3-right" 
									onclick="location.href='/Story_Blog/Project/view/user_write.jsp'">�۾���</button>
							</div>
						</div>
					</div>
				</div>
				<!-- end. �Ϸ��� �� -->
				
			</form>
			<!-- end. �Ϸ��� �� - form ���� -->
			
				
			<!-- �ϱ� 1 -->
       		<div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        		<img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
        		<span class="w3-right w3-text-gray">2018�� 02�� 07�� PM 11:55</span>
        		<h4>Kirby</h4><br>
        		<hr class="w3-clear">
        		<p>�ʹ� ������. ���õ� �����ߴ�</p>
        		
       		<!-- ���� �߰� ���� -->
       				<div class="w3-row-padding" style="margin:0 -16px">
        				<div class="w3-half">
        					<img src="<%=request.getContextPath() %>/Project/img/cat1.jpg" style="width:100%" alt="cat1" class="w3-margin-bottom">
        				</div>
        				<div class="w3-half">
        					<img src="<%=request.getContextPath() %>/Project/img/cat2.jpg" style="width:100%" alt="cat2" class="w3-margin-bottom">
        				</div>
        			</div>
        	<!-- end. ���� �߰� ���� -->	
       
       		</div>
        	<!-- end. �ϱ� 1  -->
        	
        	<!-- �ϱ� 2 -->
        	<div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        		<img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
        		<span class="w3-right w3-text-gray">2018�� 02�� 07�� PM 11:55</span>
        		<h4>Kirby</h4><br>
        		<hr class="w3-clear">
        		<p>�ʹ� ������. ���õ� �����ߴ�</p>
        	</div>
        	<!-- end. �ϱ� 2  -->

			</div>
		<!-- end. �� �� ���� -->
		
	</div>
<!-- end. ��� ��, ���̵� �� ���� -->


</div>
<!-- end. ��ü Ʋ div �� --> 
</body>
</html>