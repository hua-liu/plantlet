var times=0;	//定义为全局是为了防止同时多个事件响应
var currentButton;	//定义保存当前Button菜单，防止menu出现假死
$(function() {
	$(".spinButton").bind("mouseover", function() {
		if(this!=currentButton){
			$("#spinBox").remove();
		}
		if ($("#spinBox").length < 1) { // 当鼠标经过图标时，创建容器，如果容器已存在则不再创建
			currentButton=this;
			var div = createBox(this); // 创建容器，填充四个块到容器
			var r = 100; // 画圆半径
			times = 0; // 画圆次数
			var a = div.offsetWidth / 2 - 20; // 画圆中心点x
			var b = div.offsetHeight / 2 - 30;// 画圆中心点y
			var el = this;
			var interval = window.setInterval(function() { // 定时器画圆
				if (times >= 72 || $("#spinBox").length < 1) { // 如果容器不存在或时间达到指定则退出画圆
					clearInterval(interval);
					return;
				}
				var hudu = (2 * Math.PI / 360) * 5 * times++; // 获取画周率
				var x = a + Math.sin(hudu) * r; // 计算x坐标
				var y = b - Math.cos(hudu) * r;// 计算y坐标
				createDiv(x, y); // 画点
				setIcon(times,el);
			}, 5)
		}
	})
})

function createDiv(x, y) {
	var p = document.createElement("div");
	if ($("#spinBox").length > 0) {
		$("#spinBox").append(p)
		p.style.position = "absolute";
		p.style.width = "50px";
		p.style.height = "50px";
		p.style.borderRadius = "25px";
		p.style.left = x + "px";
		p.style.top = y + "px";
		p.style.background = "rgba(0,0,0,0.02)";
	}
}
function createBox(el) {
	var div = document.createElement("div");
	document.body.appendChild(div);
	$(div).append($("<p class='div-p'></p>"));
	div.style.zIndex = 200;
	div.style.width = "250px";
	div.style.height = "250px";
	div.style.position = "absolute";
	div.setAttribute("id", "spinBox")
	div.style.left = el.offsetLeft - el.offsetWidth / 2 - 5 + "px";
	div.style.top = el.offsetTop - el.offsetHeight / 2 - 12 + "px";
	$(div).append($("<p class='imgMenu imgTop' data-toggle='tooltip' data-placement='top' title='Tooltip on left' ></p>"));
	$(div).append($("<p class='imgMenu imgLeft' data-toggle='tooltip' data-placement='left' title='Tooltip on left' ></p>"));
	$(div).append($("<p class='imgMenu imgRight' data-toggle='tooltip' data-placement='right' title='Tooltip on left' ></p>"));
	$(div).append($("<p class='imgMenu imgBottom' data-toggle='tooltip' data-placement='bottom' title='Tooltip on left' ></p>"));
	$(div).unbind();
	$(div).bind("mouseleave", function(e) {
		$(this).remove();
	})
	 $('[data-toggle="tooltip"]').tooltip()
	return div;
}
function setIcon(times,el){
	var data = $(el).attr('data');
	if(data=='electronics'){
		if (times == 18){
			$(".imgRight").append($("<i class='iconfont'>&#xe665;</i>"));
			$(".imgRight").attr('data-original-title','手机');
		}else if (times == 36){
			$(".imgBottom").append($("<i class='iconfont'>&#xe619;</i>"));
			$(".imgBottom").attr('data-original-title','电脑');
		}else if (times == 54){
			$(".imgLeft").append($("<i class='iconfont'>&#xe60e;</i>"));
			$(".imgLeft").attr('data-original-title','电视');
		}else if (times == 72){
			$(".imgTop").append($("<i class='iconfont'>&#xe66a;</i>"));
			$(".imgTop").attr('data-original-title','家电');
		}
	}else if(data=='fashion'){
		if (times == 18){
			$(".imgRight").append($("<i class='iconfont'>&#xe60c;</i>"));
			$(".imgRight").attr('data-original-title','女装');
		}else if (times == 36){
			$(".imgBottom").append($("<i class='iconfont'>&#xe602;</i>"));
			$(".imgBottom").attr('data-original-title','鞋子');
		}else if (times == 54){
			$(".imgLeft").append($("<i class='iconfont'>&#xe605;</i>"));
			$(".imgLeft").attr('data-original-title','男装');
		}else if (times == 72){
			$(".imgTop").append($("<i class='iconfont'>&#xe617;</i>"));
			$(".imgTop").attr('data-original-title','配饰');
		}
	}else if(data=='gifts'){
		if (times == 18){
			$(".imgRight").append($("<i class='iconfont'>&#xe6cd;</i>"));
			$(".imgRight").attr('data-original-title','鲜花');
		}else if (times == 36){
			$(".imgBottom").append($("<i class='iconfont'>&#xe6ce;</i>"));
			$(".imgBottom").attr('data-original-title','生日');
		}else if (times == 54){
			$(".imgLeft").append($("<i class='iconfont'>&#xe63e;</i>"));
			$(".imgLeft").attr('data-original-title','植物');
		}else if (times == 72){
			$(".imgTop").append($("<i class='iconfont'>&#xe6cc;</i>"));
			$(".imgTop").attr('data-original-title','礼物');
		}
	}else if(data=='decor'){
		if (times == 18){
			$(".imgRight").append($("<i class='iconfont'>&#xe63c;</i>"));
			$(".imgRight").attr('data-original-title','客厅');
		}else if (times == 36){
			$(".imgBottom").append($("<i class='iconfont'>&#xe63d;</i>"));
			$(".imgBottom").attr('data-original-title','卧室');
		}else if (times == 54){
			$(".imgLeft").append($("<i class='iconfont'>&#xe608;</i>"));
			$(".imgLeft").attr('data-original-title','厨具');
		}else if (times == 72){
			$(".imgTop").append($("<i class='iconfont'>&#xe614;</i>"));
			$(".imgTop").attr('data-original-title','沙发');
		}
	}else if(data=='sports'){
		if (times == 18){
			$(".imgRight").append($("<i class='iconfont'>&#xe6d2;</i>"));
			$(".imgRight").attr('data-original-title','球类');
		}else if (times == 36){
			$(".imgBottom").append($("<i class='iconfont'>&#xe6d1;</i>"));
			$(".imgBottom").attr('data-original-title','器材');
		}else if (times == 54){
			$(".imgLeft").append($("<i class='iconfont'>&#xe6d3;</i>"));
			$(".imgLeft").attr('data-original-title','运动');
		}else if (times == 72){
			$(".imgTop").append($("<i class='iconfont'>&#xe6d0;</i>"));
			$(".imgTop").attr('data-original-title','户外');
		}
	}
}