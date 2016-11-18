<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'myInfo.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
	<style type="text/css">
		.myOrderBy div{
		display:none;
		}
		.myOrderBy .8{
			display:block;
		}
		#deleteWarning{
			display:none;
			position:fixed;
			top:20%;left:20%;
		}
		#printContext{
			overflow:auto;
			height:330px;
		}
	</style>
</head>
<body>
<!--删除警告  -->
	<div class="alert alert-danger alert-dismissible fade in"
		id="deleteWarning" role="alert" data-id="">
		<button type="button" class="close closeWin">
			<span aria-hidden="true">×</span>
		</button>
		<h4>
			<strong><s:text name="订单删除警告！" />!</strong>
		</h4>
		<s:text name="sureWantDelete" />订单号为 [
		<span class="deleteWarning-text"></span>]
		<s:text name="的订单吗？" />
		<br /> <br />

		<button type="button" class="btn btn-danger" id="sureDelete">
			<s:text name="sureDelete" />
		</button>
		<button type="button" class="btn btn-default closeWin"
			style="margin-left:20px;width:100px">
			<s:text name="cancel" />
		</button>
	</div>
	<!--删除警告结束  -->
    <div class="container-fluid">
        <div class="btn-group btn-group-justified menuButton" role="group">
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-default active" state="8">待付款</button>
            </div>
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-default" state="9">待发货</button>
            </div>
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-default" state="11">待收货</button>
            </div>
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-default" state="12">已收货</button>
            </div>
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-default" state="0">所有订单</button>
            </div>
        </div>
        <div class="myOrderBy">
              <div class="8">
               <table class="table">
                <tr>
                    <th>订单号</th>
                    <th>商品</th>
                    <th>价格</th>
                    <th>高级</th>
                </tr>
              <s:iterator value="#request.orderForms">
              <s:if test="state.id==8">
                <tr data="${id }">
                    <td>${id}</td>
                    <td><a href="single?goodsId=${goods.goodsId}" target="_blank">${goods.name}</a></td>
                    <td>
                    <s:i18n name="format">
						<s:text name="struts.percent">
							<s:param value="goods.price*buyNum" />
						</s:text>
					</s:i18n>
                    </td>
                    <td><button class="btn btn-default select"><a href="pay_goPayUi?id=${id}" target="_blank">去付款</a></button>
						<button class="btn btn-default select" data-toggle="modal"
										data-target="#myModal">查看</button><button class="btn btn-default delete">删除</button></td>
                </tr>
              </s:if>
                </s:iterator>
                 </table>
            </div>
              <div class="9">
               <table class="table">
                <tr>
                    <th>订单号</th>
                    <th>商品</th>
                    <th>价格</th>
                    <th>高级</th>
                </tr>
              <s:iterator value="#request.orderForms">
              <s:if test="state.id==9">
                <tr data="${id }">
                    <td>${id}</td>
                    <td><a href="single?goodsId=${goods.goodsId}" target="_blank">${goods.name}</a></td>
                    <td> <s:i18n name="format">
						<s:text name="struts.percent">
							<s:param value="goods.price*buyNum" />
						</s:text>
					</s:i18n></td>
                    <td><button class="btn btn-default select" data-toggle="modal"
										data-target="#myModal">查看</button><button class="btn btn-default delete">删除</button></td>
                </tr>
              </s:if>
                </s:iterator>
                 </table>
            </div>
             <div class="11">
               <table class="table">
                <tr>
                    <th>订单号</th>
                    <th>商品</th>
                    <th>价格</th>
                    <th>高级</th>
                </tr>
              <s:iterator value="#request.orderForms">
              <s:if test="state.id==11">
               <tr data="${id }">
                    <td>${id}</td>
                    <td><a href="single?goodsId=${goods.goodsId}" target="_blank">${goods.name}</a></td>
                    <td> <s:i18n name="format">
						<s:text name="struts.percent">
							<s:param value="goods.price*buyNum" />
						</s:text>
					</s:i18n></td>
                    <td><button class="btn btn-default select" data-toggle="modal"
										data-target="#myModal">查看</button><button class="btn btn-default delete">删除</button></td>
                </tr>
              </s:if>
                </s:iterator>
                 </table>
            </div>
             <div class="12">
               <table class="table">
                <tr>
                    <th>订单号</th>
                    <th>商品</th>
                    <th>价格</th>
                    <th>高级</th>
                </tr>
              <s:iterator value="#request.orderForms">
              <s:if test="state.id==12">
               <tr data="${id }">
                    <td>${id}</td>
                    <td><a href="single?goodsId=${goods.goodsId}" target="_blank">${goods.name}</a></td>
                    <td> <s:i18n name="format">
						<s:text name="struts.percent">
							<s:param value="goods.price*buyNum" />
						</s:text>
					</s:i18n></td>
                    <td><button class="btn btn-default select" data-toggle="modal"
										data-target="#myModal">查看</button><button class="btn btn-default delete">删除</button></td>
                </tr>
              </s:if>
                </s:iterator>
                 </table>
            </div>
             <div class="0">
                 <table class="table">
                <tr>
                    <th>订单号</th>
                    <th>商品</th>
                    <th>价格</th>
                    <th>高级</th>
                </tr>
              <s:iterator value="#request.orderForms">
              <tr data="${id }">
                    <td>${id}</td>
                    <td><a href="single?goodsId=${goods.goodsId}" target="_blank">${goods.name}</a></td>
                    <td> <s:i18n name="format">
						<s:text name="struts.percent">
							<s:param value="goods.price*buyNum" />
						</s:text>
					</s:i18n></td>
                    <td><button class="btn btn-default select" data-toggle="modal"
										data-target="#myModal">查看</button><button class="btn btn-default delete">删除</button></td>
                </tr>
                </s:iterator>
                 </table>
            </div>
           
        </div>
       <%--  <nav>
            <ul class="pager">
                <li class="previous"><a href="#"><span class="glyphicon glyphicon-arrow-left"></span>上一页</a></li>
                <li class="next"><a href="#">下一页<span class="glyphicon glyphicon-arrow-right"></span></a></li>
            </ul>
        </nav> --%>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabelMoreData" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<%-- <div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">
						<s:text name="订单更多信息" />
					</h4>
				</div> --%>
				<div class="modal-body" id="printContext">
					<table class="table">
						<tbody id="moreInfor">
						</tbody>
					</table>
				</div>
				<%-- <div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">
						<s:text name="close" />
					</button>
					<button type="button" class="btn btn-primary" id="printUser">
						<s:text name="print" />
					</button>
				</div> --%>
			</div>
		</div>
	</div>
