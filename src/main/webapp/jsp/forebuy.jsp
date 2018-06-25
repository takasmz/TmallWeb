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
function validate_required(field,alerttxt)
{
	var obj = document.getElementById(field);
	//alert(field + obj.value)
	var error = document.getElementById(field+'err');
	//alert(error)
  if (obj.value==null||obj.value==""){
	  //alert(alerttxt)
	error.innerHTML = alerttxt;
	error.style.display = "block";
	obj.focus();
    return 0;
  }else {
    return 1;
  }
}

function validate_form(thisform){
	var check = 0;
	check += validate_required("address","收货地址不能为空");
  	check += validate_required("postal","邮编不能为空");
	check += validate_required("phone","手机号码不能为空");
	check += validate_required("peoplename","姓名不能为空");
	if(check!=4){
		return false;
	}
  	
}
</script>	

</head>

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




<div class="buyPageDiv">
  	<form id="forealipay" action="<c:url value="/forealipay?client_id=${clientid}"  />" onsubmit="return validate_form(this)"  method="post">
  
	<div class="buyFlow">
		<img class="pull-left" src="<%=basePath %>image/forebuy/simpleLogo.png">
		<img class="pull-right" src="<%=basePath %>image/forebuy/buyflow.png">
		<div style="clear:both"></div>
	</div>
	<div class="address">
		<div class="addressTip">输入收货地址</div>
		<div>

			<table class="addressTable">
				<tr>
					<td class="firstColumn">详细地址<span class="redStar">*</span></td>
					<td><textarea id="address" name="address" placeholder="建议您如实填写详细收货地址，例如接到名称，门牌好吗，楼层和房间号等信息"></textarea></td>
				</tr>
					<tr height="10px;"  >
						<td  colspan="2" id="addresserr" class="error" style="color:#C40000;display: none;padding-right: 0px;">
														
						</td>
					</tr>
				<tr>
					<td>邮政编码</td>
					<td><input id="postal" name="postal" placeholder="如果您不清楚邮递区号，请填写000000" type="text"></td>
				</tr>
					<tr height="10px;"  >
						<td  colspan="2" id="postalerr" class="error" style="color:#C40000;display: none;padding-right: 0px;">
							
						</td>
					</tr>
				
				<tr>
					<td>收货人姓名<span class="redStar">*</span></td>
					<td><input id="peoplename" name="peoplename"  placeholder="长度不超过25个字符" type="text"></td>
				</tr>
					<tr height="10px;"  >
						<td  colspan="2" id="peoplenameerr" class="error" style="color:#C40000;display: none;padding-right: 0px;">

						</td>
					</tr>
				<tr>
					<td>手机号码 <span class="redStar">*</span></td>
					<td><input id="phone" name="phone"  placeholder="请输入11位手机号码" type="text"></td>
				</tr>
					<tr height="10px;"  >
						<td  colspan="2" id="phoneerr" class="error" style="color:#C40000;display: none;padding-right: 0px;">

						</td>
					</tr>
			</table>
		</div>
		
	
	</div>
	<div class="productList">
		<div class="productListTip">确认订单信息</div>
		
		
		<table class="productListTable">
			<thead>
				<tr>
					<th colspan="2" class="productListTableFirstColumn">
						<img class="tmallbuy" src="<%=basePath %>image/forebuy/tmallbuy.png">
						<a class="marketLink" href="#nowhere">店铺：天猫店铺</a>
						<a class="wangwanglink" href="#nowhere"> <span class="wangwangGif"></span> </a>
					</th>
					<th>单价</th>
					<th>数量</th>
					<th>小计</th>
					<th>配送方式</th>
				</tr>
				<tr class="rowborder">
					<td  colspan="2" ></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</thead>
			<tbody class="productListTableTbody">
				<c:forEach items="${productionmap}" var="map">
					<tr class="orderItemTR">
						<td class="orderItemFirstTD"><img class="orderItemImg" src="<%=basePath%>${map.key.getImgpath()}"></td>
						<td class="orderItemProductInfo">
						<a  href="<c:url value="/foreproduct?pid=${map.key.getId()}"></c:url>" class="orderItemProductLink">
							${map.key.getName()}
						</a>
						
						
							<img src="<%=basePath %>image/forebuy/creditcard.png" title="支持信用卡支付">
							<img src="<%=basePath %>image/forebuy/7day.png" title="消费者保障服务,承诺7天退货">
							<img src="<%=basePath %>image/forebuy/promise.png" title="消费者保障服务,承诺如实描述">
						
						</td>
						<td>
						
						<span class="orderItemProductPrice">￥${map.key.getPrice()}</span>
						</td>
						<td>
						<span class="orderItemProductNumber">${map.value}</span>
						</td>
						<td><span class="orderItemUnitSum">
						￥${map.key.getPrice() * map.value}
						</span></td>
						
						<td class="orderItemLastTD">
						<label class="orderItemDeliveryLabel">
							<input type="radio" value="" checked="checked">
							普通配送
						</label>
						
						<select class="orderItemDeliverySelect" class="form-control">
							<option>快递 免邮费</option>
						</select>
						</td>
					</tr>
					<c:set var="total" value="${total + map.key.getPrice() * map.value}"></c:set>
				</c:forEach>		
				
			</tbody>
			
		</table>
		<div class="orderItemSumDiv">
			<div class="pull-left">
				<span class="leaveMessageText">给卖家留言:</span>
				<span>
					<img class="leaveMessageImg" src="<%=basePath %>image/forebuy/leaveMessage.png">
				</span>
				<span class="leaveMessageTextareaSpan">
					<textarea name="userMessage" class="leaveMessageTextarea"></textarea>
					<div>
						<span>还可以输入200个字符</span>
					</div>
				</span>
			</div>
			
			<span class="pull-right">店铺合计(含运费): ￥${total}</span>
		</div>
		

				
	
	</div>

	<div class="orderItemTotalSumDiv">
		<div class="pull-right"> 
			<span>实付款：</span>
			<span class="orderItemTotalSumSpan">￥${total}</span>
		</div>
	</div>
	
	<div class="submitOrderDiv">
			<button type="submit" class="submitOrderButton">提交订单</button>
	</div>
  </form>		
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


