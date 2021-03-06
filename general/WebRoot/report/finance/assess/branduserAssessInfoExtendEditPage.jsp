<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>品牌业务员考核扩展新增明细页面</title>
  </head>
  
  <body>
    <div class="easyui-layout" data-options="fit:true">
    	<div data-options="region:'center',border:true">
    		<div align="center">
    			<form action="" method="post" id="branduserAssessExtend-form-add" style="padding: 10px;">
    				<input id="report-type-page" type="hidden" value="edit"/>
	    			<input id="report-check-branduserAssessExtend" type="hidden" name="check" value="0"/>
	    			<table cellpadding="2" cellspacing="2" border="0">
	    				<tr>
	    					<td width="80px" align="left">日期:</td>
	    					<td align="left"><input type="text" name="branduserAssessExtend.businessdate" style="width:120px" onclick="WdatePicker({dateFmt:'yyyy-MM',minDate:'1958-01',maxDate:'%y-%M'})" value="${branduserAssessExtend.businessdate }" disabled="disabled"/></td>
	    					<td width="80px" align="right">销售区域:</td>
	    					<td align="left"><input id="report-widget-salesarea" type="text" style="width: 120px;" name="branduserAssessExtend.salesarea" value="${branduserAssessExtend.salesarea }" readonly="readonly"/></td>
	    				</tr>
	    				<tr>
	    					<td align="left">品牌业务员:</td>
	    					<td align="left"><input id="report-widget-branduser" type="text" style="width: 120px;" name="branduserAssessExtend.branduser" value="${branduserAssessExtend.branduser }" readonly="readonly"/></td>
	    					<td align="left">回笼指标:</td>
	    					<td align="left"><input id="report-numberbox-wdtargetamount" type="text" name="branduserAssessExtend.wdtargetamount" value="${branduserAssessExtend.wdtargetamount }" style="width: 120px" class="easyui-numberbox" data-options="precision:2,groupSeparator:','" onfocus="this.select();frm_focus('wdtargetamount');" onblur="frm_blur('wdtargetamount');"/></td>
	    				</tr>
	    				<tr>
	    					<td align="left">其他回笼:</td>
	    					<td align="left"><input id="report-numberbox-otherwdamount" type="text" name="branduserAssessExtend.otherwdamount" value="${branduserAssessExtend.otherwdamount }" style="width: 120px" class="easyui-numberbox" data-options="precision:2,groupSeparator:','" onfocus="this.select();frm_focus('otherwdamount');" onblur="frm_blur('otherwdamount');"/></td>
	    					<td align="left">kpi目标:</td>
	    					<td align="left"><input id="report-numberbox-kpitargetamount" type="text" name="branduserAssessExtend.kpitargetamount" value="${branduserAssessExtend.kpitargetamount }" style="width: 120px" class="easyui-numberbox" data-options="precision:2,groupSeparator:','" onfocus="this.select();frm_focus('kpitargetamount');" onblur="frm_blur('kpitargetamount');"/></td>
	    				</tr>
	    				<tr>
	    					<td align="left">kpi奖金:</td>
	    					<td align="left"><input id="report-numberbox-kpibonusamount" type="text" name="branduserAssessExtend.kpibonusamount" value="${branduserAssessExtend.kpibonusamount }" style="width: 120px" class="easyui-numberbox" data-options="precision:2,groupSeparator:','" onfocus="this.select();frm_focus('kpibonusamount');" onblur="frm_blur('kpibonusamount');"/></td>
	    					<td align="left">区长:</td>
	    					<td align="left"><input id="report-numberbox-wardenamount" type="text" name="branduserAssessExtend.wardenamount" value="${branduserAssessExtend.wardenamount }" style="width: 120px" class="easyui-numberbox" data-options="precision:0,groupSeparator:','" onfocus="this.select();frm_focus('wardenamount');" onblur="frm_blur('wardenamount');"/></td>
	    				</tr>
	    				<tr>
	    					<td align="left">备注:</td>
	    					<td align="left" colspan="3">
	    						<input id="report-textarea-remark" type="text" name="branduserAssessExtend.remark" value="${branduserAssessExtend.remark }" style="width: 340px" class="easyui-validatebox" validType="maxLen[200]" style="width: 120px;" onfocus="this.select();frm_focus('remark');" onblur="frm_blur('remark');"/>
	    					</td>
	    				</tr>
	    			</table>
	    		</form>
    		</div>
    	</div>
    	<div data-options="region:'south'" style="height: 30px;border: 0px;">
    		<div align="right">
    			<a href="javaScript:void(0);" id="branduserAssessExtend-saveAgain-saveMenu" class="easyui-linkbutton" data-options="plain:true,iconCls:'button-add'" title="继续添加品牌业务员考核">继续添加</a>
    		</div>
    	</div>
    </div>
    <script type="text/javascript">
    	$("#branduserAssessExtend-saveAgain-saveMenu").click(function(){
    		if(!$("#branduserAssessExtend-form-add").form('validate')){
       			return false;
       		}
       		$("#report-check-branduserAssessExtend").val("1");
       		var addform = $("#branduserAssessExtend-form-add").serializeJSON();
       		$.messager.confirm("提醒","确定修改该品牌业务员考核?",function(r){
	    		if(r){
			    	loading("提交中..");
			    	$.ajax({
			            url :'report/finance/addBranduserAssessInfoExtend.do',
			            type:'post',
			            dataType:'json',
			            data:addform,
			            success:function(retJson){
			            	loaded();
				            if(retJson.flag){
				        		$.messager.alert("提醒","修改成功!");
				        		$('#branduserAssessExtend-dialog-operate').dialog('close');
				        		var queryJSON = $("#branduserAssessExtend-form-ListQuery").serializeJSON();
					        	$("#report-table-branduserAssessExtend").datagrid('load',queryJSON);
				        	}
				        	else{
				        		$.messager.alert("提醒","修改失败!");
				        	}
			            }
			        });
	    		}else{
	    			$("#report-check-branduserAssessExtend").val("0");
	    		}
	    	});
    	});
    	
    	$(function(){
    		//销售区域
    		$("#report-widget-salesarea").widget({
    			width:120,
				referwid:'RT_T_BASE_SALES_AREA_LIST',
				singleSelect:true
    		});
			//品牌业务员
		  	$("#report-widget-branduser").widget({
		  		width:120,
				referwid:'RL_T_BASE_PERSONNEL_BRANDSELLER',
				singleSelect:true
			});
    	});
    </script>
  </body>
</html>
