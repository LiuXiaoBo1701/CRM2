<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>查询所有用户以及用户角色</title>
    <link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/icon.css"/>
	<link rel="stylesheet" href="js/jquery-easyui-1.4.3/themes/default/easyui.css"/>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/echarts.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="js/echarts.js"></script>
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
		search();
		});
	function search(){
		var C_UserId=${usersId}
		//alert($("#Rs_Id").combobox("getValue"));
		$("#tabid").datagrid({
			url:'SelectUserRoles',
			method:"post",
			queryParams:{
				C_UserId:C_UserId,
				Us_LoginName:$("#Us_LoginName").val() ,
				//Rs_Id:$("#Rs_Id").combobox("getValue"),
				Us_IsLockout:$("#Us_IsLockout").combobox("getValue"),
				Rls_State:$("#Rls_State").combobox("getValue"),
				Us_ProtecMtel:$("#Us_ProtecMtel").val(),
				Us_CreateTimeMin:$("#Us_CreateTimeMin").datebox("getValue"),
				Us_CreateTimeMax:$("#Us_CreateTimeMax").datebox("getValue"),
				Rls_StartTimeMin:$("#Rls_StartTimeMin").datetimebox("getValue"),
				Rls_StartTimeMax:$("#Rls_StartTimeMax").datetimebox("getValue"),
				Rls_FinishTimeMin:$("#Rls_FinishTimeMin").datetimebox("getValue"),
				Rls_FinishTimeMax:$("#Rls_FinishTimeMax").datetimebox("getValue")
			}
		});
		 $("#chongzhi").form("reset");//重置文本框内容 
	}
	
	//导出
  	function exportExcel(){  
	  	var data=$("#tabid").datagrid("getSelections");
	  
	    var us_Id="";
	 
		for(var i=0;i<data.length;i++){
			var row=data[i].us_Id;
			us_Id=us_Id+row+",";
			
		}   
		if(row!=null){
			 location.href="excel/exportUserRoles?&Us_Id="+us_Id;   
		}else{
			$.messager.alert("提示","请选择要导出的行");	
			
		}
	       
    }  
	//角色名
	function rs_Nameformatter(value,row,index){
		  if(row.roles!=null){
			  return row.roles.rs_Name;
		  }
		  else{
			  return "暂无";
		  } 
	  }
	//图片
	function  UserImgformatter(value,row,index){
	      if(row.us_UserImg!=null && row.us_UserImg!=""){
	         return "<img style='width:24px;height:24px;'border='1' src='image/"+row.us_UserImg+"'/>";
	      }
	      else{
			  return "暂无";
		  }
	  } 
	//锁定
	function us_IsLockoutformatter(value,row,index){
	        if(row.us_IsLockout!=null && row.us_IsLockout!="" && row.us_IsLockout=="1"){
		         return "已锁定";
		      }
		      else{
				  return "未锁定";
			  }
		  }
	//员工的客户
	function clientsformatter(value,row,index){
		  if(row.clients!=null ){
			  return row.clients.cs_Id;
		  }
		  else{
			  return "0";
		  } 
	  }
	//修改权重
	function UserQuanZhong(index){
		    var data = $("#tabid").datagrid("getData"); //获取datagrid对应的json数据（对象集合）
			var row = data.rows[index];
		    //alert(row.consultant.c_Weight);
			$("#QuanZhong_Form").form("load",row.consultant); //爽！使用form的load方法，快速将json对象的数据显示到 弹出窗口的表单元素之中。
		    $("#QuanZhong_window").window("open");
	}
     function SubmitUpdateForm(){
    	 var  c_UserId=$("#c_UserId").val() ;
    	 var  c_Weight=$("#c_Weight").val() ;
    	 $.post(
					"updateQuanZhong", {
						c_UserId:c_UserId,
						c_Weight:c_Weight
					},
					function(res) {
						if(res>0) {
							$.messager.alert("提示","修改成功");	
							$("#tabid").datagrid("reload");
							$("#QuanZhong_window").window("close");
						}
					}, "json");
     }
     function CloseForm(){
    	 $("#QuanZhong_window").window("close");
     }
	//手动签退
	 function UserQianTUi(index){
		  var data = $("#tabid").datagrid("getData"); //获取datagrid对应的json数据（对象集合）
	      var row = data.rows[index];
	      var Us_Id=row.us_Id;
	      var State=row.consultantLabels.rls_State;
	     if(State=="1"){
		  $.post(
					"UsersQianTui", {
						Us_Id:Us_Id
					},
					function(res) {
						if(res>0) {
							$.messager.alert("提示","签退成功");	
							/* $("#qiandao").linkbutton({
								enable:true,
								text:'用户已签退'
							}); */
						
							
							$("#tabid").datagrid("reload");
							
						}
					}, "json");
	     }else{
	    	 $.messager.alert("提示","此用户未签到不能签退");	
	     }
		  
	} 
	 function qiantui(){
		var data=$("#tabid").datagrid("getSelections");
	    var Us_Id="";
	    var Start1="";
		for(var i=0;i<data.length;i++){
			 var row=data[i].us_Id;
			 var State=data[i].consultantLabels.rls_State;
			 Start1=Start1+State+",";
			 Us_Id=Us_Id+row+",";
		} 
	    
		var arr=Start1.split(",");
		var code = true;
		for(var i=0;i<arr.length;i++){
			if(arr[i] =="0" && arr[i] !=null){
				code = false;
			}
		}
		if(Us_Id){
		if(code){
		$.post(
				"UsersQianTui", {
					Us_Id:Us_Id
				},
				function(res) {
					if(res>0) {
						$.messager.alert("提示","签退成功");
						code=true;
						$("#qiandao").linkbutton({
							enable:false,
							text:'签到'
						});
						$("#tabid").datagrid("reload");
						
					}
				}, "json");
		}else{
			 $.messager.alert("提示","有用户未签到不能签退");	
		}
		}else{
			$.messager.alert("提示","请选择要签退的用户");	
		}
		
		
	}
		  function  UserRolesformatter(value,row,index){
			     return "<a style='cursor: pointer; color:blue;' onclick='SelectClientRoles(" + index + ")'>查看客户</a> <a style='cursor: pointer; color:#00BB00;' onclick='UserQuanZhong(" + index + ")'>修改权重</a> "
			    
		  }
		//查看成交率
		  function BiaoGe(){
			  $("#BiaoGe_window").window("open");
			  var data = $("#tabid").datagrid("getData"); //获取datagrid对应的json数据（对象集合）
			  
		  }
		  //查看客户操作        
		  function  SelectClientRoles(index){
			  var data = $("#tabid").datagrid("getData"); //获取datagrid对应的json数据（对象集合）
		      var row = data.rows[index];
			  var Us_Id=row.us_Id;
			  var cs_Id=row.clients.cs_Id; 
			  if(row.clients.cs_Id>0 || row.clients!=null  || row.clients.cs_Id!="" || row.clients.cs_Id!=null){
				  location.href="selectUserClientRolesjsp?&Us_Id="+Us_Id; 
				
			  } else{
				 alert("此用户无客户");
			  } 
		  }
		  //签到状态显示
		  function consultantLabelsformatter(value,row,index){
			  if(row.consultantLabels!=null){
				 if(row.consultantLabels.rls_State=="1"){
					 return "已签到";
				 }else{
					 
					  return "未签到";
			  } 
			  }else{
				 
					  return "未签到";				 
			  }
		  }
		 function  c_Weightformatter(value,row,index){
			  if(row.consultant!=null){
				  return row.consultant.c_Weight;		 
			  }
		 }
		 	  //签到时间显示
		  function Rls_StartTimeformatter(value,row,index){
			  if(row.consultantLabels!=null){
				  return row.consultantLabels.rls_StartTime;		 
			  }
		  }
		  //签退时间显示
		  function Rls_FinishTimeformatter(value,row,index){
			  if(row.consultantLabels!=null && row.consultantLabels.rls_StartTime<row.consultantLabels.rls_FinishTime){
				  return row.consultantLabels.rls_FinishTime;		 
			  }
		  }
	</script>	
