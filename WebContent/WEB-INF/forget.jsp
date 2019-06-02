<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>忘记密码</title>
	<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/icon.css"/>
	<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/default/easyui.css"/>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/address.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>

	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/gloab.css" rel="stylesheet">
	<link href="js/index.css" rel="stylesheet">
	<script src="js/register.js"></script>
<script>
$(function(){	
	//第一页的下一步按钮
	//var re = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
	//var email=$("#email").val();
	//失焦事件
	//$("#email").blur(function(){
		//if(re.test(email)){
			$("#btn_part1").click(function(){	
				if(!verifyCheck._click()) return;
				$.post("ZhaoHuiMiMaYanZheng",{
					us_LoginName:$("#adminNo").val(),
					us_ProtecMtel:$("#phone").val()
				},function(res){
					if(res==1){
						$(".part1").hide();		//隐藏功能(将第一个表格隐藏)
						$(".part2").show();		//显示功能
						$(".step li").eq(1).addClass("on");	//页面上的进度条
					}else if(res==2){
						$('#tiShi').html("手机号错误");
					}else if(res==3){
						$('#tiShi').html("用户名不存在");
					}
				},"json");
			});
		/* }else{
			alert("no");
			$("#hint").hide();
			$('#emailHint').html("邮箱格式不正确！");
		}
		}) */

	//第二页的提交按钮
	$("#btn_part2").click(function(){			
		if(!verifyCheck._click()) return;	//判断验证是否完成
		$(".part2").hide();		//隐藏功能(将第一个表格隐藏)
		$(".part3").show();		//显示功能
		$.post("ZhaoHuiMiMa",{
			us_LoginName:$("#adminNo").val(),
			us_PassWord:$("#rePassword").val()
		},function(res){
			$(".step li").eq(2).addClass("on");	//页面上的进度条
			countdown({
				maxTime:10,
				ing:function(c){
					$("#times").text(c);
				},
				after:function(){
					window.location.href="loginJSP";		
				}
			});		
		},"json");
		
	});	
})
</script>
</head>
<body class="bgf4" style="background: url(Images/bg.jpg)">
<div class="login-box f-mt10 f-pb50">
	<div class="main bgf">    
    	<div class="reg-box-pan display-inline">  
        	<div class="step">   
        	<div class="alert alert-info" style="width:700px">尊敬的用户您好：你正在找回密码，请认真填写信息！</div>                   	
                <ul>
                    <li class="col-xs-4 on">
                        <span class="num"><em class="f-r5"></em><i>1</i></span>                	
                        <span class="line_bg lbg-r"></span>
                        <p class="lbg-txt">填写账户信息</p>
                    </li>
                    <li class="col-xs-4">
                        <span class="num"><em class="f-r5"></em><i>2</i></span>
                        <span class="line_bg lbg-l"></span>
                        <span class="line_bg lbg-r"></span>
                        <p class="lbg-txt">请输入新密码</p>
                    </li>
                    <li class="col-xs-4">
                        <span class="num"><em class="f-r5"></em><i>3</i></span>
                        <span class="line_bg lbg-l"></span>
                        <p class="lbg-txt">密码找回成功</p>
                    </li>
                </ul>
            </div>
        	<div class="reg-box" id="verifyCheck" style="margin-top:20px;">
            	<div class="part1">                	
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>用户名：</span>    
                        <div class="f-fl item-ifo">
                            <input type="text" maxlength="20" class="txt03 f-r3 required" tabindex="1" data-valid="isNonEmpty||between:3-20||isUname" data-error="用户名不能为空||用户名长度3-20位||只能输入中文、字母、数字、下划线，且以中文或字母开头" id="adminNo" />                            <span class="ie8 icon-close close hide"></span>
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus"><span>3-20位，中文、字母、数字、下划线的组合，以中文或字母开头</span></label>
                            <label class="focus valid"></label>
                        </div>
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>手机号：</span>    
                        <div class="f-fl item-ifo">
                            <input type="text" class="txt03 f-r3 required" keycodes="tel" tabindex="2" data-valid="isNonEmpty||isPhone" data-error="手机号码不能为空||手机号码格式不正确" maxlength="11" id="phone" /> 
                            <span class="ie8 icon-close close hide"></span>                           
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus">请填写11位有效的手机号码</label>
                            <label class="focus valid"></label>
                        </div>
                    </div>
                 <!--   <div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>邮箱：</span>    
                        <div class="f-fl item-ifo">
                         <input  type="text" class="txt03 f-r3" tabindex="4"  id="email" /> 
                            <span class="ie8 icon-close close hide"></span>                           
                            <label class="icon-sucessfill blank hide"></label>
                            <label id="hint" class="focus">请填写有效的邮箱</label>
                            <label id="emailHint" class="focus"></label>
                        </div>
                    </div> -->
                    <span id="tiShi" style="color: red;margin-left: 100px"></span>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl">&nbsp;</span>    
                        <div class="f-fl item-ifo">
                           <a href="javascript:;" class="btn btn-blue f-r3" id="btn_part1">下一步</a>                         
                        </div>
                    </div> 
                </div>
                <div class="part2" style="display:none">
                	<div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>密码：</span>    
                        <div class="f-fl item-ifo">
                            <input type="password" id="password" maxlength="20" class="txt03 f-r3 required" tabindex="3" style="ime-mode:disabled;" onpaste="return  false" autocomplete="off" data-valid="isNonEmpty||between:6-20||level:2" data-error="密码不能为空||密码长度6-20位||该密码太简单，有被盗风险，建议字母+数字的组合" /> 
                            <span class="ie8 icon-close close hide" style="right:55px"></span>
                            <span class="showpwd" data-eye="password"></span>                        
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus">6-20位英文（区分大小写）、数字、字符的组合</label>
                            <label class="focus valid"></label>
                            <span class="clearfix"></span>
                            <label class="strength">
                            	<span class="f-fl f-size12">安全程度：</span>
                            	<b><i>弱</i><i>中</i><i>强</i></b>
                            </label>    
                        </div>
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>确认密码：</span>    
                        <div class="f-fl item-ifo">
                            <input type="password" maxlength="20" class="txt03 f-r3 required" tabindex="4" style="ime-mode:disabled;" onpaste="return  false" autocomplete="off" data-valid="isNonEmpty||between:6-16||isRepeat:password" data-error="密码不能为空||密码长度6-16位||两次密码输入不一致" id="rePassword" />
                            <span class="ie8 icon-close close hide" style="right:55px"></span>
                            <span class="showpwd" data-eye="rePassword"></span>
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus">请再输入一遍上面的密码</label> 
                            <label class="focus valid"></label>                          
                        </div>
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl">&nbsp;</span>    
                        <div class="f-fl item-ifo">
                           <a href="javascript:;" class="btn btn-blue f-r3" id="btn_part2">提交</a>                         
                        </div>
                    </div> 
                </div>
               
                <div class="part3 text-center" style="display:none">
                	<h3>恭喜您已找回密码成功，现在开始您的上班之旅吧！</h3>
                    <p class="c-666 f-mt30 f-mb50">页面将在 <strong id="times" class="f-size18">10</strong> 秒钟后，跳转到 <a href="loginJSP" class="c-blue">登录页面</a></p>
                </div>          
            </div>
        </div>
    </div>
</div>
</body>
</html>