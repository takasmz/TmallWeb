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
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/tmall-Homepage.css">

<c:url value="/tmall" var="tmall"/>
<script>
$(function(){
	if("${typelist}"==null || "${typelist}"== ""){
		window.location.href="${tmall}";
		}
	
	var id;
	var x;
	
	$("div.heng-fenlei span").mouseenter(function(){
		var left = $(this).position().left;
		var top = $(this).position().top;
		var width = $(this).css("width");
		var desLeft = parseInt(left) + parseInt(width)/2;
		$("img#catear").css("left",destLeft);
		$("img#catear").css("top",top-20);
		$("img#catear").fadeIn(500);
	})
	
	$("div.heng-fenlei span").mouseleave(function(){
		$("img#catear").hide();
	})
	
	$("div.productsAsideCategorys").hide();
	
	$("div.shu-fenlei div.eachproduct").mouseenter(function(){
		id = $(this).index();
		x = $("div.productsAsideCategorys").get(id);
		$(x).show();
	})
	
	$("div.eachproduct").mouseleave(function(){	
		$(x).hide();
	})
	
	$("div.productsAsideCategorys").mouseenter(function(){
		$(this).show();
	})
	
	$("div.productsAsideCategorys").mouseleave(function(){
		$(this).hide();
	})

})

</script>
</head>
<body>

<nav class="top">
<span class = "a1">
  <a href="<%=basePath %>/jsp/tmall.jsp" class="glyphicon glyphicon-home redColor">天猫首页</a>
  <span>喵，欢迎来到天猫</span>
  <c:if test="${username != null}">
  	${username} 欢迎您
  </c:if>
  <c:if test="${username == null}">
	<a href="<%=basePath%>/jsp/login.jsp">请登录</a>
  </c:if>
  
  <a href="<%=basePath %>/jsp/register.jsp">免费注册</a>
  </span>
<span class = "pull-right" >
  <a href="<c:url value="/forebought"></c:url>" >我的订单</a>
  <a href="<c:url value="/buycart"></c:url>">
	<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
	购物车<strong>${buycartcount}</strong>件</a>	
  </span>
</nav>



<img alt="tmall logo" src="<%=basePath%>/image/logo.gif" class="logo">
<div class="scarch">
<input type="text" placeholder="女朋友   男朋友" name="search-text" class="text-search">
<button type="submit" class= "but-search">搜索</button>
<div class="searchBelow">
<span> <a href="<c:url value="/forecategory?tid=5"></c:url>"> 平衡车 </a> <span>|</span>
</span> <span> <a href="#nowhere"> 扫地机器人 </a> <span>|</span>
</span> <span> <a href="#nowhere"> 原汁机 </a> <span>|</span>
</span> <span> <a href="#nowhere"> 冰箱 </a></span>
</div>
</div>

<div class="total">
   <div class="header">
    <div class="spfl" >
        <span class="glyphicon glyphicon-th-list" style="margin-left:10px"></span>
        <span style="margin-left:10px ">商品分类</span>
    </div>
    
    <div class="heng-fenlei">    
        <a href=#><img src="<%=basePath%>/image/chaoshi.png"></a>
        <a href=#><img src="<%=basePath%>/image/guoji.png"></a>
        <span><a href="<c:url value="/forecategory?tid=1"></c:url>">平板电视</a></span>
        <span><a href=<c:url value="/forecategory?tid=2"></c:url>>马桶</a></span>
        <span><a href=<c:url value="/forecategory?tid=3"></c:url>>沙发</a></span>
        <span><a href=<c:url value="/forecategory?tid=4"></c:url>>电热水器</a></span>
    </div>
</div>

<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
    <li data-target="#carousel-example-generic" data-slide-to="3"></li>
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

