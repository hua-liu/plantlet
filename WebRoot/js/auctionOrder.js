$(function() {
	$(".selectArea").click(function(){
		$(".provinesBox").toggle();
	})
	//首次进入填充省份
	$.post("json/provines", "id=0", function(data) {
		data = eval("("+data+")");
		for(var i=0;i<data.length;i++){
			addProvinesNode($(".city-provinces"),data[i].id,data[i].name);
		}
		//绑定点击事件
		liBindClick();
	}, "json")
	//菜单点击事件
	$(".provinesMenu li").click(function(){
		$(".city-"+$(this).attr("class")).addClass("active");
		$(".city-"+$(this).attr("class")).siblings().removeClass("active");
		$(this).addClass("active");
		$(this).siblings().removeClass("active");
	})
	/*上面为选择地址*/
	//手机号码与电话号码控制
	$("input[name=phone]").keyup(function(){
		
	})
	//提交添加地址表单按钮事件
	$(".submitAddAddress").click(function(){
		
	})
})
//li点击事件重绑定
var selectedArea=['','','',''];
function liBindClick(){
	var arr = ['.city-provinces','.city-city','.city-district','.city-street'];
	for(var i=0;i<arr.length;i++){
		$(arr[i]+" ul li").unbind();
		$(arr[i]+" ul li").bind("click",function(){
			$(this).parents(".city-group").find("li").removeClass("active");
			$(this).addClass("active");
			var className = $(this).parents(".city-group").attr("class").replace('city-group ', '').replace(' active', '');
			getArea($(this).attr("attr-id"),className);
			setSelectArea(this)
		})
	}
}
//设置已选中的地址
function setSelectArea(el){
	//获取当前菜单下标（省份，城市，县区，街道）
	var ci =$(el).parents(".city-group").index();
	//设置选中当前下标的值到数组
	selectedArea[ci] = $(el).attr("title");
	var text='';
	//移除初始化class
	$(".selectedArea").removeClass("initArea");
	//装饰选中组成字符串
	for(var i=0;i<=ci;i++){
		if(i==ci){
			text += selectedArea[i]
		}else
		text += selectedArea[i]+"/"
	}
	$(".selectedArea").html(text)
}
//填充li元素
function addProvinesNode(ul,id,name){
	//因为重庆是多音字，所以做特殊处理
	if(name=='重庆'){
		$(".city-provinces .ag li[title=北京]").after($('<li title="'+name+'" attr-id="'+id+'">'+name+'</li>'));
		return;
	}
	//获取第一个拼音字母
	var firstChar =PinYin.lookUpWord(name.charAt(0)).charAt(0);
	var li = $('<li title="'+name+'" attr-id="'+id+'">'+name+'</li>');
	//对数据进行分组
	if(firstChar>='a'&&firstChar<='g'){
		$(ul).find(".ag").append(li);
	}else if(firstChar>='h'&&firstChar<='k'){
		$(ul).find(".hk").append(li);
	}else if(firstChar>='l'&&firstChar<='s'){
		$(ul).find(".ls").append(li);
	}else{
		$(ul).find(".tz").append(li);
	}
}
//获取数据
function getArea(code,className){
	//获取当前已激活下标并清除激活
	var currentIndex = $(".provinesMenu li.active").index();
	var nextIndex = currentIndex+1>=$(".provinesMenu li").length?-1:currentIndex+1;
	//如果当前菜单下标为最后一个，则退出选择，隐藏内容
	if(nextIndex==-1){
		$(".provinesBox").hide();
		return;
	}
	//获取数据
	$.post("json/provines", "id="+code, function(data) {
		//每次填充之前清空后面所有选项,并隐藏标识
		for(var i=nextIndex;i<$(".provinesMenu li").length;i++){
			$(".provinesContent .city-group:eq("+i+") ul").html("");
			$(".provinesContent .city-group:eq("+i+") ul").parent().parent().hide();
		}
		if(data!=null){
			data = eval("("+data+")");
			if(data.message==false){	//判断后面是否还有内容，没有则直接隐藏box
				$(".provinesBox").hide();
			}else{
				//每次填充之前清空
				for(var i=0;i<data.length;i++){
					addProvinesNode($(".provinesContent .city-group:eq("+nextIndex+")"),data[i].id,data[i].name);
				}
				//每次填充之后绑定点击事件
				liBindClick();
			}
			var uls = $(".city-group:eq("+nextIndex+") ul");
			for(var i=0;i<uls.length;i++){
				if(uls[i].innerHTML==''){
					$(uls[i]).parent().parent().hide();
				}else{
					$(uls[i]).parent().parent().show();
				}
			}
		}
	}, "json")
	$(".provinesMenu li").eq(currentIndex).removeClass("active");
	$(".provinesContent .city-group").eq(currentIndex).removeClass("active");
	//获取下一个准备激活下标
	$(".provinesMenu li").eq(nextIndex).addClass("active");
	$(".provinesContent .city-group").eq(nextIndex).addClass("active");
}
/*前面多数为地址选择*/

function numberControl(){
	
}