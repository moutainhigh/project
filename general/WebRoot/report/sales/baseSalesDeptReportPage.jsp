<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>人员部门销售报表</title>
    <%@include file="/include.jsp" %>
    <script type="text/javascript" src="js/reportDatagrid.js" charset="UTF-8"></script>
    <style>
        .checkbox1{
            float:left;
            height: 22px;
            line-height: 22px;
        }
        .divtext{
            height:22px;
            line-height:22px;
            float:left;
            display: block;
        }
    </style>
</head>

<body>
<table id="report-datagrid-baseSalesDeptReport"></table>
<div id="report-toolbar-baseSalesDeptReport" class="buttonBG">
    <a href="javaScript:void(0);" id="report-advancedQuery-baseSalesDeptReportPage" class="easyui-linkbutton" iconCls="button-commonquery" plain="true" title="[Alt+Q]查询">查询</a>
    <security:authorize url="/report/sales/baseSalesDeptReportExport.do">
        <a href="javaScript:void(0);" id="report-export-baseSalesDeptReportPage" class="easyui-linkbutton" iconCls="button-export" plain="true" title="全局导出">全局导出</a>
    </security:authorize>
    <security:authorize url="/report/sales/baseSalesDeptReportPrint.do">
        <a href="javaScript:void(0);" id="report-print-baseSalesDeptReportPage" class="easyui-linkbutton" iconCls="button-print" plain="true" title="打印">打印</a>
    </security:authorize>
