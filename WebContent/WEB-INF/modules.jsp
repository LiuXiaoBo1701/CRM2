<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>模块管理</title>
	<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/icon.css"/>
	<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/metro/easyui.css"/>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
<script>
	$(function(){
		$("#treeId").tree({
			url:'selectModulesAll',	
			method:'post',
			lines:true,		//定义是否显示树控件上的虚线。
			animate:true,	//定义节点在展开或折叠的时候是否显示动画效果。
			onContextMenu: function(e, node){ //给结点添加右键菜单 
                 e.preventDefault();  //阻止右键默认事件
                 var nodes=$("#treeId").tree("getParent",node.target);
                 if(nodes==null){
                	//右击时选中该行
                	$('#treeId').tree('select', node.target);
          			// 显示快捷菜单
 	         		$('#FuJieDian').menu('show', {
 	         			left: e.pageX,
 	         			top: e.pageY
 	         		});
                 }else{
                	 //右击时选中该行
                	 $('#treeId').tree('select', node.target);
                	 $('#ZiJieDian').menu('show', {
  	         			left: e.pageX,
  	         			top: e.pageY
  	         		});
                 }
                 
			}
		});
	});
	/*父节点新增*/
	function addFuModules(){
		var nodes = $('#treeId').tree('getSelected'); 
		$("#parentNameA").text(nodes.text);	//把选中的父节点名称填在id为parentName内
		$("#addFuModules").window("open");	//打开窗口
	}
	/*父节点新增--保存*/
	function addSubmitForm(){
		var nodes = $('#treeId').tree('getSelected'); 
		var name=$("#add_Name1").textbox("getValue");
		var path=$("#add_Path1").textbox("getValue");
		var weight=$("#add_Weight1").textbox("getValue");
		var flog=$("#addFuModulesForm").form("validate");
		if(flog){
			$.post("insertModules",{
				ms_Name:name,
				ms_ParentId:nodes.id,
				ms_Weight:weight,
				ms_Ext2:path,
			},function(res){
				if(res==1){
					$("#treeId").tree("reload");
					$("#addFuModules").window("close");
					$.messager.alert("提示","添加节点成功");
				}else if(res==2){
					$.messager.alert("提示","模块名称已存在");
				}else if(res==3){
					$.messager.alert("提示","模块路径已存在");
				}else{
					$.messager.alert("提示","添加节点失败");
				}
			},"json")
		}
	}
	/*父节点新增--取消*/
	function addClearUserForm(){
		$("#addFuModulesForm").form("clear");
		$("#addFuModules").window("close");
	}
	/*父节点新增--取消*/
	function addClearUserForm(){
		$("#addFuModulesForm").form("clear");
		$("#addFuModules").window("close");
	}
	/*父节点修改*/
	function updateFuModules(){
		var nodes=$("#treeId").tree("getSelected");
		//alert(JSON.stringify(nodes.text));
			$.post("selectModulesByModulesName",{
				modulesName:nodes.text
			},function(res){
				$("#parentNameU").text(nodes.text);	//往id为parentNameU的div内填值
				$("#updateFuModulesForm").form("load",res);
				$("#updateFuModules").window("open");
			},"json"); 
	}
	/*父节点修改--保存*/
	function updateFuSubmitForm(){
		var nodes=$("#treeId").tree("getSelected");
		var name=$("#upd_Name1").textbox("getValue");
		var weight=$("#upd_Weight1").textbox("getValue");
		$.post("updateModules",{
			ms_Id:nodes.id,
			ms_Name:name,
			ms_Weight:weight
		},function(res){
			//alert(res);
			if(res==1){
				$("#treeId").tree("reload");
				$("#updateFuModules").window("close");
				$.messager.alert("提示","修改模块信息成功");
			}else if(res==2){
				$.messager.alert("提示","模块名称已存在");
			}else{
				$.messager.alert("提示","修改模块信息失败");
			}
			if(res){
				
			}
		},"json");
	}
	/*父节点修改--取消*/
	function updateClearUserForm(){
		$("#updateFuModulesForm").form("clear");	//清楚form表单的内容
		$("#updateFuModules").window("close");	//关闭Id为updateModules窗口
	}
	/*父节点删除*/
	function deleteFuModules(){
		var nodes = $('#treeId').tree('getSelected'); 
		$.messager.confirm("确定","确定要删除该模块吗？",function(res){
			if(res){
				$.post("deleteModules",{
					modulesId:nodes.id
				},function(res){
					if(res==1){
						$.messager.alert("提示","删除模块成功");
						$("#treeId").tree("reload");
					}else if(res==2){
						$.messager.alert("提示","该模块已有角色使用，不能删除");
					}else{
						$.messager.alert("提示","删除模块失败");
					}
				});
			}else{
				$.messager.alert("提示","删除模块失败");
			}
		});
	}
	
	/*子节点修改*/
	function updateZiModules(){
		var nodes=$("#treeId").tree("getSelected");
		$.post("selectModulesByModulesName",{
			modulesName:nodes.text
		},function(res){
			$("#parentNameU").text(nodes.text);	//往id为parentNameU的div内填值
			$("#updateZiModulesForm").form("load",res);
			$("#updateZiModules").window("open");
		},"json"); 
	}
	/*子节点修改--保存*/
	function updateZiSubmitForm(){
		var nodes=$("#treeId").tree("getSelected");
		var name=$("#upd_Name2").textbox("getValue");
		var path=$("#upd_Path2").textbox("getValue");
		var weight=$("#upd_weight2").textbox("getValue");
		$.post("updateModules1",{
			ms_Id:nodes.id,
			ms_Name:name,
			ms_Ext2:path,
			ms_Weight:weight
		},function(res){
			if(res==1){
				$("#treeId").tree("reload");
				$("#updateZiModules").window("close");
				$.messager.alert("提示","修改模块信息成功");
			}else if(res==2){
				$.messager.alert("提示","模块名称已存在");
			}else if(res==3){
				$.messager.alert("提示","模块路径已存在");
			}else{
				$.messager.alert("提示","修改模块信息失败");
			}
			if(res){
				
			}
		},"json");
	}
	/*子节点删除*/
	function deleteZiModules(){
		var nodes = $('#treeId').tree('getSelected'); 
		$.messager.confirm("确定","确定要删除该模块吗？",function(res){
			if(res){
				$.post("deleteModules",{
					modulesId:nodes.id
				},function(res){
					if(res==1){
						$.messager.alert("提示","删除模块成功");
						$("#treeId").tree("reload");
					}else if(res==2){
						$.messager.alert("提示","该模块已有角色使用，不能删除");
					}else{
						$.messager.alert("提示","删除模块失败");
					}
				});
			}else{
				$.messager.alert("提示","删除模块失败");
			}
		});
	}
	/*新增--父节点*/
	function addModules(){
		$("#addModules").window("open");	//打开窗口
	}
	/*新增--保存*/
	function addSubmitForm(){
		var name=$("#add_Name").textbox("getValue");
		var weight=$("#add_Weight").textbox("getValue");
		$.post("insertModulesFuJieDian",{
			ms_Name:name,
			ms_Weight:weight
		},function(res){
			if(res==1){
				$("#treeId").tree("reload");
				$("#addModules").window("close");
				$.messager.alert("提示","新增父节点成功");
			}else if(res==2){
				$.messager.alert("提示","模块名称已存在");
			}else{
				$.messager.alert("提示","新增父节点失败");
			}
		},"json")
	}
