<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>部门日常费用报表</title>
    <%@include file="/include.jsp" %>
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
<div id="personnelDailyCost-query-reportList" style="padding:2px;height:auto">
    <form action="" id="personnelDailyCost-query-form-reportList" method="post">
        <table>
            <tr>
                <security:authorize url="/journalsheet/deptdailycost/exportPersonnelDailyCostReportDataBtn.do">
                    <a href="javaScript:void(0);" id="personnelDailyCost-export-buton" class="easyui-linkbutton" iconCls="button-export" plain="true" title="导出">导出</a>
                    <a href="javaScript:void(0);" id="personnelDailyCost-export-excel" style="display:none">导出</a>
                </security:authorize>
            </tr>
            <tr>
                <td>业务日期:</td>
                <td><input id="personnelDailyCost-query-businessdate1" type="text" name="businessdate1" style="width:100px;" class="Wdate" onfocus="WdatePicker({'dateFmt':'yyyy-MM-dd'})" value="${firstday }"/> 到 <input id="personnelDailyCost-query-businessdate2" type="text" name="businessdate2" class="Wdate" style="width:100px;" onfocus="WdatePicker({'dateFmt':'yyyy-MM-dd'})" value="${today }"/></td>
                <td>人员:</td>
                <td><input id="personnelDailyCost-query-salesuser" type="text" name="salesuser" style="width: 100px;"/></td>
                <td></td>
            </tr>
            <tr>
                <td>费用科目:</td>
                <td><input id="personnelDailyCost-query-subjectid" type="text" name="subjectid" style="width: 100px;"/></td>
                <td colspan="2"></td>
                <td class="tdbutton">
                    <a href="javaScript:void(0);" id="personnelDailyCost-query-buton" class="button-qr">查询</a>
                    <a href="javaScript:void(0);" id="personnelDailyCost-reload-buton" class="button-qr">重置</a>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    &nbsp;
                    <a href="javaScript:void(0);" id="personnelDailyCost-tree-buton-expand" class="button-qr" style="width:60px">展开</a>
                    <a href="javaScript:void(0);" id="personnelDailyCost-tree-buton-collapse" class="button-qr" style="width:60px;">折叠</a>
                    <a href="javaScript:void(0);" id="personnelDailyCost-tree-buton-expandAll" expand="true" class="button-qr" style="width:80px;padding-left:2px;letter-spacing: 2px;">全部展开</a>
                    <a href="javaScript:void(0);" id="personnelDailyCost-tree-buton-collapseAll" class="button-qr" style="width:80px;padding-left:2px;letter-spacing: 2px">全部折叠</a>
                </td>
            </tr>
        </table>
    </form>
</div>
<table id="personnelDailyCost-table-reportList"></table>
<div class="easyui-menu" id="personnelDailyCost-contextMenu" style="display: none;">
    <div id="personnelDailyCost-contextMenu-export">导出</div>
    <div id="personnelDailyCost-contextMenu-expand">展开</div>
    <div id="personnelDailyCost-contextMenu-collapse">折叠</div>
    <div id="personnelDailyCost-contextMenu-detail">查看明细</div>
</div>
<div style="display:none">
    <div id="personnelDailyCost-reportDetailList-div"></div>