<div class="shu-fenlei" id="menuList">
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href="<c:url value="/forecategory?tid=1"></c:url>">平板电视</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=<c:url value="/forecategory?tid=2"></c:url>>马桶</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=<c:url value="/forecategory?tid=3"></c:url>>沙发</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=<c:url value="/forecategory?tid=4"></c:url>>电热水器</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=<c:url value="/forecategory?tid=5"></c:url>>平衡车</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=#>扫地机器人</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=#>原汁机</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=#>冰箱</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=#>空调</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=#>女表</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=#>男表</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=#>男包</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=#>女包</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=#>男装</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=#>女装</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=#>女鞋</a>
    </div>
    <div class="eachproduct">
       <span class="glyphicon glyphicon-link"></span>
       <a href=#>男鞋</a>
    </div>
</div>
    
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>高性价比</a>
             <a href=#>纳米自洁釉</a>
             <a href=#>盖板易拆</a>
             <a href=#>领券更优惠</a>
             <a href=#>全国联保</a>   
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>咨询大惊喜</a>
             <a href=#>全自动感应</a>
             <a href=#>即热式功能</a>
             <a href=#>智能护理</a>
             <a href=#>官方正品</a>
             <a href=#>高效节水</a>
             <a href=#>立减300</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>官方正品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>
<div style="position:relative;left:0;top:0;">
       <div class="productsAsideCategorys">
          <div class="row">
             <a href=#>屏大影院</a>
             <a href=#>周末</a>
             <a href=#>新品特惠</a>
             <a href=#>32小时电视机</a>
             <a href=#>智能网络</a>
             <div class="seperator"></div>
          </div>
          <div class="row">
             <a href=#>USB高清</a>
             <a href=#>芒果TV在线</a>
             <a href=#>抢购价</a>
             <a href=#>USB解码</a>
             <a href=#>32英时</a>
             <a href=#>10核</a>
             <a href=#>TCL品牌日</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>不要赠品</a>
             <a href=#>新品上市</a>
             <a href=#>4K硬屏</a>
             <a href=#>领100元劵</a>
             <a href=#>智能高清</a>
             <a href=#>8月、酷暑</a>
             <a href=#>8月大促</a>
             <a href=#>天猫定制</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>智能操作系统</a>
             <a href=#>金色外观</a>
             <a href=#>三星屏幕</a>
             <a href=#>客厅爆款</a>
             <a href=#>八核配置</a>
             <a href=#>限时促销</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>限时特惠</a>
             <a href=#>热销爆款</a>
             <a href=#>4K全高清</a>
             <a href=#>六核智能</a>
             <a href=#>14核4K</a>
             <a href=#>YUNOS</a>
             <a href=#>YUNOS</a>
             <a href=#>64位处理器</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>YUNOS</a>
             <a href=#>微信电视</a>
             <a href=#>4K超清</a>
             <a href=#>64位真4K</a>
             <a href=#>10核机芯</a>
             <a href=#>V字黑轴底座</a>
             <a href=#>4K超清</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>64位14核</a>
             <a href=#>海鳗影视</a>
             <a href=#>人气爆款</a>
             <a href=#>限时特惠</a>
             <a href=#>真4K屛</a>
             <a href=#>65寸巨屛</a>
             <a href=#>4K超清视界</a>
             <a href=#>限时特惠</a>
             <div class="seperator"></div>
          </div>
          
          <div class="row">
             <a href=#>55寸旗舰</a>
             <a href=#>4K机皇</a>
             <a href=#>曲面机皇</a>
             <a href=#>轻薄4K</a>
             <div class="seperator"></div>
          </div>
       </div>
</div>


<div class="product-list">

<c:forEach items="${typelist}" var="type">
   <div class="tablet-pc">
       <div class="left-mark"></div>
       <span class="cate">${type.getName()}<br /></span>
       <c:forEach items="${type.getListproduction()}" var="production" begin="0" end="4">
          <div class="product" >
          <a href="<c:url value="/foreproduct?pid=${production.getId()}"></c:url>" ><img alt="${type.getName()}" src="<%=basePath%>${production.getImgpath()}.jpg"/></a>
          <span class="productitem">[热销]${production.getName()}<br /></span>
          <span class="price" >${production.getPrice()}</span>
          </div>
          </c:forEach>
       </div>
       </c:forEach>
       <img class="endpng" src="<%=basePath%>/image/end.png" >
    </div>
    
    
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


