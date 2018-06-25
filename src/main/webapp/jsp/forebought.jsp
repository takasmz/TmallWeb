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
<link href="<%=basePath %>css/core/style.css" rel="stylesheet" >
</head>

<body>
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
	

	$(".wangwanglink").click(function(){
		alert("模仿旺旺的图标，并不会打开旺旺");
	});
	$("a.notImplementLink").click(function(){
		alert("这个功能没做，蛤蛤~");
	});
	
	
})

</script>	
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
	<a href="<%=basePath%>jsp/tmall.jsp">
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



<c:url value="/foredeleteOrder" var="foredeleteOrder" />
<script>
var deleteOrder = false;
var deleteOrderid = 0;

$(function(){
	$("a[orderStatus]").click(function(){
		var orderStatus = $(this).attr("orderStatus");
		if('all'==orderStatus){
			$("table[orderStatus]").show();	
		}
		else{
			$("table[orderStatus]").hide();
			$("table[orderStatus="+orderStatus+"]").show();			
		}
		
		$("div.orderType div").removeClass("selectedOrderType");
		$(this).parent("div").addClass("selectedOrderType");
	});
	
	$("a.deleteOrderLink").click(function(){
		deleteOrderid = $(this).attr("cid");
		deleteOrder = false;
		$("#deleteConfirmModal").modal("show");
	});
	
	$("button.deleteConfirmButton").click(function(){
		deleteOrder = true;
		$("#deleteConfirmModal").modal('hide');
	});	
	
	$('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
		if(deleteOrder){
			$.ajax({
				    url:"${foredeleteOrder}",
				    type:"POST",
				    dataType:"json",
				    data:{"cid":deleteOrderid},
				    error:function(){
						$("table.orderListItemTable[cid="+deleteOrderid+"]").hide();
						//location.reload();
				    }
			});
			
		}
	});
	
	$(".ask2delivery").click(function(){
		var link = $(this).attr("link");
		$(this).hide();
		page = link;
		$.ajax({
			   url: page,
			   success: function(result){
				alert("卖家已秒发，刷新当前页面，即可进行确认收货");
				//setInterval('countDown()',1000);
				           //设置倒计时时间为30秒  
			   }
			});
	});

	
	
});

function countDown() {//倒计时的方法  
	var sec = 10;
	var button = document.getElementById("button");
    if(sec > 0) {  
    	button.innerHTML = sec--;  
    } else {  
    	$.ajax({//倒计时为0进入的页面       
			url:page,
			success:function(){
				button.innerHTML("确认收货");
				}
    		
        	})            
	}
}
</script>	

<script type="text/javascript">

</script>
<div class="boughtDiv">
	<div class="orderType">
		<div class="selectedOrderType"><a orderStatus="all" href="#nowhere">所有订单</a></div>
		<div><a  orderStatus="waitPay" href="#nowhere">待付款</a></div>
		<div><a  orderStatus="waitDelivery" href="#nowhere">待发货</a></div>
		<div><a  orderStatus="waitConfirm" href="#nowhere">待收货</a></div>
		<div><a  orderStatus="waitReview" href="#nowhere" class="noRightborder">待评价</a></div>
		<div class="orderTypeLastOne"><a class="noRightborder">&nbsp;</a></div>
	</div>
	<div style="clear:both"></div>
	<div class="orderListTitle">
		<table class="orderListTitleTable">
			<tr>
				<td>宝贝</td>
				<td width="100px">单价</td>
				<td width="100px">数量</td>
				<td width="120px">实付款</td>
				<td width="100px">交易操作</td>
			</tr>
		</table>	
	</div>	
	<div class="orderListItem">		
		<c:forEach items="${clientnmap}" varStatus="i" var="map">       
			<table class="orderListItemTable" orderStatus="${map.key.getStatus()}" cid="${map.key.getId()}">
				<tr class="orderListItemFirstTR">
					<td colspan="2">
					<b>${map.key.getTime()}</b> 
					<span>订单号: ${map.key.getClient_id()}
					</span>
					</td>
					<td  colspan="2"><img width="13px" src="<%=basePath%>image/orderItemTmall.png">天猫商场</td>
					<td colspan="1">
						<a class="wangwanglink" href="#nowhere">
							<div class="orderItemWangWangGif" style="background-image: url(<%=basePath%>/image/wangwang.gif);"></div>
						</a>						
					</td>
					<td class="orderItemDeleteTD">
						<a class="deleteOrderLink" cid="${map.key.getId()}" href="#nowhere">
							<span  class="orderListItemDelete glyphicon glyphicon-trash"></span>
						</a>						
					</td>
				</tr>
					<c:forEach items="${map.value}" var="promap" varStatus="Index">				
					<tr class="orderItemProductInfoPartTR" >
						<td class="orderItemProductInfoPartTD"><img width="80" height="80" src="<%=basePath%>${promap.key.getImgpath()}"></td>
						<td class="orderItemProductInfoPartTD">
							<div class="orderListItemProductLinkOutDiv">
								<a href="<c:url value="/foreproduct?pid=${promap.key.getId()}"></c:url>">${promap.key.getName() }</a>
								<div class="orderListItemProductLinkInnerDiv">
											<img src="<%=basePath%>image/forebuy/creditcard.png" title="支持信用卡支付">
											<img src="<%=basePath%>image/forebuy/7day.png" title="消费者保障服务,承诺7天退货">
											<img src="<%=basePath%>image/forebuy/promise.png" title="消费者保障服务,承诺如实描述">						
								</div>
							</div>
						</td>
						<td  class="orderItemProductInfoPartTD" width="100px">						
							<div class="orderListItemProductPrice">￥${promap.key.getPrice()}</div>	
						</td>
							<td class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
								<span class="orderListItemNumber">${promap.value}</span>
							</td>
							
							<c:if test="${Index.index==0}">
							<td valign="top" rowspan="${fn:length(map.value)}" width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
								<div class="orderListItemProductRealPrice">￥${map.key.getPayment()}</div>
								<div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
							</td>
							<td valign="top" rowspan="${fn:length(map.value)}" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
									<c:if test="${map.key.getStatus().getName()=='待发货'}">	
									<span>${map.key.getStatus().getName()}</span>
									<button class="btn btn-info btn-sm ask2delivery" id="button" link='<c:url value="/delivery?cid=${map.key.getId()}"></c:url>'>催卖家发货</button>	
									</c:if>	
									<c:if test="${map.key.getStatus().getName()=='待收货'}">		
									<a href="<c:url value="/foreconfirmPay?cid=${map.key.getId()}"></c:url>">			
									<button class="btn btn-info btn-sm confirm" id="button" >确认收货</button>	
									</a>
									</c:if>		
									<c:if test="${map.key.getStatus().getName()=='待付款'}">		
									<a href="<c:url value="/turnforealipay?client_id=${map.key.getClient_id()}"></c:url>">			
									<button class="btn btn-info btn-sm pay" id="button" >去支付</button>	
									</a>
									</c:if>		
									<c:if test="${map.key.getStatus().getName()=='待评价'}">		
									<a href="<c:url value="/forereview?cid=${map.key.getId()}"></c:url>">			
									<button class="btn btn-info btn-sm review" id="button" >去评价</button>	
									</a>
									</c:if>														
							</td>		
							</c:if>										
					</tr>
					</c:forEach>
			</table>		
			</c:forEach>
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
			    <a href="#nowhere" ><img src="<%=basePath%>image/ma.png"></a> 
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
