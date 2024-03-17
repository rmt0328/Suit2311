<%--
  Created by IntelliJ IDEA.
  User: Leaves_XY
  Date: 2023/11/24
  Time: 21:50
  To change this template use File | Settings | File Templates.
--%>
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

</head>
<body>
<div id="loginContainer">
    <div id="loginDiv">
        <div id="loginBG"></div>
        <h3>梦想试衣间用户登录</h3>

        <form action="#" method="post">

            <div class="form-control">

                <input type="text" id="username" name="username" class="inputText" required placeholder="账号"/>
            </div>
            <div class="form-control">

                <input type="password" id="password" name="password" class="inputText"  required placeholder="密码"/>

            </div>
            <div id="loginBnts">
                <button type="button" class="loginbtn" >登录</button>
                <button type="button" class="registerbtn"  onclick="window.location.href='register.jsp'">注册</button>
            </div>
        </form>


    </div>
</div>

</body>
</html>

<script>
    var user={
        username:"",
        password:"",
    }

    $(document).ready(function () {
        $(".loginbtn").click(function () {
            user.username=$("#username").val();
            user.password=$("#password").val();

            if (!user.username||!user.password){
                customAlert("用户名或密码不能为空");
                return;
            }
            request("POST","<%=basePath%>/user/login",user,loginCallBack,serverError,true)
        });

        function loginCallBack(result) {
            if (result.code==0){
                customSuccess("登录成功");
                localStorage.setItem("curUser", JSON.stringify(result.data));
                console.log(localStorage.getItem("curUser"));
                setTimeout(function () {
                    window.location.href="index.jsp";
                },1000);
            }else {
                customAlert(result.description);
            }
        }
    });
</script>
