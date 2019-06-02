<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>CRM首页</title>
	<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/icon.css"/>
	<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/metro/easyui.css"/>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" href="js/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="css/global.css" media="all">
	<script type="text/javascript" src="js/layui/layui.js"></script>
	<script src="js/index.js"></script>
	<script type="text/javascript" src="js/echarts.js"></script>
	<script src="js/echarts/esl.js"></script>
    <script src="js/echarts/config.js"></script> 
    <script src="js/echarts/pie-texture.js"></script>
    <script src="js/echarts/dat.gui.min.js"></script>
    <link rel="stylesheet" href="js/echarts/reset.css" />
    <script src="js/echarts/testHelper.js"></script>s
	<script type="text/javascript">
		//信息通知
		var JieShouRen='${usersName}';
		var webscoket=new WebSocket("ws:localhost:8080/CRM/webscoket/"+JieShouRen);
		webscoket.onmessage=function(event){
		 	$.messager.show({
		 		title:'新信息',
		 		msg:event.data,
		 		timeout:50000,
		 		showType:'slide'
		 	});
	
		 };

	//树形结构显示
	$(function() {
		//客户来源
		SourceUrl();
		//签到按钮
		$("#yiqiandao").hide();		//隐藏功能(将第一个表格隐藏)
		$("#qiandao").show();		//显示功能
		
		var usersName= '<%=session.getAttribute("usersName")  %>';
		$("#spUName").text(usersName);
		var usersId= '<%=session.getAttribute("usersId")  %>';
			if(usersId!=null){
				$("#menuTree").tree({
					url:'selectModulesById',
					method:'post',
					lines:true,		//定义是否显示树控件上的虚线。
					animate:true,	//定义节点在展开或折叠的时候是否显示动画效果。
					queryParams:{
						usersId:usersId
					},
					onClick: function(node) {
						var flag = $('#tt').tabs('exists', node.text);
						var isLeaf = $('#menuTree').tree('isLeaf', node.target); //是否是叶子节点
						if(isLeaf) { //只有叶子节点才会在选项卡中创建选项页（每个选项页对应1个功能）
							if(!flag) {
								$('#tt').tabs('add', { //在选项卡中，创建1个选项页
									title: node.text, //选项卡中，选项页的标题（在同一个选项卡中，选项页需要保持一致）。
									closable: true,
									content: "<iframe  width='100%' height='700px'  src='" + node.url + "'/>" //此处做了调整，推荐使用iframe的方式实现
								});
							} else {
								$("#tt").tabs('select', node.text); //直接选中title对应的选项卡
							}
						}
					}
				});
			}
		})
		
	
		layui.use('layer', function() {
			var $ = layui.jquery,
				layer = layui.layer;

			$('#video1').on('click', function() {
				layer.open({
					title: 'YouTube',
					maxmin: true,
					type: 2,
					content: 'video.html',
					area: ['800px', '500px']
				});
			});

		});
		//签到
		function qiandao(){	
		 var tody = new Date();
		 var hour = tody.getHours();
		 var nian = tody.getFullYear();
         var youe = tody.getMonth() + 1;
         var day = tody.getDate();
         if(day<10){
        	 day="0"+day;
        	
         }
         if(youe<10){
        	 youe="0"+youe;
         }
         if(hour<10){
        	 hour="0"+hour;
        	
         }
        
		 var strDate =nian+'-'+youe+'-'+day;
		 var strDateDay =nian+'-'+youe+'-'+day+" "+"01:00:00";
	     
			var C_UserId=${usersId}
			var  rls_State="${usersLoginState.consultantLabels.rls_State}"
			var  rls_FinishTime="${usersLoginState.consultantLabels.rls_FinishTime}"
			var  rls_StartTime="${usersLoginState.consultantLabels.rls_StartTime}"
			var  rs_Name="${usersLoginState.roles.rs_Name}"
			var hh="${usersLoginState.consultantLabels}"
		    if(rls_FinishTime<=rls_StartTime || rls_StartTime==null || hh==null || strDate>rls_StartTime ){
		    if(hour>=8 && hour<22){
			if(rls_State!=1 && strDateDay>=rls_FinishTime){
			 $.post("ConsultantLabelsStart", {
					C_UserId:C_UserId
			 },function(res) {
				if(res>0) {
					$.messager.alert("提示","签到成功");	
					$("#qiandao").hide();		//隐藏功能(将第一个表格隐藏)
					$("#yiqiandao").show();		//显示功能
				}
			}, "json");
		}else{
			$.messager.alert("提示","今天已经签到过了");	
			$("#qiandao").hide();		//隐藏功能(将第一个表格隐藏)
			$("#yiqiandao").show();		//显示功能
		}}else{
			$.messager.alert("提示","过了签到时间 请联系相关负责人");	
			}
		}
		    else{
			$.messager.alert("提示","今天已经签到过了");	
			$("#qiandao").hide();		//隐藏功能(将第一个表格隐藏)
			$("#yiqiandao").show();		//显示功能
		}
		}
		function gerenchuqin(){
			$('#selectgerenchuqin').window('open');
			search();
		}
		
		function search(){
			    var C_UserId=${usersId}
				$("#tabid").datagrid({
					url:'SelectConsultantLabels',
					method:"post",
					pagination:true,
					queryParams:{
						C_UserId:C_UserId
					}
				});
			}
	
	//信息通知
	var JieShouRen='${usersName}';
	var webscoket=new WebSocket("ws:localhost:8080/CRM/webscoket/"+JieShouRen);
	 webscoket.onmessage=function(event){
	 	$.messager.show({
	 		title:'新信息',
	 		msg:event.data,
	 		timeout:50000,
	 		showType:'slide'
	 	});

	 }
		function tuichu(){
			$.messager.confirm("提示","确定要退出登录吗？",function(res){
				if(res){
					$.post("initSession",{
					},function(res){
						if(res>0){
							location.href="loginJSP";
						}
					},"json");
				}
			})
		}
		//单点登录
		//连接关闭的回调方法
	    webscoket.onclose = function () {
	    	// 从application清空当前用户信息
	    	$.post("errorClose",{
	    		us_LoginName:"${usersName}"
	    	})
	        console.log("WebSocket连接关闭");
	    }
	    //监听窗口关闭事件,当窗口关闭时,主动去关闭WebSocket连接,防止连接还没断开就关闭窗口，server端会抛异常。
	    window.onbeforeunload = function () {
	    	// 从application清空当前用户信息
	    	$.post("errorClose",{
	    		us_LoginName:"${usersName}"
            })
	        closeWebSocket();
	    }
	    //关闭WebSocket连接
	    function closeWebSocket() {
	    	// 从application清空当前用户信息
	    	$.post("errorClose",{
	    		us_LoginName:"${usersName}"
            })
	        websocket.close();
	    }  
	    //客户来源统计图
	    function  SourceUrl() {
	   		 $.ajax({
			        url:"selectStuSourceUrl",
			        type:"post",
			        dataType:"json",
			        success:function(data){
 			        	var myChart1 = echarts.init(document.getElementById('khly'));
	 		        	option1 = {
	 		        	    tooltip : {
	 		        	        trigger: 'item',
	 		        	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	 		        	    },
	 		        	    legend: {
	 		        	        orient: 'vertical',
	 		        	        left: 'left',
	 		        	        data: data.name
	 		        	    },
	 		        	    series : [
	 		        	        {
	 		        	            name: '客户来源',
	 		        	            type: 'pie',
	 		        	            radius : '55%',
	 		        	            center: ['50%', '60%'],
	 		        	            data:data ,
	 		        	            itemStyle: {
	 		        	                emphasis: {
	 		        	                    shadowBlur: 10,
	 		        	                    shadowOffsetX: 0,
	 		        	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	 		        	               		 }
	 		        	            		}
	 		        	       		 }
	 		        	  		 ]
	 		        			};
	 		        	myChart1.setOption(option1);
			       }
	   			 });
		 }
	       
	function XinXi(){
		var usersName='${usersName}'//用户名
			$.post("selectUserRolesByName",{us_LoginName:usersName},function(data){		
				$("#us_LoginName").textbox("setValue",data.users.us_LoginName);
				$("#rs_Name").textbox("setValue",data.roles.rs_Name);
				$("#us_ProtecEmail").textbox("setValue",data.users.us_ProtecEmail);
				$("#us_ProtecMtel").numberbox("setValue",data.users.us_ProtecMtel);
				$("#us_UserImg").attr("src","image/"+data.users.us_UserImg);
				$("#chaKan_from").form("load",data);
				$("#chaKan_window").window("open");
			});
	}
	function updatePwd() {
		$("#updatePwd_window").window("open");
	}
	</script>
