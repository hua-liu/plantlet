/**
 * Created by 甜橙六画 on 2016/11/8.
 */
$(function() {
	$(".bodyLoader").remove();
    $(".nickname").click(function(){
        var input = $("<input type='text' class='nicknameModifyInput' source="+$(".nickname").html()+" />");
        input.val($(".nickname").html());
        $(".nickname").hide();
        $(this).hide();
        $(this).parent().before(input);
        $(".nicknameModifyInput").blur(function(){
        	changeNickname(this.value,$(this).attr("source"));
            $(".nickname").html(this.value);
            $(".nickname").show();
            $(this).remove();
        })
        $(".nicknameModifyInput").keyup(function(e){
            if(e.keyCode==13){
                $(".nickname").html(this.value);
                changeNickname(this.value,$(this).attr("source"));
                $(".nickname").show();
                $(this).remove();
            }
        })
    });
    $("#modifyPhotoModal").on("show.bs.modal",function(){
       $("#modifyPhotoModal .modal-body img").attr("src",$(".photo").attr("src"));
    });

    $("#selectPicture").bind("click",function(){
        $(".avatar-input").trigger("click");
    });

    $(".menu").click(function(){
    	if($(this).attr("data")=='myMessage'){
    		$(this).css("border-color","#999")
    	}
        $("#contentModalLabel").html($(this).find("p").html());
        $(".iframeContent").html("");
        $(".iframeContent").attr("src","center_"+$(this).attr("data"));
        $("#contentModal").modal("show");
        $(".myContentBody").append($('<div class="loader"><div class="loader-inner square-spin"><div></div></div></div>'));
    })
    $.post("json/myMessage_isHasNewMessage","",function(data){
    	if(data!=null){
    		data = eval("("+data+")");
    		if(data.message){
    			$(".menu[data=myMessage").css("border-color","#0F0")
    			$("#sound")[0].play();
    		}
    	}
    })
});
//修改昵称
function changeNickname(name,source){
	if(name==null||name!=null&&name.trim()=='')return;
	if(name==source)return;
	$.post("json/myCenter_modifyNickname","onlyNickname="+name,function(data){
		if(data==null)alert("昵称更改失败");
		if(data=='input'){
			window.location.href="loginUi?url="+window.location.href.substr(7);
		}else if(data!=null){
			data = eval("("+data+")");
			if(!data.message){
				alert("昵称更改失败");
			}
		}
	})
}
function updateHeadPhoto(x,y,width,height){
	if((width+height)>0){
	x=Math.round(x);
	y=Math.round(y);
	width=Math.round(width);
	height=Math.round(height);
	$.ajaxFileUpload({
		url:"json/uploadHeadPhoto_file?x="+x+"&y="+y+"&width="+width+"&height="+height,// 用于文件上传的服务器端请求地址
		secureuri : false,// 一般设置为false
		fileElementId : 'file',// 文件上传空间的id属性
		dataType : 'json',// 返回值类型 一般设置为json
		success : function(data) {
			if(data!=null){
				data = eval("(" + data + ")");
				if (data.message) {
					$("#avatar-modal").modal("hide");
					window.location.reload();
				} else {
					alert("上传失败");
				}
			}
			
		}
	})
	}
}
