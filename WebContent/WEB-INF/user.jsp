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
<script >
	/*数据加载*/
	$(function (){
		init();
	})
	function init() {
		$("#tab").datagrid({
			//数据接口的地址
			url:'selectUsersAll', 
			method:'post',
			toolbar:'#userToolbar',
			//要发送的参数列表
			queryParams: { 
				us_LoginName:$("#userName").textbox("getValue"),
				minTime:$("#minTime").datetimebox("getValue"),
				maxTime:$("#maxTime").datetimebox("getValue"),
				us_IsLockout:$("#UsersSel").datetimebox("getValue")
			},
			onDblClickCell:function(index, row) {
				var data=$("#tab").datagrid("getData");
				var row=data.rows[index];
				//给img设置
				$("#touXiang").attr("src","image/"+row.us_UserImg+"");
				//使用form的load方法，快速将json对象的数据显示到 弹出窗口的表单元素之中。
				$("#chaKanFrom").form("load",row); 
				//打开窗口。
		        $("#chaKanUser").window("open");   
			}
			
		});
		$("#usersForm").form("reset");
	}
	/*新增 */
	function addInfo() {
		$("#addUser").window("open");
	}
	/*新增--保存 */
	function submitUserForm() {
		var us_LoginName = $("#add_Name").textbox("getValue");
		var us_PassWord = $("#add_Pwd").textbox("getValue");
		var us_UserImg = $("#add_Img").get(0).files[0];
		var us_ProtecEmail = $("#add_Email").textbox("getValue");
		var us_ProtecMtel = $("#add_Mtel").textbox("getValue");
		//手机号验证必须是13、15、18开头的
		if(!(/^[1][358][0-9]{9}$/.test(us_ProtecMtel))) {
			$.messager.alert("提示","手机号码有误，请从新输入！");
			return false;
		}
		var flog=$("#addForm").form("validate");
		if(us_UserImg!=null){
			if(flog){
		        // 声明FormData对象用来传值
		        var formData=new FormData();
		        formData.append("us_LoginName",us_LoginName);
		        formData.append("us_PassWord",us_PassWord);
		        formData.append("us_ProtecEmail",us_ProtecEmail);
		        formData.append("us_ProtecMtel",us_ProtecMtel);
		        formData.append("add_Img",us_UserImg);
				$.ajax({
		            url:"insertUsers",
		            type:"post",
		            data:formData,
		            contentType:false,
		            processData:false,
		            success:function(res){
		            	if(res==1) {
							$.messager.alert("提示","注册成功");
							$("#addUser").window("close");
							$("#tab").datagrid("reload");
						}else if(res==2){
							$.messager.alert("提示","用户名已存在");
						}else if(res==4){
							$.messager.alert("提示","手机号已存在");
						}else if(res==3){
							$.messager.alert("提示","邮箱已存在");
						}else{
							$.messager.alert("提示","新增失败");
						}  
		            },
		            error:function(res){
		                $.messager.alert("提示","注册失败！");
		            }
		        })
			}
		}else{
			 $.messager.alert("提示","请上传该用户的头像！");
		}
		
	}
	/*新增--取消 */
	function clearUserForm() {
		$("#addForm").form("clear");
	}
	
	//锁定和解锁用户
	function formatterLockUser(value, row, index) {
		return "<a style='cursor: pointer;' onclick='suoDingUser(" + index + ")'>锁定用户</a> <a style='cursor: pointer;' onclick='jieSuoUser(" + index + ")'>解锁用户</a>";
	}
	/*锁定用户*/
	function suoDingUser(index){
		var data=$("#tab").datagrid("getData");
		var row=data.rows[index];
		if(row.us_IsLockout==0){
		$.messager.confirm('确认','您确认想要锁定该用户吗？',function(res){
			if(res){
				$.post("updateUsersSuoDing",{
					us_Id:row.us_Id
				},function(res){
					if(res>0){
						$("#tab").datagrid("reload");
						$.messager.alert("提示","锁定用户成功");
					}
				},"json");
			}else{
				$.messager.alert("提示","锁定用户失败");
			}
		});
		}else{
			$.messager.alert("提示","该用户已是锁定状态！");
		}
	}
	/*解锁用户*/
	function jieSuoUser(index){
		var data=$("#tab").datagrid("getData");
		var row=data.rows[index];
		if(row.us_IsLockout==1){
		$.messager.confirm('确认','您确认想要解锁该用户吗？',function(res){  
			if(res){
				$.post("updateUsersJieSuo",{
					us_Id:row.us_Id
				},function(res){
					if(res>0){
						$("#tab").datagrid("reload");
						$.messager.alert("提示","解锁用户成功");
					}
				},"json");
			}else{
				$.messager.alert("提示","解锁用户失败");
			}
		});
		}else{
			$.messager.alert("提示","该用户已是解锁状态！");
		}
	}
	//设置角色权限
	function formatterSetRole(value, row, index) {
		return "<a style='cursor: pointer;' onclick='sheZhi(" + index + ")'>设置</a>";
	}
	/*角色权限设置*/
	var userId;
	function sheZhi(index){
		$("#userSheZhi").window("open");
		//获取数据表格里的所有数据
		var data=$("#tab").datagrid("getData");
		//根据index下标拿到选中的数据
		var row=data.rows[index];
		//拿到用户id
		userId=row.us_Id;
		//查询全部角色
		$("#userAllRole").datagrid({
			url: 'selectRolesAll',  //数据接口的地址
			method:'post'
			
		});
		//根据用户id查询角色
		$("#userDangQianRole").datagrid({
			url:'selectUserRolesById',
			method:'post',
			queryParams:{
				usersId:row.us_Id
			}
		}); 
	}
	/*设置--添加角色*/
	function addRole(){
		//获取选中的数据
		var row=$("#userAllRole").datagrid("getSelected");
		if(row!=null){
			$.post('insertUserRoles',{
				urs_UserId: userId,		//用户id
				urs_RoleId: row.rs_Id	//角色id
			},function(row){
				if(row>0){
					$("#userDangQianRole").datagrid("reload");
				}else{
					$.messager.alert("提示",row.message);
				}
			},"json");
		}else{
			$.messager.alert("提示","请选中要设置的角色");
		}
	}
	/*设置--移除角色*/
	function removeRole(){
		//获取选中的数据
		var row=$("#userDangQianRole").datagrid("getSelected");
			if(row!=null){
			$.post("deleteUserRoles",{
				urs_UserId: userId,		//用户id
				urs_RoleId: row.rs_Id	//角色id
			},function(row){
				if(row>0){
					$("#userDangQianRole").datagrid("reload");
				}else{
					$.messager.alert("提示",row.message);
				}
			},"json");
		}else{
			$.messager.alert("提示","请选中要设置的角色");
		} 
	} 
	//重置密码
	function formatterResetPassword(value, row, index) {
		return "<a style='cursor: pointer;' onclick='chongZhiMiMa(" + index + ")'>重置密码</a>";
	}
	/*重置密码*/
	function chongZhiMiMa(index){
		var data=$("#tab").datagrid("getData");
		var row=data.rows[index];
		$.messager.confirm('确认','您确认想要重置密码吗？',function(res){ 
			if(res){
				$.post("updateUsersPwd",{
					us_Id:row.us_Id
				},function(res){
					if(res>0){
						$.messager.alert("提示","密码重置成功，密码为:ysd123");
					}
				},"json");
			}else{
				$.messager.alert("提示","密码重置失败！");
			}
		});
	}
	//操作用户
	function formatterOPUser(value, row, index) {
		return "<a style='cursor: pointer;' onclick='updateInfo(" + index + ")'>编辑</a> <a style='cursor: pointer;' onclick='deleteInfo(" + index + ")'>删除</a>";
	}
	/*修改*/
	function updateInfo(index){
		//将当前行数据填入表单
		//获取datagrid对应的json数据（对象集合）
        var data = $("#tab").datagrid("getData"); 
      	//获取第index行对应的json对象。 index为传递过来的索引参数，从0开始，就像数组下标。
        var row = data.rows[index];  
      	//使用form的load方法，快速将json对象的数据显示到 弹出窗口的表单元素之中。
        $("#updateFrom").form("load",row);
        //打开窗口。
        $("#updateUser").window("open");  
	}
	/*修改--保存*/
	function updateSubmitUserForm(){
		//返回第一个被选中的行
		var data=$("#tab").datagrid("getSelected");
		var us_LoginName=$("#upd_Name").textbox("getValue");
		var us_ProtecEmail=$("#upd_Email").textbox("getValue");
		var us_ProtecMtel=$("#upd_Mtel").textbox("getValue");
		//手机号验证必须是13、15、18开头的
		if(!(/^[1][358][0-9]{9}$/.test(us_ProtecMtel))) {
			$.messager.alert("提示","手机号码有误，请从新输入！");
			return false;
		}
		//判断是否修改
		if(data.us_ProtecEmail==us_ProtecEmail){
			us_ProtecEmail="";
		}
		if(data.us_ProtecMtel==us_ProtecMtel){
			us_ProtecMtel="";
		}
		
		$.post("updateUsersByNameEmailMtel",{
			us_LoginName:us_LoginName,
			us_ProtecEmail:us_ProtecEmail,
			us_ProtecMtel:us_ProtecMtel
		},function(res){
			if(res==1){
				$.messager.alert("提示","修改成功");
				//关闭弹框
				$("#updateUser").window("close");
				//重新刷新表格
				$("#tab").datagrid("reload");	
			}else if(res==2){
				$.messager.alert("提示","邮箱已存在！");
			}else if(res==3){
				$.messager.alert("提示","手机号已存在！");
			}else{
				$.messager.alert("提示","修改失败！");
			}
		},"json");
	}
	/*修改--取消*/
	function updateClearUserForm(){
		$("#updateUser").window("close");
	}
	/*删除*/
	function deleteInfo(index){
		//获取数据表格的所有数据
		var data=$("#tab").datagrid("getData");		
		//根据index获取需要操作的一条数据
		var row=data.rows[index];	
		$.messager.confirm('确认','您确认想要删除信息吗？',function(res){  
			if(res){
				$.post("deleteusers",{
					usersId:row.us_Id
				},function(res){
					// 用户点击了确认按钮
	   			 	if (res==1){
	   			 		$.messager.alert("提示","删除成功");   
	        			$("#tab").datagrid("reload");
	    			}else if(res==2){
	    				$.messager.alert("提示","该用户已有角色，不能删！");  
	    			}else{
	    				$.messager.alert("提示","删除失败");
	    			}  
				});
			}else{
				$.messager.alert("提示","删除失败");
			}   
		});
	}
	/* 是否锁定 */
	function formatterus_IsLockout(value, row, index){
		if(value==0){
			return "否";
		}else{
			return "是";
		}
	}
	$('#minTime').datetimebox({    
	    required: true  
	}); 
	$('#maxTime').datetimebox({    
	    required: true  
	}); 
	/* 图片 */
	function formatterImages(value, row, index){
		return "<img style='width:40px;height:40px;' src='image/"+value+"'/>";
	}
	
	

    
	
	
