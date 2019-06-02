<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>修改密码</title>
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
			//提交
			var usersName="${usersName}"
			function tijiao(){	
				//验证输入框的格式是否正确
				if(!verifyCheck._click()) return;
				$.post("updatePwd",{
					usersName:usersName,
					jiuPwd:$("#jiu_Pwd").val(),
					xinPwd:$("#xin_Pwd").val()
				},function(res){
					if(res==1){
						$.post("initSession",{
						},function(res){
							if(res>0){
								$(".part1").hide();		//隐藏功能(将第一个表格隐藏)
								$(".part2").show();		//显示功能
								$(".step li").eq(1).addClass("on");	//页面上的进度条
								countdown({
									maxTime:10,
									ing:function(c){
										$("#times").text(c);
									},
									after:function(){
										
										window.location.href="loginJSP";		
									}
								});	
							}
						},"json");
					}else if(res==2){
						$('#tiShi').html("旧密码不对！");
					}
				},"json");
			}
	

	
</script>
</head>
<body class="bgf4" style="background: url(Images/bg.jpg)">
<div class="login-box f-mt10 f-pb50">
	<div class="main bgf">    
    	<div class="reg-box-pan display-inline">  
        	<div class="step">   
        	<div class="alert alert-info" style="width:700px">尊敬的用户您好：你正在修改密码，请认真填写信息！</div>                   	
                <ul>
                    <li class="col-xs-4 on">
                        <span class="num"><em class="f-r5"></em><i>1</i></span>                	
                        <span class="line_bg lbg-r"></span>
                        <p class="lbg-txt">修改密码</p>
                    </li>
                    <li class="col-xs-4">
                        <span class="num"><em class="f-r5"></em><i>2</i></span>
                        <span class="line_bg lbg-l"></span>
                        <p class="lbg-txt">密码修改成功</p>
                    </li>
                </ul>
            </div>
        	<div class="reg-box" id="verifyCheck" style="margin-top:20px;">
            	<div class="part1">                	
                    <div class="item col-xs-12">
                    	<span class="intelligent-label f-fl"><b class="ftx04">*</b>旧密码：</span>    
                        <div class="f-fl item-ifo">
                            <input type="password" maxlength="20" class="txt03 f-r3 required" tabindex="3"  data-valid="isNonEmpty||between:6-20" data-error="密码不能为空||密码长度6-20位" id="jiu_Pwd" />                            
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus"><span>请输入旧密码</span></label>
                            <label class="focus valid"></label>
                            <span class="clearfix"></span>
                        </div>
                        <span id="tiShi" style="color: red;margin-left: 100px"></span>
                    </div>
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
                            <input type="password" maxlength="20" class="txt03 f-r3 required" tabindex="4" style="ime-mode:disabled;" onpaste="return  false" autocomplete="off" data-valid="isNonEmpty||between:6-16||isRepeat:password" data-error="密码不能为空||密码长度6-16位||两次密码输入不一致" id="xin_Pwd" />
                           	<span class="ie8 icon-close close hide" style="right:55px"></span>
                            <span class="showpwd" data-eye="rePassword"></span>
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus">请再输入一遍上面的密码</label> 
                            <label class="focus valid"></label>                          
                        </div>
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl">&nbsp;</span>    
                        <div class="f-fl item-ifo">
                           <a href="javascript:tijiao();" class="btn btn-blue f-r3" id="btn_part1">提交</a>                         
                        </div>
                    </div> 
                </div>
                <div class="part2" style="display:none">
                	<h3>恭喜您已密码修改成功，现在开始您的上班之旅吧！</h3>
                    <p class="c-666 f-mt30 f-mb50">页面将在 <strong id="times" class="f-size18">10</strong> 秒钟后，跳转到 <a href="loginJSP" class="c-blue">登录页面</a></p>
                </div>          
            </div>
        </div>
    </div>
</div>
</body>
</html>