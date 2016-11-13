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
    <link href="css/myCenter/datepicker3.css" type="text/css" rel="stylesheet">
    <link href="css/myCenter/flat/green.css" type="text/css" rel="stylesheet">
    <link href="css/auctionOrder.css" type="text/css" rel="stylesheet">
    <style type="text/css">
        .table tr td{
           height:50px;
            width:50%;
        }
        .modifyButton{
            position:fixed;
            right:10px;top:10px;
            width:50px;height:50px;
            font-size:50px;
            text-align:center;
            line-height:50px;
            color:#000;
        }
        .modifyButton:hover{
            color:#5CB85C;
            cursor:pointer;
        }
        .modifyCommit{
            width:60px;height:60px;
            position:fixed;
            right:10px;bottom:10px;
           /* display:none;*/
        }
        .select{
            border:none;
        }
        .select span{
            background:none;
            border:none;
        }
        .select input{
            display:none;
        }
        .change{
            display:none;
        }
        .view{
            display: none;
        }
        .input-group-addon{
            width:80px;
        }
    </style>
</head>
<body style="padding:0 80px;">
<form action="#" method="post" id="myInfoForm"></form>
    <table class="table">
        <tr>
            <td>
                <div class="input-group select">
                    <span class="input-group-addon" id="basic-addon2">昵称</span>
                    <span  class="form-control view"  aria-describedby="basic-addon2">${user.nickname}</span>
                    <input type="text" name="nickname" class="form-control change" style="display: none" placeholder="填写昵称" aria-describedby="basic-addon2" value="${user.nickname}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="input-group select">
                    <span class="input-group-addon" id="basic-addon3">用户名</span>
                    <span  class="form-control view"  aria-describedby="basic-addon3">${user.username}</span>
                    <input type="text" name="username" class="form-control change" style="display: none" placeholder="填写用户名" aria-describedby="basic-addon3" value="${user.username}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="input-group select">
                    <span class="input-group-addon" id="basic-addon4">真实姓名</span>
                    <span  class="form-control view"  aria-describedby="basic-addon4">没开放</span>
                    <input type="text" class="form-control change" style="display: none" placeholder="没开放" aria-describedby="basic-addon4" value="没开放不要填"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="input-group select">
                    <span class="input-group-addon" id="basic-addon5">证件号</span>
                    <span  class="form-control view"  aria-describedby="basic-addon5">没开放</span>
                    <input type="text" class="form-control change" style="display: none" placeholder="没开放" aria-describedby="basic-addon5" value="没开放不要填"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="input-group select">
                    <span class="input-group-addon" id="basic-addon6">性别</span>
                    <span  class="form-control view"  aria-describedby="basic-addon6">${user.sex==1?'男':'女'}</span>
                    <!-- radio -->
                    <div class="form-group change" style="margin:5px 0">
                        <label>
                            <input type="radio" name="sex" class="flat-red" ${user.sex==1?'checked':'' } value="1">男
                        </label>
                        <label>
                            <input type="radio" name="sex" class="flat-red" ${user.sex==0?'checked':'' } value="0">女
                        </label>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="input-group select">
                    <span class="input-group-addon" id="basic-addon7">生日</span>
                    <span  class="form-control view"  aria-describedby="basic-addon7">${user.birthday}</span>
                    <input type="text" name="birthday" class="form-control change" id="datepicker" style="display: none" placeholder="选择出生日期" aria-describedby="basic-addon7"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="input-group select">
                	<s:hidden name="address"></s:hidden>
                    <span class="input-group-addon" id="basic-addon9">家乡</span>
                    <span  class="form-control view" aria-describedby="basic-addon9">${user.address}</span>
                    <div class="form-control selectArea change" style="display:none;" data-toggle="popover"
                         data-placement="top" data-content="省市是必须要选的">
                        <span class="selectedArea initArea">选择省/市/区...</span> <span
                            class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"
                            style="float:right"></span>
                    </div>
                    <div class="provinesBox">
                        <ul class="provinesMenu">
                            <li class="provinces active">省份</li>
                            <li class="city">城市</li>
                            <li class="district">县区</li>
                            <li class="street">街道</li>
                            <!-- 	<li class="village">村</li> -->
                        </ul>
                        <div class="provinesContent">
                            <div class="city-group city-provinces active">
                                <table>
                                    <tr>
                                        <td><b>A-G</b></td>
                                        <td class="col-md-11">
                                            <ul class="ag">
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>H-K</b></td>
                                        <td class="col-md-11">
                                            <ul class="hk">
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>L-S</b></td>
                                        <td class="col-md-11">
                                            <ul class="ls">
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>T-Z</b></td>
                                        <td class="col-md-11">
                                            <ul class="tz">
                                            </ul>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="city-group city-city">
                                <table>
                                    <tr>
                                        <td><b>A-G</b></td>
                                        <td class="col-md-11">
                                            <ul class="ag">
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>H-K</b></td>
                                        <td class="col-md-11">
                                            <ul class="hk">
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>L-S</b></td>
                                        <td class="col-md-11">
                                            <ul class="ls">
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>T-Z</b></td>
                                        <td class="col-md-11">
                                            <ul class="tz">
                                            </ul>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="city-group city-district">
                                <table>
                                    <tr>
                                        <td><b>A-G</b></td>
                                        <td class="col-md-11">
                                            <ul class="ag">
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>H-K</b></td>
                                        <td class="col-md-11">
                                            <ul class="hk">
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>L-S</b></td>
                                        <td class="col-md-11">
                                            <ul class="ls">
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>T-Z</b></td>
                                        <td class="col-md-11">
                                            <ul class="tz">
                                            </ul>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="city-group city-street">
                                <table>
                                    <tr>
                                        <td><b>A-G</b></td>
                                        <td class="col-md-11">
                                            <ul class="ag">
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>H-K</b></td>
                                        <td class="col-md-11">
                                            <ul class="hk">
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>L-S</b></td>
                                        <td class="col-md-11">
                                            <ul class="ls">
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>T-Z</b></td>
                                        <td class="col-md-11">
                                            <ul class="tz">
                                            </ul>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <!-- <div class="city-group city-village"></div> -->
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <div class="modifyButton" state="view"><i class="glyphicon glyphicon-pencil"></i></div>
    <button class="btn btn-primary modifyCommit" type="button">更新</button>
    <script src="js/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="js/myCenter/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="js/myCenter/icheck.min.js" type="text/javascript"></script>
    <script src="js/auctionOrder.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function(){
        $(".modifyButton").click(function(){
        	alert("更改未开发")return;
            if($(this).attr("state")=='view') {
                $(this).attr("state","change");
                $(this).children().removeClass("glyphicon-pencil");
                $(this).children().addClass("glyphicon-remove");
                $(".view").hide();
                $(".change").show();
                $(".modifyCommit").show();
            }else{
                $(this).attr("state","view");
                $(".view").show();
                $(".change").hide();
                $(".modifyCommit").hide();
                $(this).children().removeClass("glyphicon-remove");
                $(this).children().addClass("glyphicon-pencil");
            }
        })
        $(".modifyCommit").click(function(){
        	$.ajax({
				type : "POST",
				url : "json/myselfUpdate_user",
				data : $('#myInfoForm').serialize(),
				dataType : 'json',
				success : function(data) {
					if(data!=null){
						data = eval("("+data+")");
						if(data.message){
							window.location.reload();
							return;
						}
					}
					alert("更改失败");
				}
			})
        })
        //Date picker
        $('#datepicker').datepicker({
            autoclose: true
        });
        //Flat red color scheme for iCheck
        $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
            checkboxClass: 'icheckbox_flat-green',
            radioClass: 'iradio_flat-green'
        });
    })
</script>
</body>
</html>
