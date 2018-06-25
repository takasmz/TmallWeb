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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<%=basePath %>js/jquery-3.3.1.min.js" ></script>
<link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet"  >
<script src="<%=basePath %>js/bootstrap.min.js" ></script>
<link href="<%=basePath %>css/core/style.css" rel="stylesheet" >

<title>${typename}</title>
<script>
$(function(){
	$("#determine").hide();
	
	$("#priceranges #pricerange").on("click", function(e){
	    $("#determine").show();
	    $(document).on("click", function(){
	        $("#determine").hide();
	    });
	    e.stopPropagation();
	});
	$("#determine").on("click", function(e){
	    e.stopPropagation();
	});

})
</script>
<script type="text/javascript">
	document.getElementById("")
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
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

<div class="simpleSearchOutDiv">
	<a href="/tmall">
		<img id="simpleLogo" class="simpleLogo" src="<%=basePath%>image/simpleLogo.png">	
	</a>
	
	<form action="<c:url value="/search"/>" method="post" >		
	<div class="simpleSearchDiv pull-right">
		<input type="text" placeholder="平衡车 原汁机"  value="" name="keyword">
		<button class="searchButton" type="submit">搜天猫</button>
		<div class="searchBelow">	
					<span>
						<a href="forecategory?cid=76">
							冰箱
						</a>					
							<span>|</span>										
					</span>			
					<span>
						<a href="forecategory?cid=75">
							空调
						</a>				
							<span>|</span>				
					</span>			
					<span>
						<a href="forecategory?cid=74">
							女表
						</a>										
							<span>|</span>										
					</span>			
					<span>
						<a href="forecategory?cid=73">
							男表
						</a>					
					</span>										
		</div>
	</div>
	</form>
	<div style="clear:both"></div>
</div>

<div id="category">
	<div class="categoryPageDiv">
		<img  src="<%=basePath%>/image/gonggong1.jpg">
	


<div class="categorySortBar">

   <table class="categorySortBarTable categorySortTable">
		<tr>
			<td class="grayColumn" ><a href="?cid=83&sort=all">综合<span class="glyphicon glyphicon-arrow-down"></span></a></td>
			<td  ><a href="?cid=83&sort=review">人气<span class="glyphicon glyphicon-arrow-down"></span></a></td>
			<td ><a href="?cid=83&sort=date">新品<span class="glyphicon glyphicon-arrow-down"></span></a></td>
			<td ><a href="?cid=83&sort=saleCount">销量<span class="glyphicon glyphicon-arrow-down"></span></a></td>
			<td ><a href="?cid=83&sort=price">价格<span class="glyphicon glyphicon-resize-vertical"></span></a></td>
		</tr>
	</table>

    <table class="categorySortBarTable">
		<tr>
			<td><input class="sortBarPrice beginPrice" type="text" placeholder="请输入"></td>
			<td class="grayColumn priceMiddleColumn">-</td>
			<td><input class="sortBarPrice endPrice" type="text" placeholder="请输入"></td>
		</tr>
	</table>

</div>


<div id="categoryProducts">
<c:url value="/foreproduct" var="foreproduct" />
<c:forEach items="${productionlist}" var="production">
<div class="productUnit" >
   <div id="productUnitFrame">
      <a href="${foreproduct}?pid=${production.getId()}">
      	<img class="productImage" src="<%=basePath%>${production.getImgpath()}">
      </a>
      <span class="productPrice">${production.getPrice()}</span>
      <a href=# class="productLink">${production.getName()}</a>
      <a href=# class="tmallLink">天猫专卖</a>
      <div class="show1 productInfo">
      <span class="monthDeal">月成交<span class="productDealNumber">${production.getSales_volume()}笔</span></span>
      <span class="productReview">评价<span class="productReviewNumber">${production.getReviewnumber()}</span></span>
      <span class="wangwang"><img src="<%=basePath%>/image/wangwang.png"></span>
      </div>
      
   </div>
</div>
</c:forEach>
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
            	<img src="<%=basePath %>image/you.png">
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
			    <a href="#nowhere" ><img src="<%=basePath %>image/ma.png"></a> 
			</div>
			
    </div>
    
    <div style="clear:both"></div>
    
    
    
    <div id="copyright" class="copyright">
    	<div class="coptyrightMiddle">
    	<img id="cateye" class="cateye" src="<%=basePath %>image/cateye.png">
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

<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1273069248'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s13.cnzz.com/stat.php%3Fid%3D1273069248%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>

</html>