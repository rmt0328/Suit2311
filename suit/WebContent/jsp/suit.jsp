<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <% String path=request.getContextPath(); String basePath=request.getScheme() + "://" + request.getServerName() + ":" +
    request.getServerPort() + path; %>
    <html>

    <head>
          <title>梦想试衣间</title>
    <script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/main.css">


     
    </head>

    <body>


      <div id="clothesTemplate" style="display: none;">

           <!-- <img id="addImg" src="../images/ui/add.png" alt="添加图片"> -->
           <button type="button" class="image-button"></button>
           <div style="height:200px;width:100px;margin:auto;">
              <img id="imgShow" src="" alt="衣服图片">
				</div>

              <div class="form-control">编号:  <span id="clothesNo"></span></div>
              <div class="form-control">名称:  <span id="clothesAlias"></span></div>
              <div class="form-control">单价:  <span id="price"></span></div>

      </div>
      <div id="dressedTemplate" style="display: none;">
            <div class="clothesNo">编号: <span id="clothesNo"></span></div>
            <div class="clothesAlias">名称: <span id="clothesAlias"></span></div>
            <div class="price">单价: <span id="price"></span></div>
            <img id="zIndex" src="../images/ui/zIndex.png" alt="图层">
            <div class="priority"><span id="priority"></span></div>
            
<!--             <img id="up" src="../images/ui/up.png" alt="上">
 --><!--             <img id="down" src="../images/ui/down.png" alt="下"> -->  
          <!-- <img id="remove" src="../images/ui/remove.png" alt="垃圾桶"> -->
            <button type="button" class="zindexUp"></button>
            <button type="button" class="zindexDown"></button>
            <button type="button" class="clothesDel"></button>


       </div>
       
       
      <div class="container">
        <div id="dressedClothes">
          <div id="dressedDivContainer">
          
          
          </div>
       
        </div>

        <div id="clothesExhibition">
          <div class="image">
            <img id="ground" src="../images/ui/ground.png" alt="地毯">
            <img id="shadow" src="../images/data/model/modelShadow.png" alt="影子">
            <img id="modelImg" src="" alt="模特图片">


            <div id="clothesImgDiv">
            
            </div>
          </div>

          <div class="account">
            <h4>总价</h4>
            <div id="amount"><span id="money"></span></div>


          </div>
        </div>

        <div id="clothesChoose">
          <div class="search">选择分类:
            <select class="dropdown" name="dropdown" required>
              <option value="全部"  selected>请选择</option>

            </select>
          </div>
          <div id="detailsDivContainer">
            

          </div>




        </div>


      </div>
    </body>

    </html>

    <script>
    
    /*     获取所有的分类名称 */
    let categoryList = [];
  //存放查到的分类服饰
    let clothesList = [];
    
    $(document).ready(function () {
      request("POST", "<%=basePath%>/fitting/categoryList", {}, getCategoryListSuccess, serverError, true);
      
    });
    <%-- $(document).ready(function () {
        
        request("POST","<%=basePath%>/fitting/getAllByUserId",{},getFittingListSuccess,serverError,true);
      }); --%>
    
    function getCategoryListSuccess(result) {
      if (result.code == 0) {
        categoryList = result.data;
        renderCategory()
      } else if (result.code == -20) {

        customAlert(result.description);
        //一秒后跳转到登录页面
        setTimeout(function () {
          window.top.location.href = "index.jsp";
        }, 1000);
      } else {
        customAlert(result.description);
      }
    }
    let clothesListAll=[];
    
  	  

    
    var dropdown = document.querySelector('.dropdown')
    console.log(dropdown);
    function renderCategory() {
      for (let i = 0; i < categoryList.length; i++) {
        var option = document.createElement('option');
        option.value = categoryList[i].categoryAlias;
        option.textContent = categoryList[i].categoryAlias;
        dropdown.appendChild(option);
      }

    }



