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
	 var Us_Id="<%=request.getParameter("Us_Id")%>";
	$(function(){
		search();
		});
	function search(){
			$("#tabid").datagrid({
				url:'SelectUsersRolesClients',
				method:"post",
				pagination:true,
				queryParams:{
					Us_Id:Us_Id,
					Cs_Name:$("#Cs_Name").val(),
					Cs_Sex:$("#Cs_Sex").combobox("getValue"),
					Cs_Phone:$("#Cs_Phone").val(),
					Cs_ClientState:$("#Cs_ClientState").combobox("getValue"),
					Cs_Source:$("#Cs_Source").combobox("getValue"),
					Cs_SiteSheng:$("#Cs_SiteSheng").val(),
					Cs_SiteShi:$("#Cs_SiteShi").val(),
					Cs_SiteXian:$("#Cs_SiteXian").val(),
					Cur_ZhuangTai:$("#Cur_ZhuangTai").combobox("getValue"),
					Cur_RecordTimeMin:$("#Cur_RecordTimeMin").datebox("getValue"),
					Cur_RecordTimeMax:$("#Cur_RecordTimeMax").datebox("getValue")
				}
			});
			 $("#chongzhi").form("reset");//重置文本框内容 
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
	  function cs_Sexformatter(value,row,index){
		  if(row.cs_Sex=="1"){
			  return "男";
		  }
		  else{
			  return "女";
		  }
	  }  function cs_ClientStateformatter(value,row,index){
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
		 
	  } function cs_Sourceformatter(value,row,index){
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
	  function Cur_RecordTimeformatter(value,row,index){
		  if(row.clientUserRecord!=null){
			  return row.clientUserRecord.cur_RecordTime;
		  }
		  else{
			  return "暂无";
		  }
	  }  
	  function  ClientsImgformatter(value,row,index){
	      if(row.cs_Img!=null && row.cs_Img!=""){
	         return "<img style='width:24px;height:24px;'border='1' src='image/"+row.cs_Img+"'/>";
	      }
	      else{
			  return "暂无";
		  }
	  } 
	  function huiqu(){
	   location.href="userRolesjsp"; 
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
  性别：          <select id="Cs_Sex"  class="easyui-combobox" name="dept" style="width:100px;">   
			     <option value="">---请选择---</option>  
			     <option value="1">男</option>			     
			     <option value="2">女</option>  
           </select> 
  电话：<input class="easyui-textbox" id="Cs_Phone"  style="width:120px">
  客户状态： <select id="Cs_ClientState"  class="easyui-combobox" name="dept" style="width:100px;">   
			     <option value="">---请选择---</option>  
			     <option value="1">潜在客户</option>
			     <option value="2">意向客户</option>
			     <option value="3">续保客户</option>
			     <option value="4">正式客户</option>			     
			     <option value="5">流失客户</option>
			     <option value="6">未分配客户</option> 
           </select>
 客户来源：<select id="Cs_Source"  class="easyui-combobox" name="dept" style="width:100px;">   
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
  地址:        <select id="Cs_SiteSheng" name="s_province" ></select>  
		  <select id="Cs_SiteShi"   name="s_city"     ></select>  
		  <select id="Cs_SiteXian"  name="s_county"   ></select>
		  <script type="text/javascript">_init_area();</script>
 意向状态:   <select id="Cur_ZhuangTai"  class="easyui-combobox" name="dept" style="width:100px;">   
			     <option value="">---请选择---</option>  
			     <option value="1">意向强</option>  
			     <option value="2">意向中</option>
			     <option value="3">意向弱</option> 
          </select>
 记录时间:<input  id="Cur_RecordTimeMin"  type= "text" class= "easyui-datebox" /> ~
         <input  id="Cur_RecordTimeMax"  type= "text" class= "easyui-datebox" />
     <a id="aa" href="javascript:huiqu()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">回用户界面</a>
     <a id="btn" href="javascript:search()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
     <a id="btn" href="javascript:exportExcel()" class="easyui-linkbutton" data-options="iconCls:'icon-redo'">导出</a>
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
		            <th data-options="field:'cs_Source',width:100">客户来源</th>
		            <th data-options="field:'cs_FoundTime',width:150">建档时间</th>
		            <th data-options="field:'users',width:100,formatter:LoginNameformatter">所属用户</th>
		            <th data-options="field:'clientUserRecord',width:150,formatter:Cur_RecordTimeformatter">记录时间</th>
		            <!-- <th data-options="field:'format',width:100,formatter:ClientUserRecordformatter">操作</th>  -->
		        </tr>   
		    </thead>   
    </table>
</body>
</html>
