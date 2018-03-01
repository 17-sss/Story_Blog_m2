<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	String ctx = request.getContextPath(); //콘텍스트명 얻어오기.
%>
<%    
   	 	//제대로 utf-8환경이 아니라 한글 깨짐 그래서 임의로 추가                                                   
	    request.setCharacterEncoding("EUC-KR");
	    String subject = request.getParameter("subject");
	    
	    //콘솔 출력
	    System.out.println("제목:"+subject);   
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

<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
<script type="text/javascript" src="<%=ctx %>/SE2/js/service/HuskyEZCreator.js" charset="EUC-KR"></script>
<!-- jQuery를 사용하기위해 jQuery라이브러리 추가 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<script type="text/javascript">
	var oEditors = [];
	$(function() {
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : oEditors,
				elPlaceHolder : "ir1", //textarea에서 지정한 id와 일치해야 합니다. 

				//SmartEditor2Skin.html 파일이 존재하는 경로
				sSkinURI : "/Story_Blog/SE2/SmartEditor2Skin.html",

				htParams : {
					// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseToolbar : true,
					// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : true,
					// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true,
					fOnBeforeUnload : function() {
					}
				},
				
				fOnAppLoad : function() {
					//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
					oEditors.getById["ir1"].exec("PASTE_HTML",
							[ "기존 DB에 저장된 내용을 에디터에 적용할 문구" ]);
				},
				
				fCreator : "createSEditor2"
		});

		//저장버튼 클릭시 form 전송
		$("#save").click(function() {
			oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
			$("#frm").submit();
		});
	});
</script>

</head>
<body>
<!-- 전체 틀 div ★ --> 
<div>&nbsp;
	<!-- form -->
	
	<form id="frm" action="insert.jsp" method="post">
		<!-- 상단 바, 사이드 바 간격 -->
		<div style="margin-top:54px; margin-left: 10%;"><br>
			
			<!-- 양 옆 간격 -->
			<div style="margin-left: 13%; margin-right: 13%;">
				<!-- 작성 폼 -->
				<div class="w3-container w3-card w3-round w3-white">
				 	
					<div class="w3-container w3-card w3-round w3-white" style="margin: 5%;">
					
						<!-- 묶음 -->
						<div class="w3-border w3-margin  w3-text-pink">
							
							<!-- 일기장 분류 (select) -->
							<div class="w3-row w3-section">
								<div class="w3-content">
				 					일기장 선택
									&nbsp;<input class="w3-input" name="diaryid" type="text">
								</div>
							</div>
	
							<!-- 제목 -->
							<div class="w3-row w3-section">
								<div class="w3-content">
				 					제목 
									&nbsp;<input class="w3-input" name="subject" type="text" size="60" value="<%=subject %>">
								</div>
							</div>
							
							<!-- 날짜 지정  or reg_date(고정으로) 활용  -->
							<div class="w3-row w3-section">
								<div class="w3-content">
				 					날짜
				 					
									&nbsp;<input class="w3-input" name="t_date" type="date">
								</div>
							</div>
							
							<!-- 내용 (SE2) -->
							<div class="w3-row w3-section">
								<div class="w3-content">&nbsp;내용
									<textarea id="ir1" class="w3-input w3-border" rows="10" cols="30"
										style="width: 950px; height: 400px;" name="content">
									</textarea>
								</div>
							</div>
							
						</div>
						<!--end. 묶음 -->
						
												
						
						<!-- filename, size는 나중에..ㅠㅠㅠ -->
						
						<!-- 전송 -->
						<div class="w3-center" style="margin: 1%;">	
							<input class="w3-button w3-blue" type="button" id="save" value="저장" />
							<input class="w3-button w3-yellow" type="button" value="취소" onClick = "history.back();"/>
						</div>
						
					</div>
				</div>
				<!-- end. 작성폼 -->
			</div>
			<!-- end. 양 옆 간격 -->
		</div>
		<!-- end. 상단 바, 사이드 바 간격 -->
	</form>
	<!-- end. form -->
	
</div>
<!-- end. 전체 틀 div ★ --> 
</body>
</html>

