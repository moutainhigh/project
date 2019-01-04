<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>收款单列表页面</title>
    <%@include file="/include.jsp" %>   
  </head>
  
  <body>
    <div id="account-buttons-collectionOrderTransferPage"></div>
    <div id="account-datagrid-toolbar-collectionOrderPage" style="padding: 0px">
        <div class="buttonBG">
            <a href="javaScript:void(0);" id="account-transfer-collectionOrder" class="easyui-linkbutton" iconCls="button-save" plain="true">转账</a>
        </div>
    	<form action="" id="account-form-query-collectionOrderPage" method="post">
    		<input type="hidden" name="status" value="3"/>
    		<table>
    			<tr>
    				<tr>
    				<td>编号:</td>
    				<td><input type="text" name="id" style="width: 180px;"/></td>
    				<td>客户:</td>
    				<td><input id="account-query-customerid" type="text" name="customerid" style="width: 180px;"/></td>
    				<td>
    					<a href="javaScript:void(0);" id="account-query-collectionOrder" class="button-qr">查询</a>
						<a href="javaScript:void(0);" id="account-reload-collectionOrder" class="button-qr">重置</a>

    				</td>
    			</tr>
    		</table>
    	</form>
    </div>
    <div id="account-dialog-collectionOrder-TransferSubmit"></div>
    <script type="text/javascript">
    	var initQueryJSON = $("#account-form-query-collectionOrderPage").serializeJSON();
    	$(function(){
			var tableColumnListJson = $("#account-buttons-collectionOrderTransferPage").createGridColumnLoad({
				name :'t_account_collection_order',
				frozenCol : [[
			    			]],
				commonCol : [[
							  {field:'id',title:'编号',width:130,sortable:true},
							  {field:'businessdate',title:'业务日期',width:80,sortable:true},
							  {field:'customerid',title:'客户',width:150,sortable:true,
							  	formatter:function(value,rowData,rowIndex){
					        		return rowData.customername;
					        	}
							  },
							  {field:'handlerid',title:'对方经手人',width:80,sortable:true,hidden:true,
							  	formatter:function(value,rowData,rowIndex){
					        		return rowData.handlername;
					        	}
							  },
							  {field:'collectiondept',title:'收款部门',width:100,sortable:true,
							  	formatter:function(value,rowData,rowIndex){
					        		return rowData.collectiondeptname;
					        	}
							  },
							  {field:'collectionuser',title:'收款人',width:100,sortable:true,
							  	formatter:function(value,rowData,rowIndex){
					        		return rowData.collectionusername;
					        	}
							  },
							  {field:'amount',title:'收款金额',resizable:true,align:'right',sortable:true,
							  	formatter:function(value,rowData,rowIndex){
					        		return formatterMoney(value);
					        	}
							  },
							  {field:'writeoffamount',title:'已核销金额',align:'right',resizable:true,sortable:true,
							  	formatter:function(value,rowData,rowIndex){
					        		return formatterMoney(value);
					        	}
							  },
							  {field:'remainderamount',title:'剩余金额',resizable:true,align:'right',sortable:true,
							  	formatter:function(value,rowData,rowIndex){
					        		return formatterMoney(value);
					        	}
							  },
							  {field:'addusername',title:'制单人',width:80,sortable:true},
							  {field:'addtime',title:'制单时间',width:80,sortable:true},
							  {field:'auditusername',title:'审核人',width:80,sortable:true,hidden:true},
							  {field:'audittime',title:'审核时间',width:80,sortable:true,hidden:true},
							  {field:'stopusername',title:'中止人',width:80,hidden:true,hidden:true},
							  {field:'stoptime',title:'中止时间',width:80,hidden:true,sortable:true,hidden:true},
							  {field:'status',title:'状态',width:60,sortable:true,
							  	formatter:function(value,rowData,rowIndex){
					        		return getSysCodeName("status",value);
					        	}
							  },
							  {field:'remark',title:'备注',width:80,sortable:true}
				             ]]
			});
			$("#account-buttons-collectionOrderTransferPage").datagrid({ 
		 		authority:tableColumnListJson,
		 		frozenColumns: tableColumnListJson.frozen,
				columns:tableColumnListJson.common,
		 		fit:true,
		 		title:"收款单列表",
		 		method:'post',
		 		rownumbers:true,
		 		pagination:true,
		 		idField:'id',
		 		sortName:'id',
		 		sortOrder:'desc',
		 		singleSelect:true,
				url: 'account/receivable/showCollectionOrderList.do',
				queryParams:initQueryJSON,
				toolbar:'#account-datagrid-toolbar-collectionOrderPage'
			}).datagrid("columnMoving");
			$("#account-query-customerid").widget({
				name:'t_account_collection_order',
				col:'customerid',
    			singleSelect:true,
    			width:180,
    			onlyLeafCheck:false,
    			required:true,
    			view:true
			});
			
			controlQueryAndResetByKey("account-query-collectionOrder","account-reload-collectionOrder");
			
			//查询
			$("#account-query-collectionOrder").click(function(){
				var flag = $("#account-form-query-collectionOrderPage").form('validate');
		    	if(flag==false){
		    		return false;
		    	}
				//把form表单的name序列化成JSON对象
	       		var queryJSON = $("#account-form-query-collectionOrderPage").serializeJSON();
	       		$("#account-buttons-collectionOrderTransferPage").datagrid({
	       			url: 'account/receivable/showCollectionOrderList.do',
					queryParams:queryJSON
	       		});
			});
			//重置
			$("#account-reload-collectionOrder").click(function(){
				$("#account-query-customerid").widget("clear");
				$("#account-form-query-collectionOrderPage")[0].reset();
	       		$("#account-buttons-collectionOrderTransferPage").datagrid("load",{});
			});
			//转账
			$("#account-transfer-collectionOrder").click(function(){
				var row = $("#account-buttons-collectionOrderTransferPage").datagrid("getSelected");
				if(null!=row){
		   			$("#account-dialog-collectionOrder-TransferSubmit").dialog({
						href:"account/receivable/showCollectionOrderTransferSubmitPage.do?id="+row.id,
						title:"收款单转账",
					    width:700,
					    height:400,
						modal:true,
						cache:false,
						maximizable:true,
						resizable:true,
					    cache: false,  
					    modal: true,
					    buttons:[{
								text:'确定',
								handler:function(){
									transferSubmit();
								}
							}]
					});
				}else{
					$.messager.alert("提醒","请选择多条数据");
				}
			});
		});
    </script>
  </body>
</html>