/* 角色模特*/      
    var user = JSON.parse(localStorage.getItem('curUser'));
    console.log("=======getGlobalParameter=======");
    console.log(user.model);
    console.log(user.sex);
    var img = document.getElementById('modelImg');
    var src = '../images/data/model/';
    src += user.model + "Model.png";
    modelImg.src = src;
    

    document.querySelector('.dropdown').onchange = function (){
        	  //获取选择的分类名
        	  var select = document.querySelector('.dropdown');
        	  
        	  console.log("hhhhhhhhhhhhhhhhhhhhh========");
        	  console.log(select.value);
        	  var categoryAlias = select.value;
        	  //获取分类id
        	  var id ;
        	  for(var i=0;i<categoryList.length;i++){
        		  
        		  if(categoryAlias==categoryList[i].categoryAlias){
        			  id = categoryList[i].id;
        			  
        		  }
        	  }
           
        	  var clothes = {
        		  categoryId : id,
        		  sex : user.sex         		  
        		  
        	  };
        	  
        	  console.log(clothes);

        	  request("POST","<%=basePath%>/clothes/findClothesBySAC", clothes , getClothesListSuccess, serverError,true);
        	  
    }
    
    
    
    function getClothesListSuccess(result) {
        if (result.code == 0) {
          clothesList = result.data;
          console.log(clothesList);
          renderClothes();
        } else if (result.code == -20) {

          customAlert(result.description);
          //一秒后跳转到登录页面
          setTimeout(function () {
            window.top.location.href = "index.jsp";
          }, 1000);
        } else {
          customAlert(result.description);
        }
      }
     function renderClothes() {
        $('#detailsDivContainer').empty();

  	  //使用模板克隆新的服饰信息小窗口
  	  var templateHtml = $('#clothesTemplate').html();
  	  var template = $('<div class="DetailsDiv">').append(templateHtml);


        for (let i = 0; i < clothesList.length; i++) {

            var DetailsDiv = $(template).clone();

            DetailsDiv.find('#imgShow').attr("src", '../images/clothesImg/'+clothesList[i].img);
            
            if(clothesList[i].img=='') {
            	  // 图片加载失败
            	DetailsDiv.find('#imgShow').attr("src", '../images/clothesImg/add.png');
            	};
            	
            // 根据clothesList数组中查到的属性，分别给编号、名称、单价后面的span加入值
            DetailsDiv.find("#clothesNo").text(clothesList[i].clothesNo);
            DetailsDiv.find("#clothesAlias").text(clothesList[i].clothesAlias);
            DetailsDiv.find("#price").text(clothesList[i].price.formatMoney(2,"￥",",","."));
            /* var price=clothesListAll[j].price.formatMoney(2,"￥",",","."); */
            $('#detailsDivContainer').append(DetailsDiv);
        }
      //添加按钮时间
        $('.image-button').click(function(){
        	console.log('image-button')
        	
            var clothesNo = $(this).parent().find('#clothesNo').text();
        	var id;
        	var categoryId;
        	console.log(clothesNo)
        	for (let i = 0; i < clothesList.length; i++) {
			if(clothesNo==clothesList[i].clothesNo){
				categoryId=clothesList[i].categoryId
				id=clothesList[i].id
			}
			
        }
        	console.log(categoryId)
            console.log(id)


            var clothesDetails = {
                categoryId: categoryId,
                clothesId: id,
                priority: 1               
            };
            request("POST","<%=basePath%>/fitting/addSuit",clothesDetails,addSuitSuccess,serverError,true); 

        });

      }
     function addSuitSuccess(result) {
         if(result.code==0){
             customSuccess("添加成功");
             
             request("POST","<%=basePath%>/fitting/getAllByUserId",{},getFittingListSuccess,serverError,true);
             
             renderDressedList()
             /* setTimeout(function () {
                 window.location.reload();
             }, 1000); */
             
         }else{
             customAlert(result.description);
         }
     }
     console.log('clothesList.length')
     console.log(clothesList.length)
     
