<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<%=basePath%>js/Tetris.js"></script>  
<title>俄羅斯方塊</title>    
<style>    
            #board tr td{    
                width: 24px;    
                height: 24px;    
            }  
            #main{  
            	display:block;
                float: center;  
                margin: 0 auto;
                width:400px;
                background-image: 
            }  
            #big tr td{
    			box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
            }
            #preBoard tr td{  
                width: 24px;   
                height: 24px;  
                border:1px solid white;
            }  
            #pre{
            	margin-left:20px;
            	width:100px;
            	height:100px;
            	border:solid black 1px;
            	display:inline-block;
            	float: right;  
            	border-radius: 12px;
            }
            #button input{
            background-color: #008CBA; 
    		border: none;
    		color: white;
    		padding: 15px 32px;
    		text-align: center;
    		text-decoration: none;
    		display: inline-block;
    		font-size: 16px;
    		font-weight: bold;
    		border-radius: 12px;
    		-webkit-transition-duration: 0.4s; 
    		transition-duration: 0.4s;
    		box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
    		cursor:pointer;
            }
            #begin input:hover {
            box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
    		background-color: blue;
    		color: white;
			}
			
			}
        </style>   
        <script type="text/javascript">
        //表示页面中的table, 这个table就是将要显示游戏的主面板   
        var tbl;   
        //预览窗口  
        var preTbl;   
        //游戏状态 0: 未开始;1 运行; 2 中止;   
        var status = 0;    
        //定时器, 定时器内将做moveDown操作   
        var timer;   
        //分数   
        var score = 0;   
        var row = 18;
        var col = 10;
        //board是一个row*col的数组,也和页面的table对应.   
        //用来标注那些方格已经被占据. 初始时都为0, 如果被占据则为1   
        var board = new Array(row);   
        //等级
        var level = 1;
        for(var i=0;i<row;i++){   
            board[i] = new Array(col);    
        }   
        for(var i=0;i<row;i++){    
            for(var j=0; j<col; j++){    
                board[i][j] = 0;    
            }    
        }    
            
        //当前活动的方块, 它可以左右下移动, 变型.当它触底后, 将会更新board;   
        var activeBlock;  
        //下一个图形  
        var nextBlock;  
        //下一个图形预览  
        var previewBlock;  
       //生产方块形状, 有7种基本形状.   
        function generateBlock(){    
            var block = new Array(4);    
            //generate a random int number between 0-6;    
            var t = (Math.floor(Math.random()*20)+1)%7;    
            switch(t){  
                case 0:{    
                    block[0] = {x:0, y:4};    
                    block[1] = {x:1, y:4};    
                    block[2] = {x:0, y:5};    
                    block[3] = {x:1, y:5};    
                    break;    
                }    
                case 1:{    
                    block[0] = {x:0, y:3};    
                    block[1] = {x:0, y:4};    
                    block[2] = {x:0, y:5};    
                    block[3] = {x:0, y:6};    
                    break;    
                }    
                case 2:{    
                    block[0] = {x:0, y:5};    
                    block[1] = {x:1, y:4};    
                    block[2] = {x:1, y:5};    
                    block[3] = {x:2, y:4};    
                    break;    
                }    
                case 3:{    
                    block[0] = {x:0, y:4};    
                    block[1] = {x:1, y:4};    
                    block[2] = {x:1, y:5};    
                    block[3] = {x:2, y:5};    
                    break;    
                }    
                case 4:{    
                    block[0] = {x:0, y:4};    
                    block[1] = {x:1, y:4};    
                    block[2] = {x:1, y:5};    
                    block[3] = {x:1, y:6};    
                    break;    
                }    
                case 5:{    
                    block[0] = {x:0, y:4};    
                    block[1] = {x:1, y:4};    
                    block[2] = {x:2, y:4};    
                    block[3] = {x:2, y:5};    
                    break;    
                }    
                case 6:{    
                    block[0] = {x:0, y:5};    
                    block[1] = {x:1, y:4};    
                    block[2] = {x:1, y:5};    
                    block[3] = {x:1, y:6};    
                    break;    
                }   
            }  
            return block;   
        }   
        //向下移动   
        function moveDown(){   
            //检查底边界.   
          if(checkBottomBorder()){    
            //没有触底, 则擦除当前图形,    
              erase();    
              //更新当前图形坐标   
              for(var i=0; i<4; i++){   
                  activeBlock[i].x = activeBlock[i].x + 1;    
              }   
              //重画当前图形   
              paint();    
          }   
          //触底,    
          else{   
            //停止当前的定时器, 也就是停止自动向下移动.   
            clearInterval(timer);   
            //更新board数组.   
            updateBoard();   
            //消行   
            var lines = deleteLine();   
            //如果有消行, 则   
            if(lines!=0){   
                //更新分数   
                //一次消多行则分数加倍  
                if(lines==2){  
                    lines=3;  
                }  
                else if(lines==3){  
                    lines=6;  
                }  
                else if(lines==4){  
                    lines=10;  
                }  
                score = score + lines;
                level = Math.floor(score/20+1);
                document.getElementById("level").innerText=level;
                updateScore();  
                //擦除整个面板   
                eraseBoard();   
                //重绘面板   
                paintBoard();   
            }  
            erasePreview();  
            //产生一个新图形并判断是否可以放在最初的位置.   
            if(!validateBlock(nextBlock)){  
                alert("Game over!");   
                status = 2;  
                return;   
            };  
            activeBlock = nextBlock;  
            nextBlock = generateBlock();  
            previewBlock = copyBlock(nextBlock);  
            paint();  
            //定时器, 每隔一秒执行一次moveDown  
            applyPreview();  
            paintPreview();  
            timer = setInterval(moveDown,1100-(level*100))   
          }    
        }  
        
        //判断方格是否占用
        function validateBlock(block){  
            if(!block){  
                return false;  
            }  
          for(var i=0; i<4; i++){   
              if(!isCellValid(block[i].x, block[i].y)){  
                  return false;   
              }   
          }  
          return true;  
        }  
          
        //左移动   
        function moveLeft(){   
            if(checkLeftBorder()){    
                erase();    
                for(var i=0; i<4; i++){    
                    activeBlock[i].y = activeBlock[i].y - 1;    
                }    
                paint();    
            }    
        }    
        //右移动   
        function moveRight(){    
            if(checkRightBorder()){    
                erase();    
                for(var i=0; i<4; i++){    
                    activeBlock[i].y = activeBlock[i].y + 1;    
                }    
                paint();    
            }    
        }    
        //旋转, 因为旋转之后可能会有方格覆盖已有的方格.   
        //先用一个tmpBlock,把activeBlock的内容都拷贝到tmpBlock,   
        //对tmpBlock尝试旋转, 如果旋转后检测发现没有方格产生冲突,则   
        //把旋转后的tmpBlock的值给activeBlock.   
        function rotate(){    
            var tmpBlock = copyBlock(activeBlock);   
            //先算四个点的中心点，则这四个点围绕中心旋转90度。  
            var cx = Math.round((tmpBlock[0].x + tmpBlock[1].x + tmpBlock[2].x + tmpBlock[3].x)/4);    
            var cy = Math.round((tmpBlock[0].y + tmpBlock[1].y + tmpBlock[2].y + tmpBlock[3].y)/4);    
            //旋转的主要算法可以这样分解来理解。  
            //先假设围绕源点旋转,然后再加上中心点的坐标。  
            for(var i=0; i<4; i++){    
                tmpBlock[i].x = cx+cy-activeBlock[i].y;   
                tmpBlock[i].y = cy-cx+activeBlock[i].x;   
            }    
            //检查旋转后方格是否合法.   
            for(var i=0; i<4; i++){    
                if(!isCellValid(tmpBlock[i].x,tmpBlock[i].y)){   
                    return;   
                }   
            }   
            //如果合法, 擦除   
            erase();    
            //对activeBlock重新赋值.   
            for(var i=0; i<4; i++){    
                activeBlock[i].x = tmpBlock[i].x;    
                activeBlock[i].y = tmpBlock[i].y;    
            }   
            //重画.   
            paint();    
        }    
        //检查左边界,尝试着朝左边移动一个,看是否合法.   
        function checkLeftBorder(){    
            for(var i=0; i<activeBlock.length; i++){    
                if(activeBlock[i].y==0){    
                    return false;    
                }    
                if(!isCellValid(activeBlock[i].x, activeBlock[i].y-1)){    
                    return false;    
                }    
            }    
            return true;    
        }    
        //检查右边界,尝试着朝右边移动一个,看是否合法.   
        function checkRightBorder(){    
            for(var i=0; i<activeBlock.length; i++){    
                if(activeBlock[i].y==col-1){    
                    return false;    
                }    
                if(!isCellValid(activeBlock[i].x, activeBlock[i].y+1)){    
                    return false;    
                }    
            }    
            return true;    
        }    
        //检查底边界,尝试着朝下边移动一个,看是否合法.   
        function checkBottomBorder(){    
            for(var i=0; i<activeBlock.length; i++){    
                if(activeBlock[i].x==row-1){    
                    return false;    
                }    
                if(!isCellValid(activeBlock[i].x+1, activeBlock[i].y)){    
                    return false;    
                }    
            }    
            return true;    
        }    
        //检查坐标为(x,y)的是否在board种已经存在, 存在说明这个方格不合法.   
        function isCellValid(x, y){    
            if(x>row-1||x<0||y>col-1||y<0){    
                return false;    
            }    
            if(board[x][y]==1){    
                return false;    
            }    
            return true;    
        }    
                //擦除   
        function erase(){    
            for(var i=0; i<4; i++){    
                tbl.rows[activeBlock[i].x].cells[activeBlock[i].y].style.backgroundColor="white";    
            }    
        }    
        //绘活动图形   
        function paint(){    
            for(var i=0; i<4; i++){    
                tbl.rows[activeBlock[i].x].cells[activeBlock[i].y].style.backgroundColor="red";    
            }    
        }  
        //绘预览图形  
        function paintPreview(){  
            for(var i=0; i<4; i++){  
                preTbl.rows[previewBlock[i].x].cells[previewBlock[i].y].style.backgroundColor="red";  
            }  
        }  
        //擦除预览图形  
        function erasePreview(){  
            for(var i=0; i<4; i++){  
                preTbl.rows[previewBlock[i].x].cells[previewBlock[i].y].style.backgroundColor="white";  
            }  
        }  
          
        //更新board数组   
        function updateBoard(){    
            for(var i=0; i<4; i++){    
                board[activeBlock[i].x][activeBlock[i].y]=1;    
            }    
        }   
        //消行   
        function deleteLine(){   
            var lines = 0;   
            for(var i=0; i<row; i++){   
                var j=0;   
                for(; j<col; j++){   
                    if(board[i][j]==0){   
                        break;   
                    }
                }   
                if(j==col){   
                    lines++;   
                    if(i!=0){
                        for(var k=i-1; k>=0; k--){   
                            board[k+1] = board[k];   
                        }   
                    }   
                    board[0] = generateBlankLine();   
                }   
            }   
            return lines;   
        }   
        //擦除整个面板   
        function eraseBoard(){   
            for(var i=0; i<row; i++){   
                for(var j=0; j<col; j++){   
                    tbl.rows[i].cells[j].style.backgroundColor = "white";   
                }   
            }   
        }   
        //重绘整个面板   
        function paintBoard(){   
        	
            for(var i=0;i<row;i++){   
                for(var j=0; j<col; j++){    
                  if(board[i][j]==1){   
                    tbl.rows[i].cells[j].style.backgroundColor = "red";   
                  }   
                }    
            }    
        }   
        //产生一个空白行.   
        function generateBlankLine(){   
            var line = new Array(col);   
            for(var i=0; i<col; i++){   
            	line[i] = 0;   
            }   
            return line;   
        }   
        //更新分数  
        function updateScore(){  
            document.getElementById("score").innerText=" " + score;  
        }  
        //键盘控制   
        function keyControl(){    
            if(status!=1){   
                return;   
            }    
            var code = event.keyCode;    
            switch(code){    
                case 37:{   
                    moveLeft();   
                    break;    
                }    
                case 38:{   
                    rotate();    
                    break;    
                }    
                case 39:{    
                    moveRight();    
                    break;   
                }    
                case 40:{    
                    moveDown();    
                    break;    
                }    
            }    
        }  
        //辅助函数，拷贝一个图形。  
        function copyBlock(old){  
            var o = new Array(4);  
                    for(var i=0; i<4; i++){    
                o[i] = {x:0, y:0};    
          }  
          for(var i=0; i<4; i++){    
                      o[i].x = old[i].x;    
                      o[i].y = old[i].y;    
                    }  
                    return o;  
        }  
        //调整previewBlock的坐标以适应预览窗口  
        function applyPreview(){  
                var t = 100;  
                for(var i=0; i<4; i++){  
                    if(previewBlock[i].y<t){  
                        t = previewBlock[i].y;  
                    }  
                }  
                for(var i=0; i<4; i++){  
                    previewBlock[i].y-=t;  
                }  
                  
        }  
          
        //开始  
        function begin(e){   
                e.disabled = true;   
            status = 1;    
            tbl = document.getElementById("board");  
            preTbl = document.getElementById("preBoard");  
            activeBlock = generateBlock();  
            nextBlock = generateBlock();  
            previewBlock = copyBlock(nextBlock);  
            applyPreview();  
            paint();  
            paintPreview();  
            timer = setInterval(moveDown,1100-(level*100));   
        } 
        
        //暂停
        function pause(e){
        	status = 2;
        	var button = document.getElementById("pause");
        	button.value="继续";
        	button.onclick=function(){
        		Continue(e);
        	};
        	clearInterval(timer);
        }
        
        //继续
        function Continue(e){
        	status = 1;
        	var button = document.getElementById("pause");
        	button.value="暂停";
        	button.onclick=function(){
        		pause(e);
        	};
        	timer = setInterval(moveDown,1100-(level*100)); 
        }
        
        //复位
        function rebegin(e){
        	window.location.reload();
        }
        document.onkeydown=keyControl;
        </script> 
