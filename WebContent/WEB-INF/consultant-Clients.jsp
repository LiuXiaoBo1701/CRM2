<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/icon.css">
<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/metro/easyui.css">
<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
 <script type="text/javascript" src="js/address.js"></script> 
<style type="text/css">
            .datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber
            {
                text-overflow: ellipsis;/* 文本溢出省略号 */
            }
   </style> 
<script type="text/javascript">
$(function(){
	init();//初始化表格	
})
function init() {
	var minTime=$("#minTime").datebox("getValue");
	var maxTime=$("#maxTime").datebox("getValue");
	var usersId=<%=request.getSession().getAttribute("usersId")%>//用户id
	weiduMessage();
	if(minTime<=maxTime){
		$("#csTab").datagrid({
			url:"selectCstClientsByAll",
			method:"post",
			pagination:true,
			rownumbers:true,		
			toolbar:"#csbar",
			onDblClickCell: function(index,field,value){//双击查看
				chakanCs(index);
			},
			queryParams:{
				Cs_Name:$("#cs_NameBar").val().replace(/^\s*|\s*$/g,""),//去除字符串内两边的空格
				minTime:minTime,
				maxTime:maxTime,				
				C_Id:usersId,
				Cs_IsHuiFang:$("#cs_IsHuiFangBar").combobox("getValue"),
				Cs_IsJiaoFei:$("#cs_IsJiaoFeiBar").combobox("getValue")
			}		 
		})
	}else{
		$.messager.alert("提示","跟踪开始时间不能大于跟踪结束时间！！！");
	}
	
}
//根据身份证自动刷新性别，年龄，出生日期
function onShenFenZheng() {
	 $('#cs_ShenFenZheng').textbox({
         onChange: function (n, o) {        	 
        	 //出生日期
        	 var year=n.substring(6,10);//截取身份证上的年
        		var months=n.substring(10,12);//截取身份证上的月
        		var day=n.substring(12,14);//截取身份证上的日
        		var chushengrq=year+"-"+months+"-"+day;//转为2000-01-01的格式      		
        		$("#cs_BirthTime").datebox("setValue",chushengrq);
        		//年龄
        		var myDate = new Date();
        		var month = myDate.getMonth() + 1;		
        		var day = myDate.getDate(); 	
        		var age = myDate.getFullYear() - year - 1;         		
        		if (months< month || months == month && days <= day) { 
        		age++; 
        		}
        		 $("#cs_Age").numberbox("setValue",age);
        		//性别
        		  if (n.substr(16, 1) % 2 == 1) {//截取倒数第二位数
        		  $("#cs_Sex").combobox("setValue",0);
        		  }else{
        		  $("#cs_Sex").combobox("setValue",1);
        		  }       		
         }
     });
	
}
function  caozuoFormatter(value,row,index) {
	return "<a style='cursor:pointer;' href='javascript:void(0)' onclick='updateCs("+index+")'>修改</a>"
}
//打开查看弹框
function chakanCs(index) {	
	var rows=$("#csTab").datagrid("getRows");
	var row=rows[index];
	$("#chakan_form").form("load",row);			
	$("#chakan_img").attr("src","image/"+row.cs_Img+"");//给img设置	
	$("#chakan_dialog").dialog("open");	
}
//显示图片
function ImgFormatter(value,row,index) {
	return "<img style='width:24px;height:24px;' src='image/"+row.cs_Img+"'/>"
}
function SexFormatter(value,row,index) {
	return value==0?'男':'女'
}
//显示客户状态
function StateFormatter(value,row,index) {	
	return value==0?'续保':value==1?'正式':'流失'
}
function FenFormatter(value,row,index) {
	return value==0?'未分配':'已分配'
}
function JiaoFormatter(value,row,index) {
	return value==0?'未缴费':'已缴费'
}
function HuiFormatter(value,row,index) {
	return value==0?'未回访':'已回访'
}
function ValidFormatter(value,row,index) {
	return value==0?'待定':value==1?'无效':'有效'
}
function VisitFormatter(value,row,index) {
	return value==0?'未上门':'已上门'
}
function BaoFormatter(value,row,index) {
	return value==0?'未报备':'已报备'
}
function TuiFormatter(value,row,index) {
	return value==0?'未退费':'已退费'
}
function JinFormatter(value,row,index) {
	return value==0?'未进班':'已进班'
}
function CouFormatter(value,row,index) {
	return value==0?'其他':value==1?'课程':value==2?'学费':value==3?'学时':value==4?'学历':value==5?'师资':value==6?'就业':'环境'
}
function closed_edit() {
	$("#edit_dialog").dialog("close");
}
//打开修改对话框
function updateCs(index) {	
	var rows=$("#csTab").datagrid("getRows");
	var row=rows[index];	
	 $("#edit_form").form("load",row);
	 addressInit('cs_SiteSheng', 'cs_SiteShi', 'cs_SiteXian','',row.cs_SiteSheng,row.cs_SiteShi,row.cs_SiteXian);//省市县（区）三级联动，必须和js文件地址匹配
	$("#edit_Img").attr("src","image/"+row.cs_Img+"");//给img设置	
		if(row.cs_FenPei==1){//分配
			$('#cs_FenPei').combobox('readonly',true);
		}
		if(row.cs_IsHuiFang==1&&row.cs_HuiFangTime!=null&&row.cs_HuiFangTime!=""){//回访
			$('#cs_IsHuiFang').combobox('readonly',true);
			$('#cs_HuiFangTime').datebox('readonly',true);
		}
		if(row.cs_IsBaoBei==1){//报备
			$('#cs_IsBaoBei').combobox('readonly',true);
		}
		if(row.cs_IsJiaoFei==1&&row.cs_JiaoFeiTime!=null&&row.cs_JiaoFeiTime!=""){//缴费
			$('#cs_IsJiaoFei').combobox('readonly',true);
			$("#cs_JiaoFeiTime").datebox('readonly',true);
		}
		if(row.cs_IsJinBan==1&&row.cs_JinBanTime!=null&&row.cs_JinBanTime!=""){//进班
			$('#cs_IsJinBan').combobox('readonly',true);
			$("#cs_JinBanTime").datebox('readonly',true);
		}
		if(row.cs_IsTuiFen==1){//退费
			$('#cs_IsTuiFen').combobox('readonly',true);
		}
		if(row.cs_IsVisit==1&&row.cs_VisitTime!=null&&row.cs_VisitTime!=""){//上门
			$('#cs_IsVisit').combobox('readonly',true);	
			$("#cs_VisitTime").datebox('readonly',true);
		}
		$("#edit_dialog").dialog("open");
		YanZheng();//验证
		onShenFenZheng();//根据身份证自动刷新性别，年龄，出生日期	
}
//验证手机号和身份证
function YanZheng() {
	$.extend($.fn.validatebox.defaults.rules, {   
	    phoneNum: { //验证手机号  
	        validator: function(value, param){
	         return /^1[3-8]+\d{9}$/.test(value);
	        },   
	        message: '请输入正确的手机号码。'  
	    },
	    idcard: {// 验证身份证
	    	validator: function (value) {
	    	return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
	    	},
	    	message: '身份证号码格式不正确'
	    	},
    	age: {// 验证年龄
    		validator: function (value) {
    		return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value);
    		},
    		message: '年龄必须是0到120之间的整数'
    		},
   		name: {// 验证姓名，可以是中文或英文
   			validator: function (value) {
   			return /^[\Α-\￥]+$/i.test(value) | /^\w+[\w\s]+\w+$/i.test(value);
   			},
   			message: '请输入姓名(中文或英文)'
   			}
	});	 
}
//保存修改
function clients_edit() {
	var flag=$("#edit_form").form("validate");	
	if(flag){
			$.post("updateClient",{
				Cs_ClientState:$("#cs_ClientState").combobox("getValue"),
				Cs_FenPei:$("#cs_FenPei").combobox("getValue"),
				Cs_IsJiaoFei:$("#cs_IsJiaoFei").combobox("getValue"),
				Cs_IsHuiFang:$("#cs_IsHuiFang").combobox("getValue"),
				Cs_IsValid:$("#cs_IsValid").combobox("getValue"),
				Cs_IsVisit:$("#cs_IsVisit").combobox("getValue"),
				Cs_IsBaoBei:$("#cs_IsBaoBei").combobox("getValue"),
				Cs_IsTuiFen:$("#cs_IsTuiFen").combobox("getValue"),
				Cs_IsJinBan:$("#cs_IsJinBan").combobox("getValue"),
				Cs_Id:$("#cs_Id").val(),
				Cs_Name:$("#cs_Name").val(),
				Cs_Img:$("#bbb").val(),
				Cs_Sex:$("#cs_Sex").combobox("getValue"),
				Cs_Age:$("#cs_Age").val(),
				Cs_Phone:$("#cs_Phone").val(),
				Cs_Xueli:$("#cs_Xueli").combobox("getText"),
				Cs_Email:$("#cs_Email").val(),
				Cs_QQ:$("#cs_QQ").val(),
				Cs_WeiXin:$("#cs_WeiXin").val(),
				Cs_Source:$("#cs_Source").combobox("getText"),
				Cs_SiteSheng:$("#cs_SiteSheng").val(),
				Cs_SiteShi:$("#cs_SiteShi").val(),
				Cs_SiteXian:$("#cs_SiteXian").val(),
				Cs_SiteXiangXi:$("#cs_SiteXiangXi").val(),
				Cs_TuiFenInfo:$("#cs_TuiFenInfo").val(),
				Cs_HuiFangInfo:$("#cs_HuiFangInfo").val(),
				Cs_Courses:$("#cs_Courses").combobox("getValue"),
				Cs_Money:$("#cs_Money").val(),
				Cs_Grade:$("#cs_Grade").val(),
				Cs_IsValidInfo:$("#cs_IsValidInfo").val(),
				Cs_HuiFangTime:$("#cs_HuiFangTime").datebox("getValue"),
				Cs_VisitTime:$("#cs_VisitTime").datebox("getValue"),
				Cs_JiaoFeiTime:$("#cs_JiaoFeiTime").datebox("getValue"),
				Cs_FoundTime:$("#cs_FoundTime").datebox("getValue"),
				Cs_JinBanTime:$("#cs_JinBanTime").datebox("getValue"),
				Cs_ShenFenZheng:$("#cs_ShenFenZheng").val(),
				Cs_BirthTime:$("#cs_BirthTime").datebox("getValue"),
				Cs_ConsultantRemark:$("#cs_ConsultantRemark").val(),
				Cs_Remark:$("#cs_Remark").val()			
			},function(res){
				if(res>0){				
					$.messager.alert("提示","修改成功！！！");
					$("#edit_dialog").dialog("close");
					$("#csTab").datagrid("reload");
				}else{
					$.messager.alert("提示","修改失败！！！");
				}
			},"json");			
	}else{
		$.messager.alert("提示","请按要求填写表单！！！");		
	}
	
}
//打开设置显示列对话框
 function selectColumn() {
	$("#hiddenColumn_dialog").dialog("open");
}
//保存显示列
function saveColumn() {
	var cbx = $("#hiddenColumn_form input[type='checkbox']"); //获取Form里面是checkbox的Object
    var checkedValue = "";
    var unCheckValue = "";
    for (var i = 0; i < cbx.length; i++) {
        if (cbx[i].checked) {//获取已经checked的Object
            if (checkedValue.length > 0) {
                checkedValue += "," + cbx[i].value; //获取已经checked的value
            }
            else {
                checkedValue = cbx[i].value;
            }
        }       
        if (!cbx[i].checked) {//获取没有checked的Object
            if (unCheckValue.length > 0) {
                unCheckValue += "," + cbx[i].value; //获取没有checked的value
            }
            else {
                unCheckValue = cbx[i].value;
            }
        }
    }
    var checkeds = new Array();
    if (checkedValue != null && checkedValue != "") {
        checkeds = checkedValue.split(',');
        for (var i = 0; i < checkeds.length; i++) {
            $('#csTab').datagrid('showColumn', checkeds[i]); //显示相应的列
        }
    }
    var unChecks = new Array();
    if (unCheckValue != null && unCheckValue != "") {
        unChecks = unCheckValue.split(',');
        for (var i = 0; i < unChecks.length; i++) {
            $('#csTab').datagrid('hideColumn', unChecks[i]); //隐藏相应的列
        }
    }
    $('#hiddenColumn_dialog').dialog('close');
}
//关闭设置显示列弹框
function closed_hiddenColumn(){
	$('#hiddenColumn_dialog').dialog('close');
}
//全选按钮
function ChooseAll() {	
    var a=$("#isQuanXuan").text();//获取按钮的值
    if("全选"==a.trim()){
    	 $("#hiddenColumn_form input[type='checkbox']").prop("checked", true);//全选
    	$('#isQuanXuan').linkbutton({ text:'全不选' });
    }else{    	
    	 $("#hiddenColumn_form input[type='checkbox']").removeAttr("checked", "checked");//取消全选
    	 $('#isQuanXuan').linkbutton({ text:'全选' });
    }    
}
//添加跟踪记录
function addClientUserRecord(){	
	 var rows=$("#csTab").datagrid("getSelections");
	var row=rows[0];
	 if(row!=null && rows.length==1){
		 $("#add_form").form("load",row);
		$("#add_dialog").dialog("open");
	}else{
		$.messager.alert("提示","请勾选一个复选框");
	}	
}

