<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>其他入库单新增页面</title>
  </head>  
  <body>
    <div class="easyui-layout" data-options="fit:true,border:false">
    	<form id="storage-form-storageOtherEnterAdd"  method="post">
	    	<div data-options="region:'north',border:false" style="height:135px;">
	    		<table style="border-collapse:collapse;" border="0" cellpadding="5px" cellspacing="5px">
	    			<tr>
	    				<td class="len80 left">编号：</td>
	    				<td class="len165"><input class="easyui-validatebox" style="width: 135px" name="storageOtherEnter.id" value="${storageOtherEnter.id }" readonly="readonly"/></td>
	    				<td class="len80 left">业务日期：</td>
	    				<td class="len165"><input type="text" id="storage-storageOtherEnter-businessdate" class="len130" onfocus="WdatePicker({'dateFmt':'yyyy-MM-dd'})" value="${storageOtherEnter.businessdate }" name="storageOtherEnter.businessdate"/></td>
	    				<td class="len80 left">状态：</td>
	    				<td class="len165">
	    					<select id="storage-storageOtherEnter-status-select" disabled="disabled" class="len136">
    						<c:forEach items="${statusList }" var="list">
    							<c:choose>
    								<c:when test="${list.code == storageOtherEnter.status}">
    									<option value="${list.code }" selected="selected">${list.codename }</option>
    								</c:when>
    								<c:otherwise>
    									<option value="${list.code }">${list.codename }</option>
    								</c:otherwise>
    							</c:choose>
    						</c:forEach>
    						</select>
    						<input type="hidden" name="storageOtherEnter.status" value="${storageOtherEnter.status }"/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<td class="len80 left">入库仓库：</td>
	    				<td>
                            <input type="text" id="storage-storageOtherEnter-storageid" name="storageOtherEnter.storageid" value="${storageOtherEnter.storageid}" readonly="readonly"/>
	    				</td>
						<td class="len80 left">入库类型：</td>
						<td><input id="storage-otherEnter-entertype" name="storageOtherEnter.entertype" value="${storageOtherEnter.entertype}" class="len130">
						</td>
	    				<td class="len80 left">相关部门：</td>
	    				<td><input id="storage-otherEnter-deptid" name="storageOtherEnter.deptid" value="${storageOtherEnter.deptid}"/>
	    				</td>
	    			</tr>
	    			<tr>
						<td class="len80 left">来源类型：</td>
						<td><input id="storage-otherEnter-sourcetype" name="storageOtherEnter.sourcetype"  value="<c:out value="${storageOtherEnter.sourcetype}"></c:out>" readonly="readonly"></td>
						<td class="len100 left">来源单据编号：</td>
						<td>
							<input id="storage-otherEnter-sourceid" name="storageOtherEnter.sourceid" class="len130"  value="<c:out value="${storageOtherEnter.sourceid}"></c:out>" readonly="readonly">
						</td>

						<td class="len80 left">相关人员：</td>
						<td>
							<select id="storage-otherEnter-userid" class="len136" name="storageOtherEnter.userid">
								<option value="${storageOtherEnter.userid }">${storageOtherEnter.username}</option>
							</select>
						</td>
	    				</tr>
					<tr>
						<td class="len80 left">备注：</td>
						<td colspan="5" style="text-align: left;"><input type="text" name="storageOtherEnter.remark" style="width: 686px;" value="<c:out value="${storageOtherEnter.remark}"></c:out>"/></td>

					</tr>
	    		</table>
	    	</div>
	    	<div data-options="region:'center',border:false">
	    		<input type="hidden" name="detailJson" id="storage-purchaseEnter-storageOtherEnterDetail" />
	    		<input type="hidden" name="saveaudit" id="storage-purchaseEnter-saveaudit" value="save"/>
	    		<table id="storage-datagrid-storageOtherEnterAddPage"></table>
	    	</div>
	    </form>
    </div>
    <div class="easyui-menu" id="sales-contextMenu-storageOtherEnterAddPage" style="display: none;">
    	<div id="sales-addRow-storageOtherEnterAddPage" data-options="iconCls:'button-add'">添加</div>
    	<div id="sales-editRow-storageOtherEnterAddPage" data-options="iconCls:'button-edit'">编辑</div>
    	<div id="sales-removeRow-storageOtherEnterAddPage" data-options="iconCls:'button-delete'">删除</div>
    </div>
    <div id="storage-dialog-storageOtherEnterAddPage"></div>
    <script type="text/javascript">
        var oldentertype='',oldentertypename="";

    	$(function(){
    		$("#storage-datagrid-storageOtherEnterAddPage").datagrid({ //销售商品明细信息编辑
    			columns: tableColJson,
    			border: true,
    			fit: true,
    			rownumbers: true,
    			showFooter: true,
    			striped:true,
    			singleSelect: true,
    			data:JSON.parse('${detailList}'),
    			onLoadSuccess:function(data){
    				if(data.rows.length<10){
	            		var j = 10-data.rows.length;
	            		for(var i=0;i<j;i++){
	            			$("#storage-datagrid-storageOtherEnterAddPage").datagrid('appendRow',{});
	            		}
   					}else{
   						$("#storage-datagrid-storageOtherEnterAddPage").datagrid('appendRow',{});
   					}
    				countTotal();
    			},
    			onRowContextMenu: function(e, rowIndex, rowData){
    				e.preventDefault();
    				$("#storage-datagrid-storageOtherEnterAddPage").datagrid('selectRow', rowIndex);
                    $("#sales-contextMenu-storageOtherEnterAddPage").menu('show', {  
                        left:e.pageX,  
                        top:e.pageY  
                    });
    			},
    			onDblClickRow: function(rowIndex, rowData){
                    var entertype=$("#storage-otherEnter-entertype").widget("getValue");
    				if(rowData.goodsid == undefined){
                        if(entertype=='99'){
                            beginCostAddDetail();
                        }else{
                            beginAddDetail();
                        }
    				}
    				else{
                        if(entertype=='99'){
                            beginCostEditDetail();
                        }else{
                            beginEditDetail();
                        }
    				}
    			}
    		}).datagrid('columnMoving');
            //入库仓库
            $("#storage-storageOtherEnter-storageid").widget({
                width:136,
                referwid:'RL_T_BASE_STORAGE_INFO',
                singleSelect:true,
                onlyLeafCheck:false,
                required:true
            });
			$("#storage-otherEnter-sourcetype").widget({
                referwid:'RL_T_SYS_CODESOURCETYPE',
				// name: 't_storage_other_enter',
				// col: 'sourcetype',
				singleSelect: true,
				isdatasql: false,
				width:135,
				onlyLeafCheck: false
			});
			$("#storage-otherEnter-entertype").widget({
				referwid:'RL_T_SYS_CODE_ENTER_TYPE',
				singleSelect: true,
				isdatasql: false,
				width: 130,
				onlyLeafCheck: false,
                onSelect:function(data){
                    var rows = $("#storage-datagrid-storageOtherEnterAddPage").datagrid('getRows');
                    if(oldentertype!=data.code && rows[0].goodsid!=undefined){
                        if( oldentertype=='99' ){
                            if(oldentertype==''){
                                $("#storage-otherEnter-entertype").widget("clear");
							}else{
                                $("#storage-otherEnter-entertype").widget("setValue",oldentertype);
							}
                            $.messager.alert("提醒","入库类型为"+oldentertypename+"变更的时候需要先删除商品");
                            return;
                        }
                        if(data.code=='99'){
                            if(oldentertype==''){
                                $("#storage-otherEnter-entertype").widget("clear");
                            }else{
                                $("#storage-otherEnter-entertype").widget("setValue",oldentertype);
                            }
                            $.messager.alert("提醒","变更入库类型为"+data.codename+"的时候需要先删除商品");
                            return;
                        }
                    }
                    oldentertype=data.code;
                    oldentertypename=data.codename;
                },
				onClear:function(){
                    var rows = $("#storage-datagrid-storageOtherEnterAddPage").datagrid('getRows');
                    if( rows[0].goodsid!=undefined){
                        if( oldentertype=='99' ){
                            $("#storage-otherEnter-entertype").widget("setValue",oldentertype);
                            $.messager.alert("提醒","入库类型为"+oldentertypename+"变更的时候需要先删除商品");
                            return;
                        }
                    }
                    oldentertype='';
                    oldentertypename='';
				}
			});

			$("#storage-otherEnter-deptid").widget({
				referwid:'RL_T_BASE_DEPARTMENT_1',
				singleSelect: true,
				isdatasql: false,
				width: 136,
				onlyLeafCheck: false,
				onSelect : function(data){
					$.ajax({
						url :'basefiles/getPersonnelListByDeptid.do',
						type:'post',
						data:{deptid:data.id},
						dataType:'json',
						async:false,
						success:function(json){
							if(json.length>0){
								$("#storage-otherEnter-userid").html("");
								$("#storage-otherEnter-userid").append("<option value=''></option>");
								for(var i=0;i<json.length;i++){
									$("#storage-otherEnter-userid").append("<option value='"+json[i].id+"'>"+json[i].name+"</option>");
								}
							}
						}
					});
				}
			});

    		$("#sales-addRow-storageOtherEnterAddPage").click(function(){
                var entertype=$("#storage-otherEnter-entertype").widget("getValue");
                if(entertype=='99'){
                    beginCostAddDetail();
                }else{
                    beginAddDetail();
                }
    		});
    		$("#sales-editRow-storageOtherEnterAddPage").click(function(){
                var entertype=$("#storage-otherEnter-entertype").widget("getValue");
                if(entertype=='99'){
                    beginCostEditDetail();
                }else{
                    beginEditDetail();
                }
    		});
    		$("#sales-removeRow-storageOtherEnterAddPage").click(function(){
    			removeDetail();
    		});
    		$("#storage-form-storageOtherEnterAdd").form({  
			    onSubmit: function(){  
			    	var json = $("#storage-datagrid-storageOtherEnterAddPage").datagrid('getRows');
					$("#storage-purchaseEnter-storageOtherEnterDetail").val(JSON.stringify(json));
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
			    		if(json.auditflag){
			    			$.messager.alert("提醒","保存并审核成功");
			    			$("#storage-storageOtherEnter-status-select").val("4");
			    			$("#storage-buttons-storageOtherEnterPage").buttonWidget("setDataID",{id:'${storageOtherEnter.id}',state:'4',type:'view'});
			    			$("#storage-buttons-storageOtherEnterPage").buttonWidget("enableButton", 'button-oppaudit');
                            $("#storage-panel-storageOtherEnterPage").panel({
                                href:'storage/storageOtherEnterEditPage.do?id=${storageOtherEnter.id}',
                                title:'',
                                cache:false,
                                maximized:true,
                                border:false
                            });
                        }else{
			    			$.messager.alert("提醒","保存成功");
			    		}
			    	}else{
			    		$.messager.alert("提醒","保存失败</br>"+json.msg);
			    	}
			    }  
			});

            <%-- 来源为拆装单时，禁止反审 --%>
            <c:if test="${storageOtherEnter.entertype eq 4}">
                $('#storage-buttons-storageOtherEnterPage').buttonWidget('disableButton', 'button-oppaudit');
            </c:if>
			<%-- 来源为借货还货时，禁止反审 --%>
			<c:if test="${storageOtherEnter.sourcetype eq 2}">
			$('#storage-buttons-storageOtherEnterPage').buttonWidget('disableButton', 'button-oppaudit');
			</c:if>
    	});
    	$("#storage-buttons-storageOtherEnterPage").buttonWidget("setDataID",{id:'${storageOtherEnter.id}',state:'${storageOtherEnter.status}',type:'edit'});
    	$("#storage-hidden-billid").val("${storageOtherEnter.id}");
    </script>
  </body>
</html>
