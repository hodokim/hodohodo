<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<meta charset='UTF-8'>
<meta name="robots" content="noindex">
<link rel="shortcut icon" type="image/x-icon"
	href="//production-assets.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" />
<link rel="mask-icon" type=""
	href="//production-assets.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg"
	color="#111" />
<link rel="canonical"
	href="https://codepen.io/emilcarlsson/pen/ZOQZaV?limit=all&page=74&q=contact+" />
<link
	href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600,700,300'
	rel='stylesheet' type='text/css'>

<script>
$(function(){
	

	ws = new WebSocket("ws://localhost:8088/myhome/boot.do?id=" + '${name}' + "&filename=" + '${filename}');

	

	$(window).on('keyup', function(e) {
		if (e.keyCode == 13) {
			var message = newMessage(); //화면에 보이는 메시지 전송
			if (message) { //메시지가 존재하는 경우
				send(message);
			}
			return false;
		}
	});

	$(".exit").click(function() {	
		if(confirm("정말로 나가시겠습니까?")){
			send("${name}님이 퇴장하셨습니다.out")
			ws.close();
		}
		
	})

	ws.onopen = function(event) {
		console.log("접속");
		if (event.data === undefined)
			return;
	};

	//서버에서 전송하는 데이터를 받으려면 message이벤트를 구현하면 됩니다.
	//웹 소켓에서 메시지가 날아왔을 때 호출되는 이벤트입니다.
	ws.onmessage = function(event) {
		console.log("리스판스() 찍혔냐?:" + event.data);
		response(event.data);

	}

	//웹 소켓이 닫혔을 때 호출되는 이벤트입니다.
	ws.onclose = function(event) {
		console.log("웹 소켓 닫힘");
		location.href='logout';
	}
	
	
	function send (message){
         ws.send(message);
     }
	
	
	function newMessage() {
		message = $(".message-input input").val();
		if($.trim(message) == '') {
			return false;
		}
		output = '<li class="sent">'
		+'<img src="resources/upload${filename}" alt="" /><p></p></li>'
		$(output).appendTo($('.messages ul'));
		//입력한 내용등를 문자열로 벼환하기 위해 text()를 이용합니다.
		$('.messages>ul>li').last().find('p').text(message);
		$('.message-input input').val(null);
		
		moveScroll();
		
		return message;
	};
	
	function response(text) {
		//text의 전달 형식 -java&/2019-7-4/bbs~~~~.png&1234
		arr = text.split('&')
		message = arr[2];
		var out = "님이 퇴장하셨습니다.out";
		var inin = "님이 입장하셨습니다.in";
		
		//입장과 퇴장의 경우 css가 가운데로 위치해야 해서 클래스 inout을 이용합니다.
		if(message.indexOf(out) > -1 || message.indexOf(inin)>-1) {
			index = message.lastIndexOf('.');
			output = "<li class='inout'><p></p></li>"
			message = message.substring(0,index);
		} else {
			name = arr[0];
			filename = arr[1];
			output = "<li class='replies'>"
			         + "<img src='resources/upload" + filename + "'>"
			         + "<sup>" + name + "</sup><p></p></li>"
		}
		
		$("#frame > div.content > div.messages > ul").append(output);
		$('.messages>ul>li').last().find('p').text(message);
		
		moveScroll();
	}	
	
	function moveScroll () {
		$('.messages').scrollTop($('.messages').prop('scrollHeight'));
	}
	
	
	
});
</script>
<link rel='stylesheet prefetch'
	href='https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css'>
<link rel='stylesheet prefetch'
	href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.2/css/font-awesome.min.css'>
<link rel="stylesheet" href="resources/css/chat.css">
<style>
#frame .content {
	width: 100%
}

sup {
	/*  position: relative;
    top: -20px;
    right: 30px; */
	top: -10px;
	right: -97%;
	font-size: 3px;
}

.inout {
	text-align: center;
}
</style>
<title>boot.jsp</title>
</head>
<body>
	<div id="frame">
		<div class="content">
			<div class="contact-profile">
				<img src="resources/upload${filename}" alt="" />
				<p>${name}</p>
				<div class="social-media">
					<i class="fa fa-facebook" aria-hidden="true"></i> <i
						class="fa fa-twitter" aria-hidden="true"></i> <i
						class="fa fa-instagram" aria-hidden="true"></i>
				</div>
			</div>
			<div class="messages" style="overflow: auto;" type="">
				<ul>

				</ul>
			</div>
			<div class="message-input">
				<div class="wrap">
					<input type="text" id="write" placeholder="Write your message..." />
					<button class="exit">나가기</button>
				</div>
			</div>
		</div>
	</div>
	<script
		src='//production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js'></script>


</body>
</html>