<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://how2j.cn/study/js/jquery/2.0.0/jquery.min.js"></script>
<link href="http://how2j.cn/study/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="http://how2j.cn/study/js/bootstrap/3.3.6/bootstrap.min.js"></script>

<style>
body{
  font-size:12px;
  font-family: Arial;
  }
a{
  color:#999;
  }
.redColor{
color: #C40000 !important;
}  

.top{
  padding-left:150px;
  padding-right:150px;
  background-color:#f2f2f2;
  padding-top: 5px;
  padding-bottom: 5px;
  border-bottom:1px solid #e7e7e7;
  }
  nav.top span, nav.top a{
color: #999;
é¢è²#999;
margin: 0px 10px 0px 10px;
}
  nav.top a:hover{
color: #C40000;
text-decoration:none;
}
.scarch{
 background-color:#C40000;
margin:50px auto;
width: 400px;
padding: 1px;
height: 40px;
display: block; 
}
.but-search{
        border: 1px solid transparent;
        background-color:#C40000;
		color:White;
		font-size:20px;
		width:110px;
		font-weight: bold;
}

.text-search {
border:1px solid transparent;
width:275px;
height:36px;
margin:1px;
outline:none;
}
.searchBelow{
margin-top: 3px;
margin-left: -20px;
}
.searchBelow span{
color: #999;
}
.searchBelow a{
padding: 0px 20px 0px 20px;
font-size: 14px;
}
img.logo{
position: absolute;
left: 120px;
top: 30px;
z-index:-1;
}

.total{
width:100%;
}

div.total div.header{
background-color:#DD2727;
padding-left:150px;
}

div.shouhou img{
margin:0 auto;
}

div.yewei a.title{
font-size:16px;
color:#646464;
font-weight:bold;
}

div.yewei1{
padding-left:150px;
padding-bottom:20px;
}

div.yewei1 div{
display:inline-block;
width:190px;
height:130px;
text-align:center;
valign:top;
margin:10px 0px;
}
div.yewei1 div a{
text-align:center; 

}

div.weiye2{
background-color:black;
padding-left:150px;
padding-right:150px;
border-top-style:solid;
border-top-color:red;
border-top-width:2px;
}

div.weiye2-1{
padding-top:10px;
padding-bottom:20px;
}

div.weiye2-2{
padding-bottom:10px;
}

div.weiye2 a{
color:white;
font-size:12px;
margin-right:10px;
}

div.weiye2 p{
color:#666666;
}

div.yewei{
position:relative;
top:610px;
}