<script src="js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$(".myOrderBy .8").show();
    $(".menuButton button").click(function(){
        $(".menuButton button").removeClass("active");
        $(this).addClass("active");
        $(".myOrderBy div").hide();
        $(".myOrderBy ."+$(this).attr("state")).show();
    })
    $(".select").click(function(){
    	getOrderFromMoreData(this);
    })
    $(".delete").click(function(){
    	deleteOrderFormData(this);
    })
    $(".closeWin").click(function(){
  	  closeWin(this);
    })
  })
    function deleteOrderFormData(el) {
	$("#sureDelete").unbind("click");
	$("#deleteWarning").slideDown(500);
	var id = $(el).parents("tr").attr("data");
	$("#deleteWarning .deleteWarning-text").html(id);
	/* 删除按钮事件 */
	if (id == null) {
		return;
	}
	$("#sureDelete").click(function() {
		$.post({
			url : "json/userOrderForm_delete",
			data : "id=" + id,
			success : function(data) {
				if (data != null) {
					data = eval("(" + data + ")");
					$("#deleteWarning").slideUp(500);
					if (data.message) {
						$(".table tr[data=" + id + "]").remove();
						return;
					} else {
						alert("删除失败，原因："+data.cause)
						return;
					}
				}
			},
		})
	})
}
function getOrderFromMoreData(el) {
	var id = $(el).parents("tr").attr("data");
	var data = "id=" + id;
	$.post({
		url : "json/getMoreData_orderForm",
		data : data,
		success : function(data) {
			if (data != null) {
				$("#moreInfor").html("");
				data = eval("(" + data + ")");
				setMoreData(data);
			}
			return;
		}
	})
}
function setMoreData(data) {
	for ( var val in data) {
		/*if(val=='state') data[val]=i18n.get(data[val]); */
		if (data[val] != null) {
			//createTrTd(nameArr[val], data[val])
			createTrTd(val, data[val])
		}
	}

}
function createTrTd(name, value) {
	if(name=='color'){
		$("#moreInfor").append($("<tr><td>" + name + "</td><td><div style='background-color:"+value+";width:30px;height:30px;'></div></td></tr>"));
	}else
	$("#moreInfor").append($("<tr><td>" + name + "</td><td>" + value + "</td></tr>"));
}
function closeWin(el) {
	$(el.parentNode).hide(500);
}
</script>
</body>
</html>
