$(function() {
	$(".goodsPicture tr td:first-child img").bind("click", function() {
		switchBigPicture(this);
	})
	$(".bigPicture").click(function() {// 此处单击打开文件对话框
		if ($("#goodsId").val() == '') {
			alert("未提交商品基本信息，无法添加商品图片！！");
			return;
		}
		$("#file").trigger("click");
	})
	bindImgDelete();//绑定图片删除事件
	// 图片上传监听
	$(".fileBox").bind("change",function() {$(".goodsPicture .bigPicture").attr("src","img/loading.gif");
		var isBreviary=0;
		if($(".goodsBreviary").attr("class").indexOf("checked")!=-1){
			isBreviary=1;
		}
	var picId = $(".goodsPicture tr td:first-child img.checked").attr("src");
	var sourcePicId=0;
	if(picId.indexOf("id=")!=-1){
		sourcePicId = picId.substr(picId.lastIndexOf("=")+1);
	}
		$.ajaxFileUpload({
					url : "json/upload_file?id="+ $("#goodsId").val()+"&isBreviary="+isBreviary+"&sourcePicId="+sourcePicId,// 用于文件上传的服务器端请求地址
					secureuri : false,// 一般设置为false
					fileElementId : 'file',// 文件上传空间的id属性
					dataType : 'json',// 返回值类型 一般设置为json
					error : function(data) {
						alert(data.cause)
					},
					success : function(data) {
						data = eval("(" + data + ")");
						if (data.message) {
							if(isBreviary==1){
								// 上传完成预览
								$(".goodsPicture tr td:first-child img.checked").attr("src","json/download_file?isBreviary=1&id="+ data.id);
								// 上传完成大图预览
								$(".goodsPicture .bigPicture").attr("src","json/download_file?isBreviary=1&id="+ data.id);
							}else{
								// 上传完成预览
								$(".goodsPicture tr td:first-child img.checked").attr("src","json/download_file?id="+ data.id);
								// 上传完成大图预览
								$(".goodsPicture .bigPicture").attr("src","json/download_file?id="+ data.id);
							}
						} else {
							alert("上传失败");
						}
					}
				})

	})
	// 商品是否打折事件监听
	$(".isSaleControl .mc").click(function() {
		if ($(".isSaleControl .mcControl").val() == '1') {
			$(".isSale").hide();
		} else {
			$(".isSale").show();

		}
	})
	/*// 商品分类监听
	$(".goodsKindTr select")
			.change(
					function() {
						if (this.value == 0) {
							$(".moreKindTr td:last-child").html("");
							$(".moreKindTr").hide();
						} else {
							if (this.value == 2)
								$(".goodsSizeTr").show();
							else
								$(".goodsSizeTr").hide();
							// 向服务器请求详细分类
							$
									.post({
										url : "json/getMoreKind",
										data : "id=" + this.value,
										success : function(data) {
											if (data != null) {
												data = eval("(" + data + ")");
												$(".moreKindTr td:last-child")
														.html("");
												for (var i = 0; i < data.length; i++) {
													// margin-left:0;padding-right:5px;line-height:20px
													$(
															".moreKindTr td:last-child")
															.append(
																	$('<label class="checkbox-inline" style=""><input name="moreKindTemp" type="checkbox" value="'
																			+ data[i].id
																			+ '">'
																			+ data[i].name
																			+ '</label>'));
												}
												$(".moreKindTr").show();
											}
											return;
										}
									})
						}
					})*/
	// 添加颜色监听
	$(".addColor").click(function() {
		$(this).before($("<input type='color' name='color'>"));
	})
	// 点击上传html按钮
	$(".clickUploadHtml").click(function() {
		if ($("#goodsId").val() == '') {
			alert("未提交商品基本信息，无法添加商品展示网页！！");
			return;
		}
		$("#htmlfile").trigger("click");
	})
	// html上传监听
	$(".htmlfileBox")
			.bind(
					"change",
					function() {
						$(".goodsExplainBox")
								.before(
										'<div class="loaderBox"><div class="loader"><div class="loader-inner line-scale"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div></div></div>');
						$(".goodsExplainBox").hide();
						var files = htmlfile.files;
						$
								.ajaxFileUpload({
									url : "json/uploadHtml_file?id="
											+ $("#goodsId").val(),// 用于文件上传的服务器端请求地址
									secureuri : false,// 一般设置为false
									fileElementId : 'htmlfile',// 文件上传空间的id属性
									dataType : 'json',// 返回值类型 一般设置为json
									error : function(data) {
									},
									success : function(data) {
										if (data != null) {
											data = eval("(" + data + ")");
											if (data.message) {
												/* data = eval("(" + data + ")") */
												// 添加显示上传网页的框架
												var iframe = $('<iframe src='
														+ data.path
														+ ' id="iframepage" name="iframepage" frameBorder=0 scrolling=no width="100%"></iframe>')
												$(".goodsExplainBox").before(
														iframe);// 追加后移除
												$(".loaderBox").remove();
												$("#goodsExplainId").val(
														data.id);
											} else {
												alert(data.cause)
												$(".loaderBox").remove();
											}
										} else {
											alert("未知原因，上传失败")
											$(".loaderBox").remove();
										}
									}
								})
					})
	// 窗口改变更改html高度
	window.onresize = function() {
		reinitIframeEND();
	}
	// 添加图片上限监听
	$("#add-img")
			.click(
					function() {
						if ($(".img-thumbnail").length <10) {
							$(".img-thumbnail").removeClass("checked");
							$(this)
									.parent()
									.parent()
									.before(
											$('<tr><td><div><img src="img/clickUploadPicture.png" alt="点击上传商品图" class="img-thumbnail checked"><span class="deleteImg glyphicon glyphicon-remove"></span></div></td></tr>'));
							$(".goodsPicture tr td:first-child img").bind(
									"click", function() {
										switchBigPicture(this);
									})
							if ($(".img-thumbnail").length == 9)
								$(this).hide();
							bindImgDelete();//绑定图片删除事件
						}
					})
	var submitMark = true;
	// 表单验证
	$("#addGoodsButton").bind("click",function() {
		if (!submitMark)return;
		submitMark = false;
		if ($("#goodsId").val().trim() != '') {
			if (!confirm("当前商品已经提交，是否更新当前商品信息？")) {
				submitMark = true;
				return;
			}
		}
		var isPass = true;
		if ($("#addGoodsForm select[name=goodsKindTemp]").val() == 0) {
			$("#addGoodsForm select[name=goodsKindTemp]")
					.popover("show");
			window.setTimeout(function() {
				$("#addGoodsForm select[name=goodsKindTemp]")
						.popover("destroy");
			}, 3000)
			isPass = false;
		} else {
			$("#addGoodsForm select[name=goodsKindTemp]")
					.popover("destroy");
		}
	/*	if ($("#addGoodsForm .moreKindTd input:checked").length < 1) {
			$("#addGoodsForm .moreKindTd").popover("show");
			window.setTimeout(function() {
				$("#addGoodsForm .moreKindTd").popover(
						"destroy");
			}, 3000)
			isPass = false;
		} else {
			$("#addGoodsForm .moreKindTd").popover("destroy");
		}*/
		if ($("#addGoodsForm input[name=name]").val() == 0) {
			$("#addGoodsForm input[name=name]").popover("show");
			window.setTimeout(function() {
				$("#addGoodsForm input[name=name]").popover(
						"destroy");
			}, 3000)
			isPass = false;
		} else {
			$("#addGoodsForm input[name=name]").popover(
					"destroy");
		}
		if ($("#addGoodsForm input[name=simpleDescript]").val() == 0) {
			$("#addGoodsForm input[name=simpleDescript]")
					.popover("show");
			window.setTimeout(function() {
				$("#addGoodsForm input[name=simpleDescript]")
						.popover("destroy");
			}, 3000)
			isPass = false;
		} else {
			$("#addGoodsForm input[name=simpleDescript]")
					.popover("destroy");
		}
		if ($("#addGoodsForm input[name=price]").val() == 0) {
			$("#addGoodsForm input[name=price]").attr(
					"data-content", "商品价格不能为空");
			$("#addGoodsForm input[name=price]")
					.popover("show");
			window.setTimeout(function() {
				$("#addGoodsForm input[name=price]").popover(
						"destroy");
			}, 3000)
			isPass = false;
		} else {
			if (/^[0-9]+\.{0,1}[0-9]+$/.test($(
					"#addGoodsForm input[name=price]").val())) {
				$("#addGoodsForm input[name=price]").popover(
						"destroy");
			} else {
				$("#addGoodsForm input[name=price]").attr(
						"data-content", "格式错了，价格能有这奇怪的字符吗");
				$("#addGoodsForm input[name=price]").popover(
						"show");
				isPass = false;
			}
		}
		if ($("#addGoodsForm input[name=inventory]").val() == 0) {
			$("#addGoodsForm input[name=inventory]").attr(
					"data-content", "库存不能为空");
			$("#addGoodsForm input[name=inventory]").popover(
					"show");
			window.setTimeout(function() {
				$("#addGoodsForm input[name=inventory]")
						.popover("destroy");
			}, 3000)
			isPass = false;
		} else {
			if (/^[0-9]+$/.test($(
					"#addGoodsForm input[name=inventory]")
					.val())) {
				$("#addGoodsForm input[name=inventory]")
						.popover("destroy");
			} else {
				$("#addGoodsForm input[name=inventory]").attr(
						"data-content", "格式错了，库存能有字母吗");
				$("#addGoodsForm input[name=inventory]")
						.popover("show");
				isPass = false;
			}
		}
		if ($("#addGoodsForm input[name=isSale]").val() == 1) {
			if ($("#addGoodsForm input[name=salePrice]").val() == 0) {
				$("#addGoodsForm input[name=salePrice]").attr(
						"data-content", "价格不能为空");
				$("#addGoodsForm input[name=salePrice]")
						.popover("show");
				window.setTimeout(function() {
					$("#addGoodsForm input[name=salePrice]")
							.popover("destroy");
				}, 3000)
				isPass = false;
			} else {
				if (/^[0-9]+\.{0,1}[0-9]+$/.test($(
						"#addGoodsForm input[name=salePrice]")
						.val())) {
					$("#addGoodsForm input[name=salePrice]")
							.popover("destroy");
				} else {
					$("#addGoodsForm input[name=salePrice]")
							.attr("data-content",
									"格式错了，价格能有这奇怪的字符吗");
					$("#addGoodsForm input[name=salePrice]")
							.popover("show");
					isPass = false;
				}
				$("#addGoodsForm input[name=salePrice]")
						.popover("destroy");
			}
			if ($("#addGoodsForm input[name=saleTime]").val() == 0) {
				$("#addGoodsForm input[name=saleTime]")
						.popover("show");
				window.setTimeout(function() {
					$("#addGoodsForm input[name=saleTime]")
							.popover("destroy");
				}, 3000)
				isPass = false;
			} else {
				if (/^([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8])))$/
						.test($(
								"#addGoodsForm input[name=saleTime]")
								.val())) {
					$("#addGoodsForm input[name=saleTime]")
							.popover("destroy");
				} else {
					$("#addGoodsForm input[name=saleTime]")
							.attr("data-content",
									"格式错了，日期格式不对吧");
					$("#addGoodsForm input[name=saleTime]")
							.popover("show");
					isPass = false;
				}
				$("#addGoodsForm input[name=saleTime]")
						.popover("destroy");
			}
		}
		if (!isPass) {
			submitMark = true;
			return;
		}
		$(this).html("正在提交商品")
		$(this).append($('<div class="loader-inner ball-clip-rotate" style="float:right"><div></div></div>'))
		if (isPass) {
			$.ajax({
				type : "POST",
				url : "json/add_goods",
				data : $('#addGoodsForm').serialize(),
				dataType : 'json',
				success : function(result) {
					if (result != null) {
						result = eval("(" + result + ")");
						if (result.message) {
							$("#goodsId").val(result.id)
							$("#addGoodsButton")
									.html("商品已提交成功")
						} else {
							$("#addGoodsButton").attr(
									"data-content",
									result.cause);
							$("#addGoodsButton")
									.popover("show");
							$("#addGoodsButton").html("商品提交失败")
						}
					}
					submitMark = true;
				},
				error : function(data) {
					data = $.parseJSON(data);
					alert("error:" + data.cause);
					$("#addGoodsButton").html("商品提交失败")
					submitMark = true;
				}
			});
		}
	})
	/*
	 * $("#goodsId").change(function(){ alert(this.value); })
	 */
})
var bindImgDelete=function(){
	// 图片移除监听
	$(".goodsPicture tr td:first-child div").unbind("mouseover mouseout");
	$(".deleteImg").unbind("click");
	$(".goodsPicture tr td:first-child div").bind("mouseover", function() {
		$(this).children(".deleteImg").show();
	})
	$(".goodsPicture tr td:first-child div").bind("mouseout", function() {
		$(this).children(".deleteImg").hide();
	})
	$(".deleteImg").bind("click", function() {
		var src = $(this).siblings("img").attr("src");
		if (src.indexOf("?id=") == -1) {
			$(this).parent().parent().parent().remove();
			$("#add-img").show();
			return;// 图片ID不存在
		}
		src = src.substr(src.indexOf("id=") + 3, src.length - 1);
		var goodsId = $("#goodsId").val();
		if (goodsId == null || goodsId == '') {
			return;// 没发现商品ID返回
		}
		var willDeleteImg = $(this);
		var isChecked = $(this).siblings("img").is(".checked")?true:false;	//判断是否为当前，为当前选中则删除大图
		data = "goodsId=" + goodsId + "&imgId=" + src;
		$.post({
			url : "json/deleteImg_goods",
			data : data,
			success : function(data) {
				if (data != null) {
					data = eval("(" + data + ")");
					if (data.message) {
						$("#add-img").show();
						$(willDeleteImg).parent().parent().parent().remove();
						if(isChecked){
							$(".goodsPicture tr td img:eq(1)").addClass("checked");
							$(".bigPicture").attr("src",$(".goodsPicture tr td img:eq(1)").attr("src"));
						}
						return;
					}
				}
				showWarning(false, data.cause);
			}
		})
		return;
		/**/
	})
}
function clearAllForm() {
	$("#goodsId").val("");
	$(".moreKindTr").hide();
	$("input[type=color]").remove();
	$(".goodsPicture img").attr("src", "img/clickUploadPicture.png");
	$("#iframepage").remove();
	$("#goodsExplainId").remove();
	$(".goodsExplainBox").show();
	$(".loaderBox").remove();
	$("#addGoodsButton").html("提交商品基本信息");
}
function clearErrorPrompt() {
	$("select").popover("destroy");
	$("input").popover("destroy");
	$("#addGoodsButton").popover("destroy");
}
function switchBigPicture(el) { // 切换成大图显示
	$(el).addClass("checked");
	$(el).parents("tr").siblings().find("img:first-child").removeClass(
			"checked");
	$(".goodsPicture .bigPicture").attr("src", $(el).attr("src"));
}
function reinitIframe() {
	var iframe = document.getElementById("iframepage");
	try {
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = Math.max(bHeight, dHeight);
		iframe.height = height;
	} catch (ex) {
	}
}

var timer1 = window.setInterval("reinitIframe()", 500); // 定时开始

function reinitIframeEND() {
	var iframe = document.getElementById("iframepage");
	try {
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = Math.max(bHeight, dHeight);
		iframe.height = height;
	} catch (ex) {
	}
	// 停止定时
	window.clearInterval(timer1);

}