</head>
	<div class="layui-layout layui-layout-admin">
			<div class="layui-header header header-demo">
				<div class="layui-main">
					<div class="">
						<a class="logo" style="left: 0;" href="indexJSP">
							<span style="font-size: 20px;">CRM Admin System</span>
						</a>
					</div>
					<ul class="layui-nav admin-header-item">
						<li class="layui-nav-item">
							<a id="qiandao" href="javascript:qiandao();">签到</a>
							<a id="yiqiandao" href="javascript:;">已签到</a>
						</li>
						<li class="layui-nav-item">
							<a id="qiandao" href="javascript:gerenchuqin();">查看个人出勤</a>
						</li>
						<li class="layui-nav-item">
							<a href="javascript:;" class="admin-header-user">
								<img src="image/${usersImg}" id="userImg" style="width:50px;height:50px">
								<span>${usersName }</span>
							</a>
							<dl class="layui-nav-child">
								<dd>
									<a href="javascript:XinXi();">个人信息</a>
								</dd>
								<dd>
									<a href="javascript:updatePwd();">修改密码</a>
								</dd>
								<dd id="tuichu">
									<a href="javascript:tuichu();">注销</a>
								</dd>
							</dl>
						</li>
					</ul>
				</div>
			</div>
				<div class="layui-tab admin-nav-card layui-tab-brief" >
					<div class="layui-tab-content" style="min-height: 150px;">
						<div class="easyui-layout" style="width:100%;height:700px;">
							<div data-options="region:'south',split:true" style="height:50px;"></div>
							<div data-options="region:'west',split:true" title="导航应用" style="width:150px;he">
								<div>
									<!--这个地方显示树状结构-->
									<ul id="menuTree" class="easyui-tree"></ul>
								</div>
							</div>
							<!--这个地方采用tabs控件进行布局-->
							<div id="tt" class="easyui-tabs" data-options="region:'center',iconCls:'icon-ok'" style="width: 100px;">
								<div title="首页">
									 <div id="khly" style="width:100%;height:100%;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			<div class="layui-footer footer footer-demo" id="admin-footer">
				<div class="layui-main">
					<p>2019 &copy;
						<a href="#">beginner.zhengjinfan.cn</a> LGPL license
					</p>
				</div>
			</div>
		<!-- 	//查看 -->
		<div id="selectgerenchuqin" class="easyui-window" data-options="title:'截至今日本月出勤',modal:true,closed:true" style="width:700px;padding:10px;">
			<form id="selectgerenchuqin_form" class="easyui-form">	
				<table id="tabid" class="easyui-datagrid">
		           <thead>   
				        <tr> 
				            <th data-options="field:'rls_StartTime',width:150">签到时间</th>     
				            <th data-options="field:'rls_FinishTime',width:150">签退时间</th>
				        </tr>   
				    </thead>   
		       	</table>
		    </form>
		</div>
	</div>
	<!-- 个人信息 -->
	<div id="chaKan_window" class="easyui-window" title="查看个人信息" data-options="closed:true,modal:true" style="width:500px;height:300px;">
	<form id="chaKan_from">
		<table cellpadding="5">
			<tr>
				<td>用户名:</td>
				<td>
				<input class="easyui-textbox" id="us_LoginName" type="text" disabled="disabled"></input>
				</td>
				<td rowspan="4">
				<img src="" id="us_UserImg" style="width:200px;height:200px">
				</td>
			</tr>
			<tr>
				<td>职位:</td>
				<td><input class="easyui-textbox" id="rs_Name" type="text" disabled="disabled"></input></td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><input class="easyui-textbox" id="us_ProtecEmail" type="text" disabled="disabled"></input></td>
			</tr>
			<tr>
				<td>手机号:</td>
				<td><input type="text" class="easyui-numberbox" id="us_ProtecMtel" disabled="disabled"></td>
			</tr>
			
		</table>
	</form>
</div>
<!-- 修改密码 -->
<div id="updatePwd_window" class="easyui-window" title="修改密码" data-options="closed:true,modal:true" style="width:900px;height:550px;">
	
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