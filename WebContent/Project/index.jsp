<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<title>Story Blog - MAIN</title>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<!--- <link rel="stylesheet" href="../w3.css"> -->

	<style>
	/*=================== ����ȭ�� ====================*/
		body,h1 {font-family: "consolas", sans-serif}
		body, html {height: 100%}
		.bgimg {
		    background-image: url("/Story_Blog_m2/Project/img/back1.jpg");
		    min-height: 100%;
		    background-position: center;
		    background-size:cover;
		}
		#nounder{
			text-decoration: none;
		}
	/*=================== �α��� �� ���� ===================*/
		/* Full-width input fields */
		input[type=text], input[type=password] {
		    width: 100%;
		    padding: 12px 20px;
		    margin: 8px 0;
		    display: inline-block;
		    border: 1px solid #ccc;
		    box-sizing: border-box;
		}
		
		/* Set a style for all buttons */
		/* button {
		    background-color: #4CAF50;
		    color: white;
		    padding: 14px 20px;
		    margin: 8px 0;
		    border: none;
		    cursor: pointer;
		    width: 100%;
		} */
		#btn {
		    background-color: #4CAF50;
		    color: white;
		    padding: 14px 20px;
		    margin: 8px 0;
		    border: none;
		    cursor: pointer;
		    width: 100%;
		}
		
		button:hover {
		    opacity: 0.8;
		}
		
		/* Extra styles for the cancel button */
		.cancelbtn {
		    width: auto;
		    padding: 10px 18px;
		    background-color: #FFB2F5;
		    
		}
		
		/* Center the image and position the close button */
		.imgcontainer {
		    text-align: center;
		    margin: 24px 0 12px 0;
		    position: relative;
		}
		
		img.logo {
		    width: 35%;
		    border-radius: 50%;
		}
		
		.container {
		    padding: 16px;
		}
		
		span.psw {
		    float: right;
		    padding-top: 16px;
		}
		
		/* The Modal (background) */
		.modal {
		    display: none; /* Hidden by default */
		    position: fixed; /* Stay in place */
		    z-index: 1; /* Sit on top */
		    left: 0;
		    top: 0;
		    width: 100%; /* Full width */
		    height: 100%; /* Full height */
		    overflow: auto; /* Enable scroll if needed */
		    background-color: rgb(0,0,0); /* Fallback color */
		    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
		    padding-top: 60px;
		}
		
		/* Modal Content/Box */
		.modal-content {
		    background-color: #fefefe;
		    margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
		    border: 1px solid #888;
		    width: 43%; /* Could be more or less, depending on screen size */
		}
		
		/* The Close Button (x) */
		.close {
		    position: absolute;
		    right: 25px;
		    top: 0;
		    color: #000;
		    font-size: 35px;
		    font-weight: bold;
		}
		
		.close:hover,
		.close:focus {
		    color: red;
		    cursor: pointer;
		}
				
		
		/* Add Zoom Animation */
			.animate {
			    -webkit-animation: animatezoom 0.6s;
			    animation: animatezoom 0.6s
			}
		
		/* Change styles for span and cancel button on extra small screens */
		@media screen and (max-width: 300px) {
		    span.psw {
		       display: block;
		       float: none;
		    }
		    .cancelbtn {
		       width: 100%;
		    }
		}
		
		@keyframes animatezoom {
		    from {transform: scale(0)} 
		    to {transform: scale(1)}
		}
		
		@-webkit-keyframes animatezoom {
		    from {-webkit-transform: scale(0)} 
		    to {-webkit-transform: scale(1)}
		}
		#label-text{
			color: black;
		}
				
	</style>
	
	 <script type="text/javascript">

	  	/*  
	  	// ȸ������ ��ư Ŭ���� ȸ������ ȭ������ �̵�
	     function goaccountForm() {
	         location.href="accountForm.jsp";
	     }     
	     */
    	
        function checkValue()
        {
            inputForm = eval("document.loginInfo");
            if(!inputForm.email.value)
            {
                alert("���̵� �Է��ϼ���");    
                inputForm.email.focus();
                return false;
            }
            if(!inputForm.pwd.value)
            {
                alert("��й�ȣ�� �Է��ϼ���");    
                inputForm.pwd.focus();
                return false;
            }
        }
    
     
        
        // Get the modal
        var modal = document.getElementById('login');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
