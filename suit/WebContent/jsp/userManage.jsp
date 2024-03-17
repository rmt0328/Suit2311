<%--
  Created by IntelliJ IDEA.
  User: Leaves_XY
  Date: 2023/11/24
  Time: 18:06
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
    <script type="text/javascript" src="../js/main.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
</head>
<body>
<div id="userMangeContainer">

    <div id="userMangeTable">
        <table class="table" id="userTable">

        </table>
    </div>

    <div id="paginationContainer">
        <div id="pagination"></div>
    </div>

    <div id="editModal">
        <div id="infoDiv">

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
                <div class="form-control">
<%--            两个单选框 是否为管理员        --%>
                 <span style="color: white ;font-size: 14px"> 是否为管理员</span>
                    <input type="radio" name="isAdmin" value="1" id="isAdmin1"  />是
                    <input type="radio" name="isAdmin" value="0" id="isAdmin0" />否
                </div>
                <div id="selfBnts">
                    <button id="savebtn" type="button">保存信息</button>
                    <button id="cancelbtn" type="button">关闭窗口</button>
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

</div>
</body>
</html>

<script>
    var userList = [];
    var currentPage = 1;
    var rowsPerPage = 10;
    var currentUser={};
    var currentModel = "";

    $(document).ready(function () {
        request("POST", "<%=basePath%>/user/userList", {}, getUserListSuccess, serverError, true);
    });

    function getUserListSuccess(result) {
        if (result.code==0){
            userList = result.data;
            console.log(userList);
            renderTable();
            renderPagination();
        }else if(result.code==-20){

            customAlert(result.description);
            //一秒后跳转到登录页面
            setTimeout(function () {
                window.top.location.href = "index.jsp";
            },1000);
         }else{
            customAlert(result.description);}
    }


    function renderTable() {
        var tableBody = $('#userTable');

        tableBody.empty()

        //加上表头
        tableBody.append('<tr><th>id</th><th>用户名称</th><th>用户实名</th><th>性别</th><th>模型选择</th><th>是否管理员</th><th>操作</th></tr>');

        var startIndex = (currentPage - 1) * rowsPerPage;
        var endIndex = startIndex + rowsPerPage;
        var displayedUsers = userList.slice(startIndex, endIndex);

        displayedUsers.forEach(function (user) {
            var row = $('<tr>');
            row.append('<td>' + user.id + '</td>');
            row.append('<td>' + user.username + '</td>');
            row.append('<td>' + user.nickname + '</td>');
            row.append('<td>' + (user.sex === 1 ? '男' : '女') + '</td>');
            row.append('<td><img class="headImage" alt="数据丢失" src="' + '<%=basePath%>/images/data/model/' + user.model + '.png" style="height: 27px;width: 30px"></td>');
            row.append('<td>' + (user.admin ? '是' : '否') + '</td>');
            row.append('<td><button class="btnEdit">修改</button>  <button class="btnDel">删除</button></td>');

            tableBody.append(row);
        });

        $('.btnEdit').on('click', function () {
            var userId = $(this).closest('tr').find('td:first').text(); // 获取当前行的用户ID
            showEditModal(userId);
        });

        $(".btnDel").on('click', function () {
            var userId = $(this).closest('tr').find('td:first').text(); // 获取当前行的用户ID
            customConfirm("你确定要删除该用户吗", function () {
                console.log("删除删除删除:"+userId)
                request("POST", "<%=basePath%>/user/delete", {id: userId}, deleteSuccess, serverError, true);
            });
        });
    }

    function renderPagination() {
        var totalPages = Math.ceil(userList.length / rowsPerPage);
        var paginationContainer = $('#pagination');

        paginationContainer.empty();

        if (totalPages >= 1) {
            // Display previous button
            if (currentPage > 1) {
                paginationContainer.append('<button class="pageBtn" onclick="changePage(' + (currentPage - 1) + ')">上一页</button>');
            }

            for (var i = 1; i <= totalPages; i++) {
                paginationContainer.append('<button class="pageBtn" onclick="changePage(' + i + ')">' + i + '</button>');
            }

            if (currentPage < totalPages) {
                paginationContainer.append('<button class="pageBtn" onclick="changePage(' + (currentPage + 1) + ')">下一页</button>');
            }

            var tableOffset = $('#userTable').offset();
            var tableHeight = $('#userTable').height();

            $('#paginationContainer').css('top', tableOffset.top + tableHeight + 'px');

            //遍历所有按钮
            $('.pageBtn').each(function () {
                //如果是当前页，设置样式
                if ($(this).text() == currentPage) {
                    $(this).css('background-color', '#a99824');
                }
            });


        }
    }

    function changePage(page) {
        currentPage = page;
        renderTable();
        renderPagination();
    }

    // 显示用户信息窗口并填充用户信息
    function showEditModal(userId) {
        $('#editModal').show();
        // 根据 userId 获取用户信息，可以通过请求后端接口获取
        currentUser = getUserById(userId);

        console.log(currentUser)

        // 填充用户信息到编辑窗口
        $('#username').val(currentUser.username);
        $('#nickname').val(currentUser.nickname);
        $('#sex').val(currentUser.sex === 1 ? 'male' : 'female');
        $('#model').val(currentUser.model);
        if (currentUser.admin) {
            $("#isAdmin1").prop("checked", true);
        } else {
            $("#isAdmin0").prop("checked", true);
        }
        $("#selectModel").text("已选择模型");


        if (currentUser.model) {
            // 移除所有模型图片的内阴影样式
            $(".modelImg img").css("box-shadow", "none");

            // 根据 self.model 的值，给相应的图片套上内阴影样式
            $("#" + currentUser.model).css("box-shadow", "inset 0 0 10px rgba(0, 0, 0, 0.5)");
            currentModel = currentUser.model;
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
            if (currentModel) $("#selectModel").text("已选择模型");
        });

        // 当模型图片被点击时
        $(".modelImg img").click(function () {
            // 移除所有模型图片的内阴影样式
            $(".modelImg img").css("box-shadow", "none");

            // 给被点击的图片套上内阴影样式
            $(this).css("box-shadow", "inset 0 0 10px rgba(0, 0, 0, 0.5)");

            // 记录选中的图片变量
            currentModel=$(this).attr("id");
            console.log(currentModel)
        });

        $("#sex").change(function () {
            $("#selectModel").text("选择模型");
            currentUser.model="";
        });

        // 显示编辑窗口
        $('#editModal').show();
    }

    $('#savebtn').on('click', function () {
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

        if (currentModel=="") {
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
            id: currentUser.id,
            username:currentUser.username,
            nickname: $("#nickname").val(),
            password: $("#password").val(),
            passwordAgain: $("#passwordAgain").val(),
            model: currentModel,
        }
        //女0男1
        if($("#sex").val()=='female')user.sex=0;
        else user.sex=1

        if ($("#isAdmin1").prop("checked")) {
            console.log("admin")
            user.admin = 1;
        } else {
            user.admin = 0;
        }
        console.log(user)
        request("POST", "<%=basePath%>/user/updateCurUser",user, saveSuccess, serverError, true);

        $('#editModal').hide();
    });



    $('#cancelbtn').on('click', function () {

        $('#editModal').hide();
    });

    function getUserById(userId) {

        var user = userList.find(function (user) {
            console.log(user.id)
            return user.id == userId;
        });
        return user;
    }

    function saveSuccess(result) {
        if(result.code==0){
            customSuccess("保存成功");
            //刷新页面
            setTimeout(function () {
            	 window.location.reload();
                }, 1000);
           
        }else{
            customAlert(result.description);
        }

    }

    function deleteSuccess(result) {
        if(result.code==0){
            customSuccess("删除成功");
            //刷新页面
            setTimeout(function () {
            	 window.location.reload();
                }, 1000);

        }else{
            customAlert(result.description);
        }

    }



</script>