</script>
</head>
<body>
<table id="tab" class="easyui-datagrid" title="模块信息" data-options="method:'post'" >
</table>
<div id="FuJieDian" class="easyui-menu"  style="width: 120px;" >
	<div onclick="addFuModules()" iconcls="icon-add">添加节点</div>
	<div onclick="deleteFuModules()" iconcls="icon-remove">删除节点</div>
    <div onclick="updateFuModules()" iconcls="icon-edit">修改节点</div>
</div>
<div id="ZiJieDian" class="easyui-menu" style="width: 120px;">
	<div onclick="deleteZiModules()" iconcls="icon-remove">删除节点</div>
    <div onclick="updateZiModules()" iconcls="icon-edit">修改节点</div>
</div>
<!-- tree树状图 -->
<div style="margin-bottom: 5px;">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addModules()" plain="true">新增</a>
</div>
<div>
	<!--这个地方显示树状结构-->
	<ul id="treeId" class="easyui-tree"></ul>
</div>
<!-- 父节点添加 -->
<div id="addFuModules" class="easyui-window" title="新增模块信息" data-options="closed:true,iconCls:'icon-save',modal:true" style="width: 400px; height: 300px;">
	<form id="addFuModulesForm">
		<table cellpadding="5">
			<tr>
				<td>父节点名称：</td>
				<td><div id="parentNameA"></div></td>
			</tr>
			<tr>
				<td>模块名称：</td>
				<td><input class="easyui-textbox" type="text" id="add_Name1"  data-options="required:true"/></td>
			</tr>
			<tr>
				<td>路径：</td>
				<td><input class="easyui-textbox" type="text" id="add_Path1" data-options="required:true"/></td>
			</tr>
			<tr>
				<td>权重：</td>
				<td><input class="easyui-textbox" type="text" id="add_Weight1" data-options="required:true"/></td>
			</tr>
		</table>
	</form>
	<div>
		<center>
			<a href="javascript:void(o)" class="easyui-linkbutton" onclick="addSubmitForm()">保存</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:void(o)" class="easyui-linkbutton" onclick="addClearUserForm()">取消</a>
		</center>
	</div>
