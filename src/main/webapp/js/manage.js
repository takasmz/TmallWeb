var Modifieditems="production";
var page = 1;
var rows = 5;
var oid=0;
$(document).ready(function () {
//加载
initJqPaginator();
//加载
pageto();
}); 
//初始化分页
function initJqPaginator() {
    $.jqPaginator('#pagination', {
        totalPages: 100,
        visiblePages: 10,
        currentPage: 1,
        first: '<li class="prev"><a href="javascript:;">首页</a></li>',
        last: '<li class="prev"><a href="javascript:;">末页</a></li>',
        prev: '<li class="prev"><a href="javascript:;">上一页</a></li>',
        next: '<li class="next"><a href="javascript:;">下一页</a></li>',
        page: '<li class="page"><a href="javascript:;">{{page}}</a></li>',
        onPageChange: function (num, type) {
            page = num;
            if (type == "change") {
            	pageto();
            }
        }
    });
}

function change(e){
	Modifieditems = e.id;
	page=1;
	pageto();
}

function pageto(){
	$.ajax({
		type:"POST",
		dataType:"json",
		data:{type:Modifieditems,PageNum:page,PageSize:rows},
		url:'${manage}',
		success: function (data) {
			 if (data.result == 1) {
				 $(".product_length_number").each(function(){
					 $(this).html(data.data.count);
				 });
				
				// alert(data.data.reviews[0].reviewbean.id);
				 var count = data.data.count;
				 var html;
				 switch(Modifieditems){
                 case("production"):{
                	 html = '<tr class="Itemmenu" height:"28.8px">'
           				+'<td >图片</td>'
          			    +'<td class="name">商品名称</td>'
          				+'<td class="price">价格</td>'
          				+'<td class="stock">库存</td>'
          				+'<td class="type">商品种类id</td>'
          				+'<td class="model">型号</td>'
          				+'<td class="brand" >品牌</td>'
          				+'<td colspan="2">操作</td>'
          				+'<div style="clear:both"></div>'
          				+'</tr>';
                	for (var i = 0; i < data.data.objects.length; i++) {
 	                    var objectContent = data.data.objects[i];
 	                    html += create_productionlist(objectContent.object,i);                  
 	             	}
                	break;
                 }
                 case("type"):{
                	 html = '<tr class="Itemmenu" height:"28.8px">'
            				+'<td >类别名称</td>'
            				+'<td colspan="2">操作</td>'
           				+'<div style="clear:both"></div>'
           				+'</tr>';
                 	for (var i = 0; i < data.data.objects.length; i++) {
  	                    var objectContent = data.data.objects[i];
  	                    html += create_typelist(objectContent.object,i);                  
  	             	}
                 	break;
                 }
                 case("user"):{
                	 html = '<tr class="Itemmenu" height:"28.8px">'
            				+'<td >用户名</td>'
           			    +'<td class="name">邮箱</td>'
           				+'<td class="price">昵称</td>'
           				+'<td class="stock">密码</td>'
           				+'<td colspan="2">操作</td>'
           				+'<div style="clear:both"></div>'
           				+'</tr>';
                 	for (var i = 0; i < data.data.objects.length; i++) {
  	                    var objectContent = data.data.objects[i];
  	                    html += create_userlist(objectContent.object,i);                  
  	             	}
                 	break;
                 }
                 }
				 
				 var html =
				 $("table#Items").html(html);
				 //这里是分页的插件
	                $('#pagination').jqPaginator('option', {
	                    totalPages: (Math.ceil(count/rows)<1?1:Math.ceil(count/rows)),
	                    currentPage: page
	                });
			 }
        },
	});
}

function create_productionlist(object,i){
	var src = "<%=basePath%>"+object.imgpath;
	var html = '<tr class="Item" oid="'+i+'" height:"114.4px">'
				+'<td id="image"><img class="image" src='+src+'></td>'
			    +'<td id="name">'
				+ object.name
				+'</td>'
				+'<td id="price">'+object.price +'</td>'
				+'<td id="stock">' + object.stock+ '</td>'
				+'<td id="type_id">' + object.type_id+ '</td>'
				+'<td id="model">' + object.model+ '</td>'
				+'<td id="brands">' + object.brands+ '</td>'
				+'<td class="action">' + '<a onclick="action(this)">修改</a>' + '</td>'
				+'<td class="delete">' + '<a onclick="deleteitem(this)">删除</a>' + '</td>'
				+'<div style="clear:both"></div>'
				+'</tr>';
				//alert(html);
	return html;
}

function create_typelist(object,i){
	var html = '<tr class="Item" oid="'+i+'" height:"114.4px">'
			    +'<td id="name">'
				+ object
				+'</td>'
				+'<td class="action">' + '<a onclick="action(this)">修改</a>' + '</td>'
				+'<td class="delete">' + '<a onclick="deleteitem(this)">删除</a>' + '</td>'
				+'<div style="clear:both"></div>'
				+'</tr>';
				//alert(html);
	return html;
}