div.shouhou{
padding-left:150px;
position:relative;
top:580px;
border-top-style:solid;
border-top-color:black;
border-top-width:1px;
border-bottom-style:solid;
border-bottom-color:black;
border-bottom-width:1px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<nav class="top">
<span class = "a1">
  <a href=# class="glyphicon glyphicon-home redColor">å¤©ç«é¦é¡µ</a>
  <span>åµï¼æ¬¢è¿æ¥å°å¤©ç«</span>
  <a href=#>è¯·ç»å½</a>
  <a href=#>åè´¹æ³¨å</a>
  </span>
<span class = "pull-right" >
  <a href=# >æçè®¢å</a>
  <a href=#>è´­ç©è½¦</a>
  </span>
</nav>


<img alt="tmall logo" src="../image/logo.gif" class="logo">
<div class="scarch">
<input type="text" placeholder="å¥³æå   ç·æå" name="search-text" class="text-search">
<button type="submit" class= "but-search">æç´¢</button>
<div class="searchBelow">
<span> <a href="#nowhere"> å¹³è¡¡è½¦ </a> <span>|</span>
</span> <span> <a href="#nowhere"> æ«å°æºå¨äºº </a> <span>|</span>
</span> <span> <a href="#nowhere"> åæ±æº </a> <span>|</span>
</span> <span> <a href="#nowhere"> å°ç®± </a></span>
</div>
</div>
 <div class="shouhou">
       <a href=#><img src="../image/you.png"></a>
    </div>
<div class="yewei">
    <div class="yewei1">
        
        <div class="gouwu">
           <a class="title" href=#>è´­ç©æå</a><br />
           <a href=#>åè´¹æ³¨å</a><br />
           <a href=#>å¼éæ¯ä»å®</a><br />
           <a href=#>æ¯ä»å®åå¼</a><br />
           <span></span><br />
           <br /><br /><br />
        </div>
        
        <div class="baozhang">
        <a class="title" href=#>å¤©ç«ä¿é</a><br />
           <a href=#>åç¥¨ä¿é</a><br />
           <a href=#>å®åè§å</a><br />
           <a href=#>ç¼ºè´§èµä»</a><br />
           <br /><br /><br /><br />
        </div>
        
        <div class="zhifu">
           <a class="title" href=#>æ¯ä»æ¹å¼</a><br />
           <a href=#>å¿«æ·æ¯ä»</a><br />
           <a href=#>ä¿¡ç¨å¡</a><br />
           <a href=#>èèè±å</a><br />
           <a href=#>è´§å°ä»æ¬¾</a><br />
           <br /><br /><br />
        </div>
        
        <div class="fuwu">
           <a class="title" href=#>åå®¶æå¡</a><br />
           <a href=#>åå®¶å¥é©»</a><br />
           <a href=#>åå®¶ä¸­å¿</a><br />
           <a href=#>å¤©ç«æºåº</a><br />
           <a href=#>å¤©ç«è§å</a><br />
           <a href=#>ç©æµæå¡</a><br />
           <a href=#>åµè¨åµè¯­</a><br />
           <a href=#>è¿è¥æå¡</a><br />
        </div>
        
        <div class="shouji">
           <a class="title" href=#>ææºå¤©ç«</a><br />
           <a href=#><img src="../image/ma.png"></a><br />
           <br />
        </div>
    </div>
    
    <div class="weiye2">
        <div class="weiye2-1">
            <a href=#>å³äºå¤©ç«</a>
            <a href=#>å¸®å©ä¸­å¿</a>
            <a href=#>å¼æ¾å¹³å°</a>
            <a href=#>è¯èè±æ</a>
            <a href=#>èç³»æä»¬</a>
            <a href=#>ç½ç«åä½</a>
            <a href=#>æ³å¾è¯´æ</a>
            <a href=#>ç¥è¯äº§æ</a>
            <a href=#>å»æ¿ä¸¾æ¥</a>
        </div> 
       
       <div class="weiye2-2">
            <a href=#>é¿éå·´å·´éå¢</a><span>ä¸¨</span>
            <a href=#>æ·å®ç½</a><span>ä¸¨</span>
            <a href=#>å¤©ç«</a><span>ä¸¨</span>
            <a href=#>èåç®</a><span>ä¸¨</span>
            <a href=#>å¨çéåé</a><span>ä¸¨</span>
            <a href=#>é¿éå·´å·´å½éäº¤æå¸åº</a><span>ä¸¨</span>
            <a href=#>1688</a><span>ä¸¨</span>
            <a href=#>é¿éå¦å¦</a><span>ä¸¨</span>
            <a href=#>é¿éæè¡</a><span>ä¸¨</span>
            <a href=#>é¿éäºè®¡ç®</a><span>ä¸¨</span>
            <a href=#>é¿ééä¿¡</a><span>ä¸¨</span>
            <a href=#>YunOS</a><span>ä¸¨</span>
            <a href=#>é¿éäº</a><span>ä¸¨</span>
            <a href=#>ä¸ç½</a><span>ä¸¨</span>
            <a href=#>é«å¾·</a><span>ä¸¨</span>
            <a href=#>ä¼è§</a><span>ä¸¨</span>
            <a href=#>åç</a><span>ä¸¨</span>
            <a href=#>è¾ç±³</a><span>ä¸¨</span>
            <a href=#>å¤©å¤©å¨å¬</a><span>ä¸¨</span>
            <a href=#>ç½æäºé³ä¹</a><span>ä¸¨</span>
            <a href=#>æ¯ä»å®</a><span>ä¸¨</span>
            <a href=#>è±å</a>
        </div> 
        <p>å¢å¼çµä¿¡ä¸å¡ç»è¥è®¸å¯è¯ï¼ æµB2-20110446 ç½ç»æåç»è¥è®¸å¯è¯ï¼æµç½æ[2015]0295-065å· äºèç½å»çä¿å¥ä¿¡æ¯æå¡ å®¡æ ¸åæä¹¦ æµå«ç½å®¡ã2014ã6å· äºèç½è¯åä¿¡æ¯æå¡èµè´¨è¯ä¹¦ç¼å·ï¼æµ-ï¼ç»è¥æ§ï¼-2012-0005</p>
        <p>Â© 2003-2016 TMALL.COM çæææ</p>
        <img src="../image/wang1.jpg">
        <img src="../image/wang2.jpg">
    </div>
    </div>
</body>
</html>