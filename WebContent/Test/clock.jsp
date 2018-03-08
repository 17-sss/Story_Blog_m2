<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
	<style type="text/css">
		.watch {
			width: 220px;
			height: 220px;
			background: black;
			border-radius: 50%;
			display: -webkit-box;
			display: -webkit-flex;
			display: -ms-flexbox;
			display: flex;
			-webkit-box-pack: center;
			-webkit-justify-content: center;
			-ms-flex-pack: center;
			justify-content: center;
			-webkit-box-align: center;
			-webkit-align-items: center;
			-ms-flex-align: center;
			align-items: center;
			position: relative;
			overflow: hidden;
			border: 7px solid #111;
		}
		
		.watch--hour {
			width: 5px;
			height: 80px;
			border-radius: 10px;
			-webkit-transform-origin: center 65px;
			transform-origin: center 65px;
			-webkit-transform: rotate(0deg);
			transform: rotate(0deg);
			position: absolute;
			background: #111;
			left: calc(50% - 2.5px);
			top: calc(50% - 65px);
		}
		
		.watch--min {
			width: 5px;
			height: 110px;
			border-radius: 10px;
			-webkit-transform-origin: center 90px;
			transform-origin: center 90px;
			-webkit-transform: rotate(0deg);
			transform: rotate(0deg);
			position: absolute;
			background: #333;
			left: calc(50% - 2.5px);
			top: calc(50% - 90px);
		}
		
		.watch--sec {
			width: 5px;
			height: 130px;
			border-radius: 10px;
			-webkit-transform-origin: center 100px;
			transform-origin: center 100px;
			-webkit-transform: rotate(0deg);
			transform: rotate(0deg);
			position: absolute;
			background: #666;
			left: calc(50% - 2.5px);
			top: calc(50% - 100px);
		}
		
		.watch--center {
			position: absolute;
			width: 10px;
			height: 10px;
			background: black;
			border-radius: 50%;
			left: calc(50% - 7px);
			top: calc(50% - 7px);
			border: 2px solid #ddd;
		}
		
		.day {
			width: 220px;
			height: 220px;
			position: absolute;
			background: #789abc;
			left: 0;
			top: 0;
		}
		
		.day--ground {
			position: absolute;
			width: 220px;
			height: 80px;
			background: green;
			bottom: 0;
		}
		
		.day--sun {
			width: 60px;
			height: 60px;
			background: yellow;
			border-radius: 50%;
			position: absolute;
			left: 60px;
			top: 35px;
		}
		
		.day--clouds {
			position: absolute;
			width: 50px;
			height: 50px;
			background: #ddd;
			border-radius: 50%;
			left: 110px;
			top: 35px;
		}
		
		.day--clouds::before {
			content: "";
			width: 25px;
			position: absolute;
			height: 25px;
			background: #ddd;
			left: -10px;
			top: 20px;
			border-radius: 50%;
		}
		.day--clouds::after {
			content: "";
			width: 40px;
			position: absolute;
			height: 40px;
			background: #ddd;
			left: 30px;
			top: 10px;
			border-radius: 50%;
		}
		
	</style>
	<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script type="text/javascript">
	$(document)
	.ready(
			function() {
				var seconds = new Date().getSeconds(), minutes = new Date()
						.getMinutes(), hours = new Date().getHours(), sdegree = seconds * 6, mdegree = minutes * 6, hdegree = hours * 30;

				$('.watch--sec').css('transform',
						'rotate(' + sdegree + 'deg)');
				$('.watch--min').css('transform',
						'rotate(' + mdegree + 'deg)');
				$('.watch--hour').css('transform',
						'rotate(' + hdegree + 'deg)');

				setInterval(
						function() {
							var seconds = new Date().getSeconds(), minutes = new Date()
									.getMinutes(), hours = new Date()
									.getHours(), sdegree = seconds * 6, mdegree = minutes * 6, hdegree = hours * 30;
							$('.watch--sec').css('transform',
									'rotate(' + sdegree + 'deg)');
							$('.watch--min').css('transform',
									'rotate(' + mdegree + 'deg)');
							$('.watch--hour').css('transform',
									'rotate(' + hdegree + 'deg)');
						}, 1000)

			})
	</script>
	
</head>
<body>
<div class="watch">
	<div class="watch--inner"></div>
	<div class="watch--day day">
		<div class="day--sun"></div>
		<div class="day--clouds"></div>
		<div class="day--ground"></div>
	</div>
	<div class="watch--night night">
		<div class="night--moon"></div>
		<div class="night--clouds"></div>
		<div class="night--ground"></div>
	</div>
	<div class="watch--hour"></div>
	<div class="watch--min"></div>
	<div class="watch--sec"></div>
	<div class="watch--center"></div>
</div>
</body>
</html>