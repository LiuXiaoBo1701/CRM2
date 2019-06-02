<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>CRM登录页面</title>
	<link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <link href="css/index.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>  
    <script type="text/javascript">
    $(function(){
    	// 获取cookie的值
    	var loginName = getCookie("name");
    	
    	// 当cookie有值才进行赋值操作
    	if (loginName != null && loginName != "" && loginName != undefined) {
	    	$("#us_LoginName").textbox("setValue",loginName);
    	}
    })
    
    // 获取指定名称的cookie
    function getCookie(cookie_name) {
        var allcookies = document.cookie;
        //索引长度，开始索引的位置
        var cookie_pos = allcookies.indexOf(cookie_name);

        // 如果找到了索引，就代表cookie存在,否则不存在
        if (cookie_pos != -1) {
            // 把cookie_pos放在值的开始，只要给值加1即可
            //计算取cookie值得开始索引，加的1为“=”
            cookie_pos = cookie_pos + cookie_name.length + 1; 
            //计算取cookie值得结束索引
            var cookie_end = allcookies.indexOf(";", cookie_pos);
            
            if (cookie_end == -1) {
                cookie_end = allcookies.length;
            }
            //得到想要的cookie的值
            var value = unescape(allcookies.substring(cookie_pos, cookie_end)); 
        }
        return value;
    }

    </script>
</head>
<body>
<div class="bg" style="background: url(Images/bg.jpg)">
<div class="container" style="margin-top: -50px">
    <div class="line bouncein">
        <div class="xs6 xm4 xs3-move xm4-move">
            <div style="height:150px;"></div>
            <div class="media media-y margin-big-bottom">           
            </div>         
            <form action="selectUserRolesLogin" method="post">
            <div class="panel loginbox">
                <div class="text-center margin-big padding-big-top"><h1>CRM后台管理中心</h1></div>
                <div class="panel-body" style="padding:30px; padding-bottom:10px; padding-top:10px;">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input input-big" id="us_LoginName" name="us_LoginName" placeholder="登录账号" data-validate="required:请填写账号" />
                            <span class="icon icon-user margin-small"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="password" class="input input-big" name="us_PassWord" placeholder="请输入6-16位数密码 "  minlength="6" maxlength="16"  data-validate="required:请填写密码" />
                            <span class="icon icon-key margin-small"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="field">
                            <input type="text" class="input input-big"  name="yanzheng"  placeholder="填写右侧的验证码" data-validate="required:请填写右侧的验证码" />
                           <img alt="random" src="checkCode"  width="100" height="32" class="passcode" style="height:43px;cursor:pointer;" onclick="this.src=this.src+'?'">  
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="field">
                        <span style="color: red;">${msg}</span>
						</div>
                    </div>    
                    <div class="form-group">
                        <div class="field">
                        <input type="checkbox"  name="dl">记住账号
						<a href="forgetjsp" style="margin-left: 190px">忘记密码</a>
						</div>
                    </div>    
                </div>
                <div style="padding:30px;"><input type="submit" class="button button-block bg-main text-big input-big" value="登录"></div>
            </div>
            </form>          
        </div>
    </div>
</div>
</div>
</body>
</html>