</script>
<body>

<!-- 工具栏 -->
<div id="userToolbar" style="padding:5px; height:auto">
	<form id="usersForm">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addInfo()">新增</a>
		名称: <input class="easyui-textbox" id="userName" style="width:100px">
		创建时间：<input class="easyui-datetimebox" id="minTime"  style="width:140px">
				~<input class="easyui-datetimebox" id="maxTime"  style="width:140px">
		是否锁定：<select id="UsersSel" class="easyui-combobox" >   
				    <option value="">-请选择-</option>   
				    <option value="1">是</option>   
				    <option value="0">否</option>   
				</select>  
		
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="init()">查找</a>
	</form>
</div>
<table id="tab" class="easyui-datagrid" title="用户列表" data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:10">
	<thead>
		<tr>
			<th data-options="field:'us_LoginName',width:80,align:'center'">用户名</th>
			<th data-options="field:'us_UserImg',width:80,formatter:formatterImages">图片</th>
			<th data-options="field:'us_ProtecMtel',width:100,align:'center'">手机号</th>
			<th data-options="field:'us_IsLockout',width:70,align:'center',formatter:formatterus_IsLockout">是否锁定</th>
			<th data-options="field:'us_LockTime',width:140,align:'center'">锁定时间</th>
			<th data-options="field:'us_LastLoginTime',width:140,align:'center'">最后登录的时间</th>
			<th data-options="field:'setRoleAction',width:60,align:'center',formatter:formatterSetRole">角色</th>
			<th data-options="field:'setUserAction',width:120,align:'center',formatter:formatterOPUser">操作</th>
			<th data-options="field:'setPassword',width:80,align:'center',formatter:formatterResetPassword">操作</th>
			<th data-options="field:'setLock',width:140,align:'center',formatter:formatterLockUser">用户操作</th>
		</tr>
	</thead>
