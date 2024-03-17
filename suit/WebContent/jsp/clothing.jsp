<%--
  Created by IntelliJ IDEA.
  User: Leaves_XY
  Date: 2023/11/24
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String path=request.getContextPath(); String basePath=request.getScheme() + "://" + request.getServerName() + ":"
        + request.getServerPort() + path; %>
<html>
<head>
    <title>梦想试衣间</title>
    <script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <script src="<%=basePath%>/js/jquery.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>/js/vendor/jquery.ui.widget.js"></script>
    <script src="<%=basePath%>/js/jquery.iframe-transport.js" type="text/javascript"></script>
    <script src="<%=basePath%>/js/jquery.fileupload.js" type="text/javascript"></script>
    <script src="<%=basePath%>/js/main.js" type="text/javascript"></script>
    <link href="<%=basePath%>/css/main.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>/css/jquery.fileupload.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>/css/jquery.fileupload-ui.css" rel="stylesheet" type="text/css">


</head>
<body>
<div id="search">
    <form action="#" method="post">
        <div class="form-sex">性别：
            <select id="sex" name="sex" required>
                <option value="" disabled selected>性别</option>
                <option value="male" selected>男</option>
                <option value="female">女</option>
            </select>
        </div>
        <div class="category">服饰类别：
            <select class="dropdown" name="dropdown" required>
                <option value="全部"  selected>全部</option>
            </select>
        </div>
        <button type="button" class="btn">查询</button>
    </form>
</div>



<!-- 定义服饰模板  -->
<div id="clothesTemplate" style="display: none;">
    <div class="clothesDiv">
        <h4>服饰细目</h4>
        <div class = "clothes-from">
            <form action="#" method="post">
                <div class="form-control">编号: <input type="text"  name="clothesNo" class="inputTextClothes"></div>
                <div class="form-control">名称: <input type="text" name="clothesAlias" class="inputTextClothes"></div>
                <div class="form-control">价格: <input type="text" name="price" class="inputTextClothes"></div>
                <div class="form-control">性别:
                    <select name="sex" class="sex" required>
                        <option value="male" >男</option>
                        <option value="female" >女</option>
                    </select>
                </div>
                <div class="form-control">分类:
                    <select class="dropdown" name="dropdown" required>
                        <option value="" disabled selected>类别</option>


                    </select>
                </div>


                <div class="clothesBnts">
                    <button type="button" class="btnEdit">修改</button>
                    <button type="button" class="btnDel">删除</button>
                </div>


            </form>
        </div>
        <div class="uploaderContainer">
            <form action="#" method="post" >

                <h6>上传图片</h6>
                <div class="fileUp file">
                	点击上传
                    <input id="file" type="file" name="file" multiple class="imgEnter">
                </div>
                <div  class="imgShowDiv" >
                     <img class="imgShow" src="" alt="没有上传图片">
                </div>

            </form>
        </div>
    </div>
</div>



<div id="clothesContainer">
    <div id="clothesDivContainer">

    </div>

    <div id="paginationContainer">
        <div id="pagination"></div>
    </div>

</div>


