<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ page import="java.util.*,com.web.dao.*,com.web.controller.*,com.web.pojo.*" %>
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


<c:url value="/forebuy" var="forebuy" ></c:url>
<c:url value="/updatebuycart" var="updatebuycart"></c:url>
<c:url value="/deletebuycart" var="deletebuycart"></c:url>

<script>
$(function(){
	
	var deleteOrderItem = false;
	var deleteOrderItemid = 0;
	
	$("a.deleteOrderItem").click(function(){
		deleteOrderItem = false;
		var oiid = $(this).attr("oiid");
		$.ajax({
			type:"POST",
			dataType:"json",
			url:'${deletebuycart}?oiid='+oiid,
			success: function (data) {
	             alert("SUCCESS");

	        },
		});
        $(this).parent().parent().remove();
        window.location.href=page;
	});
	
	$("button.deleteConfirmButton").click(function(){
		deleteOrderItem = true;
		$("#deleteConfirmModal").modal('hide');
	});
	
	$("img.cartProductItemIfSelected").click(function(){
		var selectit = $(this).attr("selectit")
		if("selectit"==selectit){
			$(this).attr("src","<%=basePath%>image/cartNotSelected.png");
			$(this).attr("selectit","false")
			$(this).parents("tr.cartProductItemTR").css("background-color","#fff");
		}
		else{
			$(this).attr("src","<%=basePath%>image/cartSelected.png");
			$(this).attr("selectit","selectit")
			$(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
		}
		syncSelect();
		syncCreateOrderButton();
		calcCartSumPriceAndNumber();
	});
	
	$("img.selectAllItem").click(function(){
		var selectit = $(this).attr("selectit")
		if("selectit"==selectit){
			$("img.selectAllItem").attr("src","<%=basePath%>image/cartNotSelected.png");
			$("img.selectAllItem").attr("selectit","false")
			$(".cartProductItemIfSelected").each(function(){
				$(this).attr("src","<%=basePath%>image/cartNotSelected.png");
				$(this).attr("selectit","false");
				$(this).parents("tr.cartProductItemTR").css("background-color","#fff");
			});			
		}
		else{
			$("img.selectAllItem").attr("src","<%=basePath%>image/cartSelected.png");
			$("img.selectAllItem").attr("selectit","selectit")
			$(".cartProductItemIfSelected").each(function(){
				$(this).attr("src","<%=basePath%>image/cartSelected.png");
				$(this).attr("selectit","selectit");
				$(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
			});				
		}
		syncCreateOrderButton();
		calcCartSumPriceAndNumber();
	});
	
	$(".orderItemNumberSetting").keyup(function(){
		var pid=$(this).attr("pid");
		var stock= $("span.orderItemStock[pid="+pid+"]").text();
		var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
		var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
		num = parseInt(num);
		if(isNaN(num))
			num= 1;
		if(num<=0)
			num = 1;
		if(num>stock)
			num = stock;
		update(pid,num,price);
		syncPrice(pid,num,price);
	});

	$(".numberPlus").click(function(){
		var pid=$(this).attr("pid");
		var stock= $("span.orderItemStock[pid="+pid+"]").text();
		var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
		var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
		
		num++;
		if(num>stock)
			num = stock;
		syncPrice(pid,num,price);
		update(pid,num,price);
	});
	
	$(".numberMinus").click(function(){
		var pid=$(this).attr("pid");
		var stock= $("span.orderItemStock[pid="+pid+"]").text();
		var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
		
		var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
		--num;
		if(num<=0)
			num=1;
		syncPrice(pid,num,price);
		update(pid,num,price);
	});	


	$("button.createOrderButton").click(function(){
		var params = "";
		$(".cartProductItemIfSelected").each(function(){
			if("selectit"==$(this).attr("selectit")){
				var oiid = $(this).attr("oiid");
				var productNumberSetting = $(".orderItemNumberSetting[oiid="+oiid+"]").val();
				params += "&oiid="+oiid;
			}
		});
		params = params.substring(1);
		window.location.href='${forebuy}?'+params;
});

function syncCreateOrderButton(){
	var selectAny = false;
	$(".cartProductItemIfSelected").each(function(){
		if("selectit"==$(this).attr("selectit")){
			selectAny = true;
		}
	});
	
	if(selectAny){
		$("button.createOrderButton").css("background-color","#C40000");
		$("button.createOrderButton").removeAttr("disabled");
	}
	else{
		$("button.createOrderButton").css("background-color","#AAAAAA");
		$("button.createOrderButton").attr("disabled","disabled");		
	}	
}
	
function syncSelect(){
	var selectAll = true;
	$(".cartProductItemIfSelected").each(function(){
		if("false"==$(this).attr("selectit")){
			selectAll = false;
		}
	});
	
	if(selectAll)
		$("img.selectAllItem").attr("src","<%=basePath%>image/cartSelected.png");
	else
		$("img.selectAllItem").attr("src","<%=basePath%>image/cartNotSelected.png");
}

function calcCartSumPriceAndNumber(){
	var sum = 0;
	var totalNumber = 0;
	$("img.cartProductItemIfSelected[selectit='selectit']").each(function(){
		var oiid = $(this).attr("oiid");
		var price =$(".cartProductItemSmallSumPrice[oiid="+oiid+"]").text();
		price = price.replace(/,/g, "");
		price = price.replace(/￥/g, "");
		sum += new Number(price);	
		var num =$(".orderItemNumberSetting[oiid="+oiid+"]").val();
		totalNumber += new Number(num);	
		
	});
	
	$("span.cartSumPrice").html("￥"+sum);
	$("span.cartTitlePrice").html("￥"+sum);
	$("span.cartSumNumber").html(totalNumber);
}


function syncPrice(pid,num,price){
	$(".orderItemNumberSetting[pid="+pid+"]").val(num);
	var cartProductItemSmallSumPrice = num*price; 
	$(".cartProductItemSmallSumPrice[pid="+pid+"]").html("￥"+cartProductItemSmallSumPrice);
	calcCartSumPriceAndNumber();
	var page = "forechangeOrderItem";
}

function update(pid,num,price){
	var submit = document.getElementById('updatebuycart');
	//submit.action='${updatebuycart}?num='+num+'&pid='+pid;
	//submit.submit();
	$.ajax({
		type:"POST",
		dataType:"json",
		url:'${updatebuycart}?num='+num+'&pid='+pid,
		data:$('#updatebuycart').serialize(),
		success: function (data) {
             alert("SUCCESS");
             window.location.href=page;
        },
	});
}

})
</script>	

<title>购物车</title>
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



	


<div class="cartDiv">
	<div class="cartTitle pull-right">
		<span>已选商品  (不含运费)</span>
		<span class="cartTitlePrice">￥0.00</span>
		<button class="createOrderButton" disabled="disabled">结 算</button>
	</div>
	
	
	<div class="cartProductList">
		<table class="cartProductTable">
			<thead>
				<tr>
					<th class="selectAndImage">
							<img selectit="false" class="selectAllItem" src="<%=basePath%>image/cartNotSelected.png">				
					全选
					</th>
					<th>商品信息</th>
					<th>单价</th>
					<th>数量</th>
					<th width="120px">金额</th>
					<th class="operation">操作</th>
				</tr>
			</thead>
			<tbody>
					<c:forEach var="map" items="${productionmap}">
					<tr oiid="${map.value.getId()}" class="cartProductItemTR">
						<td>
							<img selectit="false" oiid="${map.value.getId()}" class="cartProductItemIfSelected" src="<%=basePath%>image/cartNotSelected.png">
							<a style="display:none" href="#nowhere"><img src="<%=basePath%>image/cartSelected.png"></a>
							<img class="cartProductImg"  src="<%=basePath%>${map.key.getImgpath()}">
						</td>
						<td>
							<div class="cartProductLinkOutDiv">
								<a href="<c:url value="/foreproduct?pid=${map.value.getProduction_id()}"></c:url>" class="cartProductLink">${map.key.getName()}</a>
								<div class="cartProductLinkInnerDiv">
									<img src="<%=basePath%>image/forebuy/creditcard.png" title="支持信用卡支付">
									<img src="<%=basePath%>image/forebuy/7day.png" title="消费者保障服务,承诺7天退货">
									<img src="<%=basePath%>image/forebuy/promise.png" title="消费者保障服务,承诺如实描述">
								</div>
							</div>
							
						</td>
						<td>
							<span class="cartProductItemOringalPrice">￥4499.01</span>
							<span  class="cartProductItemPromotionPrice">￥${map.key.getPrice()}</span>
							
						</td>
						<td>
						
							<div class="cartProductChangeNumberDiv">
								<form action="" method="post" id="updatebuycart">
								<span class="hidden orderItemStock " pid="${map.value.getProduction_id()}">${map.key.getStock()}</span>
								<span class="hidden orderItemPromotePrice " pid="${map.value.getProduction_id()}">${map.key.getPrice()}</span>
								<a  pid="${map.value.getProduction_id()}" oiid="${map.value.getId()}" class="numberMinus" href="#nowhere">-</a>
								<input pid="${map.value.getProduction_id()}" oiid="${map.value.getId()}" class="orderItemNumberSetting" autocomplete="off" value="${map.value.getNumber()}">
								<a  stock="${map.key.getStock()}" pid="${map.value.getProduction_id()}" oiid="${map.value.getId()}" class="numberPlus" href="#nowhere">+</a>
								</form>
							</div>					
						
						 </td>
						<td >
							<span class="cartProductItemSmallSumPrice" oiid="${map.value.getId()}" pid="${map.value.getProduction_id()}" >
							￥${map.value.getTotal()}
							</span>
						
						</td>
						<td>
							<a class="deleteOrderItem" oiid="${map.value.getId()}" href="#nowhere">删除</a>
						</td>
					</tr>
					</c:forEach>			
			</tbody>
		</table>
	</div>
	
	<div class="cartFoot">
		<img selectit="false" class="selectAllItem" src="<%=basePath%>image/cartNotSelected.png">
		<span>全选</span>
<!-- 		<a href="#">删除</a> -->
		
		<div class="pull-right">
			<span>已选商品 <span class="cartSumNumber" >0</span> 件</span>
			
			<span>合计 (不含运费): </span> 
			<span class="cartSumPrice" >￥0.00</span>
			<button class="createOrderButton" disabled="disabled" >结  算</button>
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
            <button data-dismiss="modal" class="close" type="button">
            <span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title">确认删除？</h4>
          </div>
          <div class="modal-footer">
            <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
            <button class="btn btn-primary deleteConfirmButton" id="submit" type="button">确认</button>
          </div>
        </div>
      </div>
	</div>
</div>

<div id="footer"  class="footer" style="display: block;">
	
    <div id="footer_ensure" class="footer_ensure">
            <a href="#nowhere">
            	<img src="<%=basePath%>image/you.png"></a>
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
			    <a href="#nowhere" ><img src="<%=basePath%>image/ma.png"></a> 
			</div>
			
    </div>
    
    <div style="clear:both"></div>
    
    
    
    <div id="copyright" class="copyright">
    	<div class="coptyrightMiddle">
    	<img id="cateye" class="cateye" src="<%=basePath%>image/cateye.png">
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
		    	<img src="<%=basePath%>image/wang1.jpg">
		    	<img src="<%=basePath%>image/wang2.jpg">
		    </div>
		</div>
   	 </div>
   </div>
</div>
</body>

<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1273069248'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s13.cnzz.com/stat.php%3Fid%3D1273069248%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>

</html>