<body>
<!-- ��ü -->
<div class="bgimg w3-display-container w3-animate-opacity w3-text-white">

	<!-- �⺻ ������ (�߾�) -->
	  <div class="w3-display-middle">
	    
	    <h1 class="w3-jumbo w3-animate-top"><a href="index" id="nounder">Story Blog</a></h1>
	    <hr class="w3-border-gray" style="margin:auto; width:40%">
	    <p class="w3-large w3-center">You & I</p>
	 
	    <p class="w3-large w3-center">
		    <button class="w3-button w3-pink w3-padding-large w3-large w3-margin-top"
		    onclick = "document.getElementById('login').style.display='block'">Login</button>
		</p>
		
		<p class="w3-center w3-small"><a href="<%=request.getContextPath() %>/story/accountForm">Sign Up</a></p>
	     
	  </div>
	  <!-- end. �⺻ ������ (�߾�) --> 
	  
   <!-- �α��� modal --> 
	     <div id="login" class="modal">
	     
	        <!-- �α��� �� -->
	     <form class="modal-content animate" name="loginInfo" method="post" action="<%=request.getContextPath() %>/story/LoginPro" onsubmit="return checkValue()">
	     
		    	
		    	<!-- �α��� �ΰ� -->
		    	<div class="imgcontainer">
		      		<span onclick="document.getElementById('login').style.display='none'" class="close" title="Close Modal">&times;</span>
		      		<img src="<%=request.getContextPath() %>/Project/img/Kirby_logo.jpg" alt="Logo" class="logo">
		    	</div>
		    	<!-- end. �α��� �ΰ� -->
		    	
	    	<!-- �α��� �Է��� -->
	    	<div class="w3-container">
	    		<label id="label-text"><b>E-mail</b></label>
			      <input type="text" placeholder="�̸����� �Է��ϼ���" name="email" required>
			    <label id="label-text"><b>Password</b></label>
			      <input type="password" placeholder="��й�ȣ�� �Է��ϼ���" name="pwd" required>
			    <!-- <label id="label-text" class="w3-right">
			    	<input type="checkbox" checked="checked">Remember me
			    </label> -->	
	    		
		    	<div class="w3-center">
		    		 <input class="w3-button w3-pink w3-large" id="btn" type="submit" value="Login"/>
			    </div>
			    
			    <div class= "container">
	    			<p class="w3-right">
	    				<a href="<%=request.getContextPath() %>/story/accountForm" class="w3-text-black">Sign Up</a>
	    			</p>
	    		</div>
		    </div>
		    <!-- end. �α��� �Է��� -->
		    
		      <!-- ��� ã����? (�̿�) -->
	    	<div class="container" style="background-color:#f1f1f1">
			      <p class="w3-center">
				      <button type="button" onclick="document.getElementById('login').style.display='none'" 
				      			class="cancelbtn w3-button w3-red">Cancel</button>
			      </p>
			     <!--  <span class="psw">Forgot <a href="#">password?</a></span> -->
    	    </div>
    	      <!-- end. ��� ã����? (�̿�) -->
		  </form>
		   <!-- end. �α��� �� -->
		 </div>
   <!--end. �α��� modal -->
		
	
	  <!-- �̸���, ��� Ʋ�� ��� -->
	  <div class="w3-center">
	  <% 
            String msg=request.getParameter("msg");
            
            if(msg!=null && msg.equals("0")) 
            {
                out.println("<script>alert('��й�ȣ�� Ȯ���� �ּ���.');</script>");
            }
            else if(msg!=null && msg.equals("-1"))
            {    
            	out.println("<script>alert('�̸����� Ȯ���� �ּ���.');</script>");
            }
        %> 
        </div>
      <!-- end. �̸���, ��� Ʋ�� ��� -->
</div>
<!-- end. ��ü -->
</body>

</html>