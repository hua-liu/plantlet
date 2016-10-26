<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>left</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/leftMenu.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/leftMenu.js"></script>
</head>
<body>
    <div class="background">
        <span class="manageSpan">管 理 中 心</span>
        <div class="box">
        <ul>
            <li class="one"><div> <img src="${pageContext.request.contextPath}/img/li.png">业务管理</div>
                <ul id="oneUl">
                   <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="#">订单管理</a></li>
                   <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="${pageContext.request.contextPath}/UserManage" target="content">用户管理</a></li>
                   <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="#">信息管理</a></li>
                   <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="#">其他业务</a></li>
                </ul>
            </li>
            <li class="two"><div><img src="${pageContext.request.contextPath}/img/li.png">系统管理</div>
                <ul id="twoUl">
                    <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="#">系统配置</a></li>
                   <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="#">修改密码</a></li>
                   <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="#">数据更新</a></li>
                   <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="#">网站维护</a></li>
                </ul>
            </li>
            <li class="three"><div><img src="${pageContext.request.contextPath}/img/li.png">安全管理</div>
                <ul id="threeUl">
                   <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="#">支付安全</a></li>
                   <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="${pageContext.request.contextPath}/PermissionManage?method=permission" target="content">权限管理</a></li>
                   <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="${pageContext.request.contextPath}/PermissionManage?method=resource" target="content">资源权限</a></li>
                   <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="${pageContext.request.contextPath}/PermissionManage?method=role" target="content">角色权限</a></li>
                   <li><img src="${pageContext.request.contextPath}/img/li2.png"><a href="#">网站安全</a></li>
                </ul>
            </li>
        </ul>
    </div>
        <span class="ver">版本：2016V1.1</span>
    </div>
</body>
</html>