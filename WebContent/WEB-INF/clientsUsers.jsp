<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>查询所有客户以及用户对客户的跟踪记录</title>
    <link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/icon.css"/>
	<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/metro/easyui.css"/>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	<!-- 三级联动的js -->
	 <script class="resources library" src="js/area.js" type="text/javascript"></script> 
	 <script class="resources library" src="js/address.js" type="text/javascript"></script> 
	 <script type="text/javascript" src="js/echarts.js"></script>
	 <style type="text/css">
            .datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber
            {
                text-overflow: ellipsis;/* 文本溢出省略号 */
            }
   </style> 
	<script type="text/javascript">
	//easyui 右键动态显示隐藏列
	var createGridHeaderContextMenu = function(e, field) {
	    e.preventDefault();
	    var grid = $(this);/* grid本身 */
	    var headerContextMenu = this.headerContextMenu;/* grid上的列头菜单对象 */
	    if (!headerContextMenu) {
	        var tmenu = $('<div style="width:100px;"></div>').appendTo('body');
	        var fields = grid.datagrid('getColumnFields');//获取列
	        for ( var i = 0; i < fields.length; i++) {
	            var fildOption = grid.datagrid('getColumnOption', fields[i]);
	            if (!fildOption.hidden) {
	                $('<div iconCls="icon-ok" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
	            } else {
	                $('<div iconCls="icon-empty" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
	            }
	        }
	        headerContextMenu = this.headerContextMenu = tmenu.menu({
	            onClick : function(item) {
	                var field = $(item.target).attr('field');
	                if (item.iconCls == 'icon-ok') {
	                    grid.datagrid('hideColumn', field);
	                    $(this).menu('setIcon', {
	                        target : item.target,
	                        iconCls : 'icon-empty'
	                    });
	                } else {
	                    grid.datagrid('showColumn', field);
	                    $(this).menu('setIcon', {
	                        target : item.target,
	                        iconCls : 'icon-ok'
	                    });
	                }
	            }
	        });
	    }
	    headerContextMenu.menu('show', {
	        left : e.pageX,
	        top : e.pageY
	    });
	};
	$.fn.datagrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
	$.fn.treegrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
	$(function(){
		weiduMessage();
		
		
		
		 
	        
		
		
		
		
		 var C_UserId=${usersId}
		 $('#switch_button').switchbutton({
				onChange: function(checked){
					var a=0;
					if (checked == true){
						$.post(
			     				"ClientsUsersFenLiangZhuangTaiKaiQi", {
			     					C_UserId:C_UserId,
			     				},
			     				function(res) {
			     					if(res>0) {
			     						$.messager.alert("提示","开启成功");	
			     					}
			     				}, "json");
					}
					if (checked == false){
						$.post(
			     				"ClientsUsersFenLiangZhuangTaiGuanBi", {
			     					C_UserId:C_UserId
			     				},
			     				function(res) {
			     					if(res>0) {
			     						$.messager.alert("提示","关闭成功");	
			     					}
			     				}, "json");
					}}
		  })
			
		$('#Us_Id').combobox({    
		    url:'selectUsers',    
		    method:"post",
		    valueField:'us_Id',    
		    textField:'us_LoginName'   
		});  
		 var Us_Id=null;
		$('#QianDaoUs_Id').combobox({    
		    url:'ziXunSHiQianDaoFenLiangOption',    
		    method:"post",
		    valueField:'us_Id',    
		    textField:'us_LoginName',
		    onSelect: function(res){
		    	$.post(
	     				"SelectTuBiaoLiuShiLv", {
	     					Us_Id:res.us_Id
	     				},
	     				function(res) {
	     					if(res>0) {
	     						 var myChart = echarts.init(document.getElementById('main'));
	     						 option = {
	     								    tooltip : {
	     								        formatter: "{a} <br/>{b} : {c}%"
	     								    },
	     								    toolbox: {
	     								        feature: {
	     								            restore: {},
	     								            saveAsImage: {}
	     								        }
	     								    },
	     								    series: [
	     								        {
	     								            name: '业务指标',
	     								            type: 'gauge',
	     								            detail: {formatter:'{value}%'},
	     								            data: [{value: res, name: '成交率'}]
	     								        }
	     								    ]
	     								};

	     								setInterval(function () {
	     								   //option.series[0].data[0].value = (Math.random() * 100).toFixed(2) - 0;
	     								    myChart.setOption(option, true);
	     								},2000); 
	     								  // 使用刚指定的配置项和数据显示图表。
	     					            
	     					}
	     					myChart.setOption(option);
	     				}, "json");
	        }  
		});  
		search();
		});
	function search(){
		   
			$("#tabid").datagrid({
				url:'SelectClientsUsers',
				method:"post",
				pagination:true,
				queryParams:{
					Cs_Name:$("#Cs_Name").val() ,
					Cs_Sex:$("#Cs_Sex").combobox("getValue"),
					Cs_Phone:$("#Cs_Phone").val(),
					Cs_ClientState:$("#Cs_ClientState").combobox("getValue"),
					Cs_Source:$("#Cs_Source").combobox("getValue"),
					Us_Id:$("#Us_Id").combobox("getValue"),
					Cs_FenPei:$("#Cs_FenPei").combobox("getValue"),
					Cs_SiteSheng:$("#Cs_SiteSheng").val(),
					Cs_SiteShi:$("#Cs_SiteShi").val(),
					Cs_SiteXian:$("#Cs_SiteXian").val(),
					Cur_ZhuangTai:$("#Cur_ZhuangTai").combobox("getValue")
				},
			 onDblClickCell:function(index, row) {
				  var rows=$("#tabid").datagrid("getRows");
		  			var row=rows[index];
		  			$("#chakan_form").form("load",row);
		  			var a=$("#cs_Img").val();//获取图片名称	
		  			a="image/"+a;//图片路径
		  			$("#aaa").attr("src",a);//给img设置
		  			$("#chakan_dialog").dialog("open");
			}
			});
			 $("#chongzhi").form("reset");//重置文本框内容 
			
		}
         //手动分量
         function shoudongfenliang(){
        	 //已签到用户id 
        	 var data=$("#tabid").datagrid("getSelections");
     	    var aa="";
     		for(var i=0;i<data.length;i++){
     			 var row=data[i].c_Id;
     			 aa=aa+row+",";
     		} 
     		var 
     		haha=aa.substring(0,aa.length-1);
     		var arr=haha.split(",");
     		var code = "";
     		var id=0;
    		for(var i=0;i<arr.length;i++){
    			id+=arr[i]    			
    		}
    		
   		     if(row!=null){
   		    	if(id==0){
        		 $("#UpdateUsers_window").window("open"); //打开窗口。     
        	 }else{
        	     $.messager.alert("提示","有的客户已经分配咨询师请重新选择");	
        	 }
   		     }else{
        	     $.messager.alert("提示","请选择要分配的客户");	
        	 }
         }
         var  faSongRen='${usersName}';//谁发送
         var webscoket=new WebSocket("ws:localhost:8080/CRM/webscoket/faSongRen");
        //自动分量
        function  zidogfenliang() {
        	var  cur_Ext1="${usersLoginState.consultantLabels.cur_Ext1}"
            var  rls_State="${usersLoginState.consultantLabels.rls_State}"
            //alert(rls_State);
    		var data=$("#tabid").datagrid("getSelections");
      		var Cs_Id="";
      		for(var i=0;i<data.length;i++){
    				var row=data[i].cs_Id;
    				Cs_Id=Cs_Id+row+",";	
    	    } 
      		var aa="";
      		for(var i=0;i<data.length;i++){
      			 var row=data[i].c_Id;
      			aa=aa+row+",";
      		} 
      		var haha=aa.substring(0,aa.length-1);
      		var arr=haha.split(",");
      		var code = "";
      		var id=0;
     		for(var i=0;i<arr.length;i++){
     			id+=arr[i]    			
     		}
     		 //if(cur_Ext1){
    		     if(row!=null){
    		    	if(id==0){
    		    		$.post(
    		     				"ZiDongFenLiang", {
    		     					Cs_Id:Cs_Id,
    		     					faSongRen:faSongRen//发送人
    		     				},
    		     				function(res) {
    		     					if(res!="") {
    		     						//alert(res);
    		     						$.messager.alert("提示","分量成功");	
    		     						$("#tabid").datagrid("reload");
    		     						var arr=res.split(",");
    		     						for(var i=0;i<arr.length;i++){
    		     							var JieShouRen=arr[i]
    		     			     			//alert(JieShouRen);
    		     							if(JieShouRen!=""){
    		     								webscoket.send(faSongRen+","+JieShouRen+","+faSongRen+"给您分配了一名新客户，请注意查收！"); 
    		     							}
    		     			     		}
    		     					}
    		     				});     
         	 }else{
         	     $.messager.alert("提示","有的客户已经分配咨询师请重新选择");	
         	 }}else{
         	     $.messager.alert("提示","请选择要分配的客户");	
         	 }
    		     //}else{
          		// $.messager.alert("提示","请开启自动分量");
         	 //}
         }
   
       //增加客户
       function addClients(){

   		$('#Client_from').form('reset');
   		 addressInit('cs_SiteSheng', 'cs_SiteShi', 'cs_SiteXian');//省市县（区）三级联动，必须和js文件地址匹配
       	$('#add_ClientWin').window('open');
       }
      //添加保存按钮
   	 function Client_Submit(){
    	  //alert(0123131);
   		var	cs_SiteSheng=$("#cs_SiteSheng").val();
   		var	cs_SiteShi= $("#cs_SiteShi").val();
   		var	cs_SiteXian= $("#cs_SiteXian").val();
   		var	cs_SiteXiangXi= $("#cs_SiteXiangXi").val();
   		var cs_Phone =	$("#innsert_cs_Phone").textbox("getValue");
   		var TEL_REGEXP = /^[1][358][0-9]{9}$/;
   		var cs_Ext2 = '<%=session.getAttribute("usersName")  %>';
   		var cs_Name=$("#innsert_cs_Name").textbox("getValue");
   		var cs_Sex=$("#innsert_cs_Sex").combobox('getValue');
   		var cs_Age=$("#innsert_cs_Age").textbox("getValue");
   		var cs_Email=$("#innsert_cs_Email").textbox("getValue");
   		var cs_QQ=$("#innsert_cs_QQ").textbox("getValue");
   		var cs_ClientState=$("#cs_ClientState").combobox('getValue');
   		var cs_Source=$("#innsert_cs_Source").combobox('getValue');
   		var cs_Remark=$("#innsert_cs_Remark").textbox("getValue");
   		var cs_Img = $("#cs_Imgs").get(0).files[0];
   		if(cs_Age != null && cs_Age != ''){
   		if(cs_Phone  != null && cs_Phone != ''){
   			if(cs_Source == '---请选择---' || cs_Source == '' ){
   			 	$.messager.alert("提示","请填写客户来源！");
   		}else{
   		if(cs_Sex=='0' || cs_Sex == '1'){
   			if(TEL_REGEXP.test(cs_Phone)){
   				if(cs_Email != null && cs_Email != ''){
   					var formData=new FormData();
   					 	formData.append("cs_Phone",cs_Phone);
   				        formData.append("cs_Ext2",cs_Ext2);
   				        formData.append("cs_Name",cs_Name);
   				        formData.append("cs_Sex",cs_Sex);
   					 	formData.append("cs_Age",cs_Age);
   				        formData.append("cs_Email",cs_Email);
   				        formData.append("cs_QQ",cs_QQ);
   				        formData.append("cs_Source",cs_Source);
   					 	formData.append("cs_Remark",cs_Remark);
   					 	formData.append("add_Img",cs_Img);
   					 	formData.append("cs_SiteSheng",cs_SiteSheng);
   					 	formData.append("cs_SiteShi",cs_SiteShi);
   					 	formData.append("cs_SiteXian",cs_SiteXian);
   					 	formData.append("cs_SiteXiangXi",cs_SiteXiangXi);
   					 	formData.append("cs_ClientState",cs_ClientState);
   					 	$.ajax({
   				            url:"innsertClients",
   				            type:"post",
   				            data:formData,
   				            contentType:false,
   				            processData:false,
   				            success:function(res){
   				            	if(res==1) {
   									$.messager.alert("提示","新增成功");
   									$("#tabid").datagrid("reload");
   									$("#add_ClientWin").window("close");
   									webscoket.send(faSongRen+","+JieShouRen+","+faSongRen+"录入了一名新客户，请注意查收！");
   								}else{
   									$.messager.alert("提示","新增失败");
   								}
   				            },
   				            error:function(res){
   				                $.messager.alert("提示","添加失败！");
   				                $("#add_ClientWin").window("close");
   				          	 }
   				       		 }) 
   	 			 }else{
   	 				$.messager.alert("提示","请填写邮箱！");		
   	 			 }
   			}
   		 }else{
   		 	$.messager.alert("提示","请填写性别！");			 
   		 }
   		 }
   		 }else{
   				$.messager.alert("提示","请填写电话！");
   		 }
   		 }else{
   			 $.messager.alert("提示","请填写年龄！");	
   		 }
   	 }
   		 
        
         function SubmitUpdateForm(){
        	//信息通知
      		var  JieShouRen=$("#QianDaoUs_Id").combobox("getText");//下拉框选中的用户
        	var data=$("#tabid").datagrid("getSelections");
     		var Cs_Id="";
     		var  C_Id=$("#QianDaoUs_Id").combobox("getValue");
     		//获取选中客户id 根据客户id循环分配 选中的已签到的用户
     		for(var i=0;i<data.length;i++){
 				var row=data[i].cs_Id;
 				Cs_Id=Cs_Id+row+",";	
 			} 
     		$.post(
     				"UsersQianDaoFenLiang", {
     					Cs_Id:Cs_Id,
     					C_Id:C_Id,
     					JieShouRen:JieShouRen, //接收人
     					faSongRen:faSongRen//发送人
     				},
     				function(res) {
     					if(res>0) {
     						$.messager.alert("提示","分量成功");	
     						$("#tabid").datagrid("reload");
     						$("#UpdateUsers_window").window("close");
     						webscoket.send(faSongRen+","+JieShouRen+","+faSongRen+"给您分配了一名新客户，请注意查收！"); 
     					}
     				}, "json");
         }
         function CloseForm(){
        	 $("#UpdateUsers_window").window("close");
         }
       //省略号
         function  SLHformatter(value,row,index){
        	 return '<span  title='+value+'>'+value+'</span>'  
        }
         //查看未读消息
         function chakanMessage() {
     		var usersName='<%=session.getAttribute("usersName")%>'//用户名
     		$("#tabMessage").datagrid({		   
     			url:"selectMessageByAll",
     			method:"post",
     			pagination:true,			
     			rownumbers:true,
     			toolbar:"#MesBar",
     			pageSize:5,
     		    pageList: [5, 10, 20], 
     			queryParams:{
     				M_ReceiveName:usersName,
     				M_InitiateName:$("#M_InitiateNameBar").val(),
     				M_State:$("#M_StateBar").combobox("getValue")
     			}	  
     		})
     		updateMeState();
     		$("#chaKan_message").dialog("open");
     		
     	}
     //有未读消息时提示
      function weiduMessage() {
      	var usersName='<%=session.getAttribute("usersName")%>'//用户名
      	$.post("selectMessageWeiJieShouCount",{usersName:usersName},function(num){
      		if(num>0){
      			$('#Message').linkbutton({ text:'未读+'+num });			
      		}else{
      			$('#Message').linkbutton({ text:'查看历史消息'});
      		}
      	},"json")
      }
      function M_StateFormatter(value,row,index) {
      	return value==0?"未查看":"已查看"
      }
      //修改信息状态
      function updateMeState() {
      	var usersName='<%=session.getAttribute("usersName")%>'//用户名
      		$('#chaKan_message').dialog({
      		    onClose:function(){		    	
      		     	 $.post("updateMessageState",{M_ReceiveName:usersName},function(res){
      		     		 if(res>0){
      		     			$('#Message').linkbutton({ text:'查看历史消息'});
      		     		 }
      		     	 },"json")		     
      		    }
      	    });
      }
         
		//导出
	  	function exportExcel(){  
		  	var data=$("#tabid").datagrid("getSelections");
		    var cs_Id="";
			for(var i=0;i<data.length;i++){
				var row=data[i].cs_Id;
				cs_Id=cs_Id+row+",";
			}   
			if(row!=null){
				 location.href="excel/export?&Cs_Id="+cs_Id;   
			}else{
				alert("请选择要导出的行");
			}
	    }  
		
	  function LoginNameformatter(value,row,index){
		  if(row.users!=null){
			  return row.users.us_LoginName;
		  }
		  else{
			  return "暂无";
		  }
	  }
	 /*  function Cur_RecordTimeformatter(value,row,index){
		  if(row.clientUserRecord!=null){
			  return row.clientUserRecord.cur_RecordTime;
		  }
		  else{
			  return "暂无";
		  }
	  }   */
	  function  ClientsImgformatter(value,row,index){
	      if(row.cs_Img!=null && row.cs_Img!=""){
	         return "<img style='width:24px;height:24px;'border='1' src='image/"+row.cs_Img+"'/>";
	      }
	      else{
			  return "暂无";
		  }
	  } 
	  function cs_Sexformatter(value,row,index){
		  if(row.cs_Sex=="1"){
			  return "男";
		  }
		  else{
			  return "女";
		  }
	  }  
	  function cs_ClientStateformatter(value,row,index){
		  if(row.cs_ClientState=="1"){
			  return "潜在客户";
		  }else if(row.cs_ClientState=="2"){
			  return "意向客户";
		  }else if(row.cs_ClientState=="3"){
			  return "续保客户";
		  }else if(row.cs_ClientState=="4"){
			  return "正式客户";
		  }else if(row.cs_ClientState=="5"){
			  return "流失客户";
		  }else if(row.cs_ClientState=="6"){
			  return "未分配客户";
		  }
	  } 
	  function cs_Sourceformatter(value,row,index){
		  if(row.cs_Source=="1"){
			  return "QQ";
		  }else if(row.cs_Source=="2"){
			  return "微信";
		  }else if(row.cs_Source=="3"){
			  return "赶集网";
		  }else if(row.cs_Source=="4"){
			  return "天涯社区";
		  }else if(row.cs_Source=="5"){
			  return "新浪论坛";
		  }else if(row.cs_Source=="6"){
			  return "网易论坛";
		  }else if(row.cs_Source=="7"){
			  return "百度贴吧";
		  }else if(row.cs_Source=="8"){
			  return "58同城";
		  }
	  } 
	 
	  //三级联动
	 var Gid  = document.getElementById ;
     var showArea = function(){
	 Gid('show').innerHTML = "<h3>省" + Gid('Cs_SiteSheng').value + " - 市" + 	
	 Gid('Cs_SiteShi').value + " - 县/区" + 
	 Gid('Cs_SiteXian').value + "</h3>"
     }
     Gid('Cs_SiteXian').setAttribute('onchange','showArea()');
	</script>
	
</head>
<body>

    <form id="chongzhi">
  客户名称:  <input  class="easyui-textbox"  id="Cs_Name"  style="width:100px"> 
  性别:<select id="Cs_Sex"  class="easyui-combobox" name="dept" style="width:100px;">   
			     <option value="">---请选择---</option>  
			     <option value="1">男</option>			     
			     <option value="2">女</option>  
           </select> 
  电话：<input class="easyui-textbox" id="Cs_Phone"  style="width:120px">
  客户状态： <select id="Cs_ClientState"  class="easyui-combobox" name="dept" style="width:200px;">   
			     <option value="">---请选择---</option>  
			     <option value="1">潜在客户</option>
			     <option value="2">意向客户</option>
			     <option value="3">续保客户</option>
			     <option value="4">正式客户</option>			     
			     <option value="5">流失客户</option>
			   
           </select>
 客户来源：<select id="Cs_Source"  class="easyui-combobox" name="dept" style="width:200px;">   
			     <option  value="">---请选择---</option>  
			     <option  value="1">QQ</option> 
			     <option  value="2">微信</option>
			     <option  value="3">赶集网</option>
			     <option  value="4">天涯社区</option>
			     <option  value="5">新浪论坛</option>
			     <option  value="6">网易论坛</option>
			     <option  value="7">百度贴吧</option>
			     <option  value="8">58同城</option>  
           </select>
           <br/>
 所属用户:  <select id="Us_Id"  class="easyui-combobox" name="dept" style="width:100px;">   
			    <option value="">---请选择---</option>    
			   <%--  <c:forEach items="${selectUsers}" var="users">
			     <option  value="${users.us_Id}">${users.us_LoginName}</option> 
			    </c:forEach>    --%>
         </select>
  分配:<select id="Cs_FenPei"  class="easyui-combobox" name="dept" style="width:100px;">   
			     <option value="">---请选择---</option>  
			     <option value="0">已分配</option>  
			     <option value="1">未分配</option>  
          </select>
  地址:    <select id="Cs_SiteSheng" name="s_province" ></select>  
		  <select id="Cs_SiteShi"   name="s_city"     ></select>  
		  <select id="Cs_SiteXian"  name="s_county"   ></select>
		  <script type="text/javascript">_init_area();</script>
 意向状态:   <select id="Cur_ZhuangTai"  class="easyui-combobox" name="dept" style="width:200px;">   
			     <option value="">---请选择---</option>  
			     <option value="1">意向强</option>  
			     <option value="2">意向中</option>
			     <option value="3">意向弱</option> 
          </select>
 
     <a id="btn" href="javascript:search()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
     <a id="zidogfenliang" href="javascript:zidogfenliang()" class="easyui-linkbutton" data-options="iconCls:'icon-man'">自动分量</a>
     <a id="shoudongfenliang" href="javascript:shoudongfenliang()" class="easyui-linkbutton" data-options="iconCls:'icon-man'">手动分量</a>
      <input id="switch_button" class="easyui-switchbutton"   style="width:120px;height:28px"  data-options="checked:false,onText:'自动分量已开启',offText:'自动分量已关闭'" >
     <a id="btn" href="javascript:addClients()" class="easyui-linkbutton" data-options="iconCls:'icon-man'">增加客户</a>
     <a id="btn" href="javascript:exportExcel()" class="easyui-linkbutton" data-options="iconCls:'icon-redo'">导出</a>
     <a href="javascript:void(0)" id="Message" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="chakanMessage()">查看历史消息</a>
    </form>
    <table id="tabid" class="easyui-datagrid">
           <thead>   
		        <tr> 
		            <th data-options="field:'che',checkbox:true"></th>
		            <th data-options="field:'cs_Id',width:100">客户Id</th>     
		            <th data-options="field:'cs_Name',width:100">客户姓名</th>
		            <th data-options="field:'cs_Img',width:100,formatter:ClientsImgformatter">客户照片</th> 
		            <th data-options="field:'cs_Sex',width:100,formatter:cs_Sexformatter">性别</th>
		            <th data-options="field:'cs_Phone',width:100">电话</th>
		            <th data-options="field:'cs_ClientState',width:100,formatter:cs_ClientStateformatter">客户状态</th>
		            <th data-options="field:'cs_Source',width:100,formatter:cs_Sourceformatter">客户来源</th>
		            <th data-options="field:'cs_SiteXiangXi',width:200">客户地址</th>
		            <th data-options="field:'cs_FoundTime',width:150">建档时间</th>
		            <th data-options="field:'users',width:100,formatter:LoginNameformatter">所属用户</th>
		        </tr>   
		    </thead>   
    </table>
    <div id="UpdateUsers_window" class="easyui-window" title="修改信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:700px;height:500px;padding:10px;">
	<form id="UpdateUsers_Form">
		<table cellpadding="5">
		   <tr>
			    <td>已签到咨询师名称:</td>
				<td>
				<select id="QianDaoUs_Id"  class="easyui-combobox" name="dept" style="width:200px;">   
			    <option value="">请选择</option>  
                </select>  
				</td>
				<td>
				 <div id="main" style="width: 400px;height:400px;"></div>
				
				</td>
			</tr>
		</table>
	</form>
	<div style="text-align:center;padding:5px">
		<a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="SubmitUpdateForm()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="CloseForm()">取消</a>
	</div>
    </div>
  <!--客户添加页面  -->
	
	<div id="add_ClientWin" class="easyui-window"  title="新增客户"  style="width:600px;height:500px;" data-options="modal:true,closed:true">
		<form id="Client_from" class="class-form" >
			<table class="Client_table" style="width:400px;height:500px"   
					        data-options="fitColumns:true,singleSelect:true" align="center" >
			<thead >
				<tr>
					<th>姓名:</th>
					<th><input type="text" autocomplete="off" class="easyui-textbox" data-options="required:true" style="width: 200px" name="cs_Name" id="innsert_cs_Name"/></th>
				</tr>
				<tr>
					<th>性别:</th>
					<th><select  class="easyui-combobox" style="width: 200px"  id="innsert_cs_Sex" name="Cs_Sex"  >   	   			 
	   			  <option>--请选择--</option>  	 
	   			  <option value="0">男</option> 
	   			  <option value="1">女</option>
				</select></th>
				</tr>
				<tr>
					<th>年龄:</th>
					<th><input type="text" autocomplete="off"  style="width: 200px" class="easyui-textbox" data-options="required:true"  name="Cs_Age" id="innsert_cs_Age"/></th>
				</tr>
				<tr>
					<th>上传头像:</th>
					<th><input type="file" name="cs_Imgs" id="cs_Imgs"  style="width:200px"  /></th>
				</tr>
				<tr>
					<th>电话:</th>
					<th><input type="text" autocomplete="off"  style="width: 200px"  class="easyui-textbox" data-options="required:true"  name="Cs_Phone" id="innsert_cs_Phone"/></th>
				</tr>
				<tr>
					<th>地址:</th>
					<th>
					<select id="cs_SiteSheng"  name="cs_SiteSheng" style="width:80px; height:25px; font-size:10px"></select>
					<select id="cs_SiteShi" name="cs_SiteShi"   style="width:80px;  height:25px; font-size:10px"></select>
					<select id="cs_SiteXian" name="cs_SiteXian"  style="width:80px;  height:25px; font-size:10px"></select>
					</th>
				</tr>
				<tr>
			
				<th>详细地址:</td><td><input class="areas"  placeholder='尽量填写详细'  id="cs_SiteXiangXi" 
				class="easyui-textbox" data-options="multiline:true" style="width:200px;height:15px"  type="text" name="cs_SiteXiangXi" /></th>
				</tr>
				<tr>
					<th>客户来源:</th>
					<th>  <select id="innsert_cs_Source"   class="easyui-combobox" name="Cs_Source" style="width:200px;">   
			     <option  value="">---请选择---</option>  
			     <option  value="1">QQ</option> 
			     <option  value="2">微信</option>
			     <option  value="3">赶集网</option>
			     <option  value="4">天涯社区</option>
			     <option  value="5">新浪论坛</option>
			     <option  value="6">网易论坛</option>
			     <option  value="7">百度贴吧</option>
			     <option  value="8">58同城</option>  
           </select></th>
				</tr>
				<tr>
					<th>客户状态:</th><th> <select id="cs_ClientState" class="easyui-combobox" name="cs_ClientState" style="width:200px;">   	   			 
	   			  <option value="0">续保</option> 
	   			  <option value="1">正式</option>
	   			  <option value="2">流失</option>
				</select></th>
				</tr>
				<tr>
					<th>QQ:</th>
					<th><input type="text"  style="width: 200px"  class="easyui-textbox" data-options="required:true,validType:'length[5,11]'"
					  name="Cs_QQ" id="innsert_cs_QQ"/></th>
				</tr>
				<tr>
					<th>Emali:</th>
					<th><input type="text"  style="width: 200px" class="easyui-textbox" data-options="validType:'email',required:true" name="Cs_Email" id="innsert_cs_Email"/></th>
				</tr>
				<tr>
					<th>在线备注:</th>
					<th><input type="text" class="easyui-textbox"  data-options="multiline:true" style="width:200px;height:100px"  name="Cs_Remark" id="innsert_cs_Remark"/></th>
				</tr>
						        	
			</thead>
			</table>
		</form>
		<div style="text-align: center;">
			<a id="btn" href="#" class="easyui-linkbutton"  onclick="Client_Submit()">保存</a>
			<a id="btn" href="#" class="easyui-linkbutton"  onclick="Client_cead()">取消</a>
		</div>
	</div>
	<!-- 查看未读消息 -->
	<div id="chaKan_message" class="easyui-dialog" data-options="title:'客户跟踪记录',modal:true,closed:true" style="width:700px;">
			<table id="tabMessage" class="easyui-datagrid">
				<thead>
					<tr>
						<th field="ck" checkbox="true"></th>
						<th data-options="field:'m_InitiateName',title:'发送人'"></th>
						<th data-options="field:'m_State',title:'状态',formatter:M_StateFormatter"></th>
						<th data-options="field:'m_Time',title:'发送时间'"></th>
						<th data-options="field:'m_Content',title:'内容',formatter:SLHformatter"></th>
					</tr>
				</thead> 
			</table>
		</div>
		<div id="MesBar" hidden="true">
			发送人：<input type="text" class="easyui-textbox" name="cs_NameBar" id="M_InitiateNameBar" style="width:200px">		
			状态：<select id="M_StateBar" class="easyui-combobox" style="width:200px;">   
	   			 <option value="-1">请选择</option>
	   			  <option value="0">未查看</option> 
	   			  <option value="1">已查看</option>
			</select>		
			<a href="javascript:void()"  class="easyui-linkbutton" onclick="chakanMessage()" data-options="iconCls:'icon-search'">搜索</a> 
		</div>
	<!-- 查看详细信息 -->
	<div id="chakan_dialog" class="easyui-dialog" data-options="title:'查看',modal:true,closed:true">
		<form id="chakan_form" class="easyui-form">	
		 <table>
		 	<tr>
		 		<td>编号:</td><td><input data-options="readonly:true" class="easyui-numberbox" type="text" name="cs_Id" /></td>
		 		<td>头像:</td><td> <img alt="" id="aaa" src="" style="width:24px;height:24px;">
	        		<input id="cs_Img" class="easyui-textbox" type="hidden" name="cs_Img" /></td>
	        	<td>姓名:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_Name" /></td>
		 	</tr>
		 	<tr>
		 		<td>性别:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_Sex" style="width:150px;">   	   			 
	   			  <option value="0">男</option> 
	   			  <option value="1">女</option>
				</select></td> 
			<td>年龄:</td><td><input data-options="readonly:true" class="easyui-numberbox" type="text" name="cs_Age" /></td> 
			<td>电话:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_Phone" /></td>
		 	</tr>
		 	<tr>
		 		<td>学历:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_Xueli" /></td>
		 		<td>邮箱:</td><td> <input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_Email" /></td>
		 		<td>QQ:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_QQ" /></td>
		 	</tr>
		 	
		 	<tr>
		 		<td>省:</td><td><select data-options="readonly:true" class="easyui-combobox" type="text" name="cs_SiteSheng" style="width:150px;" /></td>
		 		<td>市:</td><td><select data-options="readonly:true" class="easyui-combobox" type="text" name="cs_SiteShi" style="width:150px;" /></td>
		 		<td>县:</td><td><select data-options="readonly:true" class="easyui-combobox" type="text" name="cs_SiteXian" style="width:150px;" /></td>
		 	</tr>
		 	<tr>
		 		<td>详细地址:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_SiteXiangXi" /></td>
		 		<td>微信号:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_WeiXin" /></td>
		 		<td>客户来源:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_Source" /></td>
		 	</tr>
		 	<tr>
		 		<td>退费原因:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_TuiFenInfo" /></td>
		 		<td>回访情况:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_HuiFangInfo" /></td>
		 		<td>学员关注:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_Courses" style="width:150px;">   	   			 
	   			  <option value="0">其他</option> 
	   			  <option value="1">课程</option>
	   			  <option value="2">学费</option>
	   			  <option value="3">学时</option>
	   			  <option value="4">学历</option>
	   			  <option value="5">师资</option>
	   			  <option value="6">就业</option>
	   			  <option value="7">环境</option>	   			 
				</select></td>
		 	</tr>
		 	<tr>
		 		<td>课程费用:</td><td><input data-options="readonly:true" class="easyui-numberbox" type="text" name="cs_Money" /></td>
		 		<td>课程打分:</td><td><input data-options="readonly:true" class="easyui-numberbox" type="text" name="cs_Grade" /></td>
		 		<td>无效原因:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_IsValidInfo" /></td>
		 	</tr>
		 	<tr>
		 		<td>首次回访时间:</td><td><input data-options="readonly:true" class="easyui-datetimebox" type="text" name="cs_HuiFangTime" /></td>
		 		<td>上门时间:</td><td><input data-options="readonly:true" class="easyui-datetimebox" type="text" name="cs_VisitTime" /></td>
		 		<td>缴费时间:</td><td><input data-options="readonly:true" class="easyui-datetimebox" type="text" name="cs_JiaoFeiTime" /></td>
		 	</tr>
		 	<tr>
		 		<td>创建时间:</td><td><input data-options="readonly:true" class="easyui-datetimebox" type="text" name="cs_FoundTime" /></td>
		 		<td>进班时间:</td><td><input data-options="readonly:true" class="easyui-datetimebox" type="text" name="cs_JinBanTime" /></td>
		 		<td>身份证号:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_ShenFenZheng" /></td>
		 	</tr>
		 	<tr>
		 		<td>出生时间:</td><td><input data-options="readonly:true" class="easyui-datetimebox" type="text" name="cs_BirthTime" /></td>
		 		<td>咨询师备注:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_ConsultantRemark" /></td>
		 		<td>备注:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_Remark" /></td>
		 	</tr>
		 	<tr>
		 		<td>客户权重:</td><td><input data-options="readonly:true" class="easyui-numberbox" type="text" name="cs_Weight" /></td>
		 		<td>客户状态:</td><td> <select data-options="readonly:true" class="easyui-combobox" name="cs_ClientState" style="width:200px;">   	   			 
	   			  <option value="0">续保</option> 
	   			  <option value="1">正式</option>
	   			  <option value="2">流失</option>
				</select></td>
		 		<td>是否缴费:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsJiaoFei" style="width:150px;">   	   			 
	   			  <option value="0">未缴费</option> 
	   			  <option value="1">已缴费</option>
				</select></td>
		 	</tr>
		 	<tr>
		 		<td>是否回访:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsHuiFang" style="width:150px;">  	   			 
	   			  <option value="0">未回访</option> 
	   			  <option value="1">已回访</option>
				</select></td>
		 		<td>是否有效:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsValid" style="width:150px;">   	   			 
	   			  <option value="0">待定</option>
	   			  <option value="1">无效</option> 
	   			  <option value="2">有效</option>
				</select></td>
		 		<td>是否上门:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsVisit" style="width:150px;">   	   			 
	   			  <option value="0">未上门</option> 
	   			  <option value="1">已上门</option>
				</select></td>
		 	</tr>
		 	<tr>
		 		<td>是否报备:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsBaoBei" style="width:150px;">   	   			 
	   			  <option value="0">未报备</option> 
	   			  <option value="1">已报备</option>
				</select></td>
		 		<td>是否退费</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsTuiFen" style="width:150px;">   	   			 
	   			  <option value="0">未退费</option> 
	   			  <option value="1">已退费</option>
				</select></td>
		 		<td>是否进班:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsJinBan" style="width:150px;">   	   			 
	   			  <option value="0">未进班</option> 
	   			  <option value="1">已进班</option>
				</select></td>
		 	</tr>
		 	<tr>
		 		<td>是否分配:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_FenPei" style="width:150px;">   	   			 
	   			  <option value="0">未分配</option> 
	   			  <option value="1">已分配</option>
				</select></td>
		 	</<tr>
		 </table>   
  		 </form>>   
	</div>
	
</body>
</html>