</div>
<script type="text/javascript">
    var footerobject=null;
    $(function(){
        var queryInitJSON = $("#personnelDailyCost-query-form-reportList").serializeJSON();
        $("#personnelDailyCost-table-reportList").treegrid({
            columns:[[
                {field:'name',title:'人员/科目名称',width:200,sortable:true},
                {field:'subamount',title:'科目金额',resizable:true,sortable:true,align:'right',isShow:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                },
                {field:'totalamount',title:'金额',resizable:true,sortable:true,align:'right',isShow:true,
                    formatter:function(value,rowData,rowIndex){
                        return formatterMoney(value);
                    }
                }
            ]],
            fit:true,
            title:"",
            method:'post',
            rownumbers:true,
            idField:'rid',
            treeField:'name',
            singleSelect:true,
            showFooter: true,
            url: 'journalsheet/deptdailycost/showPersonnelDailyCostReportData.do',
            queryParams:queryInitJSON,
            toolbar:'#personnelDailyCost-query-reportList',
            onDblClickRow:function(row){
                //$("#personnelDailyCost-table-reportList").treegrid("expand",row.rid);
                showDeptDailyCostReportDetailList(row);
            },
            onContextMenu: function(e, rowData){
                e.preventDefault();
                $(this).treegrid('select', rowData.rid);
                console.log(rowData.rid);
                $("#personnelDailyCost-contextMenu").menu('show', {
                    left:e.pageX,
                    top:e.pageY
                });
            },
        });
        //业务员
        $("#personnelDailyCost-query-salesuser").widget({
            referwid:'RL_T_BASE_PERSONNEL',
            width:136,
            singleSelect:true
        });
        $("#personnelDailyCost-query-subjectid").widget({
            referwid:'RL_T_JS_DEPARTMENTCOSTS_SUBJECT',
            width:225,
            singleSelect:true,
            onlyLeafCheck:false
        });
        $("#personnelDailyCost-query-buton").click(function(){
            //把form表单的name序列化成JSON对象
            var queryJSON = $("#personnelDailyCost-query-form-reportList").serializeJSON();
            $("#personnelDailyCost-table-reportList").treegrid('load', queryJSON);
        });
        $("#personnelDailyCost-reload-buton").click(function(){
            $("#personnelDailyCost-query-form-reportList")[0].reset();
            $("#personnelDailyCost-table-reportList").treegrid('loadData',[]);
            $("#personnelDailyCost-query-salesuser").widget('clear');
            $("#personnelDailyCost-query-subjectid").widget('clear');
        });
        $("#personnelDailyCost-contextMenu-export").click(function(){
            var row = $("#personnelDailyCost-table-reportList").treegrid('getSelected');
            if(row.type=='1'){
                var spersonnelid = row.personnelid;
                var date1=$("#personnelDailyCost-query-businessdate1").val()||"";
                var date2=$("#personnelDailyCost-query-businessdate2").val()||"";
                var personnelname = row.name ;
                var title="";
                title=date1+(date1!=""&&date2!=""?"至":"")+date2;
                title=title+$.trim(personnelname)+"人员日常费用报表";
                $("#personnelDailyCost-export-excel").Excel('export',{
                    queryForm: "#personnelDailyCost-query-form-reportList", //查询条件的form表单，导出时只用通过查询的条件，将通用查询放在form表单里面。
                    type:'exportUserdefined',
                    name:title,
                    url:'journalsheet/deptdailycost/exportPersonnelDailyCostReportData.do?spersonnelid='+spersonnelid+"&personnelname="+personnelname
                });
                $("#personnelDailyCost-export-excel").trigger("click");
            }else if(row.type=='2'){
                $.messager.alert("提醒","请选择人员导出。");
            }
        });
        $("#personnelDailyCost-contextMenu-expand").click(function(){
            var row = $("#personnelDailyCost-table-reportList").treegrid('getSelected');
            $("#personnelDailyCost-table-reportList").treegrid("expandAll",row.rid);
        });
        $("#personnelDailyCost-contextMenu-collapse").click(function(){
            var row = $("#personnelDailyCost-table-reportList").treegrid('getSelected');
            $("#personnelDailyCost-table-reportList").treegrid("collapseAll",row.rid);
        });
        $("#personnelDailyCost-contextMenu-detail").click(function(){
            var row = $("#personnelDailyCost-table-reportList").treegrid('getSelected');
            showDeptDailyCostReportDetailList(row);
        });
        $("#personnelDailyCost-export-buton").click(function(){
            var date1=$("#personnelDailyCost-query-businessdate1").val()||"";
            var date2=$("#personnelDailyCost-query-businessdate2").val()||"";
            var deptname=$("#personnelDailyCost-query-deptid").widget("getText")|| "" ;
            var title="";
            title=date1+(date1!=""&&date2!=""?"至":"")+date2;
            title=title+$.trim(deptname)+"部门日常费用报表";
            $("#personnelDailyCost-export-excel").Excel('export',{
                queryForm: "#personnelDailyCost-query-form-reportList", //查询条件的form表单，导出时只用通过查询的条件，将通用查询放在form表单里面。
                type:'exportUserdefined',
                name:title,
                url:'journalsheet/deptdailycost/exportPersonnelDailyCostReportData.do'
            });
            $("#personnelDailyCost-export-excel").trigger("click");
        });
        $("#personnelDailyCost-tree-buton-expandAll").click(function(){
            $("#personnelDailyCost-table-reportList").treegrid("expandAll");
        });
        $("#personnelDailyCost-tree-buton-collapseAll").click(function(){
            $("#personnelDailyCost-table-reportList").treegrid("collapseAll");
        });

        $("#personnelDailyCost-tree-buton-expand").click(function(){
            var row = $("#personnelDailyCost-table-reportList").treegrid('getSelected');
            if(row!=null && row.rid!=null) {
                $("#personnelDailyCost-table-reportList").treegrid("expandAll", row.rid);
            }
        });
        $("#personnelDailyCost-tree-buton-collapse").click(function(){
            var row = $("#personnelDailyCost-table-reportList").treegrid('getSelected');
            if(row!=null && row.rid!=null) {
                $("#personnelDailyCost-table-reportList").treegrid("collapseAll", row.rid);
            }
        });
    });
    function showDeptDailyCostReportDetailList(dataRow) {
        if(dataRow==null){
            return false;
        }
        var title="人员日常费用明细";
        var queryJSON = $("#personnelDailyCost-query-form-reportList").serializeJSON();
        var personnelid=dataRow.personnelid || "";
        title = title +"-"+(dataRow.name || "");
        var subjectid = dataRow.sid || "";
        var queryparam={
            businessdate1:(queryJSON.businessdate1 || ""),
            businessdate2:(queryJSON.businessdate2 || ""),
            personnelid:personnelid,
            subjectid:subjectid,
            reporttype:'personnel'
        };
        $('<div id="personnelDailyCost-reportDetailList-div-content"></div>').appendTo("#personnelDailyCost-reportDetailList-div");
        $('#personnelDailyCost-reportDetailList-div-content').dialog({
            title: title,
            fit:true,
            closed: true,
            cache: false,
            queryParams:queryparam,
            href: "journalsheet/deptdailycost/deptDailyCostReportDetailListPage.do",
            maximizable:true,
            resizable:true,
            modal: true,
            onLoad:function(){
                showDeptDailyCostDetailDataGrid();
            },
            onClose:function(){
                $('#personnelDailyCost-reportDetailList-div-content').window("destroy");
            }
        });
        $('#personnelDailyCost-reportDetailList-div-content').dialog('open');
    }
</script>
</body>
</html>
