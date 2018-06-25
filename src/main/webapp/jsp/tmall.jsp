<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<%=basePath %>js/jquery-3.3.1.min.js" ></script>
<link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet"  >
<script src="<%=basePath %>js/bootstrap.min.js" ></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/core/style.css">

<c:url value="/tmall" var="tmall"/>
<script>
if("${typelist}" == null || "${typelist}" == ""){
	window.location.href="${tmall}";
}

function showProductsAsideCategorys(tid){
	$("div.eachCategory[tid="+tid+"]").css("background-color","white");
	$("div.eachCategory[tid="+tid+"] a").css("color","#87CEFA");
	$("div.productsAsideCategorys[tid="+tid+"]").show();
}


function hideProductsAsideCategorys(tid){
	$("div.eachCategory[tid="+tid+"]").css("background-color","#e2e2e3");
	$("div.eachCategory[tid="+tid+"] a").css("color","#000");
	$("div.productsAsideCategorys[tid="+tid+"]").hide();
}
$(function(){
    $("div.eachCategory").mouseenter(function(){
        var tid = $(this).attr("tid");
        showProductsAsideCategorys(tid);
    });
    $("div.eachCategory").mouseleave(function(){
        var tid = $(this).attr("tid");
        hideProductsAsideCategorys(tid);
    });
    $("div.productsAsideCategorys").mouseenter(function(){
    	var tid = $(this).attr("tid");
    	showProductsAsideCategorys(tid);
    });
    $("div.productsAsideCategorys").mouseleave(function(){
    	var tid = $(this).attr("tid");
    	hideProductsAsideCategorys(tid);
    });
	
	$("div.rightMenu span").mouseenter(function(){
		var left = $(this).position().left;
		var top = $(this).position().top;
		var width = $(this).css("width");
		var destLeft = parseInt(left) + parseInt(width)/2;
		$("img#catear").css("left",destLeft);
		$("img#catear").css("top",top-20);
		$("img#catear").fadeIn(500);
				
	});
	$("div.rightMenu span").mouseleave(function(){
		$("img#catear").hide();
	});
	
	var left = $("div#carousel-of-product").offset().left;
	$("div.categoryMenu").css("left",left-20);
	$("div.categoryWithCarousel div.head").css("margin-left",left);
	$("div.productsAsideCategorys").css("left",left-20);
	
	
});
</script>

</head>

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

<title>模仿天猫官网</title>

<div class="homepageDiv">

<img src="<%=basePath %>image/catear.png" id="catear" class="catear"/>
	
<div class="categoryWithCarousel">


<div class="headbar show1">
	<div class="head ">
	
		<span style="margin-left:10px" class="glyphicon glyphicon-th-list"></span>
		<span style="margin-left:10px" >商品分类</span>
		
	</div>
	
	<div class="rightMenu">
        <span><a href=#><img src="<%=basePath%>/image/chaoshi.png"></a></span>
        <span><a href=#><img src="<%=basePath%>/image/guoji.png"></a></span>		
		<span><a href="<c:url value="/forecategory?tid=1"></c:url>">平板电视</a></span>
        <span><a href=<c:url value="/forecategory?tid=2"></c:url>>马桶</a></span>
        <span><a href=<c:url value="/forecategory?tid=3"></c:url>>沙发</a></span>
        <span><a href=<c:url value="/forecategory?tid=4"></c:url>>电热水器</a></span>
	</div>
	