//关闭跟踪记录
function closed_editClientUserRecord() {
	$("#add_dialog").dialog("close");
}
//保存跟踪记录
function ClientUserRecord_edit() {
var flag=$("#add_form").form("validate");
var usersId=<%=request.getSession().getAttribute("usersId")%>
	if(flag){		
		$.post("insertClientUserRecord",{
			Cur_ZhuangTai:$("#cur_ZhuangTai").combobox("getValue"),
			Cur_LianXiFangShi:$("#cur_LianXiFangShi").combobox("getValue"),		
			Cur_ClientId:$("#cur_ClientId").val(),
			Cur_RecordTime:$("#cur_RecordTime").val(),
			Cur_Title:$("#cur_Title").val(),
			Cur_Remark:$("#cur_Remark").val(),
			Cur_UserId:usersId
		},function(res){
			if(res>0){				
				$.messager.alert("提示","保存成功！！！");
				$("#add_dialog").dialog("close");
				$("#add_form").form("clear");
			}else{
				$.messager.alert("提示","保存失败！！！");
			}
		},"json")
	}else{
		$.messager.alert("提示","请按要求填写表单！！！");
	}
}
 //导出
function exportExcel() {
	var datagridTitle = new Array();
	var rows=$("#csTab").datagrid("getSelections");//获取复选框选中行，返回数组
	if(rows!=''){
		 var fields = $("#csTab").datagrid('getColumnFields');//返回列字段
		    var Titles=datagridTitle[0];
		        for (var i = 0; i < fields.length; i++) {
		            var option = $("#csTab").datagrid('getColumnOption', fields[i]);//返回指定列属性
		            /* if (option.field != "checkItem" && option.hidden != true) { //过滤勾选框和隐藏列
		            	datagridTitle.push(option.title); 
		            	Titles+=","+datagridTitle[i];
		            } */		           
		            	datagridTitle.push(option.title);		            
		            	Titles+=","+datagridTitle[i];//包含2个undefined
		        }	        		      	        	
		        var bodyData = JSON.stringify(rows);//转成json		       		
		       $.messager.prompt('提示信息', '请输入导出的文件名：', function(r){		    	  
				if (r!=null&&r!=''){
					 $.post("exportExcel",{
							datagridTitle:Titles,
							ClientsData:bodyData,
							filePath:r							
						},function(res){
							if(res>0){
								$.messager.alert("提示","导出成功,在桌面");
							}else{
								$.messager.alert("提示","导出失败");
							}							
						},"json")
				}
			});
	}else{
		$.messager.alert("提示","请选择导出的客户信息");
	}
}

