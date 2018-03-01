<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	String ctx = request.getContextPath(); //���ؽ�Ʈ�� ������.
%>
<%    
   	 	//����� utf-8ȯ���� �ƴ϶� �ѱ� ���� �׷��� ���Ƿ� �߰�                                                   
	    request.setCharacterEncoding("EUC-KR");
	    String subject = request.getParameter("subject");
	    
	    //�ܼ� ���
	    System.out.println("����:"+subject);   
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>SmartEditor</title>
<style type="text/css">
	.w3-input {
		padding: 8px;
		display: block;
		border: none;
		border-bottom: 1px solid #ccc;
		width: 98%;
	}
</style>

<!-- SmartEditor�� ����ϱ� ���ؼ� ���� js������ �߰� (��� Ȯ��) -->
<script type="text/javascript" src="<%=ctx %>/SE2/js/service/HuskyEZCreator.js" charset="EUC-KR"></script>
<!-- jQuery�� ����ϱ����� jQuery���̺귯�� �߰� -->
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<script type="text/javascript">
	var oEditors = [];
	$(function() {
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : oEditors,
				elPlaceHolder : "ir1", //textarea���� ������ id�� ��ġ�ؾ� �մϴ�. 

				//SmartEditor2Skin.html ������ �����ϴ� ���
				sSkinURI : "/Story_Blog/SE2/SmartEditor2Skin.html",

				htParams : {
					// ���� ��� ���� (true:���/ false:������� ����)
					bUseToolbar : true,
					// �Է�â ũ�� ������ ��� ���� (true:���/ false:������� ����)
					bUseVerticalResizer : true,
					// ��� ��(Editor | HTML | TEXT) ��� ���� (true:���/ false:������� ����)
					bUseModeChanger : true,
					fOnBeforeUnload : function() {
					}
				},
				
				fOnAppLoad : function() {
					//���� ����� ������ text ������ �����ͻ� �ѷ��ְ��� �Ҷ� ���
					oEditors.getById["ir1"].exec("PASTE_HTML",
							[ "���� DB�� ����� ������ �����Ϳ� ������ ����" ]);
				},
				
				fCreator : "createSEditor2"
		});

		//�����ư Ŭ���� form ����
		$("#save").click(function() {
			oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
			$("#frm").submit();
		});
	});
</script>

</head>
<body>
<!-- ��ü Ʋ div �� --> 
<div>&nbsp;
	<!-- form -->
	
	<form id="frm" action="insert.jsp" method="post">
		<!-- ��� ��, ���̵� �� ���� -->
		<div style="margin-top:54px; margin-left: 10%;"><br>
			
			<!-- �� �� ���� -->
			<div style="margin-left: 13%; margin-right: 13%;">
				<!-- �ۼ� �� -->
				<div class="w3-container w3-card w3-round w3-white">
				 	
					<div class="w3-container w3-card w3-round w3-white" style="margin: 5%;">
					
						<!-- ���� -->
						<div class="w3-border w3-margin  w3-text-pink">
							
							<!-- �ϱ��� �з� (select) -->
							<div class="w3-row w3-section">
								<div class="w3-content">
				 					�ϱ��� ����
									&nbsp;<input class="w3-input" name="diaryid" type="text">
								</div>
							</div>
	
							<!-- ���� -->
							<div class="w3-row w3-section">
								<div class="w3-content">
				 					���� 
									&nbsp;<input class="w3-input" name="subject" type="text" size="60" value="<%=subject %>">
								</div>
							</div>
							
							<!-- ��¥ ����  or reg_date(��������) Ȱ��  -->
							<div class="w3-row w3-section">
								<div class="w3-content">
				 					��¥
				 					
									&nbsp;<input class="w3-input" name="t_date" type="date">
								</div>
							</div>
							
							<!-- ���� (SE2) -->
							<div class="w3-row w3-section">
								<div class="w3-content">&nbsp;����
									<textarea id="ir1" class="w3-input w3-border" rows="10" cols="30"
										style="width: 950px; height: 400px;" name="content">
									</textarea>
								</div>
							</div>
							
						</div>
						<!--end. ���� -->
						
												
						
						<!-- filename, size�� ���߿�..�ФФ� -->
						
						<!-- ���� -->
						<div class="w3-center" style="margin: 1%;">	
							<input class="w3-button w3-blue" type="button" id="save" value="����" />
							<input class="w3-button w3-yellow" type="button" value="���" onClick = "history.back();"/>
						</div>
						
					</div>
				</div>
				<!-- end. �ۼ��� -->
			</div>
			<!-- end. �� �� ���� -->
		</div>
		<!-- end. ��� ��, ���̵� �� ���� -->
	</form>
	<!-- end. form -->
	
</div>
<!-- end. ��ü Ʋ div �� --> 
</body>
</html>

