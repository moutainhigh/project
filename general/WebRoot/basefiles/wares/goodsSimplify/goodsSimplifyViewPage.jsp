<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
  	 <title>商品档案新增页面</title>
  </head>

  <body>
  	<div class="easyui-layout" data-options="fit:true" id="wares-layout-goodsAddPage">
  		<div data-options="region:'center',split:true,border:true">
	  		<form action="" method="post" id="goodssimplify-form-add">
		    	<input type="hidden" id="goodsSimplify-hidden-attaids" value="${goodsInfo.imageids }"/>
		    	<input type="hidden" id="goodinfo-hidden-hdimage" value="${goodsInfo.image}"/>
		    	<table cellpadding="1" cellspacing="1" border="0" >
		    		<tr>
		    			<td width="80" align="right">编码:</td>
		    			<td align="left"><input readonly="readonly" type="text" id="goodsInfo-id-baseInfo" style="width: 135px;" name="goodsInfo.id" value="${goodsInfo.id }"/><font color="red">*</font></td>
		    			<td width="80" align="right">助记符:</td>
		    			<td align="left"><input readonly="readonly" type="text" style="width: 135px;" name="goodsInfo.spell" value="${goodsInfo.spell }" maxlength="20"/><c:if test="${colMap.spell == 'spell' }"><font color="red">*</font></c:if></td>
		    			<td width="80" align="right">状态:</td>
		    			<td align="left"><select disabled="disabled" class="easyui-combobox" readonly="readonly" style="width: 135px;">
		    				<option value="0" <c:if test="${goodsInfo.state=='0'}">selected="selected"</c:if>>禁用</option>
		    				<option value="1" <c:if test="${goodsInfo.state=='1'}">selected="selected"</c:if>>启用</option>
		    				<option value="2" <c:if test="${goodsInfo.state=='2'}">selected="selected"</c:if>>保存</option>
		    				<option value="3" <c:if test="${goodsInfo.state=='3'}">selected="selected"</c:if>>暂存</option>
		    			</select></td>
		    		</tr>
		    		<tr>
						<td align="right">名称:</td>
		    			<td align="left" colspan="3"><input readonly="readonly" id="goodsSimplify-input-name" type="text" style="width: 363px;" name="goodsInfo.name" value="${goodsInfo.name }"/><font color="red">*</font></td>
		    			<td align="right">规格型号:</td>
		    			<td align="left"><input type="text" readonly="readonly" style="width: 135px;" name="goodsInfo.model" value="${goodsInfo.model }" maxlength="200"/><c:if test="${colMap.model == 'model' }"><font color="red">*</font></c:if></td>
		    		</tr>
		    		<tr>
		    			<td align="right">名称拼音:</td>
		    			<td align="left"><input type="text" readonly="readonly" id="goodsSimplify-input-pinyin" style="width: 135px" name="goodsInfo.pinyin" value="${goodsInfo.pinyin }" /><c:if test="${colMap.pinyin == 'pinyin' }"><font color="red">*</font></c:if></td>
		    			<td align="right">条形码:</td>
		    			<td align="left"><input type="text" readonly="readonly" style="width: 135px;" name="goodsInfo.barcode" value="${goodsInfo.barcode }"/><c:if test="${colMap.barcode == 'barcode' }"><font color="red">*</font></c:if></td>
		    			<td align="right">箱装条形码:</td>
		    			<td align="left"><input type="text" readonly="readonly" style="width: 135px;" name="goodsInfo.boxbarcode" value="${goodsInfo.boxbarcode }"/><c:if test="${colMap.boxbarcode == 'boxbarcode' }"><font color="red">*</font></c:if></td>
		    		</tr>
		    		<tr>
		    			<td align="right">商品分类:</td>
		    			<td align="left"><input readonly="readonly" id="goodsSimplify-widget-defaultsort" value="<c:out value="${goodsInfo.defaultsort }"></c:out>" type="text" name="goodsInfo.defaultsort"/><c:if test="${colMap.defaultsort == 'defaultsort' }"><font color="red">*</font></c:if></td>
		    			<td align="right">商品品牌:</td>
		    			<td align="left"><input readonly="readonly" id="goodsSimplify-widget-brand" type="text" name="goodsInfo.brand" value="${goodsInfo.brand }"/><c:if test="${colMap.brand == 'brand' }"><font color="red">*</font></c:if></td>
		    			<td align="right">所属部门:</td>
		    			<td align="left"><input readonly="readonly" id="goodsSimplify-widget-deptid" type="text" name="goodsInfo.deptid" value="${goodsInfo.deptid }"/><c:if test="${colMap.deptid == 'deptid' }"><font color="red">*</font></c:if></td>
		    		</tr>
		    		<tr>
		    			<td align="right">商品类型:</td>
		    			<td align="left"><select disabled="disabled" name="goodsInfo.goodstype" style="width: 135px;">
				    				<option></option>
		    						<c:forEach items="${goodstypeList }" var="list">
					    				<c:choose>
					    					<c:when test="${list.code == goodsInfo.goodstype}">
					    						<option value="${list.code }" selected="selected">${list.codename }</option>
					    					</c:when>
					    					<c:otherwise>
					    						<option value="${list.code }">${list.codename }</option>
					    					</c:otherwise>
					    				</c:choose>
					    			</c:forEach>
				    			</select><c:if test="${colMap.goodstype == 'goodstype' }"><font color="red">*</font></c:if></td>
		    			<td align="right">默认供应商:</td>
		    			<td align="left"><input readonly="readonly" id="goodsSimplify-supplierWidget" type="text" name="goodsInfo.defaultsupplier" value="${goodsInfo.defaultsupplier }" text="${goodsInfo.defaultsupplierName }" style="width: 135px;"/><c:if test="${colMap.defaultsupplier == 'defaultsupplier' }"><font color="red">*</font></c:if></td>
		    			<td align="right">第二供应商:</td>
		    			<td align="left"><input readonly="readonly" id="goodsSimplify-secondsupplierWidget" type="text" name="goodsInfo.secondsupplier" value="${goodsInfo.secondsupplier }"/><c:if test="${colMap.secondsupplier == 'secondsupplier' }"><font color="red">*</font></c:if></td>
		    		</tr>
		    		<tr>
		    			<td align="right">长度(m):</td>
		    			<td align="left"><input readonly="readonly" type="text" id="goodsSimplify-numberbox-glength" style="width: 135px;" name="goodsInfo.glength" value="${goodsInfo.glength }"><c:if test="${colMap.glength == 'glength' }"><font color="red">*</font></c:if></td>
		    			<td align="right">高度(m):</td>
		    			<td align="left"><input readonly="readonly" type="text" id="goodsSimplify-numberbox-ghight" style="width: 135px;" name="goodsInfo.ghight" value="${goodsInfo.ghight }"><c:if test="${colMap.ghight == 'ghight' }"><font color="red">*</font></c:if></td>
		    			<td align="right">宽度(m):</td>
		    			<td align="left"><input readonly="readonly" type="text" id="goodsSimplify-numberbox-gwidth" style="width: 135px;" name="goodsInfo.gwidth" value="${goodsInfo.gwidth }"><c:if test="${colMap.gwidth == 'gwidth' }"><font color="red">*</font></c:if></td>
		    		</tr>
		    		<tr>
		    			<td align="right">箱重(kg):</td>
		    			<td align="left"><input readonly="readonly" type="text" style="width: 135px;" name="goodsInfo.totalweight" value="${goodsInfo.totalweight }" class="easyui-numberbox" data-options="min:0,max:999999999999,precision:6,groupSeparator:','"><c:if test="${colMap.totalweight == 'totalweight' }"><font color="red">*</font></c:if></td>
		    			<td align="right">箱体积(m<sup>3</sup>):</td>
		    			<td align="left"><input readonly="readonly" type="text" id="goodsSimplify-numberbox-totalvolume" style="width: 135px;" name="goodsInfo.totalvolume" value="${goodsInfo.totalvolume }" class="easyui-numberbox" data-options="min:0,max:999999999999,precision:6,groupSeparator:','"><c:if test="${colMap.totalvolume == 'totalvolume' }"><font color="red">*</font></c:if></td>
		    			<td align="right">ABC码:</td>
					    <td align="left"><select disabled="disabled" style="width: 135px;" name="goodsInfo.abclevel">
					    		<option></option>
					    		<option value="A" <c:if test="${goodsInfo.abclevel=='A'}">selected="selected"</c:if> >A</option>
					    		<option value="B" <c:if test="${goodsInfo.abclevel=='B'}">selected="selected"</c:if> >B</option>
					    		<option value="C" <c:if test="${goodsInfo.abclevel=='C'}">selected="selected"</c:if> >C</option>
					    	</select></td>
		    		</tr>
		    		<tr>
		    			<td  width="80" align="right">主单位:</td>
		    			<td align="left"><input readonly="readonly" style="width: 135px" id="goodsSimplify-widget-mainunit" type="text" name="goodsInfo.mainunit" value="${goodsInfo.mainunit }"/><c:if test="${colMap.mainunit == 'mainunit' }"><font color="red">*</font></c:if></td>
		    			<td align="right">箱装量:</td>
		    			<td align="left"><input readonly="readonly" id="goodsSimplify-numberbox-rate" type="text" name="goodsMUInfo.rate" value="${goodsMUInfo.rate }" style="width: 135px;"/><c:if test="${colMap.rate == 'rate' }"><font color="red">*</font></c:if></td>
		    			<td align="right">辅单位:</td>
		    			<td align="left"><input readonly="readonly" id="goodsSimplify-widget-meteringunitid" type="text" name="goodsMUInfo.meteringunitid" value="${goodsMUInfo.meteringunitid }"/><c:if test="${colMap.meteringunitid == 'meteringunitid' }"><font color="red">*</font></c:if></td>
		    		</tr>
		    		<tr>
		    			
		    			<td align="right">默认仓库:</td>
		    			<td align="left"><input readonly="readonly"  id="goodsSimplify-widget-storage" type="text" name="goodsInfo.storageid" value="${goodsInfo.storageid }"/><c:if test="${colMap.storageid == 'storageid' }"><font color="red">*</font></c:if></td>
		    			<td align="right">库位管理:</td>
					    <td align="left"><select disabled="disabled" name="goodsInfo.isstoragelocation" style="width: 135px;">
					    		<option></option>
					    		<option value="1" <c:if test="${goodsInfo.isstoragelocation=='1'}">selected="selected"</c:if> >是</option>
								<option value="0" <c:if test="${goodsInfo.isstoragelocation=='0'}">selected="selected"</c:if> >否</option>
					    	</select><c:if test="${colMap.isstoragelocation == 'isstoragelocation' }"><font color="red">*</font></c:if></td>
					    <td align="right">商品货位:</td>
		    			<td align="left"><input readonly="readonly" id="goodsInfo-name-itemno" type="text" style="width: 135px;" name="goodsInfo.itemno" value="${goodsInfo.itemno }"/><c:if test="${colMap.itemno == 'itemno' }"><font color="red">*</font></c:if></td>
		    		</tr>
		    		<tr>
		    			<td align="right">购销类型:</td>
		    			<td align="left"><select disabled="disabled" name="goodsInfo.bstype" style="width: 135px;"  class="easyui-combobox">
			    				<option></option>
			    				<c:forEach items="${bstypeList }" var="list">
				    				<c:choose>
				    					<c:when test="${list.code == goodsInfo.bstype}">
				    						<option value="${list.code }" selected="selected">${list.codename }</option>
				    					</c:when>
				    					<c:otherwise>
				    						<option value="${list.code }">${list.codename }</option>
				    					</c:otherwise>
				    				</c:choose>
				    			</c:forEach>
			    			</select></td>
			    		<td align="right">批次管理:</td>
					    <td align="left"><select disabled="disabled" name="goodsInfo.isbatch" style="width: 135px;">
					    		<option></option>
					    		<option value="1" <c:if test="${goodsInfo.isbatch=='1'}">selected="selected"</c:if> >是</option>
								<option value="0" <c:if test="${goodsInfo.isbatch=='0'}">selected="selected"</c:if> >否</option>
					    	</select><c:if test="${colMap.isbatch == 'isbatch' }"><font color="red">*</font></c:if></td>
		    			<td align="right">默认采购员:</td>
					    <td align="left"><input readonly="readonly" id="goodsInfo-widget-defaultbuyer" type="text" style="width: 135px;" name="goodsInfo.defaultbuyer" value="${goodsInfo.defaultbuyer }"/></td>
		    		</tr>
		    		<tr>
		    			<td align="right">保质期管理:</td>
		    			<td align="left"><select id="goodsInfo-numberbox-isshelflife" disabled="disabled" name="goodsInfo.isshelflife" style="width: 135px;">
				    				<option value="1" <c:if test="${goodsInfo.isshelflife=='1'}">selected="selected"</c:if> >是</option>
								    <option value="0" <c:if test="${goodsInfo.isshelflife=='0'}">selected="selected"</c:if> >否</option>
				    			</select><c:if test="${colMap.isshelflife == 'isshelflife' }"><font color="red">*</font></c:if></td>
		    			<td align="right">保质期:</td>
		    			<td align="left"><span style="float: left;">
								    	<input id="goodsInfo-numberbox-shelflife" readonly="readonly" type="text" name="goodsInfo.shelflife" value="${goodsInfo.shelflife }" style="width:69px;float:left;" class="easyui-numberbox" data-options="min:0,max:9999999999,groupSeparator:','"/>
									    <select disabled="disabled" class="easyui-combobox" name="goodsInfo.shelflifeunit" style="width:60px; float:left;" >
									      <option value="1" <c:if test="${goodsInfo.shelflifeunit=='1'}">selected="selected"</c:if> >天</option>
										  <option value="2" <c:if test="${goodsInfo.shelflifeunit=='2'}">selected="selected"</c:if> >周</option>
									      <option value="3" <c:if test="${goodsInfo.shelflifeunit=='3'}">selected="selected"</c:if> >月</option>
									      <option value="4" <c:if test="${goodsInfo.shelflifeunit=='4'}">selected="selected"</c:if> >年</option>
									    </select>
									</span><div id="goods-red-shelflife" style="display: none;"><font color="red">*</font></div></td>
						<td align="right">默认税种:</td>
		    			<td align="left"><input readonly="readonly" id="goodsSimplify-widget-defaulttaxtype" type="text" name="goodsInfo.defaulttaxtype" value="<c:out value="${goodsInfo.defaulttaxtype }"></c:out>"/><c:if test="${colMap.defaulttaxtype == 'defaulttaxtype' }"><font color="red">*</font></c:if></td>
		    		</tr>
		    		<tr>
			    		<td align="right">采购价:</td>
		    			<td align="left"><input readonly="readonly" id="goodsSimplify-numberbox-highestbuyprice" type="text" name="goodsInfo.highestbuyprice" value="${goodsInfo.highestbuyprice }" style="width: 135px;"/><c:if test="${colMap.highestbuyprice == 'highestbuyprice' }"><font color="red">*</font></c:if></td>
		    			<td align="right">最低销售价:</td>
						<td align="left"><input readonly="readonly" type="text" class="easyui-numberbox" data-options="min:0,max:99999999,precision:6,groupSeparator:','" name="goodsInfo.lowestsaleprice" value="${goodsInfo.lowestsaleprice }" style="width: 135px;"/><c:if test="${colMap.lowestsaleprice == 'lowestsaleprice' }"><font color="red">*</font></c:if></td>
		    			<td align="right">基准销售价:</td>
		    			<td align="left"><input readonly="readonly" type="text" class="easyui-numberbox" data-options="min:0,max:999999999999,precision:6,groupSeparator:','" name="goodsInfo.basesaleprice" value="${goodsInfo.basesaleprice }" style="width: 135px;"/><c:if test="${colMap.basesaleprice == 'basesaleprice' }"><font color="red">*</font></c:if></td>
		    		</tr>
		    		<tr>
					 	<td align="right">最高库存:</td>
					    <td align="left"><input readonly="readonly" type="text" style="width: 135px;" name="goodsInfo.highestinventory" value="${goodsInfo.highestinventory }" class="easyui-numberbox" data-options="min:0,max:99999999,precision:${decimallen},groupSeparator:','"></td>
						<td align="right">最低库存:</td>
					    <td align="left"><input readonly="readonly" type="text" style="width: 135px;" name="goodsInfo.lowestinventory" value="${goodsInfo.lowestinventory }" class="easyui-numberbox" data-options="min:0,max:99999999,precision:${decimallen},groupSeparator:','"></td>
						<td align="right">安全库存:</td>
					    <td align="left"><input readonly="readonly" type="text" style="width: 135px;" name="goodsInfo.safeinventory" value="${goodsInfo.safeinventory }" class="easyui-numberbox" data-options="min:0,max:99999999,precision:${decimallen},groupSeparator:','"></td>
					</tr>
		    		<tr>
				    	<td align="right">采购箱价:</td>
				    	<td align="left"><input readonly="readonly" type="text" id="goodsSimplify-numberbox-buyboxprice" name="goodsInfo.buyboxprice" value="${goodsInfo.buyboxprice }" style="width: 135px;"/></td>
		    			<td align="right">最小发货单位:</td>
						<td align="left"><input readonly="readonly" type="text" name="goodsInfo.minimum" value="${goodsInfo.minimum }" style="width:135px;" class="easyui-numberbox" data-options="min:0,max:9999999999,groupSeparator:','"/></td>
		    			<td align="right">产地:</td>
		    			<td align="left"><input readonly="readonly" type="text" style="width: 135px;" name="goodsInfo.productfield" value="${goodsInfo.productfield }"/></td>
		    		</tr>
		    		<tr>
		    			<td align="right">最新采购价:</td>
		    			<td align="left"><input readonly="readonly" id="goodsSimplify-numberbox-newbuyprice" type="text" class="easyui-numberbox" data-options="min:0,max:999999999999,precision:6,groupSeparator:','" name="goodsInfo.newbuyprice" value="${goodsInfo.newbuyprice }" style="width: 135px;" disabled="disabled"/></td>
		    			<td align="right">最新库存价:</td>
		    			<td align="left"><input readonly="readonly" type="text" class="easyui-numberbox" data-options="max:999999999999,precision:6,groupSeparator:','"  value="${goodsInfo.newstorageprice }" style="width: 135px;" disabled="disabled"/></td>
                        <td align="right">成本未分摊<br/>金额:</td>
                        <td align="left"><input readonly="readonly" type="text" class="easyui-numberbox" data-options="precision:6,groupSeparator:','"  value="${goodsInfo.field12 }" style="width: 135px;" disabled="disabled"/></td>
		    		</tr>
                    <tr>
						<td align="right">备注:</td>
						<td align="left" colspan="5"><input readonly="readonly" name="goodsInfo.remark" type="text" style="width: 598px;" value="${goodsInfo.remark }" maxlength="200"/></td>
					</tr>
					<c:if test="${useHTKPExport=='1'}">
						<tr>
							<td align="right">金税商品编码：</td>
							<td>
								<input type="text" id="goodsInfo-jsgoodsid-baseInfo" style="width: 135px;" name="goodsInfo.jsgoodsid" value="${goodsInfo.jsgoodsid}" readonly="readonly"/>
							</td>
							<td align="right">金税税收<br/>分类编码：</td>
							<td>
								<input type="text" id="goodsInfo-jstaxsortid-baseInfo" style="width: 135px;" name="goodsInfo.jstaxsortid" value="${goodsInfo.jstaxsortid}" readonly="readonly"/>
							</td>
						</tr>
					</c:if>
		    		<div>
		   				<c:forEach var="list" items="${priceList}" varStatus="status">
		    				<c:if test="${(status.index)%3==0}">
		    					<tr>
		    					<!-- <input value="${status.index}" type="hidden"/> -->
		    				</c:if>
							<td align="right">${list.codename}-箱价:</td>
							
							<td align="left"><input id="goodsSimplify-numberbox-taxprice-${status.index}" disabled="disabled" name="priceInfoList[${status.index}].taxprice" type="text" value="${list.val }" style="width: 65px"/>-<input id="goodsSimplify-numberbox-boxprice-${status.index}" disabled="disabled" name="priceInfoList[${status.index}].boxprice" value="${list.boxval }" type="text" style="width: 65px;"/><c:if test="${status.index == 0 || status.index == 1 || status.index == 2}"><font color="red">*</font></c:if>
								<input name="priceInfoList[${status.index}].code" value="${list.code}" type="hidden"/>
								<input name="priceInfoList[${status.index}].name" value="${list.codename}" type="hidden"/>
							</td>
							<c:if test="${(status.index+1)%3==0}">
								</tr>
							</c:if>
						</c:forEach>
					</div>
		    	</table>
		    </form>
  		</div>
  		<div data-options="region:'south'">
            <div class="buttonDetailBG" style="text-align:right;">
                <input type="button" id="wares-upload-goodsAddPage" value="图片信息"/>
                <input type="button" id="wares-close-goodsAddPage" value="关闭"/>
            </div>
  		</div>
  	</div>
    <script type="text/javascript">
    	$(function(){
    		loadDropdown();
    		
    		if("1" == $("#goodsInfo-numberbox-isshelflife").combobox('getValue')){
    			document.getElementById("goods-red-shelflife").style.display="block";
    		}else{
    			<c:choose>
					<c:when test="${colMap.shelflife == 'shelflife'}">
						document.getElementById("goods-red-shelflife").style.display="block";
					</c:when>
					<c:otherwise>
						document.getElementById("goods-red-shelflife").style.display="none";
					</c:otherwise>
				</c:choose>
    		}
    		
    		//上传图片按钮，浏览 
			$("#wares-upload-goodsAddPage").click(function(){
				goods_open_upload_dialog("view");
			});
    		
	   		//关闭
	   		$("#wares-close-goodsAddPage").click(function(){
	   			$("#wares-dialog-goodsListPage1").dialog('close');
	   		});
    	});
    </script>
  </body>
</html>
