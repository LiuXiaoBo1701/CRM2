<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>角色管理</title>
	<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/icon.css"/>
	<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/metro/easyui.css"/>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
<script>
	/*数据加载*/
	$(function(){
		$("#tab").datagrid({
			url:'selectRolesAll',
			method:'post'
		});
	});
	/*操作*/
	function sheZhiQuanXian(value,row,index){
		return "<a onclick='SheZhi("+index+")'>设置</a> &nbsp;<a onclick='tabDelete("+index+")'>删除</a>  &nbsp;<a onclick='tabUpdate("+index+")'>修改</a>"
	}
	
	/*新增*/
	function addInfo(){
		$("#addUser").window("open");
	}
	/*新增--保存*/
	function submitUserForm(){
		var flag=$("#addForm").form("validate");
		var ename=$("#add_Name").textbox("getValue");
		if(flag){
			$.post("insertRoles",{
				rs_Name:ename
			},
			function(res){
				if(res==1){
					$.messager.alert("提示","新增角色成功");
					$("#addUser").window("close");
					$("#tab").datagrid("reload");
				}else if(res==2){
					$.messager.alert("提示","角色名已存在");
				}else{
					$.messager.alert("提示","新增角色失败");
				}
			},"json");
		}
	}
	/*新增--取消*/
	function clearUserForm(){
		$("#addForm").form("clear");
	}
	/*修改*/
	function tabUpdate(index){
		var data=$("#tab").datagrid("getData");
		var row=data.rows[index];
		$("#updateFrom").form("load",row);
		$("#updateUser").window("open");
		
	}
	/*修改--保存*/
	function updateSubmitUserForm(){
		var row=$("#tab").datagrid("getSelected");
		var name=$("#upd_Name").textbox("getValue");
		$.post("updateRoles",{
			rs_Id:row.rs_Id,  
			rs_Name:name
		},
		function(res){
			if(res==1){
				$.messager.alert("提示","修改角色成功");
				$("#updateUser").window("close");
				$("#tab").datagrid("reload");
			}else if(res==2){
				$.messager.alert("提示","角色名已存在");
			}else{
				$.messager.alert("提示","修改角色失败");
			}
		},"json");
	}
	/*修改--取消*/
	function updateClearUserForm(){
		$("#updateUser").window("close");
	}
	/*删除*/
	function tabDelete(index){
		var data=$("#tab").datagrid("getData");
		var row=data.rows[index];
		$.messager.confirm("删除","确定要删除吗？",function(res){
			if(res){
				$.post("deleteRoles",{
					rolesId:row.rs_Id
				},function(res){
					if(res==1){
						$.messager.alert("提示","删除角色成功");
						$("#tab").datagrid("reload");
					}else if(res==2){
						$.messager.alert("提示","该角色已有模块，不能删除");
					}else{
						$.messager.alert("提示","删除角色失败");
					}
				})
			}else{
				$.messager.alert("提示","删除角色失败");
			}
		});
	}
	/*设置*/
	var rloesId;
	function SheZhi(index){
		var data=$("#tab").datagrid("getData");
		var row=data.rows[index];
		rloesId=row.rs_Id;
		$("#shiZhiTree").tree({
			url:'selectModulesAllSheZhi',
			method:'post',
			checkbox:true,
			queryParams:{
				rloesId:row.rs_Id
			}
		})
		$("#roleSheZhi").window("open");
	}
	/*设置--保存*/
	function shiZhiBaoCun(){
		var row=$("#tab").datagrid("getRows");
		var nodes=$("#shiZhiTree").tree("getChecked",["checked","indeterminate"]);
		var s="";
		for(var i=0;i<nodes.length;i++){
			if(s==""){
				s+=nodes[i].id;
			}else{
				s+=",",
				s+=nodes[i].id;
			}
		}
		$.post("insertRoleModules",{
			parentIds:s,		//功能模块id拼接的字符串(以逗号分隔)
			rolesId:rloesId			//要设置的角色的id
		},function(res){
			if(res>0){
				$.messager.alert("提示","权限设置成功！！！");
				$("#tab").datagrid("reload");
			}else{
				$.messager.alert("提示",res.message);
			}
		},"json");
	}
</script>
</head>
<body>
<!--数据表格-->
<table class="easyui-datagrid" id="tab" title="角色管理" data-options="rownumbers:true,singleSelect:true,pagination:true,method:'post',toolbar:'#infoId'">
	<thead>
		<tr>
			<th data-options="field:'rs_Id',hidden:true,align:'center'">角色ID</th>
			<th data-options="field:'rs_Name',align:'center',width:200">角色名称</th>
			<th data-options="field:'caozuo',width:200,title:'设置权限',align:'center',formatter:sheZhiQuanXian">操作</th>
		</tr>
	</thead>
</table>
<!--新增-->
<div id="infoId">
	<div style="margin-bottom: 5px;">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add"  onclick="addInfo()">新增</a>
	</div>
</div>
<div id="addUser" class="easyui-window" title="新增角色" data-options="iconCls:'icon-save',closed:true" style="width: 400px;height: 300px;">
	<form id="addForm">
		<table cellpadding="5">
			<tr>
				<td>角色名称:</td>
				<td><input id="add_Name"  class="easyui-textbox" required="required"/></td>
			</tr>
		</table>
	</form>
	<div style="text-align: center;">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitUserForm()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearUserForm()">取消</a>
	</div>
</div>
<!-- 修改 -->
<div id="updateUser" class="easyui-window" title="修改角色名称" data-options="iconCls:'icon-save',closed:true" style="width: 400px;height: 300px;">
	<form id="updateFrom">
		<table cellpadding="5">
			<tr>
				<td>角色名称:</td>
				<td><input id="upd_Name" name="rs_Name" class="easyui-textbox" required="required"/></td>
			</tr>
		</table>
	</form>
	<div style="text-align: center;">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateSubmitUserForm()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateClearUserForm()">取消</a>
	</div>
</div>
<!--设置-->
<div id="roleSheZhi" class="easyui-window" data-options="iconCls:'icon-save',closed:true" style="width: 500px; height: 500px;">
	<ul id="shiZhiTree" class="easyui-tree" ></ul>
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="shiZhiBaoCun()">保存</a>
</div>

</body>
</html>