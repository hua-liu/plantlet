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
		if(/^[0-9]{0,11}$/.test(this.value)){
			$(this).attr("resource_data",this.value);
		}else{
			$(this).val($(this).attr("resource_data")!=null?$(this).attr("resource_data"):'');
		}
	})
	$("input[name=telephone]").keyup(function(){
		if(/^[0-9-]{0,22}$/.test(this.value)){
			$(this).attr("resource_data",this.value);
		}else{
			$(this).val($(this).attr("resource_data")!=null?$(this).attr("resource_data"):'');
		}
	})
	//提交添加地址表单按钮事件
	$("#submitAddAddress").click(function(){
		submitForm();
	})
	//添加收货地址修改事件
	changeAddrShow();
	$("#addAddrModalButton").click(function(){
		$(".selectedArea").html("选择省/市/区...");
		$(".selectedArea").addClass("initArea");
		$(".city-provinces").trigger("click");
		$(".city-group").find("li").removeClass("active");
		$("textarea[name=moreAddress]").val("");
		$("input[name=name]").val("");
		$("input[name=postcode]").val("");
		$("input[name=phone]").val("");
		$("input[name=telephone]").val("");
		$("#submitAddAddress").html("添加地址并选择");
		$("#id").val("");
	})
	
	//购买数量变更
	$("#buyNumMade input").keyup(function(e){
		if(/[0-9]{1,4}/.test(this.value)){
			var maxValue=parseInt($(this).attr("maxValue"));
			if(this.value>maxValue){
				$(this).val(maxValue);
				$(this).attr("sourceValue",this.value);
			}else if(this.value<1){
				$(this).val(1);
				$(this).attr("sourceValue",this.value);
			}
			changePrice(this);
		}else{
			$(this).val($(this).attr("sourceValue"));
		}
	})
	//减少控制
	$("#buyNumMade .minus").click(function(){
		var val = parseInt($(this).siblings(".buyNum").val())-1;
		if(val<1)val=1;
		$(this).siblings(".buyNum").val(val);
		changePrice($(this).next());
	})
	//增加控制
	$("#buyNumMade .add").click(function(){
		var maxValue=$(this).siblings(".buyNum").attr("maxValue");
		var val = parseInt($(this).siblings(".buyNum").val())+1;
		if(val>maxValue)val=maxValue;
		$(this).siblings(".buyNum").val(val);
		changePrice($(this).prev());
	})
	//总价格控制
	changeSumPrice();
	//选中调价
	$("input[name=isSelect]").bind("change",function(){
		if($(this).is(":checked")){
			$(this).parents("tr").css("opacity","1");
			$(this).parents("tr").find(".leaveMessage").attr("name","leaveMessage");
			$(this).parents("tr").find(".buyNum").attr("name","buyNum");
			$(this).parents("tr").next().find("input").attr("name","id");
		}else{
			$(this).parents("tr").css("opacity","0.3");
			$(this).parents("tr").find(".leaveMessage").removeAttr("name");
			$(this).parents("tr").find(".buyNum").removeAttr("name");
			$(this).parents("tr").next().find("input").removeAttr("name");
		}
		changeSumPrice();
	})
	//全选与反选
	$(".selectAll").click(function(){
		if($(".orderForm input[type=checkbox]").length==$(".orderForm input[type=checkbox]:checked").length){
			$(".orderForm input[type=checkbox]").removeAttr("checked");
			$(".orderForm tbody tr").css("opacity","0.3");
			$(".leaveMessage").removeAttr("name");
			$(".buyNum").removeAttr("name");
			$("input[type=hidden]").removeAttr("name");
		}else{
			$(".orderForm input[type=checkbox]").prop("checked",true);
			$(".orderForm tbody tr").css("opacity","1");
			$(".leaveMessage").attr("name","leaveMessage");
			$(".buyNum").attr("name","buyNum");
			$("input[type=hidden]").attr("name","id");
		}
		changeSumPrice();
	})
	$("#buyForm").submit(function(){
		var isSelectedInput = $(".orderForm input[type=checkbox]:checked");
		if(isSelectedInput.length<1){
			alert("您还未选择需要购买的商品！");
			return false;
		}
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
		text += selectedArea[i]+"--"
	}
	$(".selectedArea").html(text)
	setTimeout(function(){	//设置个延时，以保证能顺利设置值
		$("#address").val($(".selectedArea").html())
	},500)
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
function submitForm(){
	var isPass=true;
	if($("#address").val()==''){
		$(".selectArea").popover("show");
		setTimeout(function() {
			$(".selectArea").popover("destroy");
		}, 3000)
		return;
	}
	if($("textarea[name=moreAddress]").val()==''){
		$("textarea[name=moreAddress]").popover("show");
		setTimeout(function() {
			$("textarea[name=moreAddress]").popover("destroy");
		}, 3000)
		return;
	}
	if($("input[name=name]").val()==''){
		$("input[name=name]").popover("show");
		setTimeout(function() {
			$("input[name=name]").popover("destroy");
		}, 3000)
		return;
	}
	if($("input[name=phone]").val()==''&&$("input[name=telephone]").val()==''){
		if($("input[name=phone]").val()!=''&&/^[1][3-8][0-9]{9}$/.test($("input[name=phone]").val())){
			$("input[name=phone]").attr("data-content","手机号码格式错误");
			$("input[name=phone]").popover("show");
		}
		$("input[name=phone]").attr("data-content","货到你身边了却不知怎么告诉你");
		$("input[name=phone]").popover("show");
		setTimeout(function() {
			$("input[name=phone]").popover("destroy");
		}, 3000)
		return;
	}
	if (isPass) {
		$.ajax({
			type : "POST",
			url : "json/address_add",
			data : $('#addressForm').serialize(),
			dataType : 'json',
			success : function(data) {
				if(data!=null){
					if(data=='input'){
						window.location.href="loginUi?url="+window.location.href.substr(7);
						return;
					}
					data = eval("("+data+")");
					if(data.message){
						$("#addAddrModal").modal("hide");
						var addrInput = $(".addr input[value="+data.id+"]");
						if(addrInput.length>0){
							$(addrInput).parents("tr").remove();
						}
						//添加成功后动态添加与
						$(".addr tbody tr:eq(0)").after($('<tr><td style="padding-left:100px;"><label><input checked type="radio" value="'+data.id+'"name="addr"> '
							+$("#address").val()+'--'+$("textarea[name=moreAddress]").val()+'（'+$("input[name=name]").val()+' 收）'
							+($("input[name=phone]").val()!=''?$("input[name=phone]").val():$("input[name=telephone]").val())+
							'</label><span class="glyphicon glyphicon-pencil changeAddress" title="修改"></span><span class="glyphicon glyphicon-remove deleteAddress" title="删除"></span></td></tr>'))
							//添加收货地址修改事件
							changeAddrShow();
					}else{
						$("#submitAddAddress").attr("data-content",data.cause);
						$("#submitAddAddress").popover("show");
						setTimeout(function() {
							$("#submitAddAddress").popover("destroy");
						}, 5000)
					}
				}
			}
		});
	}
}
//修改地址事件
function changeAddrShow(){
	$(".addr tr td").unbind();
	$(".changeAddress").unbind();
	$(".addr tr td").bind("mouseover",function(){
		$(this).find("span").show();
	})
	$(".addr tr td").bind("mouseout",function(){
		$(this).find("span").hide();
	})
	$(".changeAddress").bind("click",function(){
		changeAddrData($(this).siblings("label").find("input").val());
	})
	$(".deleteAddress").bind("click",function(){
		if(confirm("是否确认删除当前收货地址？")){
			deleteAddress(this);
		}
	})
}
//更改地址
function changeAddrData(id){
	if(id==null)return;
	$.post("json/address_get","id="+id,function(data){
		if(data!=null){
			data = eval("("+data+")");
			if(data.message){
				$("#address").val(data.address);
				/*$(".selectedArea").removeClass("initArea");
				$(".selectedArea").html(data.address);*/
				$("textarea[name=moreAddress]").val(data.moreAddress);
				$("input[name=name]").val(data.name);
				$("input[name=postcode]").val(data.postcode);
				$("input[name=phone]").val(data.phone==null?'':data.phone);
				$("input[name=telephone]").val(data.telephone==null?'':data.telephone);
				$("#submitAddAddress").html("更新地址并选择");
				$("#id").val(data.id);
				$("#addAddrModal").modal("show");
				//此处为了保证修改地址时向数据库请求数据延时，设置定时器
				var i=0;
				var addressTimer = setInterval(function() {
					var addressArray = data.address.split("--");
					if(i==addressArray.length)clearInterval(addressTimer);//当下标等于长度时清除定时器
					$(".city-group:eq("+i+") li[title="+addressArray[i++]+"]").trigger("click");//招待点击请求
					$(".selectedArea").html(data.address);	//每次点击后设置最终值
				}, 500)
			}else{
				alert(data.cause)
			}
		}
	})
}
//删除地址
function deleteAddress(el){
	var id = $(el).siblings("label").find("input").val();
	if(id==null)return;
	$.post("json/address_delete","id="+id,function(data){
		if(data!=null){
			data = eval("("+data+")");
			if(data.message){
				$(el).parent().parent().hide(500);
				setTimeout(function(){
					$(el).parent().parent().remove();
				},1000)
			}else{
				alert(data.cause)
			}
		}
	})
}
//更改单价
function changePrice(el){
	var price = $(el).parents("tr").find(".singlePrice");
	$(price).find("span").html(($(price).attr("singleprice")*$(el).val()).toFixed(2));
	changeSumPrice();
}
//更改总价
function changeSumPrice(){
	var sumPrice=0;
	//选择所有已选中的商品并计算总价
	var prices = $(".orderForm input[type=checkbox]:checked").parents("tr").find(".singlePrice").find("span");
	for(var i=0;i<prices.length;i++){
		sumPrice += parseFloat($(prices[i]).html());
	}
	$(".sumPrice").html(sumPrice.toFixed(2));
}