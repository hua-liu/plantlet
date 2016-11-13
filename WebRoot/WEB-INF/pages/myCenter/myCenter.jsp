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
    
    <title>My JSP 'myCenter.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet">
    <link href="css/myCenter/myCenter.css" type="text/css" rel="stylesheet">
    <!--图片裁剪-->
    <link href="css/myCenter/pictureCut/cropper.min.css" type="text/css" rel="stylesheet">
    <link href="css/myCenter/pictureCut/main.css" type="text/css" rel="stylesheet">
    <link href="css/myCenter/borderEffects/base.css" rel="stylesheet">
    <link href="css/admin/animation.css" rel="stylesheet">
    <!--/图片裁剪-->
     <script src="js/jquery/jquery.min.js" type="text/javascript"></script>
	<style type="text/css">
		.loader{
			position:absolute;
			top:0;left:0;
			background:rgba(0,0,0,0.8);
			width:100%;height:100%;
		}
		.loader-inner{
			position:absolute;
			left:45%;top:40%;
		}
		.loader-inner>div{
			border:none;
		}
	</style>
	<script type="text/javascript">
		function removeLoading(){
			$(".loader").remove();
		}
	</script>
  </head>
<body style="background:url('img/background.jpg')">
<div class="container">
        <div class="head">
            <p>欢迎回来 《上次登陆时间:2016-6-6 12:12:12》</p>
        </div>
        <div class="body">
            <table class="table col-md-12">
                <tr>
                    <td colspan="3" style="border-top:none;">
                        <div class="photo_user">
                            <div id="crop-avatar">
                                <!-- Current avatar -->
                                <div class="avatar-view" title="更改头像">
                                	<s:if test="#session.user!=null&&#session.user.photo!=null">
                                		<img class="photo" src="json/download_file?isBreviary=2&id=${user.photo.id}"/>
                                	</s:if>
                                	<s:else>
                                    	<img class="photo" src="img/myCenter/noPhoto.png" style="border:1px solid #CCC"/>
                                	</s:else>
                                    <br/>
                                </div>
                                <p style="margin-top:10px;"><h3 class="modifyHover"><span class="nickname"><s:property value="#session.user.nickname!=null?#session.user.nickname:'您还没有昵称'"/></span><small class="nickname_modify"><i class="glyphicon glyphicon-pencil"></i></small></h3></p>
                                <div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <form class="avatar-form" action="#" enctype="multipart/form-data" method="get">
                                                <div class="modal-header">
                                                    <button class="close" data-dismiss="modal" type="button">&times;</button>
                                                    <h4 class="modal-title" id="avatar-modal-label" style="color:#000;">更换头像</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="avatar-body">

                                                        <!-- Upload image and data -->
                                                        <div class="avatar-upload" style="display:none">
                                                            <input class="avatar-src" name="avatar_src" type="hidden">
                                                            <input class="avatar-data" name="avatar_data" type="hidden">
                                                            <input class="avatar-input" name="file" type="file" id="file">
                                                        </div>

                                                        <!-- Crop and preview -->
                                                        <div class="row">
                                                            <div class="col-md-9">
                                                                <div class="avatar-wrapper"></div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="avatar-preview preview-lg"></div>
                                                                <div class="avatar-preview preview-md"></div>
                                                                <div class="avatar-preview preview-sm"></div>
                                                            </div>

                                                            <div class="row avatar-btns">
                                                                <div class="col-md-9">
                                                                    <div class="btn-group">
                                                                        <button class="btn btn-success" id="selectPicture" type="button">选择图片</button>
                                                                        <!-- <button class="btn btn-primary" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees">右旋转90度</button>
                                                                        <button class="btn btn-primary" data-method="rotate" data-option="15" type="button">右转15度</button>
                                                                        <button class="btn btn-primary" data-method="rotate" data-option="30" type="button">旋转30度</button>
                                                                        <button class="btn btn-primary" data-method="rotate" data-option="-15" type="button">左旋15度</button>
                                                                        <button class="btn btn-primary" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees">左旋转90度</button> -->
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <button class="btn btn-primary btn-block avatar-save" type="submit">Done</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- <div class="modal-footer">
                                                      <button class="btn btn-default" data-dismiss="modal" type="button">Close</button>
                                                    </div> -->
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div><!-- /.modal -->

                                <!-- Loading state -->
                                <div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="col-md-4" style="border-top:none;">
                        <div class="menu" data="myInfo">
                            <div class="top"></div>
                            <div class="left"></div>
                            <div class="bottom"></div>
                            <div class="right"></div>
                            <span class="glyphicon glyphicon-user"></span>
                            <p>我的信息</p>
                        </div>
                    </td>
                    <td class="col-md-4" style="border-top:none;">
                        <div class="menu" data="myOrderForm">
                            <div class="top"></div>
                            <div class="left"></div>
                            <div class="bottom"></div>
                            <div class="right"></div>
                            <span class="glyphicon glyphicon-star-empty"></span>
                            <p>我的订单</p>
                        </div>
                    </td>
                    <td class="col-md-4" style="border-top:none;">
                        <div class="menu" data="myMoney">
                            <div class="top"></div>
                            <div class="left"></div>
                            <div class="bottom"></div>
                            <div class="right"></div>
                            <span class="glyphicon glyphicon-usd"></span>
                            <p>我的金库</p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="col-md-4" style="border-top:none;">
                        <div class="menu" data="myDeliveryAddr">
                            <div class="top"></div>
                            <div class="left"></div>
                            <div class="bottom"></div>
                            <div class="right"></div>
                            <span class="glyphicon glyphicon-pushpin"></span>
                            <p>收货地址维护</p>
                        </div>
                    </td>
                    <td class="col-md-4" style="border-top:none;">
                        <div class="menu" data="myMessage">
                            <div class="top"></div>
                            <div class="left"></div>
                            <div class="bottom"></div>
                            <div class="right"></div>
                            <span class="glyphicon glyphicon-volume-up"></span>
                            <p>消息提醒</p>
                        </div>
                    </td>
                    <td class="col-md-4" style="border-top:none;">
                        <div class="menu" data="mySafe">
                            <div class="top"></div>
                            <div class="left"></div>
                            <div class="bottom"></div>
                            <div class="right"></div>
                            <span class="glyphicon glyphicon-lock"></span>
                            <p>安全设置</p>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="foot">
            <p>小苗基地@liuhua</p>
        </div>
    </div>
    <div class="modal fade bs-example-modal-lg" id="contentModal" tabindex="-1" role="dialog" aria-labelledby="contentModal" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" style="color:#000">&times;</span></button>
                    <h4 class="modal-title" id="contentModalLabel" style="color:#000;font-size:15px;">Modal title</h4>
                </div>
                <div class="modal-body myContentBody">
                    <div class="myContent">
                         <iframe src="" class="iframeContent" onload="removeLoading()"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="js/fileUpload/ajaxfileupload.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="js/myCenter/myCenter.js" type="text/javascript"></script>
    <!--图片裁剪-->
    <script src="js/myCenter/pictureCut/cropper.min.js" type="text/javascript"></script>
    <script src="js/myCenter/pictureCut/main.js" type="text/javascript"></script>
  <!--  <script src="js/pictureCut/pictureCut.js" type="text/javascript"></script>-->
    <!--/图片裁剪-->
    <!---->
    <script type="text/javascript" src="js/myCenter/borderEffects/main.js"></script>
</body>
</html>
