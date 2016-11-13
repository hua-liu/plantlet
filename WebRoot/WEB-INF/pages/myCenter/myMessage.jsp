<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	 <link href="bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet">
    <style type="text/css">
        li{
            list-style: none;
        }
        .selectCase{
            width:20px;height:20px;border:1px solid #555;
            float:left;
            margin:0;
            cursor:pointer;
            border-radius: 2px;
        }
        .checkbox label{
            float:left;
            margin:0;padding-left:5px;
        }
        .selectCase i{
            display:none;
        }
        .checked{
            padding:1px;
            background:#0A0;
            border-color:#CCC;
        }
        .checked i{
            display:block;
            color:#FFF;
        }
        tr td{
            padding:5px 10px;
        }
        .menu_th .selectCase{
            margin:3px 10px 0 10px;
        }
        .menu_th button{
            margin:0 5px;
            background:#337AB7;
            border:none;
            border-radius: 5px;
            color:#FFF;
            padding:5px 10px;
        }
        .menu_th button:hover{
            background:#286090;
        }
      .menu_th{
            width:50%;
            background:#CCC;
            padding:5px 0;
            position:fixed;
             z-index:100;
        }
        .left{
            width:50%;
            height:100%;
            float:left;
            border-right:1px solid #CCC;
            overflow:auto;
        }
        @media(max-width:600px){
            .twoButton{
                display:none;
            }
            .table{
                margin-top:0px;
            }
        }
        .right{
            position:fixed;
            top:0;right:0;
            width:50%;
            height:100%;
            float:right;
            padding:2px;
        }
        .textContent{
            border:none;
           max-width:100%;
           max-height:300px;

        }
        .table{
            margin-top:30px;
        }
    </style>
</head>
<body>
<div class="left">
<div class="menu_th">
    <p class="selectCase checked allCase"><i class="glyphicon glyphicon-ok"></i></p>
    <button>删除选中</button><button class="twoButton">选中标记为已读</button><button>本页标记为已读</button>
</div>
<table class="table">
    <tr>
    </tr>
    <tr>
        <td>
            <div class="checkbox">
                <p class="selectCase checked"><i class="glyphicon glyphicon-ok"></i></p><label>1你好栽要要要要要要要要要要..........</label>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="checkbox">
                <p class="selectCase checked"><i class="glyphicon glyphicon-ok"></i></p><label>你好栽要要要要要要要要要要..........</label>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="checkbox">
                <p class="selectCase checked"><i class="glyphicon glyphicon-ok"></i></p><label>你好栽要要要要要要要要要要..........</label>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="checkbox">
                <p class="selectCase checked"><i class="glyphicon glyphicon-ok"></i></p><label>你好栽要要要要要要要要要要..........</label>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="checkbox">
                <p class="selectCase checked"><i class="glyphicon glyphicon-ok"></i></p><label>你好栽要要要要要要要要要要..........</label>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="checkbox">
                <p class="selectCase checked"><i class="glyphicon glyphicon-ok"></i></p><label>你好栽要要要要要要要要要要..........</label>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="checkbox">
                <p class="selectCase checked"><i class="glyphicon glyphicon-ok"></i></p><label>你好栽要要要要要要要要要要..........</label>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="checkbox">
                <p class="selectCase checked"><i class="glyphicon glyphicon-ok"></i></p><label>你好栽要要要要要要要要要要..........</label>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="checkbox">
                <p class="selectCase checked"><i class="glyphicon glyphicon-ok"></i></p><label>你好栽要要要要要要要要要要..........</label>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="checkbox">
                <p class="selectCase checked"><i class="glyphicon glyphicon-ok"></i></p><label>你好栽要要要要要要要要要要..........</label>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="checkbox">
                <p class="selectCase checked"><i class="glyphicon glyphicon-ok"></i></p><label>你好栽要要要要要要要要要要..........</label>
            </div>
        </td>
    </tr>
</table>
</div>
<div class="right" state="select">
    <div class="input-group">
        <span class="input-group-addon" id="basic-addon1"><b>发件人</b></span>
        <input type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1" readonly="readonly">
    </div>
    <div style="border:1px solid #CCC">
        <p  id="basic-addon2" style="width:100%;height:30px;background:#EEEEEE;text-align: center;line-height:30px;margin:0;"><b>内容</b></p>
        <textarea class="form-control textContent" placeholder="Username" aria-describedby="basic-addon2" readonly="readonly"></textarea>
    </div>
    <button class="btn btn-default reply" style="float:right;">回复</button>
    <button class="btn btn-default send" style="float:right;display:none;">发送</button>
</div>
<script src="js/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
    $(".selectCase").click(function(){
        if($(this).is(".checked")){
           $(this).removeClass("checked");
        }else{
            $(this).addClass("checked");
        }
    });
    $(".allCase").click(function(){
        if($(".checkbox .checked").length<$(".checkbox .selectCase").length){
            $(".checkbox .selectCase").addClass("checked");
        }else{
            $(".checkbox .selectCase").removeClass("checked");
        }
    });
    $(".checkbox .selectCase").click(function(){
        if($(".checkbox .checked").length<$(".checkbox .selectCase").length){
            $(".allCase").removeClass("checked");
        }else{
            $(".allCase").addClass("checked")
        }
    });
    $(".reply").click(function(){
        $(this).parent().attr("state","send");
        $(this).hide();
        $(".send").show();
        $(this).siblings().find("input").removeAttr("readonly");
        $(".textContent").removeAttr("readonly");
    })
</script>
</body>
</html>
