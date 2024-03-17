<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path; %>
<html>

<head>
    <title>梦想试衣间</title>
    <script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <script>

    </script>
</head>

<%--        <frameset rows="48px,*" border="0">--%>
<%--            <frame src="<%=basePath%>/jsp/banner.jsp" />--%>
<%--            <frameset cols="140px,*" border="1">--%>
<%--                <frame src="<%=basePath%>/jsp/menu.jsp" />--%>
<%--                <frame id="workspace" src="<%=basePath%>/jsp/workspace.jsp" />--%>
<%--            </frameset>--%>

<%--        </frameset>--%>
<body>
<div id="container">


    <header id="banner">
        <div id="banner-img">
            <img src="<%=basePath%>/images/ui/themeBanner.png" alt="">
        </div>

        <div id="user">当前用户：<span id="LoginUser"></span></div>
    </header>


    <div id="menuBorder">
        <div id="menu">
            <div class="menuItem">
                <a href="self.jsp" target="workspace">
                    <div class="menuItem-a">
                        <div class="menuItem-img">
                            <img src="../images/myUi/user.png" alt="个人信息">
                        </div>
                        <span class="menuItem-text"> 个人信息</span>
                    </div>
                </a>
            </div>

            <div class="menuItem">
                <a href="userManage.jsp" target="workspace">
                    <div class="menuItem-a">
                        <div class="menuItem-img">
                            <img src="../images/myUi/userMange.png" alt="用户管理">
                        </div>
                        <div class="menuItem-text"> 用户管理</div>
                    </div>
                </a>
            </div>
            <div class="menuItem">
                <a href="category.jsp" target="workspace">
                    <div class="menuItem-a">
                        <div class="menuItem-img">
                            <img style="height: 90% ;margin-left: 4px;margin-top: 3px" src="../images/myUi/closet.png"
                                 alt="服饰类别">
                        </div>

                        <span class="menuItem-text"> 服饰类别</span>
                    </div>
                </a>
            </div>
            <div class="menuItem">
                <a href="clothing.jsp" target="workspace">
                    <div class="menuItem-a">
                        <div class="menuItem-img">
                            <img src="../images/myUi/dress.png" alt="个人信息">
                        </div>
                        <span class="menuItem-text"> 服饰管理</span>
                    </div>
                </a>
            </div>
            <div class="menuItem">
                <a href="suit.jsp" target="workspace">
                    <div class="menuItem-a">
                        <div class="menuItem-img">
                            <img style="height: 120% ;margin-top: -12%" src="../images/myUi/suit2.png" alt="试衣间">
                        </div>
                        <span class="menuItem-text">试衣间&emsp; </span>
                    </div>
                </a>
            </div>
            <div class="menuItem" id="logout" style="cursor: pointer">
                <div class="menuItem-img">
                    <img style="height: 90%" src="../images/myUi/exit.png" alt="试衣间">
                </div>
                <span class="menuItem-text"> 退出账号</span>
            </div>
        </div>
    </div>

    <div>
        <iframe name="workspace" id="workspace" src="<%=basePath%>/jsp/self.jsp" frameborder="0"
                scrolling="no"></iframe>
    </div>


</div>
</body>
</html>

<script>
    $(document).ready(function() {
        var curUser = JSON.parse(localStorage.getItem("curUser"));
        if(!curUser.isAdmin){
            $('#menu .menuItem').eq(1).hide();
            $('#menu .menuItem').eq(2).hide();
            $('#menu .menuItem').eq(3).hide();
        }
        $('#menu .menuItem a').click(function() {
            $('#menu .menuItem').removeClass('menuItemActivate');
            $(this).parent().addClass('menuItemActivate');
        });
        // 从 Local Storage 中取出用户信息并赋值给 LoginUser 元素
        var userInfo = JSON.parse(localStorage.getItem("curUser"));
        if (userInfo) {
            $('#LoginUser').text(userInfo.nickname);
        }
        $('#menu .menuItem a').first().trigger('click');
    });

    $('#logout').click(function () {
        customConfirm("确定要退出吗？",confirmLogout);
    });

    function logoutSuccess(result) {
        console.log(result)
        if (result.code==0){
            customSuccess("退出成功");
            setTimeout(function () {
                window.location.href = "login.jsp";
            },2000);
        }else {
            customAlert(result.description);
        }
    }

    function confirmLogout () {
        request("POST","<%=basePath%>/user/logout",{},logoutSuccess,serverError,true);
        localStorage.removeItem("curUser");
    }

    // 监听来自子页面的消息
    window.addEventListener('message', function (event) {
        if (event.origin !== 'null' && event.data && event.data.action === 'refreshUserInfo') {
            let curUser = JSON.parse(localStorage.getItem("curUser"));
            $('#LoginUser').text(curUser.nickname);
        }
    });
</script>