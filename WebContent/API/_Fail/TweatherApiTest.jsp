<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script>

var weatherStatusCode=''
url =https://apis.sktelecom.com/v1/weather/status?latitude={latitude}&longitude={longitude}
config={
		'Content-Type:':'application/json',
		'TDCProjectKey': '4c3066d4-20f2-4861-b04d-2c21af7765f3'
		
}

/* response
{
    "weatherStatusCode":0,
    "weatherStatusDescription":"알수없음",
    "weatherModifyCode":0,
    "weatherModifyDescription":"알수없음"
} */



$.ajax.post(url,'',config).then((response)=>{
	console.log(response.data['weatherStatusCode'])
	console.log(response.data['weatherStatusDescription'])
	this.weatherStatusCode= response.data['weatherStatusCode']
}).catch((response)=>{
	console.log(response.data)
})
</script>
</head>
<body>
=====================
<script>
</script>
</body>
</html>