/* ------------------------------------------ */
     
      var dressedList = [];
     request("POST","<%=basePath%>/fitting/getAllByUserId",{},getFittingListSuccess,serverError,true);
       function getFittingListSuccess(result){
    	  if(result.code == 0){
    		  console.log(result.data);
    		  dressedList = result.data;
    		  console.log(dressedList);
    		  console.log("我穿了衣服");
    		  request("POST","<%=basePath%>/clothes/getAll",{},getClothesListAllSuccess,serverError,true);
    		  
    		  
    		  
    		  
    	  }else if(result.code == -20){
    		  
    		  
    		  customAlert(result.description);
    		  setTimeout(function(){
    			  window.top.location.href = "index.jsp";
    		  },1000);
    	  }else{
    		  customAlert(result.description);
    	  }
   
       }
       
       function renderDressedList(){
    	   $ ('#dressedDivContainer').empty();
    	   //使用模板来克隆新的小窗口
    	   var templateHtml = $('#dressedTemplate').html();
    	   var template = $('<div class="dressedDiv">').append(templateHtml);
    	   console.log(dressedList.length);
           for(var i=0;i<dressedList.length;i++){
        	   var dressedDiv = $(template).clone();
        	 //根据dressedList查到的id去查找衣服的详细信息分别给编号名称和单价进行赋值
        	   var id = dressedList[i].clothesId;
			   console.log(clothesListAll.length);
        	   for(var j=0;j<clothesListAll.length;j++){

        		   if(id == clothesListAll[j].id){
                       dressedDiv.find("#clothesNo").text(clothesListAll[j].clothesNo);  
                       dressedDiv.find("#clothesAlias").text(clothesListAll[j].clothesAlias);
                       //把clothesListAll[j].price保留两位小数
                       var price=clothesListAll[j].price.formatMoney(2,"￥",",",".");
                       dressedDiv.find("#price").text(price);
                       dressedDiv.find("#priority").text(dressedList[i].priority);

                       $('#dressedDivContainer').append(dressedDiv);
                       
                       console.log("nihao1nihao1");
        		   }
        		   
        	   }
        	   
           }
           
           //删除按钮
              $('.clothesDel').click(function(){
              	console.log('clothesDel')
              	
                var clothesNo = $(this).parent().find('#clothesNo').text();
              	var id;
              	var categoryId;
              	console.log(clothesNo)
              	 for (let i = 0; i < clothesListAll.length; i++) {
      			if(clothesNo==clothesListAll[i].clothesNo){
      				categoryId=clothesListAll[i].categoryId
      			}
      			
              }
              	for (let i = 0; i < dressedList.length; i++) {
          			if(categoryId==dressedList[i].categoryId){
          				id=dressedList[i].id
          			}         			
                  }
              	console.log(categoryId)
                  console.log(id)


                  var clothesDetails = {
                      id: id           
                  };
                  request("POST","<%=basePath%>/fitting/deleteSuit",clothesDetails,deleteSuitSuccess,serverError,true);  

              });
           
           //调高一个index
           $('.zindexUp').click(function(){
                console.log("1111");
                var clothesNo = $(this).parent().find('#clothesNo').text();

           	    for (let i = 0; i < clothesListAll.length; i++) {
       			if(clothesNo==clothesListAll[i].clothesNo){
       				categoryId=clothesListAll[i].categoryId
       			}
       			
               }
           	    
           	 	for (let i = 0; i < dressedList.length; i++) {
          			if(categoryId==dressedList[i].categoryId){
          			          		       dressedList[i].priority = dressedList[i].priority+1;

          		       console.log("111222"+dressedList[i].priority);
                       
          		       var clothes = dressedList[i];
                    
                         request("POST","<%=basePath%>/fitting/updateSuit",clothes,updateSuitSuccess,serverError,true);

          			}         			
                  }
                     
                
              }); 
           //调低一个index
           $('.zindexDown').click(function(){
                console.log("1111");
                var clothesNo = $(this).parent().find('#clothesNo').text();

           	    for (let i = 0; i < clothesListAll.length; i++) {
       			if(clothesNo==clothesListAll[i].clothesNo){
       				categoryId=clothesListAll[i].categoryId;
       			}
       			
               }
           	    
           	 	for (let i = 0; i < dressedList.length; i++) {
          			if(categoryId==dressedList[i].categoryId){
          			   dressedList[i].priority = dressedList[i].priority-1;

          		       console.log("111222"+dressedList[i].priority);
                       
          		       var clothes = dressedList[i];
                    
                         request("POST","<%=basePath%>/fitting/updateSuit",clothes,updateSuitSuccess,serverError,true);

          			}         			
                  }
                     
                
              });
           
    	   
       } 
       function deleteSuitSuccess(result) {
           if(result.code==0){
               customSuccess("删除成功");
               
               request("POST","<%=basePath%>/fitting/getAllByUserId",{},getFittingListSuccess,serverError,true);
               
               renderDressedList();
               /* setTimeout(function () {
                   window.location.reload();
               }, 1000); */
               
           }else{
               customAlert(result.description);
           }
       }
       
       function renderExhibition(){
    	   //清空所有衣服
    	   $('#clothesImgDiv').empty();
    	   var money = 0 ;
    	   console.log("111mo"+money);
    	   for(var i=0;i<dressedList.length;i++){
        	 //根据dressedList查到的id去查找衣服的详细信息
        	   var id = dressedList[i].clothesId;
			   console.log(clothesListAll.length);
        	   for(var j=0;j<clothesListAll.length;j++){

        		   if(id == clothesListAll[j].id){
        			  money = money+ clothesListAll[j].price;
                      var img = clothesListAll[j].img;
                      var div =$('<img>').attr('src','../images/clothesImg/'+img).addClass('clothes-img');
                      $('#clothesImgDiv').append(div);
                      
                      
                      var index = dressedList[i].priority;
                      div.css('z-index',index);
                      
        		   }
        		   
        	   }
        	   
           }

           var flaotMoney=money.formatMoney(2,"￥",",",".");
           console.log("money.formatMoney:"+flaotMoney);
    	   $("#money").text(flaotMoney) ;
    	   
       }
       
       
       function getClothesListAllSuccess(result) {
           if (result.code == 0) {
             clothesListAll = result.data;
             console.log('clothesListAll')
             console.log(clothesListAll)
             renderDressedList();
             renderExhibition();

             
           } else if (result.code == -20) {

             customAlert(result.description);
             //一秒后跳转到登录页面
             setTimeout(function () {
               window.top.location.href = "index.jsp";
             }, 1000);
           } else {
             customAlert(result.description);
           }
         }
       
       function updateSuitSuccess(result) {
           if(result.code==0){
        	   renderDressedList();
               renderExhibition();

           
           }else{
               customAlert(result.description);
           }
       }
      
      

 </script>