<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>销售方式新增页面</title>
  </head>
  
  <body class="easyui-layout">
     <div region="north" data-options="border:false" style="height:50px;padding: 10px">
     	<div style="border: 1px black solid;">
     		<form action="" method="post" id="salemode-form-add">
	     		<table cellpadding="2" cellspacing="2" border="0px">
		    		<tr>
		    			<td width="80px" align="right">编码:</td>
		    			<td><input id="saleMode-id-saleModeDetail" type="text" name="saleMode.id" style="width: 120px" class="easyui-validatebox" validType="validID[20]" required="true" >
		    			</td>
		    			<td width="80px" align="right">名称:</td>
		    			<td><input id="saleMode-name-saleModeDetail" type="text" name="saleMode.name" style="width: 120px" class="easyui-validatebox" validType="validName[20]" required="true"></td>
		    			<td width="80px" align="right">状态:</td>
		    			<td><input id="common-combobox-state" type="text" value="4" disabled="disabled" class="easyui-combobox" style="width: 120px" /></td>
		    		</tr>
		    		<tr>
		    			<td width="80px" align="right">备注:</td>
		    			<td colspan="5">
		    				<input type="text" class="easyui-validatebox" name="saleMode.remark" validType="maxLen[200]" style="width: 650px;"/>
		    			</td>
		    		</tr>
		    	</table>
     		</form>
     	</div>
    </div>  
    <div region="center" data-options="fit:true,border:true" style="padding: 10px;">
    	<table id="saleMode-table-saleModeDetailList"></table>
    </div>
    <script type="text/javascript">
    	//加载下拉框
    	loadDropdown();
    	
    	var $saleMode_submit = $("#salemode-form-add");//商品档案基本主信息 
    	//销售方式数据表单json对象集合
    	function saleMode_JSONs(){
    		var saleModeInfo = $saleMode_submit.serializeJSON();
    		var saleModeDetail = saleModeDetailJson("add");
    		for(key in saleModeDetail){
				saleModeInfo[key] = saleModeDetail[key];
			};
			return saleModeInfo;
    	}
    	
    	//新增销售方式
    	function addSaleMode(type){
    		if(type == "save"){
    			if(!$saleMode_submit.form('validate')){
    				return false;
    			}
    		}
    		var ret = salemode_AjaxConn(saleMode_JSONs(),'basefiles/crmrelations/addSaleMode.do?type='+type,'提交中..');
    		var retJson = $.parseJSON(ret);
    		if(retJson.flag){
    			$("#salemode-table-list").datagrid('reload');
    			$("#salemode-div-salemodeInfo").panel('refresh','basefiles/crmrelations/showSaleModeViewPage.do?id='+$("#saleMode-id-saleModeDetail").val());
    			if("save" == type ){
    				$.messager.alert("提醒","新增保存成功!");
    			}
    			else{
    				$.messager.alert("提醒","新增暂存成功!");
    			}
    		}
    		else{
    			if("save" == type ){
    				$.messager.alert("提醒","新增保存失败!");
    			}
    			else{
    				$.messager.alert("提醒","新增暂存失败!");
    			}
    		}
    	}
    	
    	$(function(){
    		$("#salemode-button-layout").buttonWidget("initButtonType","add");
    		
    		//销售阶段列表
    		saleModeDetail("add");
    	});
    </script>
  </body>
</html>