</div>

	
<div style="position: relative">
	
	
<div class="categoryMenu">
		
			<div tid="1" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">
					平板电视
				</a>
			</div>
		
			<div tid="2" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=2"></c:url>">					
				马桶
				</a>
			</div>
		
			<div tid="3" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=3"></c:url>">					
				沙发
				</a>
			</div>
		
			<div tid="4" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=4"></c:url>">	
					电热水器
				</a>
			</div>
		
			<div tid="5" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=5"></c:url>">	
					平衡车
				</a>
			</div>
		
			<div tid="6" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">	
					扫地机器人 
				</a>
			</div>
		
			<div tid="7" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">	
					原汁机
				</a>
			</div>
		
			<div tid="8" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">	
					冰箱
				</a>
			</div>
		
			<div tid="9" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">	
					空调
				</a>
			</div>
		
			<div tid="10" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">	
					女表
				</a>
			</div>
		
			<div tid="11" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">	
					男表
				</a>
			</div>
		
			<div tid="12" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">	
					男士手拿包 
				</a>
			</div>
		
			<div tid="13" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">	
					男士西服
				</a>
			</div>
		
			<div tid="14" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">	
					时尚男鞋
				</a>
			</div>
		
			<div tid="15" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">	
					品牌女装
				</a>
			</div>
		
			<div tid="16" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">	
					太阳镜
				</a>
			</div>
		
			<div tid="17" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="<c:url value="/forecategory?tid=1"></c:url>">	
					安全座椅
				</a>
			</div>
		
	</div>  
</div>

<div style="position: relative;left: 0;top: 0;">
	

<script>
$(function(){
	$("div.productsAsideCategorys div.row a").each(function(){
		var v = Math.round(Math.random() *6);
		if(v == 1)
			$(this).css("color","#87CEFA");
	});
});

</script>
<c:forEach begin="1" end="17" var="tid">
	<div tid="${tid}" class="productsAsideCategorys">
		<c:forEach begin="0" end="7">
			<div class="row show1">
						<a href="foreproduct?pid=83">
									USB高清解
						</a>
						<a href="foreproduct?pid=81">
									芒果TV在线
						</a>
						<a href="foreproduct?pid=80">
									抢购价
						</a>
						<a href="foreproduct?pid=79">
									USB解码															
						</a>
						<a href="foreproduct?pid=78">
									32英吋
						</a>
						<a href="foreproduct?pid=77">
									10核
						</a>
						<a href="foreproduct?pid=76">
									TCL品牌日								
						</a>				
				<div class="seperator"></div>
			</div>				
		</c:forEach>
	</div>		
	</c:forEach>	
</div>
</div>
<div id="carousel-of-product"  class="carousel-of-product carousel slide1" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-of-product" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-of-product" data-slide-to="1"></li>
    <li data-target="#carousel-of-product" data-slide-to="2"></li>
    <li data-target="#carousel-of-product" data-slide-to="3"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
   <div class="item active">
            <img src="<%=basePath%>/image/index-1.jpg" >
    </div>
    <div class="item">
            <img src="<%=basePath%>/image/index-2.jpg" >
    </div>
    <div class="item">
            <img src="<%=basePath%>/image/index-3.jpg" >
    </div>
 
    <div class="item">
            <img src="<%=basePath%>/image/index-4.jpg" >
    </div>

  </div>

</div>	

<div class="carouselBackgroundDiv">
</div>

</div>

<div class="homepageCategoryProducts">

<c:forEach items="${typelist}" var="type">
   <div class="eachHomepageCategoryProducts">
       <div class="left-mark"></div>
       <span class="categoryTitle">${type.getName()}</span>
       <br>
       <c:forEach items="${type.getListproduction()}" var="production" begin="0" end="4">
          <div class="productItem" >
          	<a href="<c:url value="/foreproduct?pid=${production.getId()}"></c:url>" ><img alt="${type.getName()}" src="<%=basePath%>${production.getImgpath()}"/></a>
         	 <a class="productItemDescLink" href="<c:url value="/foreproduct?pid=${production.getId()}"></c:url>">
          		<span class="productItemDesc" style="font-size:11px;">
          		[热销]${production.getName()}
         	 	</span>
          	</a>
          	<span class="productPrice" style="margin-top:0px;">
          		${production.getPrice()}
          	</span>
          </div>
          </c:forEach>
           <div style="clear:both"></div>
       </div>
       </c:forEach>
      
       
       <img class="endpng" src="<%=basePath%>/image/end.png" >
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
							<a href="register.jsp" class="pull-right">免费注册</a> 
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

