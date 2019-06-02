<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/icon.css"/>
	<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/metro/easyui.css"/>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	 <script type="text/javascript" src="js/address.js"></script> 
</head>
<script type="text/javascript">
	$(function(){
	 	$('#QianDao').combobox({    
			url:'getClasses',
			method:'post',
			valueField:'us_Id',//<option value='valueField'></option>    
		    textField:'us_LoginName'// <option value=''> textField </option>
		}) 
		//
		into();
	})
	
	function ImgFormatter(value,row,index) {
		if(row.cs_Img != null && row.cs_Img != ''){
			 return	"<img style='width:24px;height:24px;' src='image/"+row.cs_Img+"'/>";
			
		}else{
			 return	"暂无";
		}
	}
	function SexFormatter(value,row,index) {
		return value==0?'男':'女'
	}
	 
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
	function into(){
		var usersName= '<%=session.getAttribute("usersName")  %>';
		$("#Clientstable").datagrid({
			url:"getClient",
			method:'post',
			pagination:true,
			rownumbers:true,
			singleSelect:false,
			selectOnCheck:true,
			toolbar:'#Client_toolbar',
			onDblClickCell: function(index,field,value){
				chakan(index);
			},
			queryParams:{
				Cs_Ext2:usersName,
				/* C_Id:C_id, */
				Cs_QQ:$("#search_Cs_QQ").val(),
				cs_Name:$("#search_CSname").val(), 
				cs_Phone:$("#search_Cs_Phone").val(), 
				minTime:$('#min_time').datebox('getValue'),
				maxTime:$('#max_time').datebox('getValue'),
				cs_ClientState:$('#select_cs_ClientState').val()
			} 
		})
	
	}
	//图片展示
	function showImg(value, row, index){
		if(row.url){
			return "<img style='width:24px;height:24px;' border='1' src='"+row.url+"'/>";
		}
	}
	//添加客户
	function addClient(){
		
		$('#Client_from').form('reset');
		 addressInit('cs_SiteSheng', 'cs_SiteShi', 'cs_SiteXian');//省市县（区）三级联动，必须和js文件地址匹配
		$('#add_ClientWin').window('open');
	}
	function Client_cead(){
		$('#add_ClientWin').window('close');
		
	}
	//通知信息
	var faSongRen='${usersName}';
	var JieShouRen='张耀';
	var webscoket=new WebSocket("ws:localhost:8080/CRM/webscoket/"+faSongRen);
	
	//添加保存按钮
	 function Client_Submit(){
		var	cs_SiteSheng=	 $("#cs_SiteSheng").val();
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
					 	formData.append("JieShouRen",JieShouRen);
					 	formData.append("faSongRen",faSongRen);
					 	$.ajax({
				            url:"innsertClients",
				            type:"post",
				            data:formData,
				            contentType:false,
				            processData:false,
				            success:function(res){
				            	if(res==1) {
									$.messager.alert("提示","新增成功");
									$('#Clientstable').datagrid('reload');
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
		 
//表格导出
  	function exportExl(){  
	  	var data=$("#Clientstable").datagrid("getSelections");
	    var cs_Id="";
		for(var i=0;i<data.length;i++){
			var row=data[i].cs_Id;
			cs_Id=cs_Id+row+",";
		}   
		if(row!=null){
			 location.href="excel/export?&Cs_Id="+cs_Id;   
		}else{
			   $.messager.alert('提示','请选择要导出的行');
		}
	       
    }  
  	
  	//批量操作
  	function updateshi(){
  		$('#QianDaoUs_Id').combobox({    
			url:'getClasses',
			method:'post',
			valueField:'us_Id',//<option value='valueField'></option>    
		    textField:'us_LoginName'// <option value=''> textField </option>
		}) 
  		$('#updatezixunshi_win').window('open');
  	}
  	function SubmitUpdatezixunshi(){
  		var selectTion= $('#Clientstable').datagrid('getSelections');
  		var shi=$('#QianDaoUs_Id').combobox("getValue");
  	  	var aa="";
		for(var i=0;i<selectTion.length;i++){
			 var row=selectTion[i].cs_Id;
			aa=aa+row+",";
		} 
		$.post('fenpeizixunshi',
				{
			Cs_ids:aa,
			C_Id:shi
				},function(res){
					if(res>0){
						$('#updatezixunshi_win').window('close');
						$('#Clientstable').datagrid('reload');
						$.messager.alert('提示','更改成功');
					}else{
						$('#updatezixunshi_win').window('close');
						$.messager.alert('提示','更改失败');
						
					}			
		},'json')
		
  	}
  	
  	 function cs_Source(value,row,index){
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
	 function ClientState(value,row,index){
		return value==0?'正式':value==1?'续保':'流失';
	 }
	 function cs_IsJiaoFei(value,row,index){
		 return value==0?'是':'否';
	 }
	 function cs_IsHuiFang(value,row,index){
		 return value==0?'是':'否';
	 }
	 function cs_IsValid(value,row,index){
		 return value==0?'是':'否';
	 }
	 function cs_IsBaoBei(value,row,index){
		 return value==0?'是':'否';
	 }
	 function cs_IsTuiFen(value,row,index){
		 return value==0?'是':'否';
	 }
	 
	 
	 function cs_IsJinBan(value,row,index){
		 return value==0?'是':'否';
	 }
	 
	 
	 function cs_IsVisit(value,row,index){
		 return value==0?'是':'否';
	 }
	 
	 
	 function cs_Sex(value,row,index){
		 return value==0?'男':'女';
	 }
	 
	 function cs_FenPei(value,row,index){
		 return value==0?'未分配':'已分配';
	 }
	 
	 function shifou(value,row,index){
		 return ;
		 
	 }
	 
	 
	 function users(value,row,index){
		 return value.us_LoginName;	 	 
	 }
	 
 
	function chakan(index){
		var rows=$("#Clientstable").datagrid("getRows");
		var row=rows[index];
		$("#chakan_form").form("load",row);
		var a=$("#cs_Img").val();//获取图片名称		
		a="image/"+a;//图片路径
		$("#aaa").attr("src",a);//给img设置
		$("#chakan_dialog").dialog("open");
	}
	//打开设置显示列对话框
  	function selectColumn() {
		$("#hiddenColumn_dialog").dialog("open");
	}
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
	            $('#Clientstable').datagrid('showColumn', checkeds[i]); //显示相应的列
	        }
	    }
	    var unChecks = new Array();
	    if (unCheckValue != null && unCheckValue != "") {
	        unChecks = unCheckValue.split(',');
	        for (var i = 0; i < unChecks.length; i++) {
	            $('#Clientstable').datagrid('hideColumn', unChecks[i]); //隐藏相应的列
	        }
	    }
	}
	//关闭设置显示列弹框
	function closed_hiddenColumn(){
		$('#hiddenColumn_dialog').dialog('close');
	}
	//全选按钮
	function ChooseAll() {
		
	    var a=$("#isQuanXuan").text();//获取按钮的值
	    if("全选"==a.trim()){
	    	 $("#  input[type='checkbox']").prop("checked", true);//全选
	    	$('#isQuanXuan').linkbutton({ text:'全不选' });
	    }else{    	
	    	 $("#hiddenColumn_form input[type='checkbox']").removeAttr("checked", "checked");//取消全选
	    	 $('#isQuanXuan').linkbutton({ text:'全选' });
	    }    
	}
</script> 
<body>
	
    <div id="updatezixunshi_win" class="easyui-window" title="修改信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;height:300px;padding:10px;">
	<form id="UpdateUsers_Form">
		<table cellpadding="5">
		   <tr>
			    <td>咨询师名称:</td>
				<td>
				<select id="QianDaoUs_Id"  class="easyui-combobox"  style="width:200px;">   
			    <option>请选择</option>  
                </select>  
				</td>
			</tr>
			</table>
			
			
	</form>
	<div style="text-align:center;padding:5px">
		<a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="SubmitUpdatezixunshi()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="CloseForm()">取消</a>
	</div>
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
		 		<td>退费原因:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_TuiFenInfo" /></td>
		 		<td>回访情况:</td><td><input data-options="readonly:true" class="easyui-textbox" type="text" name="cs_HuiFangInfo" /></td>
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
		 		<td>出生时间:</td><td><input data-options="readonly:true" class="easyui-datebox" type="text" name="cs_BirthTime" /></td>
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
		 		<td>是否分配:</td><td><select data-options="readonly:true" class="easyui-combobox" name="cs_FenPei" style="width:200px;">   	   			 
	   			  <option value="0">未分配</option> 
	   			  <option value="1">已分配</option>
				</select></td>
		 	</tr>
		 </table>   
  		 </form> 
	</div>
	

	<table id="Clientstable" class="easyui-datagrid">
    <thead>   
        <tr>   
            <th data-options="field:'cs_Id',checkbox:true" >编码</th>   
            <th data-options="field:'cs_Img',title:'头像',formatter:ImgFormatter"></th>	
				 <th data-options="field:'cs_Name',title:'姓名'"></th>
				<th data-options="field:'cs_Sex',title:'性别',formatter:SexFormatter"></th>
				<th data-options="field:'cs_Age',title:'年龄'"></th>
				<th data-options="field:'cs_Phone',title:'电话'"></th>
				<th data-options="field:'cs_Email',title:'邮箱'"></th>
				<th data-options="field:'cs_QQ',title:'QQ号'"></th>
				<th data-options="field:'cs_Source',title:'客户来源',formatter:cs_Source"></th>
				<!-- <th data-options="field:'users',formatter:users,title:'咨询师名字'"></th>   -->
				<th data-options="field:'cs_Remark',title:'备注'"></th>
 				<th data-options="field:'cs_Xueli',hidden:true,title:'学历'"></th>
				<th data-options="field:'cs_WeiXin',hidden:true,title:'微信号'"></th>
				<th data-options="field:'cs_ClientState',hidden:true,title:'客户状态',formatter:StateFormatter"></th>
				<th data-options="field:'cs_FenPei',hidden:true,title:'分配',formatter:FenFormatter"></th>
				<th data-options="field:'cs_SiteSheng',hidden:true,title:'省'"></th>
				<th data-options="field:'cs_SiteShi',hidden:true,title:'市'"></th>
				<th data-options="field:'cs_SiteXian',hidden:true,title:'县'"></th>
				<th data-options="field:'cs_SiteXiangXi',hidden:true,title:'详细地址'"></th>
				<th data-options="field:'cs_IsJiaoFei',hidden:true,title:'是否缴费',formatter:JiaoFormatter"></th>
				<th data-options="field:'cs_IsHuiFang',hidden:true,title:'是否回访',formatter:HuiFormatter"></th>
				<th data-options="field:'cs_IsValid',hidden:true,title:'是否有效',formatter:ValidFormatter"></th>
				<th data-options="field:'cs_IsVisit',hidden:true,title:'是否上门',formatter:VisitFormatter"></th>
				<th data-options="field:'cs_IsBaoBei',hidden:true,title:'是否报备',formatter:BaoFormatter"></th>
				<th data-options="field:'cs_IsTuiFen',hidden:true,title:'是否退费',formatter:TuiFormatter"></th>
				<th data-options="field:'cs_TuiFenInfo',hidden:true,title:'退费原因'"></th>
				<th data-options="field:'cs_IsJinBan',hidden:true,title:'是否进班',formatter:JinFormatter"></th>
				<th data-options="field:'cs_HuiFangInfo',hidden:true,title:'回访情况'"></th>
				<th data-options="field:'cs_Courses',hidden:true,title:'学员关注',formatter:CouFormatter"></th>
				<th data-options="field:'cs_Money',hidden:true,title:'课程费用'"></th>
				<th data-options="field:'cs_Grade',hidden:true,title:'课程打分'"></th>
				<th data-options="field:'cs_IsValidInfo',hidden:true,title:'无效原因'"></th>	
				<th data-options="field:'cs_HuiFangTime',hidden:true,title:'首次回访时间'"></th>
				<th data-options="field:'cs_VisitTime',hidden:true,title:'上门时间'"></th>
				<th data-options="field:'cs_JiaoFeiTime',hidden:true,title:'缴费时间'"></th>
				<th data-options="field:'cs_FoundTime',hidden:true,title:'创建时间'"></th>
				<th data-options="field:'cs_JinBanTime',hidden:true,title:'进班时间'"></th>
				<th data-options="field:'cs_ShenFenZheng',hidden:true,title:'身份证号'"></th>
				<th data-options="field:'cs_BirthTime',hidden:true,title:'出生时间'"></th>
				<th data-options="field:'cs_ConsultantRemark',hidden:true,title:'咨询师备注'"></th>
        </tr>   
    </thead> 
    </table>
    
	<div id="Client_toolbar">
		<div id="p" class="easyui-panel" title="操作客户"     
        style="padding:10px;"   
        data-options="closable:false,    
                collapsible:true,minimizable:false,maximizable:false">   
			<form id="Client_form" class="eayui-form">
						<label for="name">客户姓名:</label>   
        				<input class="easyui-validatebox" type="text"  id="search_CSname" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        				<label for="name">联系电话:</label>   
        				<input class="easyui-validatebox" type="text"  id="search_Cs_Phone" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        				<label for="name">QQ:</label>   
        				<input class="easyui-validatebox" type="text"  id="search_Cs_QQ" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        				<!-- <label for="name">咨询师:</label>   
					<select id="searchQianDao"  class="easyui-combobox"  style="width:200px;">   
					    <option>--请选择--</option>  
		                </select> --> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
        				<label for="name">是否缴费:</label>   
        				 <select id="select_cs_ClientState" 	 name="cs_ClientState" style="width:100px;">   
						    <option value="">--请选择--</option>   
						    <option value="0">是</option>   
						    <option value="1">否</option>   
						</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<label for="name">创建时间:</label>   
        				<input class="easyui-datetimebox" type="text" id="min_time" /> <span>至</span>
        				<input class="easyui-datetimebox" type="text" id="max_time" />
        				<a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="into()">开始搜索</a>
			</form>
			
			<!--修改客户信息
				在线录入：姓名、性别、年龄、电话、学历、状态、来源渠道、来源网站、来源关键词、所在区域、学员关注、来源部门、学员QQ、微信号、是否报备（是，否）、咨询师、
				录入人   -->
			<!-- 
			1．查询条件：姓名关键字、电话、咨询师、是否缴费、是否有效、是否回访、QQ、创建时间/上门时间/首次回访时间/缴费时间/进班时间 -->
			<br/>
			<a  href="javascript:void(0)" class="easyui-menubutton" data-options="iconCls:'icon-undo',hasDownArrow:false" onclick="exportExl()">导出</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a  href="javascript:addClient()" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >新增客户</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="selectColumn()">设置显示列</a>
		</div>
	</div>
	
	
	<!--客户添加页面  -->
	
	<div id="add_ClientWin" class="easyui-window"  title="新增客户"  style="width:600px;height:470px;" data-options="modal:true,closed:true">
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

	
	<!-- 设置显示列 -->
	<div id="hiddenColumn_dialog" class="easyui-dialog" data-options="title:'设置显示列',modal:true,closed:'true',
			buttons:[{
				text:'保存',
				handler:function(){
				saveColumn();<!-- 保存 -->
				into();<!-- 刷新 -->
				closed_hiddenColumn(); <!-- 关闭弹窗  -->
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
				<td><input type="checkbox" checked="checked" value="cs_Img"/>头像</td>			
				<td><input type="checkbox" checked="checked" value="cs_Sex"/>性别</td>
			</tr>
			<tr>
				<td><input type="checkbox"checked="checked" value="cs_Age"/>年龄</td>			
				<td><input type="checkbox" checked="checked"  value="cs_Phone"/>电话</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_Xueli"/>学历</td>			
				<td><input type="checkbox" checked="checked" value="cs_Email"/>邮箱</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="cs_QQ"/>QQ号</td>			
				<td><input type="checkbox" value="cs_WeiXin"/>微信号</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="cs_Source"/>客户来源</td>		
				<td><input type="checkbox" value="cs_ClientState"/>客户状态</td>
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
				<td><input type="checkbox" value="cs_IsJiaoFei"/>是否缴费</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_IsHuiFang"/>是否回访</td>			
				<td><input type="checkbox" value="cs_IsValid"/>是否有效</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_IsVisit"/>是否上门</td>		
				<td><input type="checkbox" value="cs_IsBaoBei"/>是否报备</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_IsTuiFen"/>是否退费</td>			
				<td><input type="checkbox" value="cs_TuiFenInfo"/>退费原因</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_IsJinBan"/>是否进班</td>			
				<td><input type="checkbox" value="cs_HuiFangInfo"/>回访情况</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_Courses"/>学员关注</td>			
				<td><input type="checkbox" value="cs_Money"/>课程费用</td>
			</tr>
			<tr>
				<td><input type="checkbox" value="cs_Grade"/>课程打分</td>			
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
				<td><input type="checkbox" value="cs_Weight"/>客户权重</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="users"/>咨询师名字</td>			
			</tr>
		</table>
	</form>
</div>
</body>
</html>