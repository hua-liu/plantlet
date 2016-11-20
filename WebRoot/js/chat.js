$(function(){
	//发送快捷键监听
	$(".myInput").keydown(function(e){
		if(sendKey=="ce"){
			if(e.ctrlKey&&e.keyCode==13){
				sendMessage($("#myInput").val());
				createMessage($(".myInput").val());
			}
		}
		if(sendKey=="se"){
			if(e.shiftKey&&e.keyCode==13){
				sendMessage($("#myInput").val());
				createMessage($(".myInput").val());
			}
		}
		if(sendKey=="e"){
			if(e.keyCode==13){
				sendMessage($("#myInput").val());
				createMessage($(".myInput").val());
			}
		}
	})
	//发送按钮监听
	$(".send").bind("click",function(){
		sendMessage($("#myInput").val());
		createMessage($("#myInput").val());
	})
	//选择发送快捷键监听 
	$(".selectSendMenu li").bind("click",function(){
		sendKey = $(this).attr("data");
	})
	setScrollatBottom();//设置滚动条在底部
	//显示隐藏消息记录
	$(".recordSwitch").click(function(){
		$(".messageRecord").toggle();
		if(!$(".messageRecord").is(":hidden")){
			if(systemServer!=i18n.get('systemMessage')){
				if(recordPage<=0){//首次使用发送记录请求
					sendMessage("record:"+recordPage+"make:+");
				}
			}
		}
	})
	//关闭消息记录
	$(".winCloseRecord").click(function(){
		$(this).parents(".messageRecord").hide();
	})
	//关闭聊天窗口
	$(".winClose").click(function(){
		if(confirm(i18n.get('closeChatWarning'))){
			$(this).parents(".chatWinBox").hide();
			closeWebSocket();
		}
	})
	$(".myColorpicker").colorpicker();//监听颜色控件
	//字体设置点击监听
	$(".fontSetButton").click(function(){
		$(".fontSet").slideToggle();
	})
	//字体选择监听
	$(".fontSet .font select").change(function(){
		setFont($(this).val());
	})
	//表情
	$('.emotion').qqFace({
		id : 'facebox', 
		assign:'myInput', 
		path:'css/face/img/'	//表情存放的路径
	});
	//发送图片
	$(".sendPicture").click(function(){
		$("#file").trigger("click");
	})
	
	//文件选择后监听
	// 图片上传监听
	$(".fileBox").bind("change",function() {
		createPictureMessage("chatContent",null);
		$.ajaxFileUpload({
			url : "json/uploadChatPic_file",// 用于文件上传的服务器端请求地址
			secureuri : false,// 一般设置为false
			fileElementId : 'file',// 文件上传空间的id属性
			dataType : 'json',// 返回值类型 一般设置为json
			success : function(data) {
				data = eval("(" + data + ")");
				if (data.message) {
					$(last).find("img").attr("src","json/downloadChatPic_file?id="+data.id);
					sendMessage("img:"+data.id);
				} else {
					alert(i18n.get('sendFailure')+data.cause);
				}
			}
		})

	})
	$(".chatPic").bind("click",function(){
		$.append($("<img class='showPictrueMore' src='"+this.src+"'>"));
	})
	//设置图片点击监听
	setPicClick();
	$(".messageRecord .foot .left").click(function(){
		if(recordPage!=0)
		sendMessage("record:"+recordPage+"make:-");
	})
	$(".messageRecord .foot .right").click(function(){
		sendMessage("record:"+recordPage+"make:+");
	})
})
var recordPage=0;
var sendKey="ce";	//保存当前发送消息快捷键
var color="#000";	//当前消息文本颜色
var fontSize=15;	//当前消息文本字体大小
var font="宋体";		//当前消息文本字体
var last;
//设置颜色
function setColor(){
	color=$(".myColorpicker input").val();
	setAllFont();
}
//设置字体大小
function setFontSize(num){
	fontSize=num;
	setAllFont();
}
//设置字体
function setFont(f){
	font=f;
	setAllFont();
}
//设置输入框与消息框 
function setAllFont(){
	$(".myInput").css({"color":color,"font-size":fontSize,"font-family":font});
	$(".right .direct-chat-text").css({"color":color,"font-size":fontSize,"font-family":font});
}
function setPicClick(){
	//添加图片点击事件
	$(".chatPic").unbind();
	$(".chatPic").bind("click",function(){
		$(".showPictrueMore").attr("src",this.src);
		//$("body").append($("<img class='showPictrueMore' src='"+this.src+"'>"));
		$("#showPicture").modal("show");
	})
}
//替换为表情
function replace_em(str){
	str = str.replace(/\</g,'&lt;');
	str = str.replace(/\>/g,'&gt;');
	str = str.replace(/\n/g,'<br/>');
	str = str.replace(/\[em_([0-9]*)\]/g,'<img src="css/face/img/$1.gif" border="0" />');
	return str;
}
//创建一个图片消息
function createPictureMessage(className,imgID){
	var newNode = $('<div class="direct-chat-msg right"><div class="direct-chat-info clearfix"><span class="direct-chat-name pull-right">'+currentUserName+'</span>'
		+'<span class="direct-chat-timestamp pull-right">'+new Date().Format("yyyy-MM-dd hh:mm:ss")+'</span></div><img class="direct-chat-img" src="img/duola1.png">'
		+'<div class="direct-chat-text"><img src="'+(imgID!=null?"json/downloadChatPic_file?id="+imgID:"img/loading.gif")+'" class="chatPic"/></div></div>');
	$("."+className).append(newNode);
	last=$(newNode).find(".direct-chat-text");
	$(".myInput").val("");
	setAllFont();
	setScrollatBottom();
	//延时设置滚动条在底部
	setTimeout(function(){
		setScrollatBottom();
	},1000)
	//设置图片点击监听
	setPicClick();
}
//创建一个图片消息
function createSystemPictureMessage(className,id){
	var newNode = $('<div class="direct-chat-msg"><div class="direct-chat-info clearfix"><span class="direct-chat-name">'+currentUserName+'</span>'
		+'<span class="direct-chat-timestamp">'+new Date().Format("yyyy-MM-dd hh:mm:ss")+'</span></div><img class="direct-chat-img" src="img/duola1.png">'
		+'<div class="direct-chat-text"><img src="json/downloadChatPic_file?id='+id+'" class="chatPic"/></div></div>');
	$("."+className).append(newNode);
	last=$(newNode).find(".direct-chat-text");
	$(".myInput").val("");
	setAllFont();
	setScrollatBottom();
	//延时设置滚动条在底部
	setTimeout(function(){
		setScrollatBottom();
	},1000)
	//设置图片点击监听
	setPicClick();
}
//创建当前消息
function createMessage(val){
	if(val=='')return;
	var newNode = $('<div class="direct-chat-msg right"><div class="direct-chat-info clearfix"><span class="direct-chat-name pull-right">'+currentUserName+'</span>'
		+'<span class="direct-chat-timestamp pull-right">'+new Date().Format("yyyy-MM-dd hh:mm:ss")+'</span></div><img class="direct-chat-img" src="img/duola1.png">'
		+'<div class="direct-chat-text">'+replace_em(val)+'</div></div>');
	$(".chatContent").append(newNode);
	last=$(newNode).find(".direct-chat-text");
	$(".myInput").val("");
	setAllFont();
	setScrollatBottom();
}
var systemServer=i18n.get('systemMessage');
function createSystemMessage(val,time){
	if(val=='')return;
	$(".chatContent").append($('<div class="direct-chat-msg"><div class="direct-chat-info clearfix"><span class="direct-chat-name">'+systemServer+'</span>'
			+'<span class="direct-chat-timestamp">'+time+'</span></div><img class="direct-chat-img" src="img/duola1.png">'
			+'<div class="direct-chat-text">'+replace_em(val)+'</div></div>'));
	$(".myInput").val("");
	setAllFont();
	setScrollatBottom();
}
//创建消息记录
function createRecord(val,time,isSystem){
	if(val=='')return;
	 if(val.indexOf('img:')==0){
		 var imgID = val.substr(4);
		 if(isSystem)
			 createSystemPictureMessage("recordContent",imgID);
		 else
			 createPictureMessage("recordContent",imgID);
	 }else{
		$(".recordContent").append($('<div class="direct-chat-msg '+(isSystem?' ':' right')+'"><div class="direct-chat-info clearfix"><span class="direct-chat-name '+(isSystem?' ':' pull-right')+'">'+(isSystem?systemServer:currentUserName)+'</span>'
			+'<span class="direct-chat-timestamp '+(isSystem?' ':' pull-right')+'">'+time+'</span></div><img class="direct-chat-img" src="img/duola1.png">'
			+'<div class="direct-chat-text">'+replace_em(val)+'</div></div>'));
	 }
	setAllFont();
	setScrollatBottom();
}

