$(function(){
	$("#comment table").hide(); //1
	
	function getList(){
		$.ajax({
			type:"post",
			url:"CommentList.bo",
			data: {"BOARD_RE_REF" : $("#BOARD_RE_REF").val()},
			dataType:"json",
			success:function(rdata){
				if(rdata.length>0){
					$("#comment table").show(); //문서가 로딩될 때 hide() 했던 부분을 보이게 합니다. 
					$("#comment thead").show(); //글이 있을 때 hide() 부분을 보이게 합니다.
					$("#comment tbody").empty();
					$("#message").text('');
					output='';
					$(rdata).each(function(){
						img='';
						if($("#loginid").val()==this.id){
							img="<img src='resources/image/pencil2.png' width='15px' class='update'>"+
								"<img src='resources/image/remove.png' width='15px' class='remove'>" +
								"<input type='hidden' value='"+ this.num + "'>";
								
						}
						output += "<tr><td>" + this.id + "</td>";
						if(this.content!=null){
							output += "<td>" + this.content + "</td>";
						} else{
							output += "<td>" + "" + "</td>";
						}
						
						output += "<td>" + this.reg_date + img + "</td></tr>";
					});
					$("#comment tbody").append(output);
					
				} else {
					$("#comment tbody").empty();
					$("#message").text("등록된 댓글이 없습니다.")
					$("#comment thead").hide(); //2
				}
				    $("#count").text(rdata.length);
			}
		})

	}
	
	$(".start").click(function(){
		getList();

	}) //click end

	//글자수 50개 제한 이벤트
	$("#content").on('input',function(){
		length=$(this).val().length;
		if(length>50){
			length=50;
			content = content.substring(0,length);
		}
		$(".float-left").text(length + "/50")
	})
	
	$("#write").click(function(){
		buttonText = $("#write").text();  //버튼의 라벨로 add할지 update
		content = $("#content").val();
		$(".float-left").text("총 50자까지 가능합니다.");
		if(buttonText=="등록"){ //댓글을 추가하는 경우
			url = "CommentAdd.bo";
			data = {"content": content,
			        "id":$("#loginid").val(),
			        "BOARD_RE_REF": $("#BOARD_RE_REF").val()};
			
		} else {
			url = "CommentUpdate.bo";
			data = {"num":num, "content":content};
			$("#write").text("등록"); //다시 등록으로 변경
		}
		$.ajax({
			type:"post",
		    url:url,
		    data:data,
		    dataType:"json",
		    success:function(result){
		    	$("#content").val('');
		    	if(result==1){
		    		getList();
		    	}
		    }
		}) //ajax end
		
	}) //$("#write") end
	
	//pencil2.png 클릭시(수정)
	$("#comment").on('click','.update',function(){
		before = $(this).parent().prev().text(); // 선택한 내용 가져옵니다.
		$("#content").focus().val(before); //textarea에 수정전 내용을 보여줍니다.
		num = $(this).next().next().val(); // 수정할 댓글 번호를 저장합니다.
		$("#write").text("수정완료"); //등록버튼의 라벨을 '수정완료' 로 변경합니다.
		$(this).parent().parent().css('backgorund','lightgray');
		
	})
	
	//remove.png 클릭시
	$("#comment").on('click','.remove',function(){
		var num = $(this).next().val(); //댓글 번호
		
		$.ajax({
			type:"post",
			url:"CommentDelete.bo",
			data: {"num" : num},
			success: function(result){
				if(result==1){
					getList();
				}
			}
		}) //ajax end
		
	})
	
})