</head>       
    <body>
    <div id="main">
        <h3>俄羅斯方塊遊戲</h3>
        <p>方向鍵控制，↑变形，←向左移动，→向右移动，↓向下移动,每20分等级上升</p>
        <br><br>
        <div id="big" style="display:inline-block">	
        <table id="board" cellspacing=0 cellpadding=0 border=1 style="border-collapse:collapse;">   
        <c:forEach begin="1" end="18">
        	<tr>    
               <c:forEach begin="1" end="10">
               	<td></td>
               </c:forEach>
            </tr>    
        </c:forEach> 
        </table>    
        
        </div>
        <div id="pre" >  
            <table id="preBoard" cellspacing=0 cellpadding=0  style="border-collapse:collapse;margin-left:30px;margin-top:10px; ">  
                <c:forEach begin="1" end="4">
        	<tr>    
               <c:forEach begin="1" end="4">
               	<td></td>
               </c:forEach>
            </tr>    
        </c:forEach> 
            </table>  
            <div id="button">
            	<div style="text-align: center;">Level:<br><span id="level">1</span></div><br>
            	<div style="text-align: center;">Score:<br><span id="score">0</span></div><br>
            	<div style="text-align: center;">
            		<Input id="begin" type="button" value="开始" onclick="begin(this);" />
            	</div>
            	<br>
            	<div style="text-align: center;">
            		<Input id="pause" type="button" value="暂停" onclick="pause(this);" />
            	</div>
            	<br>
            	<div style="text-align: center;">
            		<Input id="rebegin" type="button" value="复位" onclick="rebegin(this);" />
            	</div>
            </div>
        </div> 
        
        </div>
    </body>    
</html>  
