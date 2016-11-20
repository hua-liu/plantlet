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
		.head .left{
			float:left;
		}
		.head p a{
			margin:0 5px;color:#FFF;
		}
	</style>
	<script type="text/javascript">
		function removeLoading(){
			$(".loader").remove();
		}
	</script>
  </head>
<body style="background:url('img/background.jpg')">
<div class="bodyLoader" style="width:100%;height:100%;position:absolute;top:0;left:0;background:rgba(0,0,0,0.8);z-index:1500"><div class="loader-inner square-spin"><div></div></div></div>
<div class="container">
        <div class="head">
        	<p class="left"><a href="index"><s:text name="backHomepage"/></a></p>
            <p><s:text name="welcomeBack"/> 《
            <s:text name="theLastLoginTime"/><s:date name="log!=null&&log.currentDate!=null?log.currentDate:''" format="yyyy-MM-dd HH:mm:ss"/> <s:text name="lastLoginIp"/><s:text name="%{log!=null&&log.changeIp!=null?log.changeIp:getText('firstLogin')}"/>
            》<a href="userLogout"><s:text name="quit"/></a></p>
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
                                <p style="margin-top:10px;"><h3 class="modifyHover"><span class="nickname"><s:property value="%{#session.user.nickname!=null?#session.user.nickname:getText('youNoNickname')}"/></span></h3></p>
                                <div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <form class="avatar-form" action="#" enctype="multipart/form-data" method="get">
                                                <div class="modal-header">
                                                    <button class="close" data-dismiss="modal" type="button">&times;</button>
                                                    <h4 class="modal-title" id="avatar-modal-label" style="color:#000;"><s:text name="changeThePicture"/></h4>
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
                                                                        <button class="btn btn-success" id="selectPicture" type="button"><s:text name="choosePicture"/></button>
                                                                        <!-- <button class="btn btn-primary" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees">右旋转90度</button>
                                                                        <button class="btn btn-primary" data-method="rotate" data-option="15" type="button">右转15度</button>
                                                                        <button class="btn btn-primary" data-method="rotate" data-option="30" type="button">旋转30度</button>
                                                                        <button class="btn btn-primary" data-method="rotate" data-option="-15" type="button">左旋15度</button>
                                                                        <button class="btn btn-primary" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees">左旋转90度</button> -->
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <button class="btn btn-primary btn-block avatar-save" type="submit"><s:text name="done"/></button>
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
                            <p><s:text name="myInformation"/></p>
                        </div>
                    </td>
                    <td class="col-md-4" style="border-top:none;">
                        <div class="menu" data="myOrderForm">
                            <div class="top"></div>
                            <div class="left"></div>
                            <div class="bottom"></div>
                            <div class="right"></div>
                            <span class="glyphicon glyphicon-star-empty"></span>
                            <p><s:text name="myOrder"/></p>
                        </div>
                    </td>
                    <td class="col-md-4" style="border-top:none;">
                        <div class="menu" data="myMoney">
                            <div class="top"></div>
                            <div class="left"></div>
                            <div class="bottom"></div>
                            <div class="right"></div>
                            <span class="glyphicon glyphicon-usd"></span>
                            <p><s:text name="myVault"/></p>
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
                            <p><s:text name="shippingAddressMaintenance"/></p>
                        </div>
                    </td>
                    <td class="col-md-4" style="border-top:none;">
                        <div class="menu" data="myMessage">
                            <div class="top"></div>
                            <div class="left"></div>
                            <div class="bottom"></div>
                            <div class="right"></div>
                            <span class="glyphicon glyphicon-volume-up"></span>
                            <p><s:text name="messageToRemind"/></p>
                        </div>
                    </td>
                    <td class="col-md-4" style="border-top:none;">
                        <div class="menu" data="mySafe">
                            <div class="top"></div>
                            <div class="left"></div>
                            <div class="bottom"></div>
                            <div class="right"></div>
                            <span class="glyphicon glyphicon-lock"></span>
                            <p><s:text name="securitySettings"/></p>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="foot">
            <p>小苗基地@liuhua</p>
        </div>
    </div>
    <s:debug></s:debug>
    <div class="modal fade bs-example-modal-lg" id="contentModal" tabindex="-1" role="dialog" aria-labelledby="contentModal" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" style="color:#000">&times;</span></button>
                    <h4 class="modal-title" id="contentModalLabel" style="color:#000;font-size:15px;"><s:text name="%{function==1?getText('myInformation'):function==2?getText('myOrder'):function==3?getText('myVault'):function==4?getText('shippingAddressMaintenance'):function==5?getText('messageToRemind'):getText('securitySettings')}"/></h4>
                </div>
                <div class="modal-body myContentBody">
                    <div class="myContent">
                    	<s:if test="function!=0">
                    		<script>
                    			$(function(){
                    				$("#contentModal").modal("show");
                    			})
                    		</script>
                    	</s:if>
                    	<s:if test="function==1">
                    		<s:url var="url" value="center_myInfo"></s:url>
                    	</s:if>
                    	<s:elseif test="function==2">
                    		<s:url var="url" value="center_myOrderForm"></s:url>
                    	</s:elseif>
                    	<s:elseif test="function==3">
                    		<s:url var="url" value="center_myMoney"></s:url>
                    	</s:elseif>
                    	<s:elseif test="function==4">
                    		<s:url var="url" value="center_myDeliveryAddr"></s:url>
                    	</s:elseif>
                    	<s:elseif test="function==5">
                    		<s:url var="url" value="center_myMessage"></s:url>
                    	</s:elseif>
                    	<s:elseif test="function==6">
                    		<s:url var="url" value="center_mySafe"></s:url>
                    	</s:elseif>
                    	<s:else>
                    		<s:url var="url" value=""></s:url>
                    	</s:else>
                         <iframe src="${url}" class="iframeContent" onload="removeLoading()"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <audio id="sound">
		<source src="sound/msn.mp3" type="audio/mpeg" class="source">
 		<source src="sound/msn.wav" type="audio/wav" class="source">
	</audio>
	<!--i18n  -->
	<script src="js/admin/map.js"></script>
	<script type="text/javascript">
		try{
		var i18nConfig = eval("(" + "${sessionScope.i18nConfig}" + ")");
		var i18n = new Map();
		for ( var key in i18nConfig) {
			i18n.put(key, i18nConfig[key]);
		}
	}catch(e){
		alert(e);
	}
	</script>
	<!--/i18n  -->
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