function ZhuangTaiFormatter(value,row,index) {
	return value==0?'一般':value==1?'中强':'强'
}
function LianXiFangShiFormatter(value,row,index) {
	return value==0?'来电':value==1?'邮箱':value==2?'短信':'来访'
}
//用户姓名
function LoginNameFormatter(value,row,index) {
	return value.us_LoginName
}
//客户姓名
function Cs_NameFormatter(value,row,index) {
	return value.cs_Name
}
		
    			
//查看跟踪记录
 function chakanClientUserRecord() {	 
	  var rows=$("#csTab").datagrid("getSelections");	 
		var row=rows[0];
		 if(row!=null && rows.length==1){
			 $("#ddd").datagrid({		   
					url:"selectClientUserRecordByAll",
					method:"post",
					pagination:true,			
					rownumbers:true,
					pageSize:5,
				    pageList: [5, 10, 20], 
					queryParams:{
						Cur_ClientId:row.cs_Id,
						Cur_UserId:0,
						Cur_ZhuangTai:-1,
						Cur_LianXiFangShi:-1
					}	  
				})
				$("#dd").dialog("open");
		}else{
			$.messager.alert("提示","请勾选一个复选框");
		}	 	  
 }
//省略号
 function  SLHformatter(value,row,index){
	 return '<span  title='+value+'>'+value+'</span>'  
}

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
	</script>
	</head>
	<body>
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
	 <div id="dd" class="easyui-dialog" data-options="title:'客户跟踪记录',modal:true,closed:true" style="width:700px;">
		<table id="ddd" class="easyui-datagrid">
			 <thead>
		<tr>
			<th field="ck" checkbox="true"></th>
			<th data-options="field:'cur_Id',title:'编号'"></th>
			<th data-options="field:'cur_Title',title:'标题'"></th>
			<th data-options="field:'clients',title:'客户姓名',formatter:Cs_NameFormatter"></th>
			<th data-options="field:'users',title:'用户姓名',formatter:LoginNameFormatter"></th>
			<th data-options="field:'cur_ZhuangTai',title:'意向状态',formatter:ZhuangTaiFormatter"></th>
			<th data-options="field:'cur_LianXiFangShi',title:'联系方式',formatter:LianXiFangShiFormatter"></th>
			<th data-options="field:'cur_RecordTime',title:'记录时间'"></th>
			<th data-options="field:'cur_Remark',title:'备注',width:100,formatter: SLHformatter"></th>
		</tr>
	</thead> 
		</table>
	</div> 
	
	<table id="csTab" class="easyui-datagrid">
		<thead>
			<tr>
				<th field="ck" checkbox="true"></th>
				<th data-options="field:'cs_Id',title:'编号'"></th>				
				<th data-options="field:'cs_Img',title:'头像',formatter:ImgFormatter"></th>	
				<th data-options="field:'cs_Name',width:50,title:'姓名'"></th>
				<th data-options="field:'cs_Sex',title:'性别',formatter:SexFormatter"></th>
				<th data-options="field:'cs_Age',hidden:true,title:'年龄'"></th>
				<th data-options="field:'cs_Phone',width:100,title:'电话'"></th>
				<th data-options="field:'cs_Xueli',title:'学历'"></th>
				<th data-options="field:'cs_Email',width:100,title:'邮箱',formatter: SLHformatter"></th>
				<th data-options="field:'cs_QQ',hidden:true,width:100,title:'QQ号'"></th>
				<th data-options="field:'cs_WeiXin',hidden:true,width:100,title:'微信号'"></th> 
				<th data-options="field:'cs_Source',hidden:true,title:'客户来源'"></th>
				<th data-options="field:'cs_ClientState',title:'客户状态',formatter:StateFormatter"></th>
				<th data-options="field:'cs_FenPei',hidden:true,title:'分配',formatter:FenFormatter"></th>
				<th data-options="field:'cs_SiteSheng',hidden:true,title:'省'"></th>
				<th data-options="field:'cs_SiteShi',hidden:true,title:'市'"></th>
				<th data-options="field:'cs_SiteXian',hidden:true,title:'县'"></th>
				<th data-options="field:'cs_SiteXiangXi',hidden:true,title:'详细地址'"></th>
				<th data-options="field:'cs_IsJiaoFei',title:'是否缴费',formatter:JiaoFormatter"></th>
				<th data-options="field:'cs_IsHuiFang',title:'是否回访',formatter:HuiFormatter"></th>
				<th data-options="field:'cs_IsValid',title:'是否有效',formatter:ValidFormatter"></th>
				<th data-options="field:'cs_IsVisit',title:'是否上门',formatter:VisitFormatter"></th>
				<th data-options="field:'cs_IsBaoBei',title:'是否报备',formatter:BaoFormatter"></th>
				<th data-options="field:'cs_IsTuiFen',title:'是否退费',formatter:TuiFormatter"></th>
				<th data-options="field:'cs_TuiFenInfo',hidden:true,title:'退费原因',formatter: SLHformatter"></th>
				<th data-options="field:'cs_IsJinBan',title:'是否进班',formatter:JinFormatter"></th>
				<th data-options="field:'cs_HuiFangInfo',hidden:true,title:'回访情况',formatter: SLHformatter"></th>
				<th data-options="field:'cs_Courses',title:'学员关注',formatter:CouFormatter"></th>
				<th data-options="field:'cs_Money',title:'课程费用'"></th>
				<th data-options="field:'cs_Grade',title:'课程打分'"></th>
				<th data-options="field:'cs_IsValidInfo',hidden:true,title:'无效原因',width:100,formatter: SLHformatter"></th>	
				<th data-options="field:'cs_HuiFangTime',hidden:true,width:150,title:'首次回访时间'"></th>
				<th data-options="field:'cs_VisitTime',hidden:true,width:150,title:'上门时间'"></th>
				<th data-options="field:'cs_JiaoFeiTime',hidden:true,width:150,title:'缴费时间'"></th>
				<th data-options="field:'cs_FoundTime',hidden:true,width:150,title:'创建时间'"></th>
				<th data-options="field:'cs_JinBanTime',hidden:true,width:150,title:'进班时间'"></th>
				<th data-options="field:'cs_ShenFenZheng',hidden:true,title:'身份证号'"></th>
				<th data-options="field:'cs_BirthTime',hidden:true,width:150,title:'出生时间'"></th> 
				<th data-options="field:'cs_ConsultantRemark',hidden:true,title:'咨询师备注',formatter: SLHformatter"></th>
				<th data-options="field:'cs_Remark',width:35,title:'备注',formatter: SLHformatter"></th>				
				  <th data-options="field:'caozuo',align:'center',formatter:caozuoFormatter">操作</th> 				
			</tr>
		</thead>
	</table>
	<div id="csbar">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addClientUserRecord()">添加跟踪记录</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="selectColumn()">设置显示列</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="exportExcel()">导出</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="chakanClientUserRecord()">查看跟踪记录</a>
		<a href="javascript:void(0)" id="Message" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="chakanMessage()">查看历史消息</a>
		姓名：<input type="text" class="easyui-textbox" name="cs_NameBar" id="cs_NameBar">
		回访：<select id="cs_IsHuiFangBar" class="easyui-combobox" name="cs_IsHuiFangBar" style="width:200px;">   
	   			 <option value="-1">请选择</option>
	   			  <option value="0">未回访</option> 
	   			  <option value="1">已回访</option>
			</select>
		缴费：<select id="cs_IsJiaoFeiBar" class="easyui-combobox" name="cs_IsJiaoFeiBar" style="width:200px;">   
   			 <option value="-1">请选择</option>
   			  <option value="0">未缴费</option> 
   			  <option value="1">已缴费</option>
		</select>
		跟踪(上门)开始时间：<input type="text" class="easyui-datetimebox" name="minTime" id="minTime">		
		跟踪(上门)结束时间：<input type="text" class="easyui-datetimebox" name="maxTime" id="maxTime">		
		<a href="javascript:void()"  class="easyui-linkbutton" onclick="init()" data-options="iconCls:'icon-search'">搜索</a> 
	</div>
	<!-- 添加跟踪记录 -->
	<div id="add_dialog" class="easyui-dialog" data-options="title:'添加跟踪记录',modal:true,closed:true,
	buttons:[{
				text:'保存',
				handler:function(){
				ClientUserRecord_edit();<!-- 保存 -->	
				}
			},{
				text:'关闭',
				handler:function(){
				closed_editClientUserRecord();
				}
			}]">
		<form id="add_form" class="easyui-form">	
			<table>
				<tr>
					<td>记录标题:</td>
					<td><input id="cur_Title" required="required" class="easyui-textbox" type="text" /></td>
				</tr>
				<tr>
					<td>客户编号:</td>
					<td><input data-options="readonly:true" id="cur_ClientId" class="easyui-numberbox" type="text" name="cs_Id" /></td>
				</tr>
				<tr>
					<td>客户姓名:</td>
					<td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_Name" /></td>
				</tr>
				<tr>
					<td>意向状态:</td>
					<td><select id="cur_ZhuangTai" class="easyui-combobox" name="cur_ZhuangTai" style="width:200px;">   	   			 	   			  		
	   			  		<option value="0">一般</option> 
	   			  		<option value="1">中强</option>
	   			  		<option value="2">强</option>	   			  		
						</select>
					</td>
				</tr>				
				<tr>
					<td>联系方式:</td>
					<td><select id="cur_LianXiFangShi" class="easyui-combobox" name="cur_LianXiFangShi" style="width:200px;">   	   			 	   			  		
	   			  		<option value="0">来电</option> 
	   			  		<option value="1">邮箱</option>
	   			  		<option value="2">短信</option>
	   			  		<option value="3">来访</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>备注:</td>
					<td><textarea required="required" id="cur_Remark" style="height:40px;width:200px"></textarea></td>						
				</tr>
			</table>	
		</form>
	</div>
	
	<!-- 查看详细信息 -->
	<div id="chakan_dialog" class="easyui-dialog" data-options="title:'查看',modal:true,closed:true">
		<form id="chakan_form" class="easyui-form">	
		 <table>
		 	<tr>
		 		<td>编号:</td><td><input data-options="readonly:true" class="easyui-numberbox" type="text" name="cs_Id" /></td>
		 		<td>头像:</td><td> <img alt="" id="chakan_img" src="" style="width:24px;height:24px;">	        		
	        	<td>姓名:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_Name" /></td>
		 	</tr>
		 	<tr>
		 		<td>性别:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_Sex" style="width:200px;">   	   			 
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
		 		<td>省:</td><td><select data-options="readonly:true" class="easyui-combobox" type="text" name="cs_SiteSheng" style="width:200px;" /></td>
		 		<td>市:</td><td><select data-options="readonly:true" class="easyui-combobox" type="text" name="cs_SiteShi" style="width:200px;" /></td>
		 		<td>县:</td><td><select data-options="readonly:true" class="easyui-combobox" type="text" name="cs_SiteXian" style="width:200px;" /></td>
		 	</tr>
		 	<tr>
		 		<td>详细地址:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_SiteXiangXi" /></td>
		 		<td>微信号:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_WeiXin" /></td>
		 		<td>客户来源:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_Source" /></td>
		 	</tr>
		 	<tr>
		 		<td>课程费用:</td><td><input data-options="readonly:true" class="easyui-numberbox" type="text" name="cs_Money" data-options="suffix:'￥'"/></td>
		 		<td>课程打分:</td><td><input data-options="readonly:true" class="easyui-numberbox" type="text" name="cs_Grade" /></td>
		 		<td>学员关注:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_Courses" style="width:200px;">   	   			 
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
		 		<td>是否分配:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_FenPei" style="width:200px;">   	   			 
	   			  <option value="0">未分配</option> 
	   			  <option value="1">已分配</option>
				</select></td>
		 		<td>客户状态:</td><td> <select data-options="readonly:true" class="easyui-combobox" name="cs_ClientState" style="width:200px;">   	   			 
	   			  <option value="0">续保</option> 
	   			  <option value="1">正式</option>
	   			  <option value="2">流失</option>
				</select></td>
		 		<td>是否缴费:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsJiaoFei" style="width:200px;">   	   			 
	   			  <option value="0">未缴费</option> 
	   			  <option value="1">已缴费</option>
				</select></td>
		 	</tr>
		 	<tr>
		 		<td>是否回访:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsHuiFang" style="width:200px;">  	   			 
	   			  <option value="0">未回访</option> 
	   			  <option value="1">已回访</option>
				</select></td>
		 		<td>是否有效:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsValid" style="width:200px;">   	   			 
	   			  <option value="0">待定</option>
	   			  <option value="1">无效</option> 
	   			  <option value="2">有效</option>
				</select></td>
		 		<td>是否上门:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsVisit" style="width:200px;">   	   			 
	   			  <option value="0">未上门</option> 
	   			  <option value="1">已上门</option>
				</select></td>
		 	</tr>
		 	<tr>
		 		<td>是否报备:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsBaoBei" style="width:200px;">   	   			 
	   			  <option value="0">未报备</option> 
	   			  <option value="1">已报备</option>
				</select></td>
		 		<td>是否退费</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsTuiFen" style="width:200px;">   	   			 
	   			  <option value="0">未退费</option> 
	   			  <option value="1">已退费</option>
				</select></td>
		 		<td>是否进班:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_IsJinBan" style="width:200px;">   	   			 
	   			  <option value="0">未进班</option> 
	   			  <option value="1">已进班</option>
				</select></td>
		 	</tr>
		 	<tr>
		 		<td>退费原因:</td><td><textarea readonly="readonly" style="height:40px;width:195px" name="cs_TuiFenInfo"></textarea></td>
		 		<td>回访情况:</td><td><textarea readonly="readonly" style="height:40px;width:195px" name="cs_HuiFangInfo"></textarea></td>
		 		<td>无效原因:</td><td><textarea readonly="readonly" style="height:40px;width:195px" name="cs_IsValidInfo"></textarea></td>
		 	</tr>
		 </table>   
  		 </form>   
	</div>
	<!-- 修改 -->
