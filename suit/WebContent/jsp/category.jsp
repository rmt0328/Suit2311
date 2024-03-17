<%--
  Created by IntelliJ IDEA.
  User: Leaves_XY
  Date: 2023/11/24
  Time: 18:11
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
<div id="clothesTemplate" style="display: none;">
    <div class="categoryDiv">
        <h4>服饰类别</h4>
        <form action="#" method="post">
            <div class="form-control"><input type="text" name="categoryOn" class="inputText" required placeholder="编号"/></div>
            <div class="form-control"><input type="text" name="categoryAlias" class="inputText" required placeholder="名称" value=""/></div>
            <div class="categoryBnts">
                <button type="button" class="btnEdit">修改</button>
                <button type="button" class="btnDel">删除</button>
            </div>
        </form>
    </div>
</div>



<div id="categoryContainer">
    <div id="categoryDivContainer">


    </div>
  <div id="paginationContainer">
    <div id="pagination"></div>
  </div>



</div>




</body>
</html>

<script>
    var currentPage = 1;
    var itemsPerPage = 9;

    var categoryList = [];

    $(document).ready(function () {
        request("POST", "<%=basePath%>/category/categoryList", {}, getCategoryListSuccess, serverError, true);
    });

    function renderCategories() {
        $('#categoryDivContainer').empty();

        if ($(window).width() >= 1620)itemsPerPage=11;
        else if ($(window).width() <= 1060) itemsPerPage=8;
        else itemsPerPage=9;

        // 计算当前页的起始索引和结束索引
        var startIndex = (currentPage - 1) * itemsPerPage;
        var endIndex = startIndex + itemsPerPage;
        var displayedCategories = categoryList.slice(startIndex, endIndex);

        // 使用模板克隆新的服饰信息小窗口
        var template = $('#clothesTemplate').html();

        // 添加一个用于添加的容器
        var addCategoryDiv = $(template).clone();
        addCategoryDiv.find('h4').text('添加新类别');
        addCategoryDiv.find('.btnEdit').text('添加');
        addCategoryDiv.find('.btnEdit').removeClass('btnEdit').addClass('btnAdd1');
        addCategoryDiv.find('.btnDel').remove();
        $('#categoryDivContainer').append(addCategoryDiv);

        // 遍历当前页的类别
        for (var i = 0; i < displayedCategories.length; i++) {
            var category = displayedCategories[i];

            // 使用模板克隆新的服饰信息小窗口
            var categoryDiv = $(template).clone();

            // 设置服饰信息的具体内容
            categoryDiv.find('input[name="categoryOn"]').val(category.categoryNo);
            categoryDiv.find('input[name="categoryAlias"]').val(category.categoryAlias);
            categoryDiv.find('.btnEdit').attr('data-id', category.id);
            categoryDiv.find('.btnDel').attr('data-id', category.id);

            // 添加到容器中
            $('#categoryDivContainer').append(categoryDiv);
        }
        // 添加按钮事件
        $('.btnAdd1').click(function () {
            console.log("添加")
            var categoryNo = $(this).parent().parent().find('input[name="categoryOn"]').val();
            var categoryAlias = $(this).parent().parent().find('input[name="categoryAlias"]').val();
            //判断是否都输入了
            if (categoryNo == "" || categoryAlias == "") {
                customAlert("请输入完整信息");
                return;
            }
            var category = {
                categoryNo: categoryNo,
                categoryAlias: categoryAlias
            };
            console.log(category);
            request("POST", "<%=basePath%>/category/addCategory", category, addCategorySuccess, serverError, true);
        });
        // 修改按钮事件
        $('.btnEdit').click(function () {
            var id = $(this).data('id');
            var categoryNo = $(this).parent().parent().find('input[name="categoryOn"]').val();
            var categoryAlias = $(this).parent().parent().find('input[name="categoryAlias"]').val();
            //判断是否都输入了
            if (categoryNo == "" || categoryAlias == "") {
                customAlert("请输入完整信息");
                return;
            }
            var category = {
                id: id,
                categoryNo: categoryNo,
                categoryAlias: categoryAlias
            };
            console.log(category);
            request("POST", "<%=basePath%>/category/updateCategory", category, updateCategorySuccess, serverError, true);
        });

        // 删除按钮事件
        $('.btnDel').click(function () {

            var id = $(this).data('id');

            customConfirm("你确定要删除这个分类吗",function (){
                var category = {
                    id: id
                };
                console.log(category);
                request("POST", "<%=basePath%>/category/deleteCategory", category, deleteCategorySuccess, serverError, true);
            })
        });

        // 渲染分页按钮
        renderPagination();
    }

    function renderPagination() {

      var totalPages = Math.ceil(categoryList.length / itemsPerPage);
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
                    renderCategories();
                }
            });

            $('#nextPageBtn').click(function () {
                var totalPages = Math.ceil(categoryList.length / itemsPerPage);
                if (currentPage < totalPages) {
                    currentPage++;
                    renderCategories();
                }
            });
            //遍历所有按钮
            $('.pageBtn').each(function () {
                if ($(this).text() == currentPage) {
                    $(this).css('background-color', '#a99824');
                }
            });


        }
    }

    $(window).on('resize', function () {
        // 调用渲染函数
        if ($(window).width() >= 1400)itemsPerPage=11;
        else if ($(window).width() <= 1060) itemsPerPage=8;
        else itemsPerPage=9;

        renderCategories();
    });

    function changePage(page) {
      currentPage = page;
      renderCategories();
      renderPagination();
    }


    function getCategoryListSuccess(result) {
        if(result.code==0){
            categoryList = result.data;
            renderCategories();
        }else if (result.code==-20){
            customAlert(result.description);
            setTimeout(function () {
                window.top.location.href = "index.jsp";
            }, 1000);
        }
        else{
                customAlert(result.description);
            }


    }

    function addCategorySuccess(result) {
        if(result.code==0){
            customSuccess("添加成功");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        }else{
            customAlert(result.description);
        }
    }

    function updateCategorySuccess(result) {
        if(result.code==0){
            customSuccess("修改成功");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        }else{
            customAlert(result.description);
        }
    }

    function deleteCategorySuccess(result) {
        if(result.code==0){
            customSuccess("删除成功");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        }else{
            customAlert(result.description);
        }
    }



</script>