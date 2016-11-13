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
	<link href="bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="css/auctionOrder.css" type="text/css" rel="stylesheet">
    <style type="text/css">
        ul li{
            width:150px;
            list-style: none;
            border:1px solid #CCC;
            padding:2px;
            font-size:15px;
            text-align:center;
            display:block;
        }
        ul li:hover{
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
        .boxCont {
            position: absolute;
            background: white;
            border-radius: 5px;
            box-shadow: 0px 1px 2px rgba(0,0,0,0.3);
            padding: 5px;
        }
        .boxCont:hover {
            box-shadow: 1px 1px 10px rgba(0,0,0,0.5);
            margin-top: -5px;
            -webkit-transition: all 0.3s ease-in-out;
            -moz-transition: all 0.3s ease-in-out;
            -o-transition: all 0.3s ease-in-out;
            transition: all 0.3s ease-in-out;
        }
    </style>
</head>
<body>
    <ul id="gallery-wrapper">
        <li class="boxCont" style="height:200px;line-height:200px;" data-toggle="modal"
            data-target="#addAddrModal" id="addAddrModalButton"><i class="glyphicon glyphicon-plus"><br/>添加新地址</i></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>刘华<br/>刘华<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>刘华<br/>刘华<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>刘华<br/>刘华<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>刘华<br/>刘华<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>东兴区尚华名<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>刘华<br/>15808325356</span></p></li>
        <li class="boxCont"><p  class="thumb"><span>四川省<br/>内江市<br/>东兴区<br/>东兴街道<br/>东兴区尚华名<br/>东兴区尚华名<br/>刘华<br/>15808325356</span></p></li>
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
                        <b>添加收货地址</b>
                    </h4>
                </div>
                <form action="addAddr" method="post" id="addressForm">
                    <div class="modal-body">
                        <s:hidden name="address"></s:hidden>
                        <div class="input-group">
                            <div class="input-group-addon">所在地区</div>
                            <div class="form-control selectArea" data-toggle="popover"
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
                        <div class="input-group">
                            <div class="input-group-addon">详细地址</div>
							<textarea class="form-control" name="moreAddress" rows="3"
                                      placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息"
                                      style="max-width:490px;" data-toggle="popover"
                                      data-placement="top" data-content="多多少少也请填写一点，让你取货更方便"></textarea>
                            <!-- 						<input type="text" class="form-control col-md-10" placeholder="输入详细的地址">
 -->
                        </div>
                        <div class="input-group">
                            <div class="input-group-addon">收&ensp;件&ensp;人</div>
                            <input type="text" class="form-control col-md-10" name="name"
                                   placeholder="填写收件人姓名" data-toggle="popover" data-placement="top"
                                   data-content="你要把货寄给谁呀">
                            <div class="input-group-addon">邮政编码</div>
                            <input type="text" class="form-control col-md-10" name="postcode"
                                   placeholder="不填写，默认000000">
                        </div>
                        <div class="input-group">
                            <div class="input-group-addon">手&ensp;机&ensp;号</div>
                            <input type="text" class="form-control col-md-10" name="phone"
                                   placeholder="电话号码、手机号码必须填一项" data-toggle="popover"
                                   data-placement="top" data-content="手机号或电话号码为方便联系你">
                            <div class="input-group-addon">电话</div>
                            <input type="text" class="form-control col-md-10"
                                   name="telephone" placeholder="电话号码、手机号码必须填一项">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="hidden" name="id" id="addrId">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary"
                                id="submitAddAddress" data-toggle="popover" data-placement="left"
                                data-content="">确定添加</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="js/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!--流动布局-->
    <script src="js/myCenter/layout/pinterest_grid.js"></script>
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
