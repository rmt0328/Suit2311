function request(method,url,data,successCallBack,errorCallBack,async){
        $.ajax({
            url: url,
            contentType:"application/json",
            async:async,
            data: JSON.stringify(data),
            method: method
        }).done(successCallBack).fail(errorCallBack);
}

/*function uploadFileRequest(suit,urlPrefix){
	suit.find("#uploaderContainer input").fileupload({
		    dataType: 'json',
		    done: function (e, data) {
		    	suit.find("#imageUrl").val(data.result.description);
		    	suit.find("#uploaderContainer img").attr("src",urlPrefix+data.result.description);
		    	showMessage({"code":0,"description":data.result.description+"上传成功！"});
		        }
		});
}
*/
function showMessage(data){	
	alert(data.description);
}

var isCustomSuccess=false;
function customSuccess(message) {
	isCustomSuccess=true;
	let alertContainer = $("<div id='centeredAlert'>" +
		"<p>" + message + "</p>" +
		"<button id='closeAlert'>确定</button>" +
		"</div>");
	$("body").append(alertContainer);

	alertContainer.css({
		"z-index":"99999",
		"position": "fixed",
		"top": "50%",
		"left": "50%",
		"transform": "translate(-50%, -50%)",
		"background-color": "rgb(55,140,49)",
		"padding": "20px",
		"border": "1px solid #ccc",
		"border-radius": "15px",
		"box-shadow": "0 0 10px rgba(0, 0, 0, 0.3)",
		"text-align": "center",
		"height":"30px",
		"width":"200px",
	});


	$("#closeAlert").click(function () {
		alertContainer.remove();
	});

	// 设置一定时间后自动隐藏
	setTimeout(function () {
		alertContainer.remove();
		isCustomSuccess=false;
	}, 3000);
}

var isCustomAlert=false;

function customAlert(message) {
	isCustomAlert=true;
	let alertContainer = $("<div id='centeredAlert'>" +
		"<p>" + message + "</p>" +
		"<button id='closeAlert'>确定</button>" +
		"</div>");
	$("body").append(alertContainer);

	alertContainer.css({
		"position": "fixed",
		"top": "50%",
		"left": "50%",
		"transform": "translate(-50%, -50%)",
		"background-color": "rgb(199,84,80)",
		"padding": "20px",
		"border": "1px solid #ccc",
		"border-radius": "15px",
		"box-shadow": "0 0 10px rgba(0, 0, 0, 0.3)",
		"text-align": "center",
		"height":"30px",
		"width":"200px",
	});


	$("#closeAlert").click(function () {
		alertContainer.remove();
	});

	// 设置一定时间后自动隐藏
	setTimeout(function () {
		alertContainer.remove();
		isCustomAlert=false;
	}, 3000);
}

var isConfirmVisible = false;

function customConfirm(message, callback) {
	if (isConfirmVisible) {
		return;
	}

	isConfirmVisible = true;

	let confirmContainer = $("<div id='centeredConfirm'>" +
		"<p>" + message + "</p>" +
		"<button id='confirm'>确定</button>" +
		"<button id='cancel'>取消</button>" +
		"</div>");
	$("body").append(confirmContainer);

	confirmContainer.css({
		"position": "fixed",
		"top": event.pageY + "px",
		"left": "50%",
		"transform": "translate(-50%, -50%)",
		"background-color": "rgb(255,255,255)",
		"padding": "20px",
		"border": "1px solid #ccc",
		"border-radius": "15px",
		"box-shadow": "0 0 10px rgba(0, 0, 0, 0.3)",
		"text-align": "center",
		"height":"35px",
		"width":"200px",
	});

	$("#confirm").click(function () {
		confirmContainer.remove();
		isConfirmVisible = false;
		callback();
	});

	$("#cancel").click(function () {
		confirmContainer.remove();
		isConfirmVisible = false;
	});

}

function serverError(XMLHttpRequest, textStatus){
    console.log("responseText:",XMLHttpRequest.responseText);
    console.log("status:",XMLHttpRequest.status);
    console.log("textStatus:",textStatus);
    console.log("readyState:",XMLHttpRequest.readyState);
    alert("服务器故障");
}

function centerObject(object,zIndex){
	object.css({
    	zIndex:zIndex,
		position:'absolute', 
		left: ($(window).width() - object.outerWidth())/2, 
		top: ($(window).height() -object.outerHeight())/3 + $(document).scrollTop() 
	});
}

function centerObjectX(object,zIndex){
	object.css({
    	zIndex:zIndex,
		position:'absolute', 
		left: ($(window).width() - object.outerWidth())/2
	});
}

function centerObjectY(object,zIndex){
	object.css({
    	zIndex:zIndex,
		position:'absolute', 		 
		top: ($(window).height() - object.outerHeight())/3 + $(document).scrollTop() 
	});
}


function hideObject(object){
	object.css({
    	zIndex:0,
		display:"none"
	});
}

Number.prototype.formatMoney = function (places, symbol, thousand, decimal) {
    places = !isNaN(places = Math.abs(places)) ? places : 2;
    symbol = symbol !== undefined ? symbol : "$";
    thousand = thousand || ",";
    decimal = decimal || ".";
    var number = this,
        negative = number < 0 ? "-" : "",
        i = parseInt(number = Math.abs(+number || 0).toFixed(places), 10) + "",
        j = (j = i.length) > 3 ? j % 3 : 0;
    return symbol + negative + (j ? i.substr(0, j) + thousand : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousand) + (places ? decimal + Math.abs(number - i).toFixed(places).slice(2) : "");
};

