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

<!-- Ÿ�Ӷ��� (�������������� ���� X) -->
<div style="margin-top:54px; margin-left: 10%;"><br>
	<!-- <div class="w3-col m8 w3-row" style="margin-left: 22%; margin-top: 5%; margin-bottom: 3%;"> -->

<!-- Ÿ�Ӷ��� margin -->
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

		<!-- �ϱ� 6 -->
		<div class="w3-container w3-card w3-white w3-round w3-margin"><br>
	        <img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
	        <span class="w3-right w3-text-gray">2018�� 02�� 07�� PM 11:55</span>
	        <h4>Kirby</h4><br>
	        <hr class="w3-clear">
	        <p>�ʹ� ������. ���õ� �����ߴ�</p>
	    </div>
	    <!-- end. �ϱ� 6 -->
    
    	<!-- �ϱ� 5 -->
	    <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
	        <img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
	        <span class="w3-right w3-text-gray">2018�� 02�� 07�� PM 11:55</span>
	        <h4>Kirby</h4><br>
	        <hr class="w3-clear">
	        <p>�ʹ� ������. ���õ� �����ߴ�</p>
	    </div>
   		 <!-- end. �ϱ� 5 -->
	
		<!-- �ϱ� 4 -->
       <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
        <span class="w3-right w3-text-gray">2018�� 02�� 07�� PM 11:55</span>
        <h4>Kirby</h4><br>
        <hr class="w3-clear">
        <p>�ʹ� ������. ���õ� �����ߴ�</p>
       </div>
       <!-- end. �ϱ� 4  -->	
	
	
		
	  <!-- �ϱ� 3  -->
	  <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
        <span class="w3-right w3-text-gray">2018�� 02�� 06�� PM 10:30</span>
        <h4>Kirby</h4><br>
        <hr class="w3-clear">
        <p>�ų���. ���� ��������.</p>
       </div>
       <!-- end. �ϱ� 3  -->
       
       <!-- �ϱ� 2 -->
       <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
        <span class="w3-right w3-text-gray">2018�� 02�� 05�� PM 11:00</span>
        <h4>Kirby</h4><br>
        <hr class="w3-clear">
        <p>����</p>
       </div>
       <!-- end. �ϱ� 2  -->
       
        <!-- �ϱ� 1 -->
       <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <img src="<%=request.getContextPath() %>/Project/img/Kirby_1.png" alt="kirby1" class="w3-left w3-circle w3-margin-right" style="width:60px">
        <span class="w3-right w3-text-gray">2018�� 02�� 04�� PM 11:25</span>
        <h4>Kirby</h4><br>
        <hr class="w3-clear">
        <p>�����ߴ�.</p>
      </div>
      	<!-- end. �ϱ� 1  -->	
</div>
<!-- end. Ÿ�Ӷ��� margin -->
</div>
<!-- end. Ÿ�Ӷ��� -->

</div>
<!-- end. ��ü Ʋ div �� -->  
</body>
</html>