<div id="edit_dialog" class="easyui-dialog" data-options="title:'修改对话框',modal:true,closed:'true',
			buttons:[{
				text:'保存',
				handler:function(){
				clients_edit();<!-- 保存 -->				
				}
			},{
				text:'关闭',
				handler:function(){
				closed_edit();
				}
			}]">
	<form id="edit_form" class="easyui-form">
		<table>
		 	<tr>
		 		<td>编号:</td><td><input data-options="readonly:true" class="easyui-numberbox" id="cs_Id" type="text" name="cs_Id"/></td>
		 		<td>头像:</td><td> <img alt="" id="edit_Img" src="" style="width:24px;height:24px;">
		 		<input type="hidden" class="easyui-textbox" name="cs_Img" id="bbb"></td>
	        	<td>姓名:</td><td><input id="cs_Name" class="easyui-textbox" type="text" validType="name" name="cs_Name" required="required"/></td>
		 	</tr>
		 	<tr>
		 		<td>性别:</td><td><select id="cs_Sex" class="easyui-combobox" name="cs_Sex" style="width:200px;">   	   			 
	   			  <option value="0">男</option> 
	   			  <option value="1">女</option>
				</select></td> 
			<td>年龄:</td><td><input required="required" id="cs_Age" class="easyui-numberbox" type="text" name="cs_Age" validType="age"/></td> 
			<td>电话:</td><td><input required="required" id="cs_Phone" class="easyui-textbox" validType='phoneNum' type="text" name="cs_Phone" /></td>
		 	</tr>
		 	<tr>
		 		<td>学历:</td><td><select id="cs_Xueli" class="easyui-combobox" name="cs_Xueli" style="width:200px;">   	   			 
	   			  <option>未知</option> 
	   			  <option>大专</option>
	   			  <option>高中</option>
	   			  <option>中专</option>
	   			  <option>初中</option>
	   			  <option>本科</option>
	   			  <option>其它</option>  			 
				</select></td>
		 		<td>邮箱:</td><td> <input id="cs_Email" class="easyui-textbox" type="text" name="cs_Email" data-options="validType:'email'"/></td>
		 		<td>QQ:</td><td><input id="cs_QQ" class="easyui-textbox" type="text" name="cs_QQ" /></td>
		 	</tr>
		 	
		 	<tr>
		 		<td>省:</td><td><select id="cs_SiteSheng"  name="cs_SiteSheng" style="width:200px;"></select></td>
		 		<td>市:</td><td><select id="cs_SiteShi" name="cs_SiteShi" style="width:200px;"/></td>
		 		<td>县:</td><td><select id="cs_SiteXian" name="cs_SiteXian" style="width:200px;"/></td>
		 	</tr>
		 	<tr>
		 		<td>详细地址:</td><td><input id="cs_SiteXiangXi" class="easyui-textbox" type="text" name="cs_SiteXiangXi" /></td>
		 		<td>微信号:</td><td><input id="cs_WeiXin" class="easyui-textbox" type="text" name="cs_WeiXin" /></td>
		 		<td>客户来源:</td><td><select id="cs_Source" class="easyui-combobox" name="cs_Source" style="width:200px;">   	   			 
	   			  <option>未知</option> 
	   			  <option>百度</option>
	   			  <option>百度移动端</option>
	   			  <option>360</option>
	   			  <option>360移动端</option>
	   			  <option>搜狗</option>
	   			  <option>搜狗移动端</option>
	   			  <option>UC移动端</option>
	   			  <option>微信</option>
	   			  <option>自然流量</option>
	   			  <option>直电</option>
	   			  <option>QQ</option>  			 
				</select></td>
		 	</tr>
		 	<tr>
		 		<td>课程费用:</td><td><input id="cs_Money" class="easyui-numberbox" type="text" name="cs_Money" data-options="suffix:'￥'"/></td>
		 		<td>课程打分:</td><td><input id="cs_Grade" class="easyui-numberbox" type="text" name="cs_Grade" data-options="min:0,max:100"/></td>
		 		<td>学员关注:</td><td><select id="cs_Courses" class="easyui-combobox" name="cs_Courses" style="width:200px;">   	   			 
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
		 		<td>首次回访时间:</td><td><input id="cs_HuiFangTime" class="easyui-datetimebox" type="text" name="cs_HuiFangTime" /></td>
		 		<td>上门时间:</td><td><input id="cs_VisitTime" class="easyui-datetimebox" type="text" name="cs_VisitTime" /></td>
		 		<td>缴费时间:</td><td><input id="cs_JiaoFeiTime" class="easyui-datetimebox" type="text" name="cs_JiaoFeiTime" /></td>
		 	</tr>
		 	<tr>
		 		<td>创建时间:</td><td><input data-options="readonly:true"  id="cs_FoundTime" class="easyui-datetimebox" type="text" name="cs_FoundTime" /></td>
		 		<td>进班时间:</td><td><input id="cs_JinBanTime" class="easyui-datetimebox" type="text" name="cs_JinBanTime" /></td>
		 		<td>身份证号:</td><td><input id="cs_ShenFenZheng" class="easyui-textbox" type="text" name="cs_ShenFenZheng" validType="idcard"/></td>
		 	</tr>
		 	<tr>
		 		<td>出生时间:</td><td><input id="cs_BirthTime" class="easyui-datetimebox" type="text" name="cs_BirthTime" /></td>
		 		<td>咨询师备注:</td><td><input id="cs_ConsultantRemark" class="easyui-textbox" type="text" name="cs_ConsultantRemark" /></td>
		 		<td>备注:</td><td><input id="cs_Remark" class="easyui-textbox" type="text" name="cs_Remark" /></td>
		 	</tr>
		 	<tr>
		 		<td>是否分配:</td><td><select id="cs_FenPei" class="easyui-combobox" name="cs_FenPei" style="width:200px;">   	   			 
	   			  <option value="0">未分配</option> 
	   			  <option value="1">已分配</option>
				</select></td>
		 		<td>客户状态:</td><td> <select id="cs_ClientState" class="easyui-combobox" name="cs_ClientState" style="width:200px;">   	   			 
	   			  <option value="0">续保</option> 
	   			  <option value="1">正式</option>
	   			  <option value="2">流失</option>
				</select></td>
		 		<td>是否缴费:</td><td><select id="cs_IsJiaoFei" class="easyui-combobox" name="cs_IsJiaoFei" style="width:200px;">   	   			 
	   			  <option value="0">未缴费</option> 
	   			  <option value="1">已缴费</option>
				</select></td>
		 	</tr>
		 	<tr>
		 		<td>是否回访:</td><td><select id="cs_IsHuiFang" class="easyui-combobox" name="cs_IsHuiFang" style="width:200px;">  	   			 
	   			  <option value="0">未回访</option> 
	   			  <option value="1">已回访</option>
				</select></td>
		 		<td>是否有效:</td><td><select id="cs_IsValid" class="easyui-combobox" name="cs_IsValid" style="width:200px;">   	   			 
	   			   <option value="0">待定</option>
	   			  <option value="1">无效</option> 
	   			  <option value="2">有效</option>
				</select></td>
		 		<td>是否上门:</td><td><select id="cs_IsVisit" class="easyui-combobox" name="cs_IsVisit" style="width:200px;">   	   			 
	   			  <option value="0">未上门</option> 
	   			  <option value="1">已上门</option>
				</select></td>
		 	</tr>
		 	<tr>
		 		<td>是否报备:</td><td><select id="cs_IsBaoBei" class="easyui-combobox" name="cs_IsBaoBei" style="width:200px;">   	   			 
	   			  <option value="0">未报备</option> 
	   			  <option value="1">已报备</option>
				</select></td>
		 		<td>是否退费</td><td><select id="cs_IsTuiFen" class="easyui-combobox" name="cs_IsTuiFen" style="width:200px;">   	   			 
	   			  <option value="0">未退费</option> 
	   			  <option value="1">已退费</option>
				</select></td>
		 		<td>是否进班:</td><td><select id="cs_IsJinBan" class="easyui-combobox" name="cs_IsJinBan" style="width:200px;">   	   			 
	   			  <option value="0">未进班</option> 
	   			  <option value="1">已进班</option>
				</select></td>
		 	</tr>
		 	<tr>
		 		<td>退费原因:</td><td><textarea style="height:40px;width:195px" name="cs_TuiFenInfo"></textarea></td>
		 		<td>回访情况:</td><td><textarea style="height:40px;width:195px" name="cs_HuiFangInfo"></textarea></td>
		 		<td>无效原因:</td><td><textarea style="height:40px;width:195px" name="cs_IsValidInfo"></textarea></td>
		 	</tr>
		 </table>   
	</form>
