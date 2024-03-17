<%--
  Created by IntelliJ IDEA.
  User: Leaves_XY
  Date: 2023/11/24
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String path=request.getContextPath(); String basePath=request.getScheme() + "://" + request.getServerName() + ":"
        + request.getServerPort() + path; %>
<html>
<head>
    <title>梦想试衣间</title>
    <script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
</head>
<body>
<div id="selfContainer">
    <div id="selfDiv">

        <h3>用户信息</h3>

        <form action="#" method="post">
            <div class="form-control">
                <input type="text" id="username" name="username" class="inputText" required placeholder="用户名" disabled/>
            </div>
            <div class="form-control">
                <input type="text" id="nickname" name="nickname" class="inputText" required placeholder="真实姓名"/>
            </div>
            <div class="form-control">
                <input type="password" id="password" name="password" class="inputText"/>
                <p>密码:密码如果不需要修改本项留空</p>
            </div>
            <div class="form-control">
                <input type="password" id="passwordAgain" name="passwordAgain" class="inputText" />
                <p>确认密码:密码如果不需要修改本项留空</p>
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
            <div id="selfBnts">
                <button id="savebtn" type="button">保存信息</button>
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
    var self={
        id:"",
        username:"",
        nickname:"",
        password:"",
        passwordAgain:"",
        sex:"",
        model:"",
        isAdmin:""
    }
	
    $(document).ready(function () {

        self=JSON.parse(localStorage.getItem("curUser"));
        $("#id").val(self.id);
        $("#username").val(self.username);
        $("#nickname").val(self.nickname);
        $("#password").val("");
        $("#passwordAgain").val("");

        $("#model").val(self.model);

        $("#selectModel").text("已选择模型");

        if(self.sex=='1')$("#sex").val('male');
        else $("#sex").val('female');

        let curModel=self.model;

        // 根据 self.model 的值为特定模型图片添加阴影样式
        if (self.model) {
            // 移除所有模型图片的内阴影样式
            $(".modelImg img").css("box-shadow", "none");

            // 根据 self.model 的值，给相应的图片套上内阴影样式
            $("#" + self.model).css("box-shadow", "inset 0 0 10px rgba(0, 0, 0, 0.5)");
        }


        // When the "选择模型" button is clicked
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

        // When the "关闭" button inside the modal is clicked
        $(".closeModal").click(function () {
            // 隐藏男性模型选择弹窗
            $("#maleModelModal").hide();
            $("#femaleModelModal").hide();
            // 修改按钮文字为"已选择模型"
            if (curModel) $("#selectModel").text("已选择模型");
        });

        // 当模型图片被点击时
        $(".modelImg img").click(function () {
            // 移除所有模型图片的内阴影样式
            $(".modelImg img").css("box-shadow", "none");

            // 给被点击的图片套上内阴影样式
            $(this).css("box-shadow", "inset 0 0 10px rgba(0, 0, 0, 0.5)");

            // 记录选中的图片变量
            curModel=$(this).attr("id");
        });

        $("#sex").change(function () {
            $("#selectModel").text("选择模型");
            self.model="";
        });


        $("#savebtn").click(function () {

            if ($("#username").val() == "") {
                customAlert("用户名不能为空");
                return;
            }
            if ($("#nickname").val() == "") {
                customAlert("昵称不能为空");
                return;
            }

            if($("#sex").val()==null){
                customAlert("请选择性别");
                return;
            }

            if (curModel=="") {
                customAlert("请选择模型");
                return;
            }



            if ($("#password").val() != $("#passwordAgain").val()) {
                    customAlert("两次密码不一致");
                    return;
            }

            //密码六位到十六位，字母数字组合,必须包含字母和数字
            let reg=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
            if ($("#password").val()!=''&&!reg.test($("#password").val())){
                customAlert("密码必须为6-16位字母数字组合");
                return;
            }


            var user = {
                id: self.id,
                username:self.username,
                nickname: $("#nickname").val(),
                password: $("#password").val(),
                passwordAgain: $("#passwordAgain").val(),
                model: curModel,
                isAdmin: self.isAdmin
            }
            //女0男1
            if($("#sex").val()=='female')user.sex=0
            else user.sex=1
            console.log(user)
            request("POST", "<%=basePath%>/user/updateCurUser",user, saveSuccess, serverError, true);
        });


        function saveSuccess(result) {
            if (result.code == 0) {
                customSuccess("修改成功");
                localStorage.setItem("curUser", JSON.stringify(result.data));
                //刷新父页面
                window.parent.postMessage({ action: 'refreshUserInfo' }, '*');
                setTimeout(function () {
                    //刷新页面
                    window.location.reload();
                }, 1000);
            } else {
                customAlert(result.description);
            }
        }
    });

</script>