</div>
<div style="display:none">
    <div id="report-dialog-advancedQueryDialog" >
        <form action="" id="report-query-form-baseSalesDeptReport" method="post">
            <table cellpadding="2" style="margin-left:5px;margin-top: 5px;">
                <tr>
                    <td>业务日期:</td>
                    <td><input type="text" name="businessdate1" value="${today }" style="width:87px;" class="Wdate" onclick="WdatePicker({'dateFmt':'yyyy-MM-dd',maxDate:'${today }'})" /> 到 <input type="text" name="businessdate2" value="${today }" class="Wdate" style="width:87px;" onclick="WdatePicker({'dateFmt':'yyyy-MM-dd',maxDate:'${today }'})" /></td>
                    <td>客&nbsp;&nbsp;户:</td>
                    <td><input type="text" name="customerid" id="report-customernamemore-advancedQuery"/></td>
                </tr>
                <tr>
                    <td>总&nbsp;&nbsp;店:</td>
                    <td><input type="text" name="pcustomerid" id="report-pcustomernamemore-advancedQuery"/></td>
                    <td>品&nbsp;&nbsp;牌:</td>
                    <td><input type="text" name="brandid" id="report-brandid-advancedQuery"/></td>
                </tr>
                <tr>
                    <td>品牌部门:</td>
                    <td><input type="text" name="branddept" id="report-branddept-advancedQuery"/></td>
                    <td>品牌业务员:</td>
                    <td><input type="text" name="branduser" id="report-branduser-advancedQuery"/></td>
                </tr>
                <tr>
                    <td>商&nbsp;&nbsp;品:</td>
                    <td><input type="text" name="goodsid" id="report-goodsid-advancedQuery"/></td>
                    <td>商品分类:</td>
                    <td><input type="text" name="goodssort" id="report-goodssort-advancedQuery"/></td>
                </tr>
                <tr>
                    <td>商品类型:</td>
                    <td><select name="goodstype" id="report-goodstype-advancedQuery" style="width: 200px;"  data-options="multiple:true,onLoadSuccess:function(){$(this).combobox('clear');}">
                        <option></option>
                        <c:forEach items="${goodstypeList }" var="list">
                            <option value="${list.code }">${list.codename }</option>
                        </c:forEach>
                    </select>
                    </td>
                    <td>销售区域:</td>
                    <td><input type="text" name="salesarea" id="report-salesarea-advancedQuery"/></td>
                </tr>
                <tr>
                    <td>客户分类:</td>
                    <td><input type="text" name="customersort" id="report-customersort-advancedQuery"/></td>
                    <td>客户业务员:</td>
                    <td><input type="text" name="salesuser" id="report-salesuser-advancedQuery"/></td>
                </tr>
                <tr>
                    <td>供 应 商:</td>
                    <td><input type="text" name="supplierid" id="report-supplierid-advancedQuery"/></td>
                    <td>厂家业务员:</td>
                    <td><input type="text" name="supplieruser" id="report-supplieruser-advancedQuery"/></td>
                </tr>
                <tr>
                    <td>销售部门:</td>
                    <td><input type="text" name="salesdept" id="report-salesdept-advancedQuery"/></td>
                    <td>人员部门:</td>
                    <td><input type="text" name="branduserdept" id="report-branduserdept-advancedQuery"/></td>
                </tr>
                <tr>
                    <td>小计列：</td>
                    <td colspan="3">
                        <div style="margin-top:2px">
                            <div style="line-height: 25px;margin-top: 2px;">
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="customerid"/>客户</label>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="pcustomerid"/>总店</label>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="customersort"/>客户分类</label>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="salesarea"/>销售区域</label>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="salesuser"/>客户业务员</label>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="salesdept"/>销售部门</label>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="branduserdept"/>人员部门</label>
                                <br/>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="goodsid"/>商品</label>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="brandid"/>品牌</label>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="goodssort"/>商品分类</label>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="branddept"/>品牌部门</label>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="branduser"/>品牌业务员</label>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="supplieruser"/>厂家业务员</label>
                                <label class="divtext"><input type="checkbox" class="groupcols checkbox1" value="supplierid"/>供应商</label>
                                <input id="report-query-groupcols" type="hidden" name="groupcols"/>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script type="text/javascript">
    var SR_footerobject  = null;
    var initQueryJSON = $("#report-query-form-baseSalesDeptReport").serializeJSON();
    $(function(){
        $("#report-print-baseSalesDeptReportPage").click(function () {
            var msg = "";
            printByAnalyse("人员部门销售报表", "report-datagrid-baseSalesDeptReport", "report/sales/printSalesDeptReportData.do", msg);
        });
        $("#report-export-baseSalesDeptReportPage").click(function(){
            var queryJSON = $("#report-query-form-baseSalesDeptReport").serializeJSON();
            //获取排序规则
            var objecr  = $("#report-datagrid-baseSalesDeptReport").datagrid("options");
            if(null != objecr.sortName && null != objecr.sortOrder ){
                queryJSON["sort"] = objecr.sortName;
                queryJSON["order"] = objecr.sortOrder;
            }
            var queryParam = JSON.stringify(queryJSON);
            var url = "report/sales/exportSalesDeptReportData.do?exporttype=base";
            exportByAnalyse(queryParam,"人员部门销售报表","report-datagrid-baseSalesDeptReport",url);
        });

        $(".groupcols").click(function(){
            var cols = "";
            $("#report-query-groupcols").val(cols);
            $(".groupcols").each(function(){
                if($(this).attr("checked")){
                    if(cols==""){
                        cols = $(this).val();
                    }else{
                        cols += ","+$(this).val();
                    }
                    $("#report-query-groupcols").val(cols);
                }
            });
        });
        var tableColumnListJson = $("#report-datagrid-baseSalesDeptReport").createGridColumnLoad({
            frozenCol : [[
                {field:'idok',checkbox:true,isShow:true}
            ]],
            commonCol : [[
                {field:'customerid',title:'客户编号',sortable:true,width:60,
                    formatter:function(value,rowData,rowIndex){
                        if("nodata" != value){
                            return value;
                        }else{
                            return "";
                        }
                    }
                },
                {field:'customername',title:'客户名称',width:210},
                {field:'pcustomerid',title:'总店编码',sortable:true,width:60,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        if("nodata" != value){
                            return value;
                        }else{
                            return "";
                        }
                    }
                },
                {field:'pcustomername',title:'总店名称',width:60,hidden:true},
                {field:'salesuser',title:'客户业务员',sortable:true,width:70,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return rowData.salesusername;
                    }
                },
                {field:'customersort',title:'客户分类',sortable:true,width:60,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return rowData.customersortname;
                    }
                },
                {field:'salesarea',title:'销售区域',sortable:true,width:60,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return rowData.salesareaname;
                    }
                },
                {field:'salesdept',title:'销售部门',sortable:true,width:80,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return rowData.salesdeptname;
                    }
                },
                {field:'branddept',title:'品牌部门',sortable:true,width:80,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return rowData.branddeptname;
                    }
                },
                {field:'branduser',title:'品牌业务员',sortable:true,width:70,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return rowData.brandusername;
                    }
                },
                {field:'branduserdept',title:'人员部门',sortable:true,width:70,
                    formatter:function(value,rowData,rowIndex){
                        return rowData.branduserdeptname;
                    }
                },
                {field:'supplieruser',title:'厂家业务员',sortable:true,width:70,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return rowData.supplierusername;
                    }
                },
                {field:'goodsid',title:'商品编码',sortable:true,width:60,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        if("nodata" != value){
                            return value;
                        }else{
                            return "";
                        }
                    }
                },
                {field:'goodsname',title:'商品名称',width:250,hidden:true},
                {field:'goodssortname',title:'商品分类',width:60,hidden:true},
                {field:'goodstypename',title:'商品类型',width:60,hidden:true},
                {field:'barcode',title:'条形码',width:90,hidden:true},
                {field:'brandid',title:'品牌名称',sortable:true,width:60,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return rowData.brandname;
                    }
                },
                {field:'supplierid',title:'供应商名称',sortable:true,width:200,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return rowData.suppliername;
                    }
                },
                {field:'unitname',title:'主单位',width:45,hidden:true},
                {field:'auxunitname',title:'辅单位',width:45,hidden:true},
                <c:if test="${map.costprice == 'costprice'}">
                {field:'costprice',title:'成本价',width:60,align:'right',hidden:true,sortable:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                </c:if>
                {field:'price',title:'单价',width:60,align:'right',hidden:true,sortable:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'ordernum',title:'订单数量',width:60,align:'right',hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'ordertotalbox',title:'订单箱数',width:60,align:'right',isShow:true,sortable:true,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'orderamount',title:'订单金额',resizable:true,sortable:true,align:'right',
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'ordernotaxamount',title:'订单未税金额',width:80,sortable:true,align:'right',isShow:true,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'initsendnum',title:'发货单数量',width:70,align:'right',hidden:true,sortable:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'initsendtotalbox',title:'发货单箱数',width:70,align:'right',isShow:true,sortable:true,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'initsendamount',title:'发货单金额',resizable:true,sortable:true,align:'right',
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'initsendnotaxamount',title:'发货单未税金额',width:90,sortable:true,align:'right',isShow:true,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'sendnum',title:'发货出库数量',width:80,align:'right',hidden:true,sortable:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'sendtotalbox',title:'发货出库箱数',width:80,align:'right',isShow:true,sortable:true,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'sendamount',title:'发货出库金额',resizable:true,sortable:true,align:'right',
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'sendnotaxamount',title:'发货出库未税金额',width:100,sortable:true,align:'right',isShow:true,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                <c:if test="${map.sendcostamount == 'sendcostamount'}">
                {field:'sendcostamount',title:'发货出库成本',width:80,sortable:true,align:'right',hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                </c:if>
                {field:'pushbalanceamount',title:'冲差金额',resizable:true,sortable:true,align:'right',
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'directreturnnum',title:'直退数量',width:60,sortable:true,align:'right',hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'directreturntotalbox',title:'直退箱数',width:60,sortable:true,align:'right',isShow:true,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'directreturnamount',title:'直退金额',resizable:true,sortable:true,align:'right',
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'checkreturnnum',title:'退货数量',width:60,sortable:true,align:'right',hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'checkreturntotalbox',title:'退货箱数',width:60,sortable:true,align:'right',isShow:true,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'checkreturnamount',title:'退货金额',resizable:true,sortable:true,align:'right',
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'checkreturnrate',title:'退货率',width:60,align:'right',isShow:true,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        if(value!=null && value!=0){
                            return formatterMoney(value)+"%";
                        }else{
                            return "";
                        }
                    }
                },
                {field:'returnnum',title:'退货总数量',width:70,sortable:true,align:'right',hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'returntotalbox',title:'退货总箱数',width:70,sortable:true,align:'right',isShow:true,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'returnamount',title:'退货合计',resizable:true,sortable:true,align:'right',
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'salenum',title:'销售数量',width:60,align:'right',hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'saletotalbox',title:'销售箱数',width:60,align:'right',isShow:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterBigNumNoLen(value);
                    }
                },
                {field:'saleamount',title:'销售金额',resizable:true,align:'right',
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'salenotaxamount',title:'销售无税金额',width:80,align:'right',hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'saletax',title:'销售税额',width:60,align:'right',isShow:true,hidden:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                }
                <c:if test="${map.costamount == 'costamount'}">
                ,
                {field:'costamount',title:'成本金额',align:'right',resizable:true,isShow:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                }
                </c:if>
                <c:if test="${map.salemarginamount == 'salemarginamount'}">
                ,
                {field:'salemarginamount',title:'销售毛利额',resizable:true,align:'right',
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                }
                </c:if>
                <c:if test="${map.realrate == 'realrate'}">
                ,
                {field:'realrate',title:'实际毛利率',width:70,align:'right',isShow:true,
                    formatter:function(value,rowData,rowIndex){
                        if(value!=null && value!=0){
                            return formatterMoney(value)+"%";
                        }else{
                            return "";
                        }
                    }
                }
                </c:if>
            ]]
        });
        //品牌
        $("#report-brandid-advancedQuery").widget({
            referwid:'RL_T_BASE_GOODS_BRAND',
            singleSelect:false,
            width:200,
            onlyLeafCheck:true
        });
        //品牌部门
        $("#report-branddept-advancedQuery").widget({
            referwid:'RL_T_BASE_DEPARTMENT_BUYER',
            singleSelect:false,
            width:200,
            onlyLeafCheck:true
        });

        //品牌业务员
        $("#report-branduser-advancedQuery").widget({
            referwid:'RL_T_BASE_PERSONNEL_BRANDSELLER',
            singleSelect:false,
            width:200,
            onlyLeafCheck:true
        });
        //供应商
        $("#report-supplierid-advancedQuery").widget({
            referwid:'RL_T_BASE_BUY_SUPPLIER',
            singleSelect:false,
            width:200,
            onlyLeafCheck:true
        });
        $("#report-salesdept-advancedQuery").widget({
            name:'t_sales_order',
            col:'salesdept',
            width:200,
            singleSelect:true,
            onlyLeafCheck:true
        });
        //人员部门
        $("#report-branduserdept-advancedQuery").widget({
            referwid:'RL_T_BRANDUSER_BELONG_DEPT',
            width:200,
            singleSelect:true,
            onlyLeafCheck:false
        });
        //厂家业务员
        $("#report-supplieruser-advancedQuery").widget({
            referwid:'RL_T_BASE_PERSONNEL_SUPPLIER',
            singleSelect:false,
            width:200
        });
        $("#report-customernamemore-advancedQuery").widget({
            referwid:'RL_T_BASE_SALES_CUSTOMER',
            singleSelect:false,
            width:200,
            onlyLeafCheck:true
        });
        $("#report-pcustomernamemore-advancedQuery").widget({
            referwid:'RL_T_BASE_SALES_CUSTOMER_PARENT',
            singleSelect:false,
            width:200,
            onlyLeafCheck:true
        });
        $("#report-goodsid-advancedQuery").widget({
            referwid:'RL_T_BASE_GOODS_INFO',
            singleSelect:false,
            width:200,
            onlyLeafCheck:true
        });
        $("#report-goodssort-advancedQuery").widget({
            referwid:'RL_T_BASE_GOODS_WARESCLASS',
            singleSelect:false,
            width:200,
            onlyLeafCheck:false
        });
        $("#report-customersort-advancedQuery").widget({
            referwid:'RT_T_BASE_SALES_CUSTOMERSORT',
            singleSelect:false,
            width:200,
            onlyLeafCheck:false
        });
        $("#report-salesuser-advancedQuery").widget({
            referwid:'RL_T_BASE_PERSONNEL_CLIENTSELLER',
            singleSelect:false,
            width:200,
            onlyLeafCheck:false
        });
        $("#report-salesarea-advancedQuery").widget({
            referwid:'RT_T_BASE_SALES_AREA',
            singleSelect:false,
            width:200,
            onlyLeafCheck:false
        });

        $("#report-datagrid-baseSalesDeptReport").datagrid({
            authority:tableColumnListJson,
            frozenColumns: tableColumnListJson.frozen,
            columns:tableColumnListJson.common,
            method:'post',
            title:'',
            fit:true,
            rownumbers:true,
            pagination:true,
            showFooter: true,
            singleSelect:false,
            checkOnSelect:true,
            selectOnCheck:true,
            pageSize:100,
            toolbar:'#report-toolbar-baseSalesDeptReport',
            onLoadSuccess:function(){
                var footerrows = $(this).datagrid('getFooterRows');
                if(null!=footerrows && footerrows.length>0){
                    SR_footerobject = footerrows[0];
                    baseSalesReportCountTotalAmount(baseSales_retColsname(),this);
                }
            },
            onCheckAll:function(){
                baseSalesReportCountTotalAmount(baseSales_retColsname(),this);
            },
            onUncheckAll:function(){
                baseSalesReportCountTotalAmount(baseSales_retColsname(),this);
            },
            onCheck:function(){
                baseSalesReportCountTotalAmount(baseSales_retColsname(),this);
            },
            onUncheck:function(){
                baseSalesReportCountTotalAmount(baseSales_retColsname(),this);
            }
        }).datagrid("columnMoving");

        //回车事件
        controlQueryAndResetByKey("report-advancedQuery-baseSalesDeptReportPage","");

        //高级查询
        $("#report-advancedQuery-baseSalesDeptReportPage").click(function(){
            $("#report-dialog-advancedQueryDialog").dialog({
                maximizable:false,
                resizable:true,
                title: '人员部门统计表查询',
                top:30,
                width: 565,
                height: 400,
                closed: false,
                cache: false,
                modal: true,
                buttons:[
                    {
                        text:'确定',
                        handler:function(){
                            setColumn();
                            //把form表单的name序列化成JSON对象
                            var queryJSON = $("#report-query-form-baseSalesDeptReport").serializeJSON();
                            $("#report-datagrid-baseSalesDeptReport").datagrid({
                                url:'report/sales/showSalesDeptReportData.do',
                                pageNumber:1,
                                queryParams:queryJSON
                            }).datagrid("columnMoving");

                            $("#report-dialog-advancedQueryDialog").dialog('close');
                        }
                    },
                    {
                        text:'重置',
                        handler:function(){
                            $("#report-query-form-baseSalesDeptReport").form("reset");
                            $(".groupcols").each(function(){
                                if($(this).attr("checked")){
                                    $(this)[0].checked = false;
                                }
                            });
                            $("#report-query-groupcols").val("");
                            $("#report-customernamemore-advancedQuery").widget("clear");
                            $("#report-pcustomernamemore-advancedQuery").widget("clear");
                            $("#report-customersort-advancedQuery").widget("clear");
                            $("#report-brandid-advancedQuery").widget("clear");
                            $("#report-branddept-advancedQuery").widget("clear");
                            $("#report-branduser-advancedQuery").widget("clear");
                            $("#report-branduserdept-advancedQuery").widget("clear");
                            $("#report-salesarea-advancedQuery").widget("clear");
                            $("#report-salesuser-advancedQuery").widget("clear");
                            $("#report-goodsid-advancedQuery").widget("clear");
                            $("#report-goodssort-advancedQuery").widget("clear");
                            $("#report-supplierid-advancedQuery").widget("clear");
                            $("#report-supplieruser-advancedQuery").widget("clear");
                            $("#report-datagrid-baseSalesDeptReport").datagrid("loadData",[]);
                            $("#report-salesdept-advancedQuery").widget("clear");
                            $("#report-goodstype-advancedQuery").combobox("clear");
                            setColumn();
                        }
                    }
                ],
                onClose:function(){
                }
            });
        });
    });
    function setColumn(){
        var cols = $("#report-query-groupcols").val();
        if(cols!=""){
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "customerid");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "customername");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "pcustomerid");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "pcustomername");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "salesuser");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "customersort");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "salesarea");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "salesdept");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "goodsid");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "goodsname");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "goodssortname");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "goodstypename");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "barcode");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "brandid");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "branduser");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "branduserdept");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "supplieruser");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "branddept");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "supplierid");
        }
        else{
            $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "customerid");
            $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "customername");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "pcustomerid");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "pcustomername");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "salesuser");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "salesarea");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "salesdept");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "goodsid");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "goodsname");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "goodssortname");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "goodstypename");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "barcode");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "brandid");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "branduser");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "branduserdept");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "supplieruser");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "branddept");
            $("#report-datagrid-baseSalesDeptReport").datagrid('hideColumn', "supplierid");
        }
        var colarr = cols.split(",");
        for(var i=0;i<colarr.length;i++){
            var col = colarr[i];
            if(col=='customerid'){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "customerid");
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "customername");
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "pcustomerid");
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "pcustomername");
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "salesuser");
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "customersort");
                //$("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "salesarea");
                //$("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "salesdept");
            }else if(col=="pcustomerid"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "pcustomerid");
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "pcustomername");
            }else if(col=="salesuser"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "salesuser");
                //$("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "salesarea");
                //$("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "salesdept");
            }else if(col=="salesarea"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "salesarea");
            }else if(col=="salesdept"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "salesdept");
            }else if(col=="goodsid"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "goodsid");
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "goodsname");
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "goodssortname");
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "goodstypename");
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "barcode");
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "brandid");
            }else if(col=="goodssort"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "goodssortname");
            }else if(col=="brandid"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "brandid");
                //$("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "branddept");
            }else if(col=="branduser"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "branduser");
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "branduserdept");
                //$("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "branddept");
            }else if(col=="branduserdept"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "branduserdept");
            }else if(col=="branddept"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "branddept");
            }else if(col=="customersort"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "customersort");
            }else if(col=="supplierid"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "supplierid");
            }else if(col=="supplieruser"){
                $("#report-datagrid-baseSalesDeptReport").datagrid('showColumn', "supplieruser");
            }
        }
    }

    function baseSales_retColsname(){
        var colname = "";
        var cols = $("#report-query-groupcols").val();
        if(cols == ""){
            cols = "customerid";
        }
        var colarr = cols.split(",");
        if(colarr[0]=="pcustomerid"){
            colname = "pcustomername";
        }else if(colarr[0]=='customerid'){
            colname = "customername";
        }else if(colarr[0]=="salesuser"){
            colname = "salesusername";
        }else if(colarr[0]=="salesarea"){
            colname = "salesareaname";
        }else if(colarr[0]=="salesdept"){
            colname = "salesdeptname";
        }else if(colarr[0]=="goodsid"){
            colname = "goodsname";
        }else if(colarr[0]=="goodssort"){
            colname = "goodssortname";
        }else if(colarr[0]=="brandid"){
            colname = "brandname";
        }else if(colarr[0]=="branduser"){
            colname = "brandusername";
        }else if(colarr[0]=="branddept"){
            colname = "branddeptname";
        }else if(colarr[0]=="customersort"){
            colname = "customersortname";
        }else if(colarr[0]=="supplierid"){
            colname = "suppliername";
        }else if(colarr[0]=="supplieruser"){
            colname = "supplierusername";
        }
        return colname;
    }
</script>
</body>
</html>
