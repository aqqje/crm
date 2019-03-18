<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>CRM 人力资源管理系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="easyui/jquery.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css" />
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
		var url;
		function newUser(){
			$('#dlg').dialog('open').dialog('setTitle','新增');
			$('fm').form('clear');
			url="dept?action=insert";
		}
		function editUser(){
			var row = $('#mTb').datagrid('getSelected');
			if(row){
				$('#dlg').dialog('open').dialog('setTitle','修改');
				$('#fm').form('load',row);
				url="dept?action=update&deptno="+row.deptno;
			}
		}
		
		function saveUser(){
            $('#fm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                    var result = eval('('+result+')');
                    if (result.success){
                        $.messager.show({
                            title: '提示',
                            msg: result.message
                        });
                        $('#dlg').dialog('close');        // close the dialog
                        $('#mTb').datagrid('reload');    // reload the user data
                    } else {
                        $.messager.show({
                            title: '提示',
                            msg: result.message
                        });
                    }
                }
            });
        }
		
		function removeUser(){
            var row = $('#mTb').datagrid('getSelected');
            if (row){
                $.messager.confirm('确认','您确定要删除吗？',function(r){
                    if (r){
                        $.post('dept?action=delete',{deptno:row.deptno},function(result){
                            if (result.success){
                                $.messager.show({    
                                        title: '提示',
                                        msg: result.message
                                    });
                                $('#mTb').datagrid('reload'); 
                            } else {
                                $.messager.show({   
                                    title: '提示',
                                    msg: result.message
                                });
                            }
                        },'json');
                    }
                });
            }
        }
	</script>
  </head>
  
  <body bgcolor="#D1EEEE">
  	
  	<div>
  		<h1 style="float: left;padding-left: 10px">CRM 人力资源管理系统</h1>
  		<h3 style="padding-right: 30px;padding-top: 40px; float: right;"><a href="empinfo.jsp">员工信息管理</a></h3>
  	</div>
  		<h2 style="font-size: 25px;" align="center">部门信息</h2>
    <table id="mTb" 
          class="easyui-datagrid" width="100%" 
          url="dept?action=query"
          toolbar="#toolbar" pagination="true"
        rownumbers="true" fitColumns="true" singleSelect="true"
        pageSize="5"        
        pageList="[3,5,8,10]">
        <thead>
            <tr>
            	<!--  data-options="hidden: true"是否隐藏该列 -->
                <th field="deptno" width="50">部门ID</th>
                <th field="dname" width="50">部门</th>
                <th field="loc" width="50">地址</th>
            </tr>
        </thead>
      </table>
      
      <div id="toolbar">
        <a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新增</a>
        <a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">修改</a>
        <a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeUser()">删除</a>
    </div>
    
    <div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
            closed="true" buttons="#dlg-buttons">
        <div class="ftitle">部门信息</div>
        <form id="fm" method="post" novalidate>
        	<div class="fitem">
                <label>部门ID:</label>
                <input name="deptno" class="easyui-validatebox" required="true">
            </div>
            <div class="fitem">
                <label>部门:</label>
                <input name="dname" class="easyui-validatebox" required="true">
            </div>
            <div class="fitem">
                <label>地址:</label>
                <input name="loc" class="easyui-validatebox" required="true">
            </div>
        </form>
    </div>
    <div id="dlg-buttons">
        <a class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">提交</a>
        <a class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
      
  </body>
</html>
