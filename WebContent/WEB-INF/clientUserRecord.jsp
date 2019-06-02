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
<style type="text/css">
            .datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber
            {
                text-overflow: ellipsis;
            }
   </style>
<script type="text/javascript">
$(function(){	
	 $('#us_LoginNameBar').combobox({    
	    url:'selectZHaoUsers',
	    method:"post",
	    valueField:'us_Id',    
	    textField:'us_LoginName'   
	});	
	init();	
})
function init() {
	var minTime=$("#minTime").datebox("getValue");
	var maxTime=$("#maxTime").datebox("getValue");
	var Cur_UserId=$("#us_LoginNameBar").combobox("getValue");
	if(Cur_UserId=="请选择"){
		Cur_UserId=0;		
	}
	if(minTime<=maxTime){
		$("#curTab").datagrid({
			url:"selectClientUserRecordByAll",
			method:"post",
			pagination:true,
			rownumbers:true,
			toolbar:"#curBar",
			onDblClickCell: function(index,field,value){
				chakanCur(index);
			},
			queryParams:{
				Cur_Title:$("#Cur_TitleBar").val().replace(/^\s*|\s*$/g,""),//去除字符串内两边的空格
				minTime:minTime,
				maxTime:maxTime,
				Cur_UserId:Cur_UserId,
				Cur_ZhuangTai:$("#Cur_ZhuangTaiBar").combobox("getValue"),
				Cur_LianXiFangShi:$("#Cur_LianXiFangShiBar").combobox("getValue")
			}		 
		})
	}else{
		$.messager.alert("提示","跟踪开始时间不能大于跟踪结束时间！！！");
	}
}
function chakanCur(index) {
	
	var rows=$("#curTab").datagrid("getRows");
	var row=rows[index];
	$("#cs_Name").textbox('setValue',row.clients.cs_Name);
	$("#us_LoginName").textbox('setValue',row.users.us_LoginName);
	$("#chakan_form").form("load",row);		
	$("#chakan_dialog").dialog("open");	
}
function ZhuangTaiFormatter(value,row,index) {
	return value==0?'一般':value==1?'中强':'强'
}
function LianXiFangShiFormatter(value,row,index) {
	return value==0?'来电':value==1?'邮箱':value==2?'短信':'来访'
}
function LoginNameFormatter(value,row,index) {
	return value.us_LoginName
}
function Cs_NameFormatter(value,row,index) {
	return value.cs_Name
}
function  SLHformatter(value,row,index){
	 return '<span  title='+value+'>'+value+'</span>'  
}
</script>

</head>
<body>
<table id="curTab" class="easyui-datagrid">
	<thead>
		<tr>
			<th field="ck" checkbox="true"></th>
			<th data-options="field:'cur_Id',title:'编号'"></th>
			<th data-options="field:'cur_Title',width:150,title:'标题'"></th>
			<th data-options="field:'clients',title:'客户姓名',formatter:Cs_NameFormatter"></th>
			<th data-options="field:'users',title:'用户姓名',formatter:LoginNameFormatter"></th>
			<th data-options="field:'cur_ZhuangTai',title:'意向状态',formatter:ZhuangTaiFormatter"></th>
			<th data-options="field:'cur_LianXiFangShi',title:'联系方式',formatter:LianXiFangShiFormatter"></th>
			<th data-options="field:'cur_RecordTime',title:'记录时间'"></th>
			<th data-options="field:'cur_Remark',title:'备注',width:100,formatter:SLHformatter"></th>
		</tr>
	</thead>
</table>
<div id="curBar">		
		标题：<input type="text" class="easyui-textbox" name="Cur_TitleBar" id="Cur_TitleBar">
		 跟踪者：<select id="us_LoginNameBar" class="easyui-combobox" style="width:200px;">   
   			<option>请选择</option>  			
		</select> 
		意向状态：<select id="Cur_ZhuangTaiBar" class="easyui-combobox" name="Cur_ZhuangTaiBar" style="width:200px;">   
	   			 <option value="-1">请选择</option>
	   			  <option value="0">一般</option> 
	   			  <option value="1">中强</option>
	   			  <option value="2">强</option>
			</select>
		联系方式：<select id="Cur_LianXiFangShiBar" class="easyui-combobox" name="Cur_LianXiFangShiBar" style="width:200px;">   
   			<option value="-1">请选择</option>
   			<option value="0">来电</option> 
	   		<option value="1">邮箱</option>
	   		<option value="2">短信</option>
	   		<option value="3">来访</option>
		</select>
		跟踪开始时间：<input type="text" class="easyui-datetimebox" name="minTime" id="minTime">		
		跟踪结束时间：<input type="text" class="easyui-datetimebox" name="maxTime" id="maxTime">		
		<a href="javascript:void()"  class="easyui-linkbutton" onclick="init()" data-options="iconCls:'icon-search'">搜索</a> 
	</div>
<!-- 查看详细信息 -->
	<div id="chakan_dialog" class="easyui-dialog" data-options="title:'查看',modal:true,closed:true">
		<form id="chakan_form" class="easyui-form">	
		 <table>
		 	<tr><td>编号:</td><td><input data-options="readonly:true" class="easyui-numberbox" type="text" name="cur_Id" /></td></tr>
		 	<tr><td>标题:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cur_Title"/></td></tr>
		 	<tr><td>客户姓名:</td><td><input id="cs_Name" data-options="readonly:true" class="easyui-numberbox" type="text" name="cs_Name" /></td></tr>
		 	<tr><td>跟踪者:</td><td><input id="us_LoginName" data-options="readonly:true" class="easyui-numberbox" type="text" /></td></tr>
		 	<tr><td>意向状态:</td><td><select class="easyui-combobox" name="Cur_ZhuangTai" style="width:200px;">   	   			 
	   			  <option value="0">一般</option> 
	   			  <option value="1">中强</option>
	   			  <option value="2">强</option>
			</select></td></tr>
		 	<tr><td>联系方式:</td><td><select class="easyui-combobox" name="Cur_LianXiFangShi" style="width:200px;">
   			<option value="0">来电</option>
	   		<option value="1">邮箱</option>
	   		<option value="2">短信</option>
	   		<option value="3">来访</option>
			</select></td></tr>
			<tr><td>记录时间:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cur_RecordTime" /></td></tr>
		 	<tr><td>备注:</td><td><textarea style="height:40px;width:200px" name="cur_Remark"></textarea></td></tr>		 					
		 	</table>
		 </form>
	</div>	
</body>
</html>