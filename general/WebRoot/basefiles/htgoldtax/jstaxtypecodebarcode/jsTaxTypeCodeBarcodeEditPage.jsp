<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>税收分类关联商品条形码编辑</title>
</head>

<body>
<div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'center',border:false">
        <div align="center" style="padding: 10px;">
            <form action="basefiles/htgoldtax/editJsTaxTypeCodeBarcode.do" method="post" id="htgoldtax-form-editJsTaxTypeCodeBarcode">
                <table cellpadding="3" cellspacing="3" border="0">
                    <tr>
                        <td width="100px" align="right">税收分类编码:</td>
                        <td align="left">
                            <input type="text" id="htgoldtax-form-addJsTaxTypeCodeBarcode-jstypeid" name="jsTaxTypeCodeBarcode.jstypeid" value="${jsTaxTypeCodeBarcode.jstypeid}" class="easyui-validatebox" data-options="required:true" style="width:200px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">商品条形码:</td>
                        <td align="left">
                            <input type="text" name="jsTaxTypeCodeBarcode.barcode" value="${jsTaxTypeCodeBarcode.barcode}" class="easyui-validatebox" data-options="required:true,validType:['validJsTaxTypeCodeBarcode']" style="width:200px;" maxlength="20"/>
                        </td>
                    </tr>
                </table>
                <input type="hidden" name="jsTaxTypeCodeBarcode.id" value="${jsTaxTypeCodeBarcode.id}" />
            </form>
        </div>
    </div>
    <div data-options="region:'south',border:false">
        <div class="buttonDetailBG" style="height:30px;text-align:right;">
            <input type="button" name="savegoon" id="htgoldtax-save-editJsTaxTypeCodeBarcode" value="确定"/>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function(){
        validJsTaxTypeCodeBarcode("edit","${jsTaxTypeCodeBarcode.id}");

        $("#htgoldtax-form-addJsTaxTypeCodeBarcode-jstypeid").widget({
            referwid:'RL_T_BASE_JSTAXTYPECODE',
            singleSelect:true,
            width:'200',
            required:true
        });
        $("#htgoldtax-form-editJsTaxTypeCodeBarcode").form({
            onSubmit: function(){

                var flag = $(this).form('validate');
                if(flag==false){
                    return false;
                }
            },
            success:function(data){
                //$.parseJSON()解析JSON字符串
                var json = $.parseJSON(data);
                if(json.flag==true){
                    $.messager.alert("提醒","编辑成功!");
                    $("#htgoldtax-dialogOper-jsTaxTypeCodeBarcodeList-content").dialog('close',true);
                    $("#htgoldtax-table-jsTaxTypeCodeBarcodeList").datagrid('reload');
                }
                else{
                    if(json.msg!=null){
                        $.messager.alert("提醒","编辑失败,"+json.msg);
                    }else{
                        $.messager.alert("提醒","编辑失败!");
                    }
                }
            }
        });
        $("#htgoldtax-save-editJsTaxTypeCodeBarcode").click(function(){
            $.messager.confirm("提醒","是否编辑税收分类关联商品条形码信息?",function(r){
                if(r){
                    $("#htgoldtax-form-editJsTaxTypeCodeBarcode").submit();
                }
            });
        });

    });
</script>
</body>
</html>
