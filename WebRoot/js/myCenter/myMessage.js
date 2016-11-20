/**
 * Created by 甜橙六画 on 2016/11/8.
 */
$(function() {
	//选择框
	$(".selectCase").click(function(){
        if($(this).is(".checked")){
           $(this).removeClass("checked");
        }else{
            $(this).addClass("checked");
        }
    });
	//全选框
    $(".allCase").click(function(){
        if($(".mytable .checked").length<$(".mytable .selectCase").length){
            $(".mytable .selectCase").addClass("checked");
        }else{
            $(".mytable .selectCase").removeClass("checked");
        }
    });
    //表格的选择框
    $(".mytable .selectCase").click(function(){
        if($(".mytable .checked").length<$(".mytable .selectCase").length){
            $(".allCase").removeClass("checked");
        }else{
            $(".allCase").addClass("checked")
        }
        return false;
    });
    //回复按钮
    $(".reply").click(function(){
    	$(".right").removeClass("selectState");
    	$(".right").addClass("sendState");
    	$(".receiveUser").val($(".selectReceiveUser").html());
    	checkExist($(".receiveUser")[0]);
    })
    //判断用户是否存在 
    $(".receiveUser").blur(function(){
    	checkExist(this);
    })
    //发送消息
    $(".send").click(function(){
    	if($(".receiveUser").attr("sendid")==''){
    		$(".receiveUser").tooltip("show");
    		setTimeout(function(){
				$(".receiveUser").tooltip("destroy");
			},5000)
			return;
    	}
    	if($(".textContent").val()=='')return;
    	var data = "receiveID="+$(".receiveUser").attr("sendid")+"&content="+$(".textContent").val();
    	$.post("json/myMessage_send",data,function(data) { // 此处可以因为版本问题导入包commons-lang-2.3.jar
			if (data != null) {
				data = eval("(" + data + ")");
				if(data.message){
					$(".receiveUser").val("");
					$(".receiveUser").attr("sendid","");
					$(".textContent").val("")
					$(".textContent").attr("title",i18n.get("sendSuccess"));
					$(".textContent").tooltip("show");
					$(".receiveUser").attr("source","");
					setTimeout(function(){
						$(".textContent").tooltip("destroy");
					},5000)
				}else{
					$(".send").attr("title",i18n.get("sendFailure")+message.cause);
					$(".send").tooltip("show");
					setTimeout(function(){
						$(".send").tooltip("destroy");
					},5000)
				}
			}
    	})
    })
    //点击查看
    $(".mytable tr").click(function(){
    	$(".selectReceiveUser").html($(this).find(".sendNameTD").html());
    	$(".selectTextContent").html($(this).find(".contentTD").html());
    	$(this).find(".isnew").remove();
    	$(".right").removeClass("sendState");
    	$(".right").addClass("selectState");
    	selectMessage($(this));
    })
     //删除多个
    $(".deleteMany").click(function(){
    	var checked = $(".mytable .selectCase.checked").parents("tr");
    	deleteMessage(checked);
    })
    //显示删除
    $(".mytable tr").bind("mouseover",function(){
    	$(this).find(".delete").show();
    })
    //隐藏删除
    $(".mytable tr").bind("mouseout",function(){
    	$(this).find(".delete").hide();
    })
    //标记为已读
    $(".signMany").click(function(){
    	var checked = $(".mytable .selectCase.checked").parents("tr");
    	selectMessage(checked);
    })
})
function checkExist(el){
	var val = el.value;
	if(val==$(el).attr("source"))return;
	if(val==''||val.trim()=='')return;
	$.post("json/myMessage_checkIsExist","username="+$(el).val(),function(data) { // 此处可以因为版本问题导入包commons-lang-2.3.jar
		if (data != null) {
			data = eval("(" + data + ")");
			if(data.message){
				 $(".receiveUser").attr("sendID",data.id);
				 $(".receiveUser").attr("source",val);
			}else{
				if(data.cause!=null){
					$(".receiveUser").attr("title",data.cause);
				}else{
					$(".receiveUser").attr("title",i18n.get("receiveNoExist"));
				}
				$(".receiveUser").tooltip("show");
				 $(".receiveUser").attr("sendID","");
				 $(".receiveUser").attr("source",val);
				setTimeout(function(){
					$(".receiveUser").tooltip("destroy");
				},5000)
			}
		}
	})
}
function selectMessage(arr){
	var data="";
	for(var i=0;i<arr.length;i++){
		if($(arr[i]).attr("isNew")!='1')continue;
		$(arr[i]).attr("isNew","0");
		$(arr[i]).find(".isnew").remove();
		if(i==arr.length-1){
			data += "ids="+$(arr[i]).attr("data-id");
		}else
		data += "ids="+$(arr[i]).attr("data-id")+"&";
	}
	if(data=='')return;
	$.post("json/myMessage_selected",data,null)
}
function deleteMessage(arr){
	var data="";
	for(var i=0;i<arr.length;i++){
		if(i==arr.length-1){
			data += "ids="+$(arr[i]).attr("data-id");
		}else
		data += "ids="+$(arr[i]).attr("data-id")+"&";
	}
	if(data=='')return;
	$.post("json/myMessage_delete",data,function(data){
		if (data != null) {
			data = eval("(" + data + ")");
			if(data.message){
				for(var i=0;i<arr.length;i++){
					$(arr[i]).remove();
				}
			}else{
				alert(i18n.get("deleteFailure"));
			}
		}
	})
}