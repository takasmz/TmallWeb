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
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/register.css">


<script type="text/javascript">
function validate_required(field,alerttxt)
{
with (field)
  {
  if (value==null||value=="")
    {document.getElementById(field).style.visibility	
	    ;return false}
  else {return true}
  }
}

function validate_form(thisform)
{
with (thisform)
  {
  if (validate_required(mail,"邮箱不能为空")==false)
    {mail.focus();return false}
  }
}
</script>

<title>注册</title>
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
<img alt="tmall logo" src="<%=basePath%>/image/logo.gif" class="logo">
<form action="<c:url value="/search"/>" method="post" >		
<div class="scarch">
	<input type="text" placeholder="女朋友   男朋友" name="keyword" class="text-search">
	<button type="submit" class= "but-search">搜索</button>
	<div class="searchBelow">
		<span> <a href="#nowhere"> 平衡车 </a> <span>|</span>
		</span> <span> <a href="#nowhere"> 扫地机器人 </a> <span>|</span>
		</span> <span> <a href="#nowhere"> 原汁机 </a> <span>|</span>
		</span> <span> <a href="#nowhere"> 冰箱 </a></span>
	</div>
</div>
</form>
    
<div id="register-page" >
	<form id="register" action="<c:url value="/register" />" method="post" onsubmit="return validate_form(this)">
	<table id="register-table" >
			<tr id="register-title" style="">
				<td>注册</td>
			</tr>
			<tr>
				<td>登录名：</td> 
				<td><input type="text" placeholder="登录名一旦设置成功，无法修改" name="username" id="uesrname" ></td>
			</tr>
			<c:if test="${!empty errorusername}">
			<tr height="10px;">
				<td  colspan="2" id="error-username" class="error" 
				style="color:#C40000">
				<%=session.getAttribute("errorusername") %>
				</td>
			</tr>
			</c:if>
			<tr>
				<td>昵称：</td>
				<td><input type="text" placeholder="设置你的昵称" name="nickname" id="nickname" ></td>
			</tr>
			<c:if test="${!empty errornickname}">
				<tr>
					<td  colspan="2" id="error-nickname" class="error" 
					style="color:#C40000;">
					<%=session.getAttribute("errornickname") %>
					</td>
				</tr>
			</c:if>
			<tr>
				<td>登录密码：</td>
				<td><input type="password" placeholder="设置你的登录密码" name="password" id="password" ></td>
			</tr>
			<c:if test="${!empty errorpassword}">
				<tr><td  colspan="2" id="error-password" class="error" 
						style="color:#C40000;">
						<%=session.getAttribute("errorpassword") %>
				</td></tr>
			</c:if>
			<tr>
				<td>确认密码：</td>
				<td><input type="password" placeholder="确认你的登录密码" name="password1" id="password1" ></td>
			</tr>
			<c:if test="${!empty errorpassword2}">
				<tr>
					<td  colspan="2" id="error-password2" class="error" 
					style="color:#C40000">
					<%=session.getAttribute("errorpassword2") %>
					</td>
				</tr>
			</c:if>
			<tr>
				<td>邮箱：</td>
				<td><input type="email" placeholder="请输入你的邮箱" name="mail" id="mail" ></td>
			</tr>
			<c:if test="${!empty errormail}">
				<tr>
					<td  colspan="2" id="error-mail" class="error" 
					style="color:#C40000">
					<%=session.getAttribute("errormail") %>
					</td>
				</tr>
			</c:if>
			<tr></tr>
			<tr>
				<td id="register-td" colspan="2">
				<input id="register-button" type="submit" value="注册" name="login" ></td>
			</tr>
		</table>
		
	</form>
</div>
<div id="end-page">
<div class="shouhou">
       <a href=#><img src="<%=basePath%>/image/you.png"></a>
    </div>
<div class="yewei">
    <div class="yewei1">
        
        <div class="gouwu">
           <a class="title" href=#>购物指南</a><br />
           <a href=#>免费注册</a><br />
           <a href=#>开通支付宝</a><br />
           <a href=#>支付宝充值</a><br />
           <span></span><br />
           <br /><br /><br />
        </div>
        
        <div class="baozhang">
        <a class="title" href=#>天猫保障</a><br />
           <a href=#>发票保障</a><br />
           <a href=#>售后规则</a><br />
           <a href=#>缺货赔付</a><br />
           <br /><br /><br /><br />
        </div>
        
        <div class="zhifu">
           <a class="title" href=#>支付方式</a><br />
           <a href=#>快捷支付</a><br />
           <a href=#>信用卡</a><br />
           <a href=#>蚂蚁花呗</a><br />
           <a href=#>货到付款</a><br />
           <br /><br /><br />
        </div>
        
        <div class="fuwu">
           <a class="title" href=#>商家服务</a><br />
           <a href=#>商家入驻</a><br />
           <a href=#>商家中心</a><br />
           <a href=#>天猫智库</a><br />
           <a href=#>天猫规则</a><br />
           <a href=#>物流服务</a><br />
           <a href=#>喵言喵语</a><br />
           <a href=#>运营服务</a><br />
        </div>
        
        <div class="shouji">
           <a class="title" href=#>手机天猫</a><br />
           <a href=#><img src="<%=basePath%>/image/ma.png"></a><br />
           <br />
        </div>
    </div>
    
    <div class="weiye2">
        <div class="weiye2-1">
            <a href=#>关于天猫</a>
            <a href=#>帮助中心</a>
            <a href=#>开放平台</a>
            <a href=#>诚聘英才</a>
            <a href=#>联系我们</a>
            <a href=#>网站合作</a>
            <a href=#>法律说明</a>
            <a href=#>知识产权</a>
            <a href=#>廉政举报</a>
        </div> 
       
       <div class="weiye2-2">
            <a href=#>阿里巴巴集团</a><span>丨</span>
            <a href=#>淘宝网</a><span>丨</span>
            <a href=#>天猫</a><span>丨</span>
            <a href=#>聚划算</a><span>丨</span>
            <a href=#>全球速卖通</a><span>丨</span>
            <a href=#>阿里巴巴国际交易市场</a><span>丨</span>
            <a href=#>1688</a><span>丨</span>
            <a href=#>阿里妈妈</a><span>丨</span>
            <a href=#>阿里旅行</a><span>丨</span>
            <a href=#>阿里云计算</a><span>丨</span>
            <a href=#>阿里通信</a><span>丨</span>
            <a href=#>YunOS</a><span>丨</span>
            <a href=#>阿里云</a><span>丨</span>
            <a href=#>万网</a><span>丨</span>
            <a href=#>高德</a><span>丨</span>
            <a href=#>优视</a><span>丨</span>
            <a href=#>友盟</a><span>丨</span>
            <a href=#>虾米</a><span>丨</span>
            <a href=#>天天动听</a><span>丨</span>
            <a href=#>网易云音乐</a><span>丨</span>
            <a href=#>支付宝</a><span>丨</span>
            <a href=#>花呗</a>
        </div> 
        <p>增值电信业务经营许可证： 浙B2-20110446 网络文化经营许可证：浙网文[2015]0295-065号 互联网医疗保健信息服务 审核同意书 浙卫网审【2014】6号 互联网药品信息服务资质证书编号：浙-（经营性）-2012-0005</p>
        <p>© 2003-2016 TMALL.COM 版权所有</p>
        <img src="<%=basePath%>/image/wang1.jpg">
        <img src="<%=basePath%>/image/wang2.jpg">
    </div>
    </div>
</div>
</body>
</html>