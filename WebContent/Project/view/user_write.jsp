<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	String ctx = request.getContextPath(); //���ؽ�Ʈ�� ������.
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Story Blog - User Write</title>
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



</head>
<body>
<!-- ��ü Ʋ div �� --> 
<div>&nbsp;
	<!-- form -->
	
	<form id="frm" action="<%=request.getContextPath()%>/story/user_writePro" enctype="multipart/form-data" method="post">
	<input type="hidden" name="diaryid" value="${diaryid}">
	<input type="hidden" name="num" value="${num}">
		
		<!-- ��� ��, ���̵� �� ���� -->
		<div style="margin-top:54px; margin-left: 10%;"><br>
			
			<!-- �� �� ���� -->
			<div style="margin-left: 13%; margin-right: 13%;">
				<!-- �ۼ� �� -->
				<div class="w3-container w3-card w3-round w3-white">
				 	
					<div class="w3-container w3-card w3-round w3-white" style="margin: 5%;">
					
						<!-- ���� -->
						<div class="w3-border w3-margin  w3-text-pink">
							
							<!-- �ϱ��� �з� (select) / �̿��̶� ���� -->
							<%-- <div class="w3-row w3-section">
								<div class="w3-content">
				 					�ϱ��� ����
									&nbsp;
									<select name="diaryid">
			   							<!-- <option value="">Select</option> -->
									    <option value="${diaryid}">${diaryid}</option>
									</select>
								
									<input class="w3-input" name="diaryid" type="text" value="${diaryid}">
								</div>
							</div> --%>
	
							<!-- ���� -->
							<div class="w3-row w3-section">
								<div class="w3-content">
				 					���� 
									&nbsp;<input class="w3-input" name="subject" type="text" size="60" value="${subject}" />
								</div>
							</div>
							
							<!-- ��¥   / ��¥ ���� �Ұ�..�����.. -->
							<div class="w3-row w3-section">
								<div class="w3-content">
				 					��¥ 
									&nbsp;<span class="w3-input w3-light-gray w3-text-gray" style="font-size: 9pt;">���� �ð����� ��ϵ˴ϴ�.</span>
								</div>
							</div>
							<!-- <div class="w3-row w3-section">
								<div class="w3-content">
				 					��¥
									&nbsp;<input class="w3-input" name="cdate" type="text" value="" readonly>
								</div>
							</div> -->
					
							<!-- ���Ͼ��ε�  -->
							<!-- <div class="w3-row w3-section">
								<div class="w3-content">
				 					���� 
									&nbsp;<input class="w3-input" name="filename" type="file" style="font-size: 9pt;" size="60" maxlength="50"/>
								</div>
							</div> -->
							
							<!-- ���Ͼ��ε� - �����׽�Ʈ  --> 
							<div class="w3-row w3-section">
								<div class="w3-content" style="font-size: 11pt;">
				 					<b>���� 1 [������ ���� ����]</b>
									&nbsp;<input class="w3-input w3-light-blue" name="filename0" type="file" style="font-size: 9pt;" size="60" maxlength="50"/>
								</div>
							</div>
							
							<div class="w3-row w3-section">
								<div class="w3-content" style="font-size: 9pt;">
				 					���� 2
									&nbsp;<input class="w3-input" name="filename1" type="file" style="font-size: 7pt;" size="60" maxlength="50"/>
								</div>
							</div>
							<div class="w3-row w3-section">
								<div class="w3-content" style="font-size: 9pt;">
				 					���� 3
									&nbsp;<input class="w3-input" name="filename2" type="file" style="font-size: 7pt;" size="60" maxlength="50"/>
								</div>
							</div>
							<div class="w3-row w3-section">
								<div class="w3-content" style="font-size: 9pt;">
				 					���� 4
									&nbsp;<input class="w3-input" name="filename3" type="file" style="font-size: 7pt;" size="60" maxlength="50"/>
								</div>
							</div>
							<div class="w3-row w3-section">
								<div class="w3-content" style="font-size: 9pt;">
				 					���� 5
									&nbsp;<input class="w3-input" name="filename4" type="file" style="font-size: 7pt;" size="60" maxlength="50"/>
								</div>
							</div>
							
							<!-- ���� (SE2) -->
							<div class="w3-row w3-section">
								<div class="w3-content">&nbsp;����
									<textarea  id="ir1" class="w3-input w3-border" rows="10" cols="30" 	name="content">
									</textarea>
									<!-- <textarea id="ir1" class="w3-input w3-border" rows="10" cols="30"
										style="width: 950px; height: 400px;" name="content">
									</textarea> -->
								</div>
							</div>
							
						</div>
						<!--end. ���� -->
						
												
						
						<!-- filename, size�� ���߿�..�ФФ� -->
						
						<!-- ���� -->
						<div class="w3-center" style="margin: 1%;">
							<input class="w3-button w3-white" type="button" onclick="submitContents(this);" value="����" />
							&nbsp;
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
<script type="text/javascript">
	var oEditors = [];
	
	//�߰� �۲� ���
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "ir1",
		sSkinURI: "/Story_Blog_m2/SE2/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// ���� ��� ���� (true:���/ false:������� ����)
			bUseVerticalResizer : true,		// �Է�â ũ�� ������ ��� ���� (true:���/ false:������� ����)
			bUseModeChanger : true,			// ��� ��(Editor | HTML | TEXT) ��� ���� (true:���/ false:������� ����)
			//aAdditionalFontList : aAdditionalFontSet,		// �߰� �۲� ���
			fOnBeforeUnload : function(){
				//alert("�Ϸ�!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//���� �ڵ�
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["�ε��� �Ϸ�� �Ŀ� ������ ���ԵǴ� text�Դϴ�."]);
		},
		fCreator: "createSEditor2"
	});
	
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>�̹����� ���� ������� �����մϴ�.<\/span>";
		oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["ir1"].getIR();
		alert(sHTML);
	}
		
	function submitContents(elClickedObj) {
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);	// �������� ������ textarea�� ����˴ϴ�.
		
		// �������� ���뿡 ���� �� ������ �̰����� document.getElementById("ir1").value�� �̿��ؼ� ó���ϸ� �˴ϴ�.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
	
	function setDefaultFont() {
		var sDefaultFont = '�ü�';
		var nFontSize = 24;
		oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>
<!-- end. ��ü Ʋ div �� --> 
</body>
</html>