//让滚动条在底部
function setScrollatBottom(){
	var content = $(".chatContent").get(0);
	content.scrollTop=content.scrollHeight;	//让滚动条在底部
}
/*websocket服务*/
var webSocket = null;
function openWebSocket(){
	 if ('WebSocket' in window)  
		 webSocket = new WebSocket(webSocketUri);  
     else if ('MozWebSocket' in window)  
    	 webSocket = new MozWebSocket(webSocketUri);  
     else  
         console.error("你浏览器不支持webSocket通信/not support WebSocket!");  
	 webSocket.onmessage=function(evt){
		 if(evt.data!=null){
			 var data = eval("("+evt.data+")");
			 if(data.state=='5'){
				 $(".serverName").html(i18n.get('system'));
				 $(".state").html(i18n.get('serviceBusy'));
				 systemServer=i18n.get('systemMessage');
				 createSystemMessage(data.message,data.time!=null?data.time:'');
			 }else if(data.state=='10'){//表示没客服或正常状态
				 if(data.message.indexOf('img:')==0){
					 var imgID = data.message.substr(4);
					 createSystemPictureMessage("chatContent",imgID);
				 }else
				 createSystemMessage(data.message,data.time!=null?data.time:'');
				 $(".state").html(i18n.get('chating'));
			 }else if(data.state=='1'){//表示发现客服，并将客服名带过来了
				 createSystemMessage(data.message,data.time!=null?data.time:'');
				 systemServer=data.user;
				 $(".serverName").html(systemServer);
				 $(".state").html(i18n.get('serviceOnline'));
			 }else if(data.state=='2'){
				$(last).css("border-bottom","1px solid #050");
			 }else if(data.state=='6'){
				$(".newMessage").html(data.num)
				var sound = $("#sound")[0];
				sound.src="sound/sys.mp3";
				sound.play();
				$(".linkService").html("");
				$(".linkService").append($('<a><h3><span class="username">'+data.user+'</span><small class="pull-right"><span class="messageNum">'+data.num+'</span>'+i18n.get('aMessage')+'</small></h3></a>'));
			 }else if(data.state=='0'){
				 $(".serverName").html(i18n.get('system'));
				 $(".state").html(i18n.get('serviceBusy'));
				 systemServer=i18n.get('systemMessage');
				 $(".linkService h3").html(i18n.get('noNewMessage'));
				 createSystemMessage(data.message,data.time!=null?data.time:'');
			 }else if(data.state=='4'){
				 allowUpload=false;//不允许上传
			 }else if(data.state=='3'){
				 if(data.page!=recordPage){
					 recordPage=data.page;
					 $(".recordContent").html("");
				 }
				 createRecord(data.message,data.time,data.isSystem=='1'?true:false)
				 
			 }
		 }
		 /*crateSystemMessage(evt.data);*/
		 console.info(evt);
	 };
	 webSocket.onclose = function(evt){
		 if(evt.reason!=''){
			 alert(evt.reason)
		 }
		 console.info(evt);
	 };
	 webSocket.onopen = function(evt){
		 console.info(evt);
	 };
}
function closeWebSocket(){
	webSocket.close();
}
function sendMessage(message){
	if(message==''){
		$("#myInput").focus();
		return;
	}
	webSocket.send(message);
}
//对日期扩展
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
