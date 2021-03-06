<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>销售订单商品批量添加</title>
</head>
<body>
<table id="sales-datagrid-orderDetailAddByBrandAndSort"></table>
<div id="sales-queryDiv-orderDetailAddByBrandAndSort">
    <form id="sales-queryform-orderDetailAddByBrandAndSort">
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td class="len80 right">编码/条形码：</td>
                <td><input type="text" name="id" style="width: 150px;" /></td>
                <td class="len80 right">品&nbsp;&nbsp;牌：</td>
                <td><input type="text" name="brand" id="sales-brand-orderDetailAddByBrandAndSort" style="width: 150px;" /></td>
            </tr>
            <tr>
                <td class="len80 right">商品名称：</td>
                <td><input type="text" name="goodsname" style="width: 150px;" /></td>
                <td class="len80 right">商品分类：</td>
                <td><input type="text" name="defaultsort" id="sales-defaultsort-orderDetailAddByBrandAndSort" style="width: 150px;" /></td>
                <td class="len120 right"><a href="javascript:;" class="button-qr" id="sales-query-orderDetailAddByBrandAndSort">查询</a></td>
                <td class="len120 right"><a href="javascript:;" class="button-qr" id="sales-save-orderDetailAddByBrandAndSort">保存</a></td>
            </tr>
        </table>
        <input type="hidden" id="sales-detailJson-orderDetailAddByBrandAndSort" name="detailJson" />
    </form>