</div>
<!-- 设置显示列 -->
<div id="hiddenColumn_dialog" class="easyui-dialog" data-options="title:'设置显示列',modal:true,closed:'true',
			buttons:[{
				text:'保存',
				handler:function(){
				saveColumn();<!-- 保存 -->				
				}
			},{
				text:'关闭',
				handler:function(){
				closed_hiddenColumn();
				}
			}]">
	<form id="hiddenColumn_form" class="easyui-form">
	<a href="javascript:void()"  class="easyui-linkbutton" id="isQuanXuan" onclick="ChooseAll()" data-options="iconCls:'icon-edit'">全不选</a> 
		<table>
			<tr>
				<td><input type="checkbox" checked="checked" value="cs_Id"/>编号</td>			
				<td><input type="checkbox" checked="checked" value="cs_Name"/>姓名</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_Img"/>头像</td>			
				<td><input type="checkbox" checked="checked" value="cs_Sex"/>性别</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_Age"/>年龄</td>			
				<td><input type="checkbox" checked="checked" value="cs_Phone"/>电话</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="cs_Xueli"/>学历</td>			
				<td><input type="checkbox" checked="checked" value="cs_Email"/>邮箱</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_QQ"/>QQ号</td>			
				<td><input type="checkbox" value="cs_WeiXin"/>微信号</td> 
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_Source"/>客户来源</td>		
				<td><input type="checkbox" checked="checked" value="cs_ClientState"/>客户状态</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_FenPei"/>是否分配</td>			
				<td><input type="checkbox" value="cs_SiteSheng"/>省</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_SiteShi"/>市</td>			
				<td><input type="checkbox" value="cs_SiteXian"/>县</td>
			</tr>			
			<tr>
				<td><input type="checkbox" value="cs_SiteXiangXi"/>详细地址</td>			
				<td><input type="checkbox" checked="checked" value="cs_IsJiaoFei"/>是否缴费</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="cs_IsHuiFang"/>是否回访</td>			
				<td><input type="checkbox" checked="checked" value="cs_IsValid"/>是否有效</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="cs_IsVisit"/>是否上门</td>		
				<td><input type="checkbox" checked="checked" value="cs_IsBaoBei"/>是否报备</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="cs_IsTuiFen"/>是否退费</td>			
				<td><input type="checkbox" value="cs_TuiFenInfo"/>退费原因</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="cs_IsJinBan"/>是否进班</td>			
				<td><input type="checkbox" value="cs_HuiFangInfo"/>回访情况</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="cs_Courses"/>学员关注</td>			
				<td><input type="checkbox" checked="checked" value="cs_Money"/>课程费用</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="cs_Grade"/>课程打分</td>			
				<td><input type="checkbox" value="cs_IsValidInfo"/>无效原因</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_HuiFangTime"/>首次回访时间</td>			
				<td><input type="checkbox" value="cs_VisitTime"/>上门时间</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_JiaoFeiTime"/>缴费时间</td>			
				<td><input type="checkbox" value="cs_FoundTime"/>创建时间</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_JinBanTime"/>进班时间</td>		
				<td><input type="checkbox" value="cs_ShenFenZheng"/>身份证号</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_BirthTime"/>出生时间</td>	 		
				<td><input type="checkbox" value="cs_ConsultantRemark"/>咨询师备注</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="cs_Remark"/>备注</td>							
			</tr>
		</table>
	</form>
</div>
</body>

</html>