</body>
</html>
<script>
    let categoryList = []
    $(document).ready(function () {
        request("POST", "<%=basePath%>/category/categoryList", {}, getCategoryListSuccess, serverError, true);
    });
    console.log(categoryList.length)
    function getCategoryListSuccess(result) {
        if (result.code==0){
            categoryList = result.data;
            console.log('categoryList');
            console.log(categoryList);
            renderCategory()
        }else if(result.code==-20){

            customAlert(result.description);
            //一秒后跳转到登录页面
            setTimeout(function () {
                window.top.location.href = "index.jsp";
            },1000);
        }else{
            customAlert(result.description);}
    }
    let dropdown = document.querySelector('.dropdown')
    console.log(dropdown);
    function renderCategory() {
        for (let i = 0; i < categoryList.length; i++) {
            var option = document.createElement('option');
            option.value = categoryList[i].categoryAlias;
            option.textContent = categoryList[i].categoryAlias;
            dropdown.appendChild(option);
        }

    }

    var currentPage=1;
    var itemsPerPage=5;

    // 所有分类名称列表
    var categoryNoList=[];

    // 所有服饰列表
    var clothesList=[];

    $(document).ready(function (){
        request("POST","<%=basePath%>/clothes/getAll",{},getClothesListSuccess,serverError,true);

    });
    //判断是否为数字
    function isNumber(str) {
        // 使用 parseFloat 将字符串转换为数值
        var num = parseFloat(str);

        // 使用 isNaN 判断数值是否为 NaN
        // 如果不是 NaN，且转换后的数值与原始字符串相等，则为数字
        if (!isNaN(num) && num.toString() === str) {
            return true;
        } else {
            return false;
        }
    }

    function renderClothes(){
        //清空容器中的对象
        $('#clothesDivContainer').empty();

        //获取当前页的起始索引和结束索引
        var startIndex=(currentPage-1)*itemsPerPage;
        var endIndex=startIndex+itemsPerPage;
        var displayedClothes=clothesList.slice(startIndex,endIndex);

        //使用模板克隆新的服饰小窗口
        //获取模板代码
        var template =$('#clothesTemplate').html();

        //添加一个用于添加的容器
        var addClothesDiv=$(template).clone();
        console.log('---------------')
        console.log(addClothesDiv)
        addClothesDiv.find('.btnEdit').text('添加');
        addClothesDiv.find('.btnEdit').removeClass('btnEdit').addClass('btnAdd');
        addClothesDiv.find('.btnDel').remove();
        addClothesDiv.find('.uploaderContainer').remove();
        let add = addClothesDiv.find('.dropdown')

        for(let i = 0;i<categoryList.length;i++){
            var option = document.createElement('option');
            option.value = categoryList[i].categoryAlias;
            option.textContent = categoryList[i].categoryAlias;
            add.append(option);
        }
        $('#clothesDivContainer').append(addClothesDiv);


        //遍历当前页的类别
        for(var i=0;i < displayedClothes.length;i++){
            var clothes = displayedClothes[i];

            //使用模板克隆新的衣服细目小窗口
            var clothesDiv = $(template).clone();

            //设置服饰信息的具体内容
            clothesDiv.find('input[name="clothesNo"]').val(clothes.clothesNo);
            clothesDiv.find('input[name="clothesAlias"]').val(clothes.clothesAlias);
            clothesDiv.find('input[name="price"]').val(clothes.price);
            
            clothesDiv.find('.imgShow').attr("src", '../images/clothesImg/'+clothes.img);
            if(clothes.img=='') {
            	  // 图片加载失败
            	clothesDiv.find('.imgShow').attr("src", '../images/clothesImg/add.png');
            	};
            clothesDiv.find('.btnEdit').attr('data-id', clothes.id);
            clothesDiv.find('.btnDel').attr('data-id', clothes.id);


            //clothesDiv.find('select[name="sex"]').val(clothes.sex);
            if(clothes.sex=='1') clothesDiv.find('select[name="sex"]').val('male');
            else clothesDiv.find('select[name="sex"]').val('female');
            let clothesadd = clothesDiv.find('.dropdown')
            for(let i = 0;i<categoryList.length;i++){
                var option = document.createElement('option');
                option.value = categoryList[i].categoryAlias;
                option.textContent = categoryList[i].categoryAlias;
                if (clothes.categoryId == categoryList[i].id) {
                    // 如果成立，将该选项设置为默认选项
                    option.selected = true;
                }
                clothesadd.append(option);
            }
            var url = "<%=basePath%>/upload/uploadImage?code="+clothes.clothesNo;

            $(clothesDiv).find('.imgEnter').attr("data-url",url);
            //添加到容器中
            $('#clothesDivContainer').append(clothesDiv);

        }
        //添加按钮时间
        $('.btnAdd').click(function(){
            console.log("添加")
            var clothesNo = $(this).parent().parent().find('input[name="clothesNo"]').val();
            console.log(clothesNo)
            var clothesAlias = $(this).parent().parent().find('input[name="clothesAlias"]').val();
            console.log(clothesAlias)
            var price = $(this).parent().parent().find('input[name="price"]').val();
            if(!isNumber(price)){
                customAlert("价格要为数字");
                return;
            }

            if($(this).parent().parent().find('select[name="sex"]').val()=='female') var sex=0
            else var sex=1
            //var sex= $(this).parent().parent().find('select[name="sex"]').val();
            console.log(sex)


            var category = $(this).parent().parent().find('select[name="dropdown"]').val();
            console.log(category)
            if(category==null){
                customAlert("请选择分类");
                return;
            }
            var categoryId;
            for(let i = 0;i<categoryList.length;i++){

                if(categoryList[i].categoryAlias==category){
                    categoryId=categoryList[i].id;
                }
            }
            console.log(categoryId)
            //判断是否都输出了
            if(clothesNo == ""||clothesAlias== ""||price == ""||sex === ""){

                customAlert("请输入完整信息");
                return ;
            }

            var clothes = {
                clothesNo: clothesNo,
                clothesAlias: clothesAlias,
                price: price,
                sex: sex,
                img:"",
                categoryId:categoryId
            };
            console.log('clothes');
            console.log(clothes);
            request("POST","<%=basePath%>/clothes/addClothes",clothes,addClothesSuccess,serverError,true);

        });

        //修改按钮事件
        $('.btnEdit').click(function(){
            var id = $(this).data('id');
            console.log('id')
            console.log(id)
            var clothesNo = $(this).parent().parent().find('input[name="clothesNo"]').val();
            var clothesAlias = $(this).parent().parent().find('input[name="clothesAlias"]').val();
            var price = $(this).parent().parent().find('input[name="price"]').val();
            if(!isNumber(price)){
                customAlert("价格要为数字");
                return;
            }
            if($(this).parent().parent().find('select[name="sex"]').val()=='female') var sex=0
            else var sex=1


            var category = $(this).parent().parent().find('select[name="dropdown"]').val();
            var categoryId;

            for(let i = 0;i<categoryList.length;i++){

                if(categoryList[i].categoryAlias==category){
                    categoryId=categoryList[i].id;
                }
            }



            console.log(sex)
            //判断是否都输出了
            if(clothesNo==""||clothesAlias==""||price==""||sex===""){
                customAlert("请输入完整信息");
                return ;
            }

            var clothes = {
                id: id,
                clothesNo: clothesNo,
                clothesAlias: clothesAlias,
                price: price,
                sex: sex,
                img: "",
                categoryId: categoryId

            };
            console.log(clothes);
            request("POST","<%=basePath%>/clothes/updateClothes",clothes,updateClothesSuccess,serverError,true);
        });


        //删除事件
        $('.btnDel').click(function(){
            var id =$(this).data('id');

            customConfirm("你确定要删除这个服饰吗",function(){
                var clothes = {
                    id: id
                };
                console.log(clothes);
                request("POST","<%=basePath%>/clothes/deleteClothes",clothes,deleteClothesSuccess,serverError,true);

            })

        });
        /* ---------------上传文件------------------- */
        $('.imgEnter').fileupload({
            autoUpload: true, // 是否自动上传
            dataType: 'json', // 设置响应的数据类型
            done: function (e, data) {
                var imageName = data.result.description;
                $(this).parent().parent().find('.imgShow').attr('src', '../images/clothesImg/'+imageName); 
                if(imageName=='') {
              	  // 图片加载失败
              	$(this).parent().parent().find('.imgShow').attr("src", '../images/clothesImg/add.png');
              	};
                //$('.imgShow').attr('src', '../images/clothesImg/'+imageName); 
                if (data.result.code==0){
                    customSuccess("上传成功！");
                }else{
                    customAlert("上传失败！"+data.result.description);
                }
            },
            fail: function (e, data) {
                customAlert("上传失败！"+data.result.description);
            },
            progressall: function (e, data) {
                console.log("上传中")
                console.log(e)
                console.log(data)
            }
        });
        /* ---------------------------------- */


        renderPagination();

    }

    function renderPagination() {

        var totalPages = Math.ceil(clothesList.length / itemsPerPage);
        var paginationContainer = $('#pagination');
        paginationContainer.empty();
        // 渲染分页按钮
        if (totalPages >= 1) {
            if (currentPage > 1) {
                paginationContainer.append('<button class="pageBtn" onclick="changePage(' + (currentPage - 1) + ')">上一页</button>');
            }

            for (var i = 1; i <= totalPages; i++) {
                paginationContainer.append('<button class="pageBtn" onclick="changePage(' + i + ')">' + i + '</button>');
            }

            if (currentPage < totalPages) {
                paginationContainer.append('<button class="pageBtn" onclick="changePage(' + (currentPage + 1) + ')">下一页</button>');
            }

            // 添加分页按钮事件处理
            $('#prevPageBtn').click(function () {
                if (currentPage > 1) {
                    currentPage--;
                    renderClothes();
                }
            });

            $('#nextPageBtn').click(function () {
                var totalPages = Math.ceil(clothesList.length / itemsPerPage);
                if (currentPage < totalPages) {
                    currentPage++;
                    renderClothes();
                }
            });
            //遍历所有按钮
            $('.pageBtn').each(function () {
                if ($(this).text() == currentPage) {
                    $(this).css('background-color', '#a99824');
                }
            });
            $(window).on('resize', function () {
                // 调用渲染函数
                if ($(window).width() >= 1400)itemsPerPage=5;
                else if ($(window).width() <= 1060) itemsPerPage=4;
                else itemsPerPage=3;

                renderClothes();
            });


        }
    }

    function changePage(page) {
        currentPage = page;
        renderClothes();
        renderPagination();
    }


    function getClothesListSuccess(result) {
        if(result.code==0){
            clothesList = result.data;
            renderClothes();
        }else{
            customAlert(result.description);
        }

    }

    function addClothesSuccess(result) {
        if(result.code==0){
            customSuccess("添加成功");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        }else{
            customAlert(result.description);
        }
    }

    function updateClothesSuccess(result) {
        if(result.code==0){
            customSuccess("修改成功");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        }else{
            customAlert(result.description);
        }
    }

    function deleteClothesSuccess(result) {
        if(result.code==0){
            customSuccess("删除成功");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        }else{
            customAlert(result.description);
        }
    }
    //查询
    $('.btn').click(function(){
        console.log("查询")



        if($(this).parent().parent().find('select[name="sex"]').val()=='female') var sex=0
        else var sex=1
        //var sex= $(this).parent().parent().find('select[name="sex"]').val();
        console.log(sex)


        var category = $(this).parent().parent().find('select[name="dropdown"]').val();
        console.log('category')
        console.log(category+"------------")
        var categoryId;
        if(category=='全部'){
            request("POST","<%=basePath%>/clothes/getAll",{},getClothesListSuccess,serverError,true);
            return;

        }else{
            for(let i = 0;i<categoryList.length;i++){

                if(categoryList[i].categoryAlias==category){
                    categoryId=categoryList[i].id;
                }
            }
        }

        console.log(categoryId)
        //判断是否都输出了
        if(categoryId == ""||sex === ""){

            customAlert("请输入完整信息");
            return ;
        }

        var clothes = {
            sex: sex,
            categoryId:categoryId
        };
        console.log('clothes');
        console.log(clothes);
        request("POST","<%=basePath%>/clothes/findClothesBySAC",clothes,searchClothesSuccess,serverError,true);

    });
    function searchClothesSuccess(result) {
        if(result.code==0){
            customSuccess("查询成功");
            console.log('clothes');
            console.log(result);
            clothesList = result.data;
            renderClothes()
        }else{
            customAlert(result.description);
        }
    }

</script>