</table>
<!-- 新增 -->
<div id="addUser" class="easyui-window" title="新增员工信息" data-options="closed:true" style="width:500px;height:300px;padding:10px;">
	<form id="addForm" method="post" enctype="multipart/form-data">
		<table cellpadding="5">
			<tr>
				<td>用户名:</td>
				<td><input class="easyui-textbox" type="text"  id="add_Name" data-options="required:true,validType:'length[3,20]'"/>
				</td>
			</tr>
			<tr>
				<td>上传头像:</td>
				<td><input type="file" name="add_Img" id="add_Img"  />
				</td>
			</tr>
			<tr>
				<td>密码:</td>
				<td><input class="easyui-textbox" type="password" id="add_Pwd" data-options="required:true,validType:'length[6,20]'" />
				</td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><input class="easyui-textbox" type="text"  id="add_Email" data-options="required:true,validType:'email'"></input>
				</td>
			</tr>

			<tr>
				<td>手机号:</td>
				<td><input type="text" class="easyui-numberbox" id="add_Mtel" data-options="required:true"/></td>
			</tr>
		</table>
	</form>
	<div style="text-align: center;">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitUserForm()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearUserForm()">取消</a>
	</div>
</div>

<!--修改-->
<div id="updateUser" class="easyui-window" title="修改用户信息" data-options="closed:true,iconCls:'icon-save'" style="width:500px;height:300px;">
	<form id="updateFrom">
		<table cellpadding="5">
			<tr>
				<td>用户名:</td>
				<td><input class="easyui-textbox" type="text" name="us_LoginName" id="upd_Name" readonly="readonly" data-options="required:true" disabled="disabled"></input>
				</td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><input class="easyui-textbox" type="text" name="us_ProtecEmail" id="upd_Email" data-options="required:true,validType:'email'"></input>
				</td>
			</tr>

			<tr>
				<td>手机号:</td>
				<td><input type="text" class="easyui-numberbox" id="upd_Mtel" name="us_ProtecMtel" data-options="required:true"></td>
			</tr>
		</table>
	</form>
	<div style="text-align: center;">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateSubmitUserForm()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateClearUserForm()">取消</a>
	</div>