</div>
<!-- 父节点修改 -->
<div id="updateFuModules" class="easyui-window" title="修改模块信息" data-options="closed:true,iconCls:'icon-save',modal:true" style="width: 400px; height: 300px;">
	<form id="updateFuModulesForm">
		<table cellpadding="5">
			<tr>
				<td>父节点名称：</td>
				<td><div id="parentNameU"></div></td>
			</tr>
			
			<tr>
				<td>模块名称：</td>
				<td><input class="easyui-textbox" type="text" id="upd_Name1" name="ms_Name"/></td>
			</tr>
			<tr>
				<td>权重：</td>
				<td><input class="easyui-textbox" type="text" id="upd_Weight1" name="ms_Weight"/></td>
			</tr>
		</table>
	</form>
	<div>
		<center>
			<a href="javascript:void(o)" class="easyui-linkbutton" onclick="updateFuSubmitForm()">保存</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:void(o)" class="easyui-linkbutton" onclick="updateFuClearUserForm()">取消</a>
		</center>
	</div>
</div>
<!-- 子节点修改 -->
<div id="updateZiModules" class="easyui-window" title="修改模块信息" data-options="closed:true,iconCls:'icon-save',modal:true" style="width: 400px; height: 300px;">
	<form id="updateZiModulesForm">
		<table cellpadding="5">
			<tr>
				<td>父节点名称：</td>
				<td><div id="parentNameU"></div></td>
			</tr>
			<tr>
				<td>模块名称：</td>
				<td><input class="easyui-textbox" type="text" id="upd_Name2" name="ms_Name"/></td>
			</tr>
			<tr>
				<td>路径：</td>
				<td><input class="easyui-textbox" type="text" id="upd_Path2" name="ms_Ext2" data-options="required:true"/></td>
			</tr>
			<tr>
				<td>权重：</td>
				<td><input class="easyui-textbox" type="text" id="upd_weight2" name="ms_Weight"/></td>
			</tr>
		</table>
	</form>
	<div>
		<center>
			<a href="javascript:void(o)" class="easyui-linkbutton" onclick="updateZiSubmitForm()">保存</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:void(o)" class="easyui-linkbutton" onclick="updateZiClearUserForm()">取消</a>
		</center>
	</div>
</div>
<!-- 新增--父节点 -->
<div id="addModules" class="easyui-window" title="新增父模块信息" data-options="closed:true,iconCls:'icon-save',modal:true" style="width: 400px; height: 300px;">
	<form id="addModulesForm">
		<table cellpadding="5">
			<tr>
				<td>模块名称：</td>
				<td><input class="easyui-textbox" type="text" id="add_Name" /></td>
			</tr>
			<tr>
				<td>权重：</td>
				<td><input class="easyui-textbox" type="text" id="add_Weight" /></td>
			</tr>
			
		</table>
	</form>
	<div>
		<center>
			<a href="javascript:void(o)" class="easyui-linkbutton" onclick="addSubmitForm()">保存</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:void(o)" class="easyui-linkbutton" onclick="addClearUserForm()">取消</a>
		</center>
	</div>
</div>

</body>
</html>