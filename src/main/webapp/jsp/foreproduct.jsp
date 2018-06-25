<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<%=basePath %>js/jquery-3.3.1.min.js" ></script>
<link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet"  >
<script src="<%=basePath %>js/bootstrap.min.js" ></script>
<script src="<%=basePath %>js/jqPaginator.js" ></script>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/css/core/style.css">
<c:url value="/reviewpage" var="reviewpage" />
<script>
$(function(){	
	
	$("a.productDetailTopReviewLink").click(function(){
		$("div.productReviewDiv").show();
		$("div.productDetailDiv").hide();
		
	});
	$("a.productReviewTopPartSelectedLink").click(function(){
		$("div.productReviewDiv").hide();
		$("div.productDetailDiv").show();		
	});
	
	$("span.leaveMessageTextareaSpan").hide();
	$("img.leaveMessageImg").click(function(){
		
		$(this).hide();
		$("span.leaveMessageTextareaSpan").show();
		$("div.orderItemSumDiv").css("height","100px");
	});
	
	$("div#footer a").click(function(){
		alert("模仿天猫的连接，并没有跳转到实际的页面");
	});
	

	$("a.wangwanglink").click(function(){
		alert("模仿旺旺的图标，并不会打开旺旺");
	});
	$("a.notImplementLink").click(function(){
		alert("这个功能没做，蛤蛤~");
	});
	

});

</script>	
<c:url value="/loginCheck" var="loginCheck"/>
<script>

$(function(){
	var stock = ${production.getStock()};
	$(".productNumberSetting").keyup(function(){
		var num= $(".productNumberSetting").val();
		num = parseInt(num);
		if(isNaN(num))
			num= 1;
		if(num<=0)
			num = 1;
		if(num>stock)
			num = stock;
		$(".productNumberSetting").val(num);
	});
	
	$(".increaseNumber").click(function(){
		var num= $(".productNumberSetting").val();
		num++;
		if(num>stock)
			num = stock;
		$(".productNumberSetting").val(num);
	});
	$(".decreaseNumber").click(function(){
		var num= $(".productNumberSetting").val();
		--num;
		if(num<=0)
			num=1;
		$(".productNumberSetting").val(num);
	});

	
	$("button.loginSubmitButton").click(function(){
		var name = $("#name").val();
		var password = $("#password").val();
		
		if(0==name.length||0==password.length){
			$("span.errorMessage").html("请输入账号密码");
			$("div.loginErrorMessageDiv").show();			
			return false;
		}
		var page = "${loginCheck}";
		$.get(
	            page,
	            {"username":name,"password":password},
	            function(result,status){
	            	if("success"==status){
	            		location.reload();
	            	}
	            	else{
	            		$("span.errorMessage").html("账号密码错误");
	            		$("div.loginErrorMessageDiv").show();	            		
	            	}
	            }
		);			
		
		return true;
	});
	
	$("img.smallImage").mouseenter(function(){
		var bigImageURL = $(this).attr("bigImageURL");
        $("img.bigImg").attr("src",bigImageURL);
	});
	
	$("img.bigImg").load(
		function(){
			$("img.smallImage").each(function(){
				var bigImageURL = $(this).attr("bigImageURL");
				img = new Image();
				img.src = bigImageURL;
				
				img.onload = function(){
					console.log(bigImageURL);	
					$("div.img4load").append($(img));
				};
			});		
		}
	);
	
});


</script>


<c:url value="/forebuy" var="forebuy" ></c:url>
<c:url value="/forecart" var="forecart"></c:url>
<c:url value="/login" var="login"></c:url>