</div>
<!--设置-->
<div id="userSheZhi" class="easyui-window" title="您正在设置角色信息" data-options="closed:true,modal:true,iconCls:'icon-save'" style="width:500px;height:500px;">
	<table cellpadding="5">
		<tr>
			<td>
				<table id="userAllRole" class="easyui-datagrid" title="系统所有角色" data-options="rownumbers:true,singleSelect:true" style="width:200px;height:700px;">
					<thead>
						<tr>
							 <th data-options="field:'rs_Name',width:170">用户名</th>
						</tr>
					</thead>
				</table>
			</td>
			<td style="width:100px;height:700px;">
				<a href="javascript:void(0)"  class="easyui-linkbutton" onclick="addRole()">>></a><br />
				<a href="javascript:void(0)"  class="easyui-linkbutton" onclick="removeRole()"><<</a>
			</td>
			<td>
				<table id="userDangQianRole" class="easyui-datagrid"  title="当前用户的角色" data-options="rownumbers:true,singleSelect:true" style="width:200px;height:700px;"> 
					<thead>
					    <tr>
					         <th data-options="field:'rs_Name',width:170">用户名</th>
					    </tr>                                      
					</thead>
				</table>
			</td>
		</tr>
	</table>
</div>
<!-- 查看 -->
<div id="chaKanUser" class="easyui-window" title="查看用户信息" data-options="closed:true,iconCls:'icon-save'" style="width:500px;height:300px;">
	<form id="chaKanFrom">
		<table cellpadding="5">
			<tr>
				<td>头像:</td>
				<td>
				<img id="touXiang" alt="" src="" style="height: 50px">
				</td>
			</tr>
			<tr>
				<td>用户名:</td>
				<td>
				<input class="easyui-textbox" type="text" name="us_LoginName"  readonly="readonly" data-options="required:true" disabled="disabled"></input>
				</td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><input class="easyui-textbox" type="text" name="us_ProtecEmail"  data-options="required:true,validType:'email'" disabled="disabled"></input>
				</td>
			</tr>
			<tr>
				<td>手机号:</td>
				<td><input type="text" class="easyui-numberbox" name="us_ProtecMtel" data-options="required:true" disabled="disabled"></td>
			</tr>
			<tr>
				<td>创建时间:</td>
				<td><input type="text" class="easyui-textbox" name="us_CreateTime" data-options="required:true" disabled="disabled"></td>
			</tr>
			<tr>
				<td>登录时间:</td>
				<td><input type="text" class="easyui-textbox" name="us_LastLoginTime" data-options="required:true" disabled="disabled"></td>
			</tr>
		</table>
	</form>
	<div style="text-align: center;">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateSubmitUserForm()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateClearUserForm()">取消</a>
	</div>
</div>
</body>
