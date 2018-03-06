<%-- <%@page import="com.db.DiaryDataBean"%>
<%@page import="com.db.DiaryDBBean"%>
<%@page import="java.text.SimpleDateFormat"%> --%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<% String ctx = request.getContextPath(); //콘텍스트명 얻어오기. %>
<%-- <
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	//제대로 utf-8환경이 아니라 한글 깨짐 그래서 임의로 추가
	request.setCharacterEncoding("EUC-KR");
%>
<%
	String diaryid = request.getParameter("diaryid");
	if (diaryid==null) diaryid="Main";
	String pageNum = request.getParameter("pageNum");
		if (pageNum == null || pageNum == "") { 
			pageNum = "1"; 
		}
%>
<% 
	int num = Integer.parseInt(request.getParameter("num"));

	/* String email=request.getParameter("email"); */
	
	try {
		DiaryDBBean diaryPro = DiaryDBBean.getInstance();
		DiaryDataBean diary = diaryPro.getDiary(num, (String)session.getAttribute("sessionID"), diaryid); 
%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Story Blog - ADMIN Write</title>
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



</head>
<body>
<!-- 전체 틀 div ★ --> 
<div>&nbsp;
	<!-- form -->
	
	<form id="frm" action="<%=request.getContextPath()%>/story/admin/ad_updateDPro" method="post">
	
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
									&nbsp;<input class="w3-input" name="diaryid" type="text" value="${diary.diaryid}"/>
								</div>
							</div>
	
							<!-- 제목 -->
							<div class="w3-row w3-section">
								<div class="w3-content">
				 					제목 
									&nbsp;<input class="w3-input" name="subject" type="text" size="60" value="${diary.subject}" />
								</div>
							</div>
							
							<!-- 날짜   / 날짜 수정 불가..방법이.. -->
							<div class="w3-row w3-section">
								<div class="w3-content">
				 					날짜 
									&nbsp;<span class="w3-input w3-light-gray w3-text-gray" style="font-size: 9pt;">처음 만든 시간으로 등록됩니다.</span>
								</div>
							</div>
							<%-- <div class="w3-row w3-section">
								<div class="w3-content">
				 					날짜
									&nbsp;<input class="w3-input w3-light-gray" name="cdate" type="text" value="<%=sdf.format(diary.getCdate()) %>" readonly>
								</div>
							</div> --%>
							
							<!-- 내용 (SE2) -->
							<div class="w3-row w3-section">
								<div class="w3-content">&nbsp;내용
									<textarea  id="ir1" class="w3-input w3-border" rows="10" cols="30" 	name="content">
										${diary.content}
									</textarea>
									<!-- <textarea id="ir1" class="w3-input w3-border" rows="10" cols="30"
										style="width: 950px; height: 400px;" name="content">
									</textarea> -->
								</div>
							</div>
							
						</div>
						<!--end. 묶음 -->
						
												
						
						<!-- filename, size는 나중에..ㅠㅠㅠ -->
						
						<!-- 전송 -->
						<div class="w3-center" style="margin: 1%;">
							<input class="w3-button w3-white" type="button" onclick="submitContents(this);" value="저장" />
							&nbsp;
							<input class="w3-button w3-yellow" type="button" value="취소" onClick = "history.back();"/>
							
							<input type="hidden" name="diaryid" value="${diary.diaryid}">
							<input type="hidden" name="email" value="${diary.email}">
							<input type="hidden" name="num" value="${diary.num}">
							<input type="hidden" name="pageNum" value="${pageNum}">	
							
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
	<%-- <% } catch (Exception e) {} %> --%>
</div>
<script type="text/javascript">
	var oEditors = [];
	
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "ir1",
		sSkinURI: "/Story_Blog_m2/SE2/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["ir1"].getIR();
		alert(sHTML);
	}
		
	function submitContents(elClickedObj) {
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>
<!-- end. 전체 틀 div ★ --> 

</body>
</html>