</div>
<script type="text/javascript">
    var date = $("input[name='allocateNotice.businessdate']").val();
    var storageid = '${outstorageid}';

    var expandIndex = undefined;
    var editIndex = undefined;
    var thisIndex = undefined;
    var editfiled = null;
    var nextfiled = null;
    $(function() {
        $("#sales-brand-orderDetailAddByBrandAndSort").widget({
            width : 120,
            name : 't_base_goods_brand',
            col : 'id',
            singleSelect : false,
            onlyLeafCheck : false
        });
        $("#sales-defaultsort-orderDetailAddByBrandAndSort").widget({
            width : 120,
            referwid : 'RL_T_BASE_GOODS_WARESCLASS',
            col : 'id',
            singleSelect : false,
            onlyLeafCheck : false
        });
        var tableColJson = $("#sales-datagrid-orderDetailAddByBrandAndSort").createGridColumnLoad(
            {
                frozenCol : [ [
                    {field : 'ck',checkbox : true} ,
                ] ],
                commonCol : [ [
                    {field : 'goodsid',title : '商品编码',width : 70,align : ' left',sortable : true},
                    {field : 'goodsname',title : '商品名称',width : 250,align : 'left',aliascol : 'goodsid',
                        formatter : function(value,rowData, rowIndex) {
                            if (rowData.goodsInfo != null) {
                                return rowData.goodsInfo.name;
                            }else{
                                return "";
                            }

                        }
                    },
                    {field : 'spell',title : '助记符',width : 60,align : 'left',aliascol : 'goodsid',
                        formatter : function(value,rowData, rowIndex) {
                            if (rowData.goodsInfo != null) {
                                return rowData.goodsInfo.spell;
                            } else {
                                return "";
                            }
                        }
                    },
                    {field : 'barcode',title : '条形码',width : 90,align : 'left',aliascol : 'goodsid',
                        formatter : function(value,rowData, rowIndex) {
                            if (rowData.goodsInfo != null) {
                                return rowData.goodsInfo.barcode;
                            } else {
                                return "";
                            }
                        }
                    },
                    {field : 'brandName',title : '商品品牌',width : 60,align : 'left',aliascol : 'goodsid',hidden : true,
                        formatter : function(value,rowData, rowIndex) {
                            if (rowData.goodsInfo != null) {
                                return rowData.goodsInfo.brandName;
                            } else {
                                return "";
                            }
                        }
                    },
                    {field : 'boxnum', title : '箱装量', aliascol : 'goodsid',width : 45,align : 'right',
                        formatter : function(value,rowData, rowIndex) {
                            if ( rowData.goodsInfo != null) {
                                return formatterBigNumNoLen(rowData.goodsInfo.boxnum);
                            } else {
                                return "";
                            }
                        }
                    },
                    {field : 'unitname',title : '单位',width : 35,align : 'left'},
                    {field : 'unitid',title : '单位编码',width : 35,align : 'left',hidden:true},
                    {field : 'usablenum',title : '可用量',width : 60,align : 'right',isShow : true,sortable : true,
                        formatter : function(value, row,index) {
                            if (row.goodsInfo != null) {
                                return formatterBigNumNoLen(value);
                            } else {
                                return "";
                            }
                        }
                    },
                    {field : 'auxnum',title : '箱数',width : 60,align : 'right',sortable : true,editor:'numberbox',
                        formatter : function(value, row,index) {
                            return formatterBigNum(value);
                        },
                    },
                    {field : 'auxremainder',title : '个数',width : 60,align : 'right',sortable : true,
                        editor:{
                            type:'numberbox',
                            options:{
                                min:0,
                                precision:${decimallen}
                            }
                        },
                        formatter : function(value, row,index) {
                            return formatterBigNumNoLen(value);
                        },
                    },
                    {field : 'taxprice',title : '单价',width : 60,align : 'right',sortable : true,
                        formatter : function(value, row,index) {
                            return formatterMoney(value);
                        }
                    },
                    {field : 'storageid',title : '仓库编号',width : 60,align : 'right',sortable : true,hidden:true},
                    {field : 'remark',title : '备注',width : 200,align : 'left',editor:'textbox'},


                ] ],
            });
        $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid({
            authority : tableColJson,
            frozenColumns : tableColJson.frozen,
            columns : tableColJson.common,
            fit : true,
            title : "",
            method : 'post',
            rownumbers : true,
            pagination : true,
            idField : 'goodsid',
            sortName : 'goodsid',
            sortOrder : 'desc',
            singleSelect : false,
            checkOnSelect : true,
            selectOnCheck : true,
            showFooter : false,
            pageSize : 100,
            toolbar : "#sales-queryDiv-orderDetailAddByBrandAndSort",

            onClickCell: function(index, field, value){
                onClickCell(index, field);
                thisIndex = index;
            },
            onClickRow:function(rowIndex, rowData){
                if(rowData.auxremainder >0 && !rowData.goodsInfo!=null ){
                    //只可销售的不能采购
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('checkRow',rowIndex);
                }else{
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('uncheckRow',rowIndex);
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('unselectRow',rowIndex);
                }
                thisIndex=rowIndex;
            },
            onLoadSuccess:function(data){
                editIndex = undefined;
                thisIndex = undefined;
                editfiled = null;
                nextfiled = null;
            }
        }).datagrid('columnMoving');

        function endEditing(field){
            if (editIndex == undefined){
                return true;
            }
            if(field == "auxremainder"){
                if ($("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('validateRow', editIndex)){
                    var ed = $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('getEditor', {index:editIndex,field:'auxremainder'});
                    var edObj=getNumberBoxObject(ed.target);
                    if(null==edObj){
                        return false;
                    }
                    var auxremainder = edObj.val();
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('selectRow',editIndex);
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('getRows')[editIndex]['auxremainder'] = auxremainder;
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('endEdit', editIndex);
                    editIndex = undefined;
                    return true;
                } else {
                    return false;
                }
            }
            else if(field == "auxnum"){
                if ($("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('validateRow', editIndex)){
                    var ed = $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('getEditor', {index:editIndex,field:'auxnum'});
                    var edObj=getNumberBoxObject(ed.target);
                    if(null==edObj){
                        return false;
                    }
                    var auxnum = edObj.val();
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('selectRow',editIndex);
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('getRows')[editIndex]['auxnum'] = auxnum;
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('endEdit', editIndex);
                    editIndex = undefined;
                    return true;
                } else {
                    return false;
                }
            }

            else if(field == "remark"){
                if ($("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('validateRow', editIndex)){
                    var ed = $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('getEditor', {index:editIndex,field:'remark'});
                    var edObj=getNumberBoxObject(ed.target);
                    if(null==edObj){
                        return false;
                    }
                    var remark = edObj.val();
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('selectRow',editIndex);
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('getRows')[editIndex]['remark'] = remark;
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('endEdit', editIndex);
                    editIndex = undefined;
                    return true;
                } else {
                    return false;
                }
            }
        }

        function onClickCell(index, field){
            if (endEditing(editfiled)){
                var row = $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('getRows')[index];
                if(row.goodsid == undefined){
                    return false;
                }
                editfiled = field;
                if(field == "auxremainder"){
                    nextfiled="auxremainder";
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('selectRow', index).datagrid('editCell', {index:index,field:field});
                    editIndex = index;
                    thisIndex = index;
                    var ed = $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('getEditor', {index:editIndex,field:'auxremainder'});
                    var obj=getNumberBoxObject(ed.target);
                    if(null==obj){
                        return false;
                    }
                    obj.focus();
                    obj.select();
                    obj.die("keyup").bind("keyup",function(e){
                        var e = e || event,
                            keycode = e.which || e.keyCode;
                        if (keycode==13 || keycode==38 || keycode==40) {
                            if(editfiled!=null){
                                endEditing(editfiled);
                            }
                        }
                    });
                }else if(field == "auxnum" && row.deliverytype !='2' && row.deliverytype !='3'){ //捆绑产品不允许添加箱数
                    nextfiled="auxnum";
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('selectRow', index).datagrid('editCell', {index:index,field:field});
                    editIndex = index;
                    thisIndex = index;
                    var ed = $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('getEditor', {index:editIndex,field:'auxnum'});
                    var obj=getNumberBoxObject(ed.target);
                    if(null==obj){
                        return false;
                    }
                    obj.focus();
                    obj.select();
                    obj.die("keyup").bind("keyup",function(e){
                        var e = e || event,
                            keycode = e.which || e.keyCode;
                        if (keycode==13 || keycode==38 || keycode==40) {
                            if(editfiled!=null){
                                endEditing(editfiled);
                            }
                        }
                    });
                }
                else if(field == "remark"){
                    nextfiled="remark";
                    $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('selectRow', index).datagrid('editCell', {index:index,field:field});
                    editIndex = index;
                    thisIndex = index;
                    var ed = $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('getEditor', {index:editIndex,field:'remark'});
                    var obj=getNumberBoxObject(ed.target);
                    if(null==obj){
                        return false;
                    }
                    obj.focus();
                    obj.select();
                    obj.die("keyup").bind("keyup",function(e){
                        var e = e || event,
                            keycode = e.which || e.keyCode;
                        if (keycode==13 || keycode==38 || keycode==40) {
                            if(editfiled!=null){
                                endEditing(editfiled);
                            }
                        }
                    });
                }
            }
        }


        function moveToNextRow(){
            var datarow=$("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('getRows');
            if(null!=datarow && (thisIndex+1) < datarow.length){
                if(editIndex == null){
                    onClickCell(thisIndex+1, nextfiled);
                }
            }
        }

        function moveToPrevRow(){
            if((thisIndex-1) >0){
                if(editIndex == null){
                    onClickCell(thisIndex-1,nextfiled);
                }
            }
        }
        $(document).bind('keyup', 'up',function (event){
            moveToPrevRow();
            return false;
        });
        $(document).bind('keyup', 'down',function (event){
            moveToNextRow();
            return false;
        });
        $(document).bind('keyup', 'enter',function (event){
            moveToNextRow();
            return false;
        });

        //查询
        $("#sales-query-orderDetailAddByBrandAndSort").click(function() {
            editIndex = undefined;
            thisIndex = undefined;
            editfiled = null;
            nextfiled = null;
            var queryJSON = $("#sales-queryform-orderDetailAddByBrandAndSort").serializeJSON();
            $('#sales-datagrid-orderDetailAddByBrandAndSort').datagrid('options').url = 'storage/getOrderDetailByBrandAndSort.do?date='+ date + '&storageid=' + storageid;
            $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('load', queryJSON);
        });

        //保存
        $("#sales-save-orderDetailAddByBrandAndSort").click(function() {
            endEditing(editfiled);
            var rows = $("#sales-datagrid-orderDetailAddByBrandAndSort").datagrid('getChecked');
            var jsonDetail=JSON.stringify(rows);
            $.ajax({
                url :'storage/AddOrderDetailByBrandAndSort.do',
                data:{jsonDetail:jsonDetail},
                type:'post',
                dataType:'json',
                success:function(json){console.log(json);
                    loaded();
                    editIndex = undefined;

                    for(var index=0; index<json.length; index++){
                        var rowIndex = 0;
                        var rows = $("#storage-datagrid-allocateNoticeAddPage").datagrid('getRows');
                        var updateFlag = false;

                        for(var i=0; i<rows.length; i++){
                            var rowJson = rows[i];
                            if(rowJson.goodsid==json[index].goodsid){
                                rowIndex = i;
                                updateFlag = true;
                                break;
                            }

                            if(rowJson.goodsid == undefined){
                                rowIndex = i;
                                break;
                            }
                        }
                        if(rowIndex == rows.length - 1){
                            $("#storage-datagrid-allocateNoticeAddPage").datagrid('appendRow',{}); //如果是最后一行则添加一新行
                        }
                        if(updateFlag){
                            var r =confirm("商品编号："+json[index].goodsid+"已存在，是否替换？");
                            if(r){
                                $("#storage-datagrid-allocateNoticeAddPage").datagrid('updateRow',{index:rowIndex, row:json[index]}); //将数据更新到列表中
                            }
                        }else{
                            $("#storage-datagrid-allocateNoticeAddPage").datagrid('updateRow',{index:rowIndex, row:json[index]}); //将数据更新到列表中
                        }
                    }
                    $("#storage-dialog-allocateNoticeAddPage-content").dialog('close', true);
                },
                error:function(){
                    loaded();
                    $("#storage-dialog-allocateNoticeAddPage-content").dialog('close', true)
                }
            });
        });
    });

</script>
</body>
</html>
