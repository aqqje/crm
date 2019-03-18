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
			url="emp?action=insert";
		}
		function editUser(){
			var row = $('#mTb').datagrid('getSelected');
			if(row){
				$('#dlg').dialog('open').dialog('setTitle','修改');
				$('#fm').form('load',row);
				url="emp?action=update&id="+row.empno;
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
			//alert('delete...');
            var row = $('#mTb').datagrid('getSelected');
            if (row){
                $.messager.confirm('确认','您确定要删除吗？',function(r){
                    if (r){
                        $.post('emp?action=delete',{empno:row.empno},function(result){
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
  		<h3 style="padding-right: 30px;padding-top: 40px; float: right;"><a href="deptinfo.jsp">部门信息管理</a></h3>
  	</div>
  	
    <table id="mTb" 
          class="easyui-datagrid" width="100%" 
          url="emp?action=query"
          toolbar="#toolbar" pagination="true"
        rownumbers="true" fitColumns="true" singleSelect="true"
        pageSize="5"        
        pageList="[3,5,8,10]">
        <thead>
            <tr>
            	<!--  data-options="hidden: true"是否隐藏该列 -->
                <th field="empno" width="50">编号</th>
                <th field="ename" width="50">姓名</th>
                <th field="job" width="50">岗位</th>
                <th field="hiredate" width="50">入职时间</th>
                <th field="mgr" width="50">上司编号</th>
                <th field="deptno" width="50">部门编号</th>
                <th field="sal" width="50">底薪</th>
                <th field="comm" width="50">奖金</th>
            </tr>
        </thead>
      </table>
      
      <div id="toolbar">
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新增</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">修改</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeUser()">删除</a>
    </div>
    
    <div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
            closed="true" buttons="#dlg-buttons">
        <div class="ftitle">用户信息</div>
        <form id="fm" method="post" novalidate>
        	<div class="fitem">
                <label>编号:</label>
                <input name="empno" class="easyui-validatebox" required="true">
            </div>
            <div class="fitem">
                <label>姓名:</label>
                <input name="ename" class="easyui-validatebox" required="true">
            </div>
            <div class="fitem">
                <label>岗位:</label>
                <input name="job" class="easyui-validatebox" required="true">
            </div>
            <div class="fitem">
                <label>入职:</label>
                <input name="hiredate" class="easyui-datebox" required="true">
            </div>
            <div class="fitem">
                <label>上司:</label>
                <input name="mgr" class="easyui-validatebox" required="true">
            </div>
            <div class="fitem">
                <label>部门:</label>
                <input name="deptno" class="easyui-validatebox" required="true">
            </div>
            <div class="fitem">
                <label>底薪:</label>
                <input name="sal" class="easyui-validatebox" required="true">
            </div>
            <div class="fitem">
                <label>奖金:</label>
                <input name="comm" class="easyui-validatebox" required="true">
            </div>
        </form>
    </div>
    <div id="dlg-buttons">
        <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">提交</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
      
  </body>
</html>