<script>
var page = 1;
var rows = 5;
$(document).ready(function () {
//加载
//alert("ASda")
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
function pageto(){
	var url = '<%=basePath%>/reviewpage';
	//alert(url);
	$.ajax({
		type:"POST",
		dataType:"json",
		data:{pid:'${pid}',PageNum:page,PageSize:rows},
		url:url,
		success: function (data) {
			 if (data.result == 1) {
				 $(".product_length_number").each(function(){
					 $(this).html(data.data.count);
				 });
				 var count = data.data.count;
				 var html = "";
				 for (var i = 0; i < data.data.reviews.length; i++) {
	                    var reviewContent = data.data.reviews[i];
	                    html += create_list(reviewContent.reviewbean);
	             }
				 $("div.review_content").html(html);
				 //这里是分页的插件
	                $('#pagination').jqPaginator('option', {
	                    totalPages: (Math.ceil(count/rows)<1?1:Math.ceil(count/rows)),
	                    currentPage: page
	                });
			 }
        },
	});
}

function create_list(reviewbean){
	var html = '<div class="productReviewItem">'
				+'<div class="productReviewItemDesc">'
			    +'<div class="productReviewItemContent">'
				+ reviewbean.review
				+'</div>'
				+'<div class="productReviewItemDate">'+reviewbean.time +'</div>'
				+'</div>'
				+'<div class="productReviewItemUserInfo">'
				+ reviewbean.username
				+'</div>'
				+'<div style="clear:both"></div>'
				+'</div>';
	return html;
}

$(".productReviewItem:even").css("background", "#e6e6e6");//隔行变色

function buy(){
	var checklogin = '${username}';
	if( checklogin == null || checklogin==""){
		$("#loginModal").modal('show');
	}else{
		var num= $(".productNumberSetting").val();
		var n = parseInt(${production.getStock()}) - parseInt(num) ;
		if(n < 0){
			alert("库存不足，请重试")
		}else{		
			window.location.href="${forebuy}?productNumberSetting="+num +'&pid='+'${pid}';
		}
	}
}

function add(){
		var checklogin = '${username}';
		if( checklogin == null || checklogin==""){
			$("#loginModal").modal('show');
		}else{
			var num= $(".productNumberSetting").val();
			var n = parseInt(${production.getStock()}) - parseInt(num) ;
			if(n < 0){
				alert("库存不足，请重试")
			}else{		
			$("#addCartButton").html("已加入购物车");
			$("#addCartButton").attr("disabled","disabled");
			$("#addCartButton").css("background-color","lightgray");
			$("#addCartButton").css("border-color","lightgray");
			$("#addCartButton").css("color","black");
			var submit = document.getElementById('submit');
			submit.action='${forecart}?pid='+'${pid}';
			submit.submit();
			alert("加入购物车成功");
			}
		}
}

</script>
</head>
<title>${production.getName()}</title>
<body>
<nav class="top">
<div class = "top_middle">
  <a href="<c:url value="/tmall"/>" style="color:#C40000;margin:0px" class="glyphicon glyphicon-home redColor">天猫首页</a>
  	<span>喵，欢迎来到天猫</span>
  <c:if test="${username != null}">
  	<span>${username} 欢迎您</span>
  	<a href="<c:url value="/quitlogin" />">退出</a>
  </c:if>
  <c:if test="${username == null}">
	<a href="<%=basePath%>/jsp/login.jsp">请登录</a>
  </c:if>
  
  <a href="<%=basePath %>/jsp/register.jsp">免费注册</a>
<span class = "pull-right" >
  <a href="<c:url value="/forebought"></c:url>" >我的订单</a>
  <a href="<c:url value="/buycart"></c:url>">
	<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
	购物车<strong>${buycartcount}</strong>件</a>	
  </span>
  </div>
</nav>


<div class="searchOutDiv">
	<a href="${tmall}">
	<img alt="tmall logo" src="<%=basePath%>/image/logo.gif" class="logo">
	</a>
	<form action="<c:url value="/search"/>" method="post" >	
	<div class="searchDiv">
		<input type="text" placeholder="女朋友   男朋友" name="keyword" >
		<button type="submit" class= "searchButton">搜索</button>
		<div class="searchBelow">
			<span> <a href="<c:url value="/forecategory?tid=5"></c:url>"> 平衡车 </a> <span>|</span>
			</span> <span> <a href="#nowhere"> 扫地机器人 </a> <span>|</span>
			</span> <span> <a href="#nowhere"> 原汁机 </a> <span>|</span>
			</span> <span> <a href="#nowhere"> 冰箱 </a></span>
		</div>
	</div>
	</form>
</div>



<div class="categoryPictureInProductPageDiv">
	<img class="categoryPictureInProductPage" src="<%=basePath%>image/gonggong1.jpg">
</div>

<div class="productPageDiv">

<div class="imgAndInfo">

	<div class="imgInimgAndInfo">
		<img src="<%=basePath%>${production.getImgpath()}" class="bigImg">
		<div class="smallImageDiv">
			
				<img src="<%=basePath%>image/tablettv/tablet-tv1/tablet-tv1-1x.jpg" bigImageURL="<%=basePath%>image/tablettv/tablet-tv1/tablet-tv1-1d.jpg" class="smallImage">
			
				<img src="<%=basePath%>image/tablettv/tablet-tv1/tablet-tv1-2x.jpg" bigImageURL="<%=basePath%>image/tablettv/tablet-tv1/tablet-tv1-2d.jpg" class="smallImage">
			
				<img src="<%=basePath%>image/tablettv/tablet-tv1/tablet-tv1-3x.jpg" bigImageURL="<%=basePath%>image/tablettv/tablet-tv1/tablet-tv1-3d.jpg" class="smallImage">
			
				<img src="<%=basePath%>image/tablettv/tablet-tv1/tablet-tv1-4x.jpg" bigImageURL="<%=basePath%>image/tablettv/tablet-tv1/tablet-tv1-4d.jpg" class="smallImage">
			
				<img src="<%=basePath%>image/tablettv/tablet-tv1/tablet-tv1-4x.jpg" bigImageURL="<%=basePath%>image/tablettv/tablet-tv1/tablet-tv1-4d.jpg" class="smallImage">
			
		</div>
		<div class="img4load hidden" ></div>
	</div>
	
	<div class="infoInimgAndInfo">
		
		<div class="productTitle">
			${production.getName()}
		</div>
		<div class="productSubTitle">
			屏大影院 高配12核 安卓智能 
		</div>
		
		<div class="productPrice">
			<div class="juhuasuan">
				<span class="juhuasuanBig" >聚划算</span>
				<span>此商品即将参加聚划算，<span class="juhuasuanTime">1天19小时</span>后开始，</span>
			</div>
			<div class="productPriceDiv">
				<div class="gouwujuanDiv"><img height="16px" src="<%=basePath%>image/gouwujuan.png">
				<span> 全天猫实物商品通用</span>
				
				</div>
				<div class="originalDiv">
					<span class="originalPriceDesc">价格</span>
					<span class="originalPriceYuan">¥</span>
					<span class="originalPrice">
					
						${production.getPrice()+500}					
					</span>
				</div>
				<div class="promotionDiv">
					<span class="promotionPriceDesc">促销价 </span>
					<span class="promotionPriceYuan">¥</span>
					<span class="promotionPrice">
						${production.getPrice()}
					</span>				
				</div>
			</div>
		</div>
		<div class="productSaleAndReviewNumber">
			<div>销量 <span class="redColor boldWord"> ${production.getSales_volume()}</span></div>	
			<div>累计评价 <span class="product_length_number" style="font-weight: bold;color: #C40000;"></span></div>	
		</div>
		<iframe id="id_iframe" name="id_iframe" style="display:none;"></iframe> 
		<form id="submit" action="" method="post" target="id_iframe">
		<div class="productNumber">
			<span>数量</span>
			<span>
				<span class="productNumberSettingSpan">
				<input class="productNumberSetting" type="text" name="productNumberSetting" value="1">
				</span>
				<span class="arrow">
					<a href="#nowhere" class="increaseNumber">
					<span class="updown">
							<img src="<%=basePath%>image/tablettv/tablet-tv1/increase.png">
					</span>
					</a>
					
					<span class="updownMiddle"> </span>
					<a href="#nowhere"  class="decreaseNumber">
					<span class="updown">
							<img src="<%=basePath%>image/tablettv/tablet-tv1/decrease.png">
					</span>
					</a>
					
				</span>
					
			件</span>
			<span>库存 ${production.getStock()} 件</span>
		</div>
		<div class="serviceCommitment">
			<span class="serviceCommitmentDesc">服务承诺</span>
			<span class="serviceCommitmentLink">	
				<a href="#nowhere">正品保证</a>
				<a href="#nowhere">极速退款</a>
				<a href="#nowhere">赠运费险</a>
				<a href="#nowhere">七天无理由退换</a>
			</span>
		</div>	
		
		<div class="buyDiv">
			<a class="buyLink" href="#nowhere">			
			<input type="button" class="buyLink" id="buybutton" value="立即购买" onclick="buy();" style="
			display: inline-block;
			margin: 0px 10px;
			width: 180px;
			height: 40px;
			border: 1px solid #C40000;
			background-color: #FFEDED;
			text-align: center;
			line-height: 40px;
			font-size: 16px;
			color: #C40000;
			font-family: arial;"></a>
			<a  class="addCartLink">
			<span class="glyphicon glyphicon-shopping-cart" style="font-size: 12px;margin-right: 8px;"></span>			
			<input type="button" class="buyLink" id="addCartButton" value="加入购物车" onclick="add();" style="
			display: inline-block;
			margin: 0px 10px;
			width: 180px;
			height: 40px;
			border: 1px solid #C40000;
			background-color: #C40000;
			text-align: center;
			line-height: 40px;
			font-size: 16px;
			color: white;
			font-family: arial;">
			</a>
		</div>
		</form>
	</div>
	<div style="clear:both"></div>
	
</div>


<div class="productReviewDiv" >
	<div class="productReviewTopPart">
		<a  href="#nowhere" class="productReviewTopPartSelectedLink">商品详情</a>
		<a  href="##" class="selected">累计评价 <span class="product_length_number" ></span> </a>
	</div>
	
		
	<div class="productReviewContentPart">
		
		<div class="review_content">
   		 </div>
		<ul class="pagination" id="pagination"></ul>
		<div class="oper_box">共<span class="product_length_number"></span>条记录</div>
		
		
		<div style="clear:both"></div>
	</div>

</div>

	
	

	
<div class="productDetailDiv" >
	<div class="productDetailTopPart">
		<a href="#nowhere" class="productDetailTopPartSelectedLink selected">商品详情</a>
		<a href="##"  class="productDetailTopReviewLink">累计评价 <span class="product_length_number" ></span> </a>
	</div>
	
	
	<div class="productParamterPart">
		<div class="productParamter">产品参数：</div>
		
		<div class="productParamterList">
			<c:forEach items="${listproper}" var="property">
				<span>${property.getName()}:  ${property.getValue()} </span>
			</c:forEach>
		</div>
		<div style="clear:both"></div>
	</div>
	
	<div class="productDetailImagesPart">
			
				<img src="<%=basePath%>image/tablettv/tablet-tv1/Introction/intro-1.jpg">
			
				<img src="<%=basePath%>image/tablettv/tablet-tv1/Introction/intro-2.jpg">
			
				<img src="<%=basePath%>image/tablettv/tablet-tv1/Introction/intro-3.jpg">
			
				<img src="<%=basePath%>image/tablettv/tablet-tv1/Introction/intro-4.jpg">
			
				<img src="<%=basePath%>image/tablettv/tablet-tv1/Introction/intro-5.jpg">
			
				<img src="<%=basePath%>image/tablettv/tablet-tv1/Introction/intro-6.jpg">
			
	</div>
</div>


	
	

</div>





<div class="modal " id="loginModal" tabindex="-1" role="dialog" >
	<div class="modal-dialog loginDivInProductPageModalDiv">
	        <div class="modal-content">
					<div class="loginDivInProductPage">
						<div class="loginErrorMessageDiv">
							<div class="alert alert-danger" >
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
							  	<span class="errorMessage"></span>
							</div>
						</div>
							
						<div class="login_acount_text">账户登录</div>
						<div class="loginInput " >
							<span class="loginInputIcon ">
								<span class=" glyphicon glyphicon-user"></span>
							</span>
							<input id="name" name="name" placeholder="手机/会员名/邮箱" type="text">			
						</div>
						
						<div class="loginInput " >
							<span class="loginInputIcon ">
								<span class=" glyphicon glyphicon-lock"></span>
							</span>
							<input id="password" name="password"  type="password" placeholder="密码" type="text">			
						</div>
									<span class="text-danger">不要输入真实的天猫账号密码</span><br><br>
						<div>
							<a href="#nowhere">忘记登录密码</a> 
							<a href="<%=basePath %>/jsp/register.jsp" class="pull-right">免费注册</a> 
						</div>
						<div style="margin-top:20px">
							<button class="btn btn-block redButton loginSubmitButton" type="submit">登录</button>
						</div>
					</div>	
	      </div>
	</div>
</div>

<div class="modal" id="deleteConfirmModal" tabindex="-1" role="dialog" >
	<div class="modal-dialog deleteConfirmModalDiv">
       <div class="modal-content">
          <div class="modal-header">
            <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title">确认删除？</h4>
          </div>
          <div class="modal-footer">
            <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
            <button class="btn btn-primary deleteConfirmButton" id="submit" type="button">确认</button>
          </div>
        </div>
      </div>
	</div>
<div id="footer"  class="footer" style="display: block;">
	
    <div id="footer_ensure" class="footer_ensure">
            <a href="#nowhere">
            	<img src="<%=basePath%>/image/you.png">
            </a>
    </div>

	<div class="horizontal_line">
	</div>
	    
    <div id="footer_desc" class="footer_desc">
            <div class="descColumn">
			    <span class="descColumnTitle">购物指南</span>
			    <a href="#nowhere" >免费注册</a> 
			    <a href="#nowhere" >开通支付宝</a> 
			    <a href="#nowhere" >支付宝充值</a>
			</div>
            <div class="descColumn">
			    <span class="descColumnTitle">天猫保障</span>
			    <a href="#nowhere" >发票保障</a> 
			    <a href="#nowhere" >售后规则</a> 
			    <a href="#nowhere" >缺货赔付</a>
			</div>
            <div class="descColumn">
			    <span class="descColumnTitle">支付方式</span>
			    <a href="#nowhere" >快捷支付</a> 
			    <a href="#nowhere" >信用卡</a> 
			    <a href="#nowhere" >蚂蚁花呗</a>
			    <a href="#nowhere" >货到付款</a>
			</div>
            <div class="descColumn">
			    <span class="descColumnTitle">商家服务</span>
			    <a href="#nowhere" >商家入驻</a> 
			    <a href="#nowhere" >商家中心</a> 
			    <a href="#nowhere" >天猫智库</a>
			    <a href="#nowhere" >天猫规则</a>
			    <a href="#nowhere" >物流服务</a>
			    <a href="#nowhere" >喵言喵语</a>
			    <a href="#nowhere" >运营服务</a>
			</div>
            <div class="descColumn">
			    <span class="descColumnTitle">手机天猫</span>
			     <a href=#><img src="<%=basePath%>/image/ma.png"></a>
			</div>
			
    </div>
    
    <div style="clear:both"></div>
    
    
    
    <div id="copyright" class="copyright">
    	<div class="coptyrightMiddle">
		<div class="white_link" >
			<a href="#nowhere" style="padding-left:0px" >关于天猫</a>
			<a href="#nowhere" > 帮助中心</a>
			<a href="#nowhere" >开放平台</a>
			<a href="#nowhere" >  诚聘英才</a>
			<a href="#nowhere" >联系我们</a>
			<a href="#nowhere" >网站合作</a>
			<a href="#nowhere" >法律声明</a>
			<a href="#nowhere" >知识产权</a>
			<a href="#nowhere" >  廉正举报	</a>
		</div>
		<div class="white_link" >
			<a href="#nowhere"  style="padding-left:0px"> 阿里巴巴集团</a><span class="slash">|</span>
			<a href="#nowhere" > 淘宝网</a><span class="slash">|</span>
			<a href="#nowhere" >天猫 </a><span class="slash">|</span>
			<a href="#nowhere" >  聚划算</a><span class="slash">|</span>
			<a href="#nowhere" >全球速卖通</a><span class="slash">|</span>
			<a href="#nowhere" >阿里巴巴国际交易市场</a><span class="slash">|</span>
			<a href="#nowhere" >1688</a><span class="slash">|</span>
			<a href="#nowhere" >阿里妈妈</a><span class="slash">|</span>
			<a href="#nowhere" >  阿里旅行·去啊	</a><span class="slash">|</span>
			<a href="#nowhere" >  阿里云计算	</a><span class="slash">|</span>
			<a href="#nowhere" >  阿里通信 	</a><span class="slash">|</span>
			<a href="#nowhere" >  YunOS	</a><span class="slash">|</span>
			<a href="#nowhere" >  阿里旅行·去啊	</a><span class="slash">|</span>
			<a href="#nowhere" >   万网	</a><span class="slash">|</span>
			<a href="#nowhere" >  高德	</a><span class="slash">|</span>
			<a href="#nowhere" > 优视 	</a><span class="slash">|</span>
			<a href="#nowhere" >  友盟	</a><span class="slash">|</span>
			<a href="#nowhere" >  虾米	</a><span class="slash">|</span>
			<a href="#nowhere" >  天天动听	</a><span class="slash">|</span>
			<a href="#nowhere" >  来往	</a><span class="slash">|</span>
			<a href="#nowhere" >  钉钉	</a><span class="slash">|</span>
			<a href="#nowhere" >  支付宝 		</a>
		</div>
	
		<div class="license">
			<span>增值电信业务经营许可证： 浙B2-20110446</span>
			<span>网络文化经营许可证：浙网文[2015]0295-065号</span>
			<span>互联网医疗保健信息服务 审核同意书 浙卫网审【2014】6号 </span>
			<span>互联网药品信息服务资质证书编号：浙-（经营性）-2012-0005</span>
		    <div class="copyRightYear">&copy; 2003-2016 TMALL.COM 版权所有</div>
		    <div>
        		<img src="<%=basePath%>/image/wang1.jpg">
        		<img src="<%=basePath%>/image/wang2.jpg">
		    </div>
		</div>
   	 </div>
   </div>
</div>
</body>


</html>

