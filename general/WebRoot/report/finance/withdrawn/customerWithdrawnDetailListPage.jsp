<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>按客户分品牌,分商品统计页面</title>
    <%@include file="/include.jsp" %>
    <script type="text/javascript" src="js/reportDatagrid.js" charset="UTF-8"></script>     
  </head>
  
  <body>
  	<form action="" id="report-query-form-CustomerWithdrawnDetail" method="post">
		<input type="hidden" name="customerid" value="${customerid}"/>
		<input type="hidden" name="businessdate1" value="${businessdate1}"/>
		<input type="hidden" name="businessdate2" value="${businessdate2}"/>
	</form>
  	<div id="report-tab-CustomerWithdrawnDetail" class="buttonBG">
		<security:authorize url="/report/finance/fundsCustomerReturnExport.do">
			<a href="javaScript:void(0);" id="report-export-CustomerWithdrawnDetail" class="easyui-linkbutton" iconCls="button-export" plain="true" title="导出">导出</a>
		</security:authorize>
	</div>
	<div id="tt" class="easyui-tabs" data-options="fit:true">
	    <div title="分品牌统计" style="padding:2px;">
	       <table id="report-datagrid-CustomerWithdrawnDetail-brand"></table>
	    </div>
	    <div title="分商品统计" style="padding:2px;">
	       <table id="report-datagrid-CustomerWithdrawnDetail-goods"></table>
	    </div>
	</div>
	<div id="report-fundsCustomer1-detail-dialog"></div>
    	<script type="text/javascript">
    		$('#tt').tabs({
				tools:'#report-tab-CustomerWithdrawnDetail'
			});
    		var initQueryJSON = $("#report-query-form-CustomerWithdrawnDetail").serializeJSON();
    		$(function(){
                var brandColumnListJson = $("#report-datagrid-CustomerWithdrawnDetail-brand").createGridColumnLoad({
                    frozenCol : [[]],
                    commonCol : [[
                        {field:'brandname',title:'商品品牌',width:60},
                        {field:'branddeptname',title:'品牌部门',width:80},
                        {field:'withdrawnamount',title:'回笼金额',align:'right',width:60,isShow:true,
                            formatter:function(value,rowData,rowIndex){
                                return formatterMoney(value);
                            }
                        }
                        <c:if test="${map.costwriteoffamount == 'costwriteoffamount'}">
                        ,
                        {field:'costwriteoffamount',title:'回笼成本',align:'right',width:60,isShow:true,sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                return formatterMoney(value);
                            }
                        }
                        </c:if>
                        <c:if test="${map.writeoffmarginamount == 'writeoffmarginamount'}">
                        ,
                        {field:'writeoffmarginamount',title:'回笼毛利额',align:'right',width:70,isShow:true,sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                return formatterMoney(value);
                            }
                        }
                        </c:if>
                        <c:if test="${map.writeoffrate == 'writeoffrate'}">
                        ,
                        {field:'writeoffrate',title:'回笼毛利率',align:'right',width:70,isShow:true,sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                if(null != value && "" != value){
                                    return formatterMoney(value)+"%";
                                }
                            }
                        }
                        </c:if>
                    ]]
                });

                var goodsColumnListJson = $("#report-datagrid-CustomerWithdrawnDetail-goods").createGridColumnLoad({
                    frozenCol : [[]],
                    commonCol : [[
                        {field:'goodsid',title:'商品编号',sortable:true,width:60},
                        {field:'goodsname',title:'商品名称',width:250},
                        {field:'barcode',title:'条形码',sortable:true,width:90},
                        {field:'brandname',title:'品牌名称',width:60},
                        {field:'unitnum',title:'数量',width:60,
                            formatter:function(value,rowData,rowIndex){
                                return formatterBigNumNoLen(value);
                            }
                        },
                        {field:'auxnumdetail',title:'辅数量',width:80,hidden:true},
                        {field:'withdrawnamount',title:'回笼金额',align:'right',width:60,isShow:true,
                            formatter:function(value,rowData,rowIndex){
                                return formatterMoney(value);
                            }
                        }
                        <c:if test="${map.costwriteoffamount == 'costwriteoffamount'}">
                        ,
                        {field:'costwriteoffamount',title:'回笼成本',align:'right',width:60,isShow:true,sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                return formatterMoney(value);
                            }
                        }
                        </c:if>
                        <c:if test="${map.writeoffmarginamount == 'writeoffmarginamount'}">
                        ,
                        {field:'writeoffmarginamount',title:'回笼毛利额',align:'right',width:70,isShow:true,sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                return formatterMoney(value);
                            }
                        }
                        </c:if>
                        <c:if test="${map.writeoffrate == 'writeoffrate'}">
                        ,
                        {field:'writeoffrate',title:'回笼毛利率',align:'right',width:70,isShow:true,sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                if(null != value && "" != value){
                                    return formatterMoney(value)+"%";
                                }
                            }
                        }
                        </c:if>
                    ]]
                });

    			$("#report-datagrid-CustomerWithdrawnDetail-brand").datagrid({
                    authority:brandColumnListJson,
                    frozenColumns: brandColumnListJson.frozen,
                    columns:brandColumnListJson.common,
			 		method:'post',
		  	 		fit:true,
		  	 		rownumbers:true,
		  	 		pagination:true,
		  	 		showFooter: true,
		  	 		singleSelect:true,
		  	 		pageSize:100,
					url: 'report/finance/showBaseFinanceDrawnData.do?groupcols=brandid',
					queryParams:initQueryJSON
				}).datagrid("columnMoving");
				$("#report-datagrid-CustomerWithdrawnDetail-goods").datagrid({
                    authority:goodsColumnListJson,
                    frozenColumns: goodsColumnListJson.frozen,
                    columns:goodsColumnListJson.common,
			 		method:'post',
		  	 		title:'',
		  	 		fit:true,
		  	 		rownumbers:true,
		  	 		pagination:true,
		  	 		pageSize:100,
		  	 		showFooter: true,
		  	 		singleSelect:true,
					url: 'report/finance/showBaseFinanceDrawnData.do?groupcols=goodsid',
					queryParams:initQueryJSON
				}).datagrid("columnMoving");
				
				$("#report-export-CustomerWithdrawnDetail").Excel('export',{
					queryForm: "#report-query-form-CustomerWithdrawnDetail", //查询条件的form表单，导出时只用通过查询的条件，将通用查询放在form表单里面。
			 		type:'exportUserdefined',
			 		name:'按客户：[${customername}]统计表',
			 		url:'report/finance/exportFinanceWithdrawnDetailReportData.do?groupcols=brandid;goodsid'
				});
    		});
    	</script>
  </body>
</html>
