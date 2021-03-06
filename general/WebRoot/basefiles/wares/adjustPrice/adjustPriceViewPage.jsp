<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>调价单新增页面</title>
</head>
<body>
    <div class="easyui-layout" data-options="fit:true,border:false">
    	<form id="goods-form-adjustPriceAddPage" action="" method="post">
	    	<div data-options="region:'north',border:false" style="height: 100px;">
	    		<table style="border-collapse:collapse;" border="0" cellpadding="5px" cellspacing="5px">
	    			<tr>
	    				<td class="len80 left">编号：</td>
	    				<td class="len165"><input id="goods-adjustPrice-id" class="easyui-validatebox" name="adjustPrice.id" value="${adjustPrice.id }"  readonly="readonly" style="width:160px;"/></td>
	    				<td class="len80 right">业务日期：</td>
	    				<td class="len165"><input type="text" id="goods-adjustPrice-businessdate"  onfocus="WdatePicker({'dateFmt':'yyyy-MM-dd'})" value="${adjustPrice.businessdate }"  name="adjustPrice.businessdate" style="width:160px;"/></td>
	    				<td class="len80 right">状态：</td>
	    				<td class="len165"><select id="goods-adjustPrice-status-select" disabled="disabled" style="width:160px;">
    	                          <c:forEach items="${statusList }" var="list">
    							<c:choose>
    								<c:when test="${list.code == adjustPrice.status}">
    									<option value="${list.code }" selected="selected">${list.codename }</option>
    								</c:when>
    								<c:otherwise>
    									<option value="${list.code }">${list.codename }</option>
    								</c:otherwise>
    							</c:choose>
    						</c:forEach>
    	                    </select></td>
	    			</tr>
	    			<tr>
	    			    <td>调价单名称：</td>
	    				<td>
	    					<input type="text" id="goods-adjustPrice-name" name="adjustPrice.name" value="${adjustPrice.name }"  style="width:160;" />
	    				</td>
	    				<td class="len80 right">调价类型：</td>
	    				<td class="len165"><select id="goods-adjustPrice-type-select" name="adjustPrice.type"  value="${adjustPrice.type }" disabled="disabled"  style="width:160px;">
    	                        <option value="1">商品采购价</option>
    	                        <option value="2">商品基准销售价</option>
    	                        <option value="3">价格套</option>
    	                        <option value="4">合同价</option>
    	                    </select>
    	                </td>
    	                <td class="len80 right">对应项目：</td>
	    				<td class="len165" id="customertd">
	    				    <input  class="easyui-validatebox" readonly='readonly' style="width:160px;"/>
    	                </td>
	    		    <tr>
	    				<td>生成方式：</td>
	    				<td class="len165">
	    				    <select id="goods-adjustPrice-createtype-select" style="width:160px;" disabled="disabled" >
    	                        <option value="0" selected="selected">手动生成</option>
    	                        <option value="1">品牌生成</option>
    	                        <option value="2">商品分类生成</option>
    	                    </select>
    	                </td>
	    				<td class="len80 right">备注：</td>
	    				<td colspan="3" style="text-align: left">
	    					<input type="text"  id="goods-adjustPrice-remark" name="adjustPrice.remark" alue="${adjustPrice.remark}" style="width: 425px;" onfocus="frm_focus('adjustPrice.remark');" onblur="frm_blur('adjustPrice.remark');"/>
	    				</td>
	    			</tr>
	    			<tr>
	    		</table>
	    	</div>
	    	<div data-options="region:'center',border:false">
	    		<table id="goods-datagrid-adjustPriceAddPage"></table>
	    	</div>
	    	<input type="hidden" id="goods-adjustPrice-adjustPriceDetail" name="detailJson"/>
	    	<input type="hidden" id="goods-adjustPrice-saveaudit" name="saveaudit" value="save"/>
	    </form>
    </div>
    <div id="goods-dialog-adjustPriceAddPage"></div>
    <script type="text/javascript">
    	$(function(){
    		 var type='${adjustPrice.type }'; 
 		$("#goods-adjustPrice-type-select").val(type);
 		if(type=="3"){
 			var busid="${adjustPrice.busid }" ;
 		     changeCustomerWidget("3",busid,"1");
 		}
 		if(type=="4"){
 			var busid="${adjustPrice.busid }" ;
 		     changeCustomerWidget("4",busid,"1");
 		}
    		
    		$("#goods-buttons-adjustPricePage").buttonWidget("initButtonType", 'add');
    		$("#goods-datagrid-adjustPriceAddPage").datagrid({
    			authority:tableColJson,
    			columns: tableColJson.common,
    			frozenColumns: tableColJson.frozen,
    			border: true,
    			rownumbers: true,
    			showFooter: true,
    			striped:true,
    			fit:true,
    			singleSelect: false,
    			checkOnSelect:true,
    	 		selectOnCheck:true,
    	 		data:JSON.parse('${detailList}'),
    	 		onRowContextMenu: function(e, rowIndex, rowData){
    				e.preventDefault();
    				$("#goods-datagrid-adjustPriceAddPage").datagrid('selectRow', rowIndex);
                    $("#goods-contextMenu-adjustPriceAddPage").menu('show', {  
                        left:e.pageX,  
                        top:e.pageY  
                    });
    			},
    			onLoadSuccess: function(data){
    				if(data.rows.length<12){
    					var j = 12-data.rows.length;
	            		for(var i=0;i<j;i++){
	            			$(this).datagrid('appendRow',{});
	            		}
    				}else{
    					$(this).datagrid('appendRow',{});
    				}
    			},
    		}).datagrid('columnMoving'); 
    		
    		//调价商品添加
    		$("#goods-addRow-adjustPriceAddPage").click(function(){
				var flag = $("#goods-contextMenu-adjustPriceAddPage").menu('getItem','goods-addRow-adjustPriceAddPage').disabled;
				if(flag){
					return false;
				}
    			beginAddDetail();
    		});
    		
    		//调价商品修改
    		$("#goods-editRow-adjustPriceAddPage").click(function(){
    			var flag = $("#goods-contextMenu-adjustPriceAddPage").menu('getItem','#goods-editRow-adjustPriceAddPage').disabled;
				if(flag){
					return false;
				}
    			beginEditDetail();
    		});
    		//调价商品删除
    		$("#goods-removeRow-adjustPriceAddPage").click(function(){
    			var flag = $("#goods-contextMenu-adjustPriceAddPage").menu('getItem','#goods-removeRow-adjustPriceAddPage').disabled;
				if(flag){
					return false;
				}
    			removeDetail();
    		});
    		//调价单提交
    		$("#goods-form-adjustPriceAddPage").form({  
			    onSubmit: function(){  
			    	var json = $("#goods-datagrid-adjustPriceAddPage").datagrid('getRows');
		
					$("#goods-adjustPrice-adjustPriceDetail").val(JSON.stringify(json));
			    	var flag = $(this).form('validate');
			    	if(flag==false){
			    		return false;
			    	}

			    	loading("提交中..");
			    },  
			    success:function(data){
			    	
			    	//表单提交完成后 隐藏提交等待页面
			    	loaded();
			    	var json = $.parseJSON(data);
			    	if(json.flag){
			    		$("#goods-adjustPrice-id").val(json.id);
			    		if(json.auditflag){
			    			$("#goods-adjustPrice-status-select").val("3");
			    			var d = new Date();
							var str = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
							$("#goods-adjustPrice-businessdate").val(str);
			    			$.messager.alert("提醒","保存并审核成功");
			    			$("#goods-buttons-adjustPricePage").buttonWidget("setDataID",{id:'${adjustPrice.id}',state:'3',type:'view'});
			    		}else{
			    			$("#goods-adjustPrice-status-select").val("2");
			    			$.messager.alert("提醒","保存成功"+json.msg);
			    			$("#goods-buttons-adjustPricePage").buttonWidget("setDataID",{id:'${adjustPrice.id}',state:'2',type:'edit'});
			    		}
			    		$("#goods-buttons-adjustPricePage").buttonWidget("addNewDataId", json.id);
			    		
			    	}else{
			    		$.messager.alert("提醒","保存失败."+json.msg);
			    	}
			    }  
			}); 
    	});
    	//控制按钮状态
    	$("#goods-buttons-adjustPricePage").buttonWidget("setDataID",{id:'${adjustPrice.id}',state:'${adjustPrice.status}',type:'view'});
    </script>
</body>

</html>