</head>
<body>
     <form id="chongzhi">
  用户名称:  <input  class="easyui-textbox"  id="Us_LoginName"  style="width:300px"> 
 <%--  角色名称:      <select id="Rs_Id"  class="easyui-combobox" name="dept" style="width:200px;">   
			    <option value="">---请选择---</option>    
			    <c:forEach items="${selectRoles}" var="roles">
			     <option  value="${roles.rs_Id}">${roles.rs_Name}</option> 
			    </c:forEach>   
         </select> --%>
  是否锁定：          <select id="Us_IsLockout"  class="easyui-combobox" name="dept" style="width:200px;">   
			     <option value="">---请选择---</option>  
			     <option value="1">已锁定</option>			     
			     <option value="0">未锁定</option>  
           </select> 
 签到状态：          <select id="Rls_State"  class="easyui-combobox" name="dept" style="width:200px;">   
			     <option value="">---请选择---</option>  
			     <option value="1">已签到</option>  
			     <option value="0">未签到</option>			     
			    
           </select> 
  电话：<input class="easyui-textbox" id="Us_ProtecMtel"  style="width:120px">
  <br/>
 创建时间:<input  id="Us_CreateTimeMin"   type= "text" class= "easyui-datebox" /> ~
         <input  id="Us_CreateTimeMax"   type= "text" class= "easyui-datebox" />
 签到时间:<input  id="Rls_StartTimeMin"   type= "text" class= "easyui-datetimebox" /> ~
         <input  id="Rls_StartTimeMax"   type= "text" class= "easyui-datetimebox" />
 签退时间:<input  id="Rls_FinishTimeMin"  type= "text" class= "easyui-datetimebox" /> ~
         <input  id="Rls_FinishTimeMax"  type= "text" class= "easyui-datetimebox" />
       
     <a id="btn" href="javascript:search()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
     <a id="qiantuia" href="javascript:qiantui()" class="easyui-linkbutton" data-options="iconCls:'icon-man'">手动签退</a>
     <a id="btn" href="javascript:BiaoGe()" class="easyui-linkbutton" data-options="iconCls:'icon-sum'">员工成交率</a>
     <a id="btn" href="javascript:exportExcel()" class="easyui-linkbutton" data-options="iconCls:'icon-redo'">导出</a>
    </form>
     <table id="tabid" class="easyui-datagrid" data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:10">
           <thead>
		        <tr> 
		            <th data-options="field:'che',checkbox:true"></th>
		            <th data-options="field:'us_LoginName',width:100">用户名</th>     
		            <th data-options="field:'us_UserImg',width:100,formatter:UserImgformatter">用户照片</th> 
		            <th data-options="field:'users',width:100,formatter:rs_Nameformatter">所属角色</th>
		            <th data-options="field:'us_ProtecMtel',width:100">手机号码</th> 
		            <th data-options="field:'us_CreateTime',width:150">创立时间</th> 
		            <th data-options="field:'us_IsLockout',width:100,formatter:us_IsLockoutformatter">是否锁定</th>
		            <th data-options="field:'us_LockTime',width:150">被锁定时间</th>
		           <!--  //<th data-options="field:'c_Weight',width:150,formatter:c_Weightformatter">权重</th> -->
		            <th data-options="field:'consultantLabels',width:100,formatter:consultantLabelsformatter">签到状态</th>
		            <th data-options="field:'Rls_StartTime',width:150,formatter:Rls_StartTimeformatter">签到时间</th>
		            <th data-options="field:'Rls_FinishTime',width:150,formatter:Rls_FinishTimeformatter">签退时间</th> 
		            <th data-options="field:'clients',width:100,formatter:clientsformatter">客户个数</th>
		            <th data-options="field:'format',width:150,formatter:UserRolesformatter">操作</th>
		        </tr>   
		    </thead>   
    </table>
    <div id="BiaoGe_window" class="easyui-window" title="修改信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:1000px;height:500px;padding:10px;">
	   <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
        <div id="main" style="width: 800px;height:400px;"></div>
         <script type="text/javascript">
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('main'));
            // 指定图表的配置项和数据
            option = {
    title : {
        text: '某地区蒸发量和降水量',
        subtext: '纯属虚构'
    },
    tooltip : {
        trigger: 'axis'
    },
    legend: {
        data:['蒸发量','降水量']
    },
    toolbox: {
        show : true,
        feature : {
            dataView : {show: true, readOnly: false},
            magicType : {show: true, type: ['line', 'bar']},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    xAxis : [
        {
            type : 'category',
            data : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'蒸发量',
            type:'bar',
            data:[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3],
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name: '平均值'}
                ]
            }
        },
        {
            name:'降水量',
            type:'bar',
            data:[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3],
            markPoint : {
                data : [
                    {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183},
                    {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name : '平均值'}
                ]
            }
        }
    ]
};

            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
      
        </script>
        
	</div>
	<div id="QuanZhong_window" class="easyui-window" title="修改权重" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:700px;height:500px;padding:10px;">
	<form id="QuanZhong_Form">
		<table cellpadding="5">
		   <tr>
				<td>id:</td>
				<td><input class="easyui-textbox" type="text" name="c_UserId" id="c_UserId"  readonly data-options="disabled:true"></input>
				</td>
			</tr>
		   <tr>
			    <td>权重</td>
				<td>
				<input type="text" autocomplete="off" class="easyui-textbox" data-options="required:true" style="width: 200px" name="c_Weight" id="c_Weight"/>
				</td>
			</tr>
		</table>
	</form>
	<div style="text-align:center;padding:5px">
		<a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="SubmitUpdateForm()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="CloseForm()">取消</a>
	</div>
    </div>
</body>
</html>