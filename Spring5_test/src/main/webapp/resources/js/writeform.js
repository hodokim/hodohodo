$(document).ready(function(){
	

 $("#upfile").change(function(){
	 $('#filevalue').val('');
	 console.log($(this).val());
	 var inputfile=$(this).val().split('\\');
	 $('#filevalue').text(inputfile[inputfile.length-1]);
 });
 
 
	var check = 0;
	
	//등록 버튼 클릭할 때 이벤트 부분
	$("form").submit(function(){
		
		if($.trim($("#board_pass").val())=="") {
			alert("비밀번호를 입력하세요");
			$("#board_pass").focus();
			return false;
		}
		
		if($.trim($("#board_subject").val())=="") {
			alert("제목을 입력하세요");
			$("#board_subject").focus();
			return false;
		}
		
	})





function show() {
	if($('#filevalue').text()==''){
		$(".remove").css('display','none');
	} else {
		$('.remove').css('display','inline-block');
	}
	
}

$("#upfile").on("change", function() {
	check++;
	var inputfile = $(this).val().split('\\');
	$('#filevalue').text(inputfile[inputfile.length - 1]);
	show();
	});
	
	// remove 이미지를 클릭하면 파일명을 ''로 변경하고 remove 이미지를 보이지 않게 합니다.
	$(".remove").click(function(){
		$('#filevalue').text('');
	    $(this).css('display','none');
	    $("input[name=BOARD_ORIGINAL]").val('');
	    $("input[name=BOARD_FILE").val('');
	})
});