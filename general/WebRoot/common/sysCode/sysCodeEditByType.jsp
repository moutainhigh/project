<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<<<<<<< .mine
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
=======
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
>>>>>>> .r478
  <head>
    <title>根据代码类型修改单据</title>
  </head>
  
  <body>
    <form action="sysCode/editSysCode.do" method="post" id="sysCode-form-editCode">
    	<div class="pageContent">
    		<p>
    			<label>单据:</label>
    			<input type="text" name="sysCode.code" readonly="readonly" value="${sysCode.code }" class="easyui-validatebox" required="true" style="width:200px;"/>
    		</p>
    		<p>
    			<label>单据名称:</label>
    			<input type="text" name="sysCode.codename" value="${sysCode.codename }" class="easyui-validatebox" required="true" style="width:200px;"/>
    		</p>
    		<p>
    			<label>单据类型:</label>
    			<input type="text" name="sysCode.type" readonly="readonly" value="${sysCode.type }" class="easyui-validatebox" required="true" style="width:200px;"/>
    		</p>
    		<p>
    			<label>单据类型名称:</label>
    			<input type="text" name="sysCode.typename" readonly="readonly"  value="${sysCode.typename }" class="easyui-validatebox" required="true" style="width:200px;"/>
    		</p>
    		<p>
    			<label>排序:</label>
    			<input type="text" name="sysCode.seq" value="${sysCode.seq }" class="easyui-validatebox" required="true" style="width:200px;"/>
    		</p>
    		<p>
    			<label>状态:</label>
    			<select name="sysCode.state" style="width:200px;">
    				<option value="1" <c:if test="${sysCode.state=='1' }">selected="selected"</c:if> >有效</option>
    				<option value="0" <c:if test="${sysCode.state=='0' }">selected="selected"</c:if> >无效</option>
    			</select>
    		</p>
    		<div class="buttondiv">
    			<a href="javaScript:void(0);" id="sysCode-save-editCode" class="easyui-linkbutton" data-options="iconCls:'button-save'">确定</a>
    		</div>
    	</div>
    </form>
    <script type="text/javascript">
    	$(function(){
    		$("#sysCode-form-editCode").form({
    			onSubmit: function(){
    				var flag = $(this).form('validate');
    				if(flag==false){
    					return false;
    				}
    			},
    			success: function(data){
    				var json=$.parseJSON(data);
    				if(json.flag == true){
    					$.messager.alert("提醒","修改成功！");
    					//$("#sysCode-dialog-codeOper").dialog('close',true);
    					$("#sysNumber-table-billName").datagrid('reload');
    					$("#tt").tabs('close','修改单据名称信息');
    					//$("#sysCode-table-showCodeList").datagrid('reload');
    				}else{
    					$.messager.alert("提醒","修改失败！");
    				}
    			}
    		});
    		$("#sysCode-save-editCode").click(function(){
    			$.messager.confirm("提醒","是否修改单据信息?", function(r){
    				if(r){
    					var ret=$("#sysCode-form-editCode").submit();
    				}
    			});
    		});
    	});
    </script>
  </body>
</html>