function create_userlist(object,i){
	var html = '<tr class="Item" oid="'+i+'" height:"114.4px">'
			    +'<td id="username">'
				+ object.username
				+'</td>'
				+'<td id="mail">'+object.mail +'</td>'
				+'<td id="nickname">' + object.nickname+ '</td>'
				+'<td id="password">' + object.password+ '</td>'
				+'<td id="action">' + '<a onclick="action(this)">修改</a>' + '</td>'
				+'<td class="delete">' + '<a onclick="deleteitem(this)">删除</a>' + '</td>'
				+'<div style="clear:both"></div>'
				+'</tr>';
				//alert(html);
	return html;
}
function deleteitem(e){
	var tr = $(e).parents("tr");
	oid = parseInt((page-1)*5)+parseInt(tr.attr("oid"));
	$("#deleteConfirmModal").show();
}

function comfirmdeleteitem(){
	$.ajax({
		url:'${delete}?oid='+oid+'&item='+Modifieditems,
		type:'POST',
		success:function(data){
			
		},
	});
	location.reload();
}

function action(e){
	var tr = $(e).parents("tr");
	oid = tr.attr("oid");
	//alert(oid);
	var trList = tr.children("td");
	var html='';
	 for (var i=0;i<trList.length-1;i++) {
		 	var td = trList.eq(i);
		 	//alert(td.attr("id"));
		 	if(td.attr("id")=="image"){
		 		html += '<div class="Input">'
					+'<span class="InputIcon">'+td.attr("id")+'</span>'
					+'<img id="'+td.attr("id")+'" src="'+ td.children("img").attr('src')+'" style="margin-left:100px;" width="80px" height="80px">'
					+'<input class="form-inline" type="file" onchange="changeimg(this)" id="changebutton" name="file" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg">'
					+'</div>';
		 	}else{
		 		html += '<div class="Input" >'
					+'<span class="InputIcon">'+td.attr("id")+'</span>'
					+'<input id="'+td.attr("id")+'" name="'+td.attr("id")+'" value="'+td.text()+'" type="text">'
					+'</div>';
		 	}
		 	
			//alert(html);
	 }
	 $("#modifys").html(html);
	 $("#loginModal").modal('show');
}
function changeimg(fileDom){
	//alert("124");
	//判断是否支持FileReader
    if (window.FileReader) {
        var reader = new FileReader();
    } else {
        alert("您的设备不支持图片预览功能，如需该功能请升级您的设备！");
    }
  	//获取文件
    var file = fileDom.files[0];
    var imageType = /^image\//;
    //是否是图片
    if (!imageType.test(file.type)) {
        alert("请选择图片！");
        return;
    }
    //读取完成
    reader.onload = function(e) {
        //获取图片dom
        var img = $(fileDom).parents("div").find("img");
        //图片路径设置为读取的图片
        img.attr("src",e.target.result);
    };
    reader.readAsDataURL(file); 
    
}
function submit(){
	//alert("124");
	var form = document.getElementById('modifypro'); 
    var url = '${upload}?oid='+oid;
    form.action=url;
    form.submit();
}

function addsubmit(n){
	//alert("124");
	var form = document.getElementById('modifypro'); 
	if(n==2){
		var url = '${addtype}';
	}else if(n==4){
		var url = '${adduser}';
	}else{
		var url = '${addpro}';
	}
    form.action=url;
    form.submit();
}
function addaction(list){
	 var html ="";
	 for (var i=0;i<list.length;i++) {
		 if(list[i]=="image"){
			 html +='<div class="Input">'
					+'<span class="InputIcon">image</span>'
					+'<img id="image" src="" style="margin-left:100px;" width="80px" height="80px">'
					+'<input class="form-inline" type="file" onchange="changeimg(this)" id="changebutton" name="file" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg">'
					+'</div>';
		 }else{
			 html += '<div class="Input" >'
					+'<span class="InputIcon">'+list[i]+'</span>'
					+'<input  id="'+list[i]+'" name="'+list[i]+'" type="text">'
					+'</div>';
		 }
	 }
	 $("#confirm-submission").click(function(){
		 addsubmit(list.length);
	 })
	 $("#modifys").html(html);
	 $("#loginModal").modal('show');
}
function addpro(){
	var list = new Array("image","name","price","stock","type_id","model","brands");
	addaction(list);
}
function addtype(){
	var list = new Array("name","path");
	addaction(list);
}
function adduser(){
	var list = new Array("username","mail","nickname","password");
	addaction(list);
}

$(".Item:even").css("background", "#e6e6e6");//隔行变色
