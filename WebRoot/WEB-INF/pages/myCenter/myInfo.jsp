<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
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
    <link href="css/datepicker/datepicker3.css" type="text/css" rel="stylesheet">
    <link href="css/myCenter/flat/green.css" type="text/css" rel="stylesheet">
    <link href="css/auctionOrder.css" type="text/css" rel="stylesheet">
    <style type="text/css">
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
           display:none;
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
        .provinesContent tr td{
        	padding:0;margin:0;
        }
        .provinesContent tr td ul{
        	padding:0;
        }
        .provinesContent tr td:first-child{
        	width:45px;
        }
    </style>
</head>
<body style="padding:0 80px;">
<form action="myCenter_myInfo" method="post" id="myInfoForm">
    <table class="table">
        <tr>
            <td>
                <div class="input-group select">
                    <span class="input-group-addon" id="basic-addon2">昵称</span>
                    <span  class="form-control view"  aria-describedby="basic-addon2">${nickname}</span>
                    <input type="text" name="nickname" class="form-control change" style="display: none" placeholder="填写昵称" aria-describedby="basic-addon2" value="${nickname}" source="${nickname}" data-toggle="tooltip" data-placement="top" title="昵称已经被使用"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="input-group select">
                    <span class="input-group-addon" id="basic-addon3">用户名</span>
                    <span  class="form-control view"  aria-describedby="basic-addon3">${username}</span>
                    <input type="text" name="username" class="form-control change" style="display: none" placeholder="填写用户名" aria-describedby="basic-addon3" value="${username}" source="${username}" data-toggle="tooltip" data-placement="top" title="用户名已经被使用"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="input-group select">
                    <span class="input-group-addon" id="basic-addon4">真实姓名</span>
                    <span  class="form-control view"  aria-describedby="basic-addon4">${identity.name}</span>
                    <input type="text" name="identity.name" class="form-control change" style="display: none" placeholder="what's your name" aria-describedby="basic-addon4" value="${identity.name}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="input-group select">
                    <span class="input-group-addon" id="basic-addon5">证件号</span>
                    <span  class="form-control view"  aria-describedby="basic-addon5">${identity.identityNumber}</span>
                    <input type="text"name="identity.identityNumber" class="form-control change identityNumber" style="display: none" placeholder="what's your identity number" aria-describedby="basic-addon5" value="${identity.identityNumber}" maxlength=18 data-toggle="tooltip" data-placement="top" title="身份证号码格式不正确，可以选择不填"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="input-group select">
                    <span class="input-group-addon" id="basic-addon6">性别</span>
                    <span  class="form-control view"  aria-describedby="basic-addon6">${sex==1?'男':'女'}</span>
                    <!-- radio -->
                    <div class="form-group change" style="margin:5px 0">
                        <label>
                            <input type="radio" name="sex" class="flat-red" ${sex==1?'checked':'' } value="1">男
                        </label>
                        <label>
                            <input type="radio" name="sex" class="flat-red" ${sex==0?'checked':'' } value="0">女
                        </label>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="input-group select">
                    <span class="input-group-addon" id="basic-addon7">出生日期</span>
                    <span  class="form-control view"  aria-describedby="basic-addon7"><s:date name="birthday" format="yyyy-MM-dd"/></span>
                    <input type="text" name="birthday" class="form-control change" id="datepicker" style="display: none" placeholder="选择出生日期" aria-describedby="basic-addon7" value="<s:date name="birthday" format="yyyy-MM-dd"/>"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="input-group select">
                	<input type="hidden" value="${address}" name="address">
                    <span class="input-group-addon" id="basic-addon9">家乡</span>
                    <span  class="form-control view" aria-describedby="basic-addon9">${address}</span>
                    <div class="form-control selectArea change" style="display:none;" data-toggle="popover"
                         data-placement="top" data-content="省市是必须要选的">
                        <span class="selectedArea initArea">${address!=null?address:'选择省/市/区...'}</span> <span
                            class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"
                            style="float:right"></span>
                    </div>
                    <div class="provinesBox" style="width:350px;">
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
    </form>
    <div class="modifyButton" state="view"><i class="glyphicon glyphicon-pencil"></i></div>
    <button class="btn btn-primary modifyCommit" type="button" data-toggle="popover" data-placement="left" data-content="">更新</button>
    <script src="js/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="js/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="js/ChineseAscii.js"></script>
    <script src="js/myCenter/icheck.min.js" type="text/javascript"></script>
    <script src="js/auctionOrder.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function(){
        $(".modifyButton").click(function(){
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
        	var _this = this;
       		 $("input[name=address]").val($(".selectedArea").html());//把地址赋给表单地址
        	$.ajax({
				type : "POST",
				url : "json/myCenter_myInfo",
				data : $('#myInfoForm').serialize(),
				dataType : 'json',
				success : function(data) {
					if(data!=null){
						data = eval("("+data+")");
						if(data.message){
							window.location.reload();
						}else{
							$(_this).attr("data-content","更新失败，原因："+data.cause);
							$(_this).popover("show");
							setTimeout(function(){
								$(_this).popover("destroy");
							},3000)
						}
						return;
					}
					$(_this).attr("data-content","更新失败，未知原因");
					$(_this).popover("show");
					setTimeout(function(){
						$(_this).popover("destroy");
					},3000)
				}
			})
        })
        $("input[name=nickname]").blur(function(){
        	checkIsExist("nickname",this)
        })
        $("input[name=username]").blur(function(){
        	checkIsExist("username",this)
        })
        $(".identityNumber").blur(function(){
        	var _this = this;
        	if(this.value!=''&&!/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/.test(this.value)){
        		$(this).tooltip("show");
        		$(this).focus();
        		setTimeout(function(){
					$(_this).tooltip("destroy");
				},3000);
        	}
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
    function checkIsExist(type, el) {
    	if(el.value==''||el.value==$(el).attr("source"))return;
    	if(type=='username'&&!/^[a-zA-Z]+[0-9a-zA-Z]{4,20}$/.test(el.value)){
    		$(el).attr("title","用户名只支持英文加数字并且5-20位");
    		$(el).tooltip("show");
    		setTimeout(function(){
				$(el).tooltip("destroy");
				$(el).attr("title","用户名已经被使用");
			},3000);
			return;
    	}
			var data = "type=" + type + "&value=" + el.value;
			$.post({
				url : "json/checkIsExist",
				data : data,
				success : function(data) { // 此处可以因为版本问题导入包commons-lang-2.3.jar
					if (data != null) {
						var data = eval("(" + data + ")");
						if (data.message) {
							$(el).tooltip("show");
							setTimeout(function(){
								$(el).tooltip("destroy");
							},3000);
						}else{
							$(el).attr("source",el.value);
						}
					}
				}
			});
}
</script>
</body>
</html>
