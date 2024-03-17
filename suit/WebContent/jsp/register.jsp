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
<div id="registerContainer">
    <div id="registerDiv">

        <h3>梦想试衣间用户注册</h3>

        <form action="#" method="post">
            <div class="form-control">
                <input type="text" id="username" name="username" class="inputText" required placeholder="用户名"/>
            </div>
            <div class="form-control">
                <input type="text" id="nickname" name="nickname" class="inputText" required placeholder="真实姓名"/>
            </div>
            <div class="form-control">
                <input type="password" id="password" name="password" class="inputText" required placeholder="密码:6-16位字母数字组合"/>
            </div>
            <div class="form-control">
                <input type="password" id="passwordAgain" name="passwordAgain" class="inputText" required
                       placeholder="确认密码"/>
            </div>
            <div class="form-control">
                <select id="sex" name="sex" required>
                    <option value="" disabled selected>选择性别</option>
                    <option value="male">男</option>
                    <option value="female">女</option>
                </select>
            </div>
            <div class="form-control">
                <button id="selectModel" type="button">选择模型</button>
            </div>
            <div id="registerBnts">
                <button class="registerbtn" type="button">点击注册</button>
                <button class="backLoginbtn" type="button" onclick="window.location.href='login.jsp'">返回登陆</button>
            </div>
        </form>


    </div>

    <div id="maleModelModal">
        <h3>选择模型</h3>
        <div class="modelImg" >
            <img id="mheadA"  src="<%=basePath%>/images/data/model/mheadA.png" width="65px" height="120px" style="padding: 5px" />
            <img id="mheadB"  src="<%=basePath%>/images/data/model/mheadB.png" width="65px" height="120px"  style="padding: 5px;margin-left: 20px" />
        </div>
        <button class="closeModal">确认</button>
    </div>

    <div id="femaleModelModal">
        <h3>选择模型</h3>
        <div class="modelImg" >
            <img id="wheadA"  src="<%=basePath%>/images/data/model/wheadA.png" width="65px" height="120px" style="padding: 5px" />
            <img id="wheadB"  src="<%=basePath%>/images/data/model/wheadB.png" width="65px" height="120px"  style="padding: 5px;margin-left: 20px" />
        </div>
        <button class="closeModal">确认</button>
    </div>
</div>

</body>
</html>

<script>
    var user={
        username:"",
        nickname:"",
        password:"",
        passwordAgain:"",
        sex:"",
        model:"",
    }

    $(document).ready(function () {
        $("#selectModel").click(function () {
            let sex=$("#sex").val();

            if (sex!="male"&&sex!="female"){
                customAlert("请选择性别");
                return;
            }
            // Show the modal
            if (sex=="male") $("#maleModelModal").show();
            else $("#femaleModelModal").show();
        });

        $(".closeModal").click(function () {
            // 隐藏男性模型选择弹窗
            $("#maleModelModal").hide();
            $("#femaleModelModal").hide();
            // 修改按钮文字为"已选择模型"
            if (user.model) $("#selectModel").text("已选择模型");
        });

        // 当模型图片被点击时
        $(".modelImg img").click(function () {
            // 移除所有模型图片的内阴影样式
            $(".modelImg img").css("box-shadow", "none");

            // 给被点击的图片套上内阴影样式
            $(this).css("box-shadow", "inset 0 0 10px rgba(0, 0, 0, 0.5)");

            // 记录选中的图片变量
            user.model=$(this).attr("id");
        });

        $("#sex").change(function () {
            $("#selectModel").text("选择模型");
            user.model="";
        });

        $(".registerbtn").click(function () {
            user.username=$("#username").val();
            user.nickname=$("#nickname").val();
            user.password=$("#password").val();
            user.passwordAgain=$("#passwordAgain").val();
            //女0男1
            if($("#sex").val()=="male")user.sex="1"
            else user.sex="0";

            if(!user.username){
                customAlert("用户名不能为空");
                return;
            }

            if(!user.nickname){
                customAlert("真实姓名不能为空");
                return;
            }

            if(!user.password){
                customAlert("密码不能为空");
                return;
            }

            if(!user.passwordAgain){
                customAlert("确认密码不能为空");
                return;
            }

            if(!user.sex){
                customAlert("性别不能为空");
                return;
            }

            if(!user.model){
                customAlert("模型不能为空");
                return;
            }

            if (user.password!==user.passwordAgain){
                customAlert("两次密码不一致");
                return;
            }

            //密码六位到十六位，字母数字组合,必须包含字母和数字
            let reg=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
            if (!reg.test(user.password)){
                customAlert("密码必须为6-16位字母数字组合");
                return;
            }

            request("POST","<%=basePath%>/user/register",user,registerCallBack,serverError,true)

        });

        function registerCallBack(result) {
            if (result.code==0){
                customSuccess("注册成功");
                setTimeout(function () {
                    window.location.href="login.jsp";
                },1000);
            }else {
                customAlert(result.description);
            }
        }
    });
</script>
