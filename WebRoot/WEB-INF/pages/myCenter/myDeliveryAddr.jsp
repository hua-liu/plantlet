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
    <link href="css/auctionOrder.css" type="text/css" rel="stylesheet">
    <style type="text/css">
        #gallery-wrapper li{
            width:150px;
            list-style: none;
            border:1px solid #CCC;
            padding:2px;
            font-size:15px;
            text-align:center;
            display:block;
        }
        #gallery-wrapper li:hover{
            border-color:green;
            cursor:pointer;
        }
        #gallery-wrapper {
            position: relative;
            width: 100%;
            padding:0;
        }
        p.thumb {
            width: 100%;
            max-width: 100%;
            height: auto;
        }
        .boxCont,.boxContPrimary {
            position: absolute;
            background: white;
            border-radius: 5px;
            box-shadow: 0px 1px 2px rgba(0,0,0,0.3);
            padding: 5px;
        }
        .boxCont:hover,.boxContPrimary:hover {
            box-shadow: 1px 1px 10px rgba(0,0,0,0.5);
            margin-top: -5px;
            -webkit-transition: all 0.3s ease-in-out;
            -moz-transition: all 0.3s ease-in-out;
            -o-transition: all 0.3s ease-in-out;
            transition: all 0.3s ease-in-out;
        }
        .delAddress{
        	width:20px;height:20px;
        	display:none;
        	position:absolute;
        	right:2px;top:90%;
        }
        .delAddress:hover{
        	color:#F00;
        }
    </style>
</head>
<body>
    <ul id="gallery-wrapper">
        <li class="boxContPrimary" style="height:200px;" data-toggle="modal"
            data-target="#addAddrModal" id="addAddrModalButton"><i class="glyphicon glyphicon-plus" style="margin-top:40%;"><br/><s:text name="addANewAddress"/></i></li>
       <s:iterator value="#request.addrs" status="c">
      	<li class="boxCont" data-id="${id}"><p class="thumb"><span>${address.replace("--","<br/>")}<br/>${moreAddress}<br/>${name}<br/>${phone}</span></p><span class="glyphicon glyphicon-remove delAddress" title="删除"></span></li>
	</s:iterator>
    </ul>
    <div class="modal fade" id="addAddrModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        <b><s:text name="addAShippingAddress"/></b>
                    </h4>
                </div>
                <form action="addAddr" method="post" id="addressForm">
                    <div class="modal-body">
                        <s:hidden name="address"></s:hidden>
                        <div class="input-group">
                            <div class="input-group-addon"><s:text name="inTheArea"/></div>
                            <div class="form-control selectArea" data-toggle="popover"
                                data-placement="top" data-content="<s:text name='selectProvince_error'/>">
								<span class="selectedArea initArea"><s:text name='selectProvince/city/district...'/></span> <span
									class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"
									style="float:right"></span>
							</div>
							<div class="provinesBox">
								<ul class="provinesMenu">
									<li class="provinces active"><s:text name='provinces'/></li>
									<li class="city"><s:text name='city'/></li>
									<li class="district"><s:text name='county'/></li>
									<li class="street"><s:text name='street'/></li>
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
                       <div class="input-group">
							<div class="input-group-addon"><s:text name='detailedAddress'/></div>
							<textarea class="form-control" name="moreAddress" rows="3"
								placeholder="<s:text name='detailedAddress_placeHolder'/>"
								style="max-width:490px;" data-toggle="popover"
								data-placement="top" data-content="<s:text name='detailedAddress_error'/>"></textarea>
						</div>
						<div class="input-group">
							<div class="input-group-addon"><s:text name='toReceiveA'/></div>
							<input type="text" class="form-control col-md-10" name="name"
								placeholder="<s:text name='fillInTheRecipientsName'/>" data-toggle="popover" data-placement="top"
								data-content="<s:text name='toReceiveA_error'/>">
							<div class="input-group-addon"><s:text name='postalcode'/></div>
							<input type="text" class="form-control col-md-10" name="postcode"
								placeholder="<s:text name='doNotFillIn,theDefaultOf000000'/>">
						</div>
						<div class="input-group">
							<div class="input-group-addon"><s:text name='mobilePhoneNo.'/></div>
							<input type="text" class="form-control col-md-10" name="phone"
								placeholder="<s:text name='mobilePhoneNo._placeHolder'/>" data-toggle="popover"
								data-placement="top" data-content="<s:text name='mobilePhoneNo._error'/>">
							<div class="input-group-addon"><s:text name='telephone'/></div>
							<input type="text" class="form-control col-md-10"
								name="telephone" placeholder="<s:text name='mobilePhoneNo._placeHolder'/>">
						</div>
					</div>
                    <div class="modal-footer">
                        <input type="hidden" name="id" id="addrId">
                       <button type="button" class="btn btn-default" data-dismiss="modal"><s:text name='close'/></button>
						<button type="button" class="btn btn-primary"
							id="submitAddAddress" data-toggle="popover" data-placement="left"
							data-content=""><s:text name='addAddressAndSelect'/></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
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
    <script src="js/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!--流动布局-->
    <script src="js/myCenter/layout/pinterest_grid.js"></script>
    <script src="js/ChineseAscii.js"></script>
    <script src="js/auctionOrder.js"></script>
    <script type="text/javascript">
        $(function(){
            $("#gallery-wrapper").pinterest_grid({
                no_columns: 4,
                padding_x: 10,
                padding_y: 10,
                margin_bottom: 50,
                single_column_breakpoint: 700
            });
        });
    </script>
    <!--/流动布局-->
</body>
</html>
