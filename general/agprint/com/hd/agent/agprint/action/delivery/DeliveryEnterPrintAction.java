/**
 * @(#)DeliveryEnterPrintAction.java
 * @author huangzhiqian
 * <p>
 * 版本历史
 * -------------------------------------------------------------------------
 * 时间 作者 内容
 * -------------------------------------------------------------------------
 * 2015年10月9日 huangzhiqian 创建版本
 */
package com.hd.agent.agprint.action.delivery;

import com.hd.agent.accesscontrol.model.SysUser;
import com.hd.agent.agprint.model.PrintJob;
import com.hd.agent.agprint.model.PrintJobCallHandle;
import com.hd.agent.agprint.model.PrintTemplet;
import com.hd.agent.agprint.service.impl.AgprintServiceImpl;
import com.hd.agent.basefiles.action.BaseFilesAction;
import com.hd.agent.common.annotation.UserOperateLog;
import com.hd.agent.common.util.CommonUtils;
import com.hd.agent.common.util.JSONUtils;
import com.hd.agent.common.util.JasperReportUtils;
import com.hd.agent.common.util.ListSortLikeSQLComparator;
import com.hd.agent.storage.model.StorageDeliveryEnter;
import com.hd.agent.storage.model.StorageDeliveryEnterDetail;
import com.hd.agent.storage.model.StorageDeliveryOut;
import com.hd.agent.storage.model.StorageDeliveryOutDetail;
import com.hd.agent.storage.service.DeliveryOutService;
import com.hd.agent.storage.service.IDistributeRejectService;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.util.JRLoader;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import java.io.File;
import java.util.*;

/**
 *
 * 代配送出入库打印相关
 * @author huangzhiqian
 */
public class DeliveryEnterPrintAction extends BaseFilesAction {
    //region 参数初始化
    private static final Logger logger = Logger.getLogger(DeliveryEnterPrintAction.class);
    private static final long serialVersionUID = 1L;
    private IDistributeRejectService distributeRejectService;
    private DeliveryOutService deliveryOutService;

    public IDistributeRejectService getDistributeRejectService() {
        return distributeRejectService;
    }

    public void setDistributeRejectService(IDistributeRejectService distributeRejectService) {
        this.distributeRejectService = distributeRejectService;
    }

    public DeliveryOutService getDeliveryOutService() {
        return deliveryOutService;
    }

    public void setDeliveryOutService(DeliveryOutService deliveryOutService) {
        this.deliveryOutService = deliveryOutService;
    }

    private AgprintServiceImpl agprintServiceImpl;

    public AgprintServiceImpl getAgprintServiceImpl() {
        return agprintServiceImpl;
    }

    public void setAgprintServiceImpl(AgprintServiceImpl agprintServiceImpl) {
        this.agprintServiceImpl = agprintServiceImpl;
    }
    //endregion 参数初始化

    /**
     * 代配送出入库打印查看
     * @return
     * @throws Exception
     * @author huangzhiqian
     * @date 2015年10月9日
     */
    public String deliveryEnterPrintView() throws Exception {

        //查询入库表,还是出库表
        String isenter = request.getParameter("isenter");
        String queryTable = "";

        if ("true".equals(isenter)) {
            //入库
            return deliveryEnterPrintHandle(true);
        } else if ("false".equals(isenter)) {
            //出库
            return deliveryOutPrintHandle(true);
        }
        return null;
    }


    /**
     * 代配送出入库单
     * @throws Exception
     * @author zhanghonghui
     * @date 2015-01-14
     */
    @UserOperateLog(key = "Storage_Delivery", type = 0)
    public String deliveryorderPrint() throws Exception {
        String isenter = request.getParameter("isenter");
        //是否是代配送入库单
        boolean isEnter = false;
        if ("true".equals(isenter)) {
            isEnter = true;
        }
        String justprint = request.getParameter("justprint");
        String printcallback = request.getParameter("agprint_callback_params");
        if (null != printcallback && !"".equals(printcallback)) {
            if (isEnter) {
                deliveryEnterPrintCallBackHandle(printcallback);
            } else {
                deliveryOutPrintCallBackHandle(printcallback);
            }
        } else {
            boolean isview = false;
            if ("1".equals(justprint) || "true".equals(justprint)) {
                isview = false;
            } else {
                isview = true;
            }
            if (!isview) {
                logStr = "代配送出入库单打印";
            }
            if (isEnter) {
                return deliveryEnterPrintHandle(isview);
            } else {
                return deliveryOutPrintHandle(isview);
            }
        }
        return null;
    }


    /**
     * 代配送入库打印预览以及打印(enter)
     * @return
     * @throws Exception
     * @author wanghongteng
     * @date 2015-9-2
     */
    private String deliveryEnterPrintHandle(boolean isview) throws Exception {
        String viewtype = request.getParameter("viewtype");
        if (null == viewtype) {
            viewtype = "pdf";
        }
        viewtype = viewtype.trim();
        //返回的格式：
        //{flag:true,printname:'',printdata:[{}],msg:'',totalpages:100}
        //ajax数据
        Map ajaxResultMap = new HashMap();
        ajaxResultMap.put("printname", "到货订单打印-" + CommonUtils.getDataNumberSeconds());
        String idarrs = request.getParameter("idarrs");
        if (null == idarrs || "".equals(idarrs.trim())) {
            if ("ajaxhtml".equals(viewtype)) {
                ajaxResultMap.put("flag", false);
                ajaxResultMap.put("msg", "未能找到相关打印单据");
                addJSONObject(ajaxResultMap);
                return SUCCESS;
            } else {
                return null;
            }
        }
        Map printTempletSettingFistMap = null;
        String templetid = request.getParameter("templetid");

        SysUser sysUser = getSysUser();
        String canprintIds = "";
        try {

            //打印任务信息
            PrintJob printJob = new PrintJob();
            if ( "ajaxhtml".equals(viewtype)) {
                printJob.setAddtime(new Date());
                printJob.setAdduserid(sysUser.getUserid());
                printJob.setAddusername(sysUser.getName());
                printJob.setIp(CommonUtils.getIP(request));
                printJob.setJobname("代配送入库打印");
                printJob.setOrderidarr(idarrs);
                if (request.getQueryString() != null) {
                    printJob.setRequestparam(request.getQueryString());
                }
                
            if(isview){
                //3打印预览
                printJob.setStatus("3");
             }else{
                //0申请
                 printJob.setStatus("0");
             }
                //打印对象添加到数据库
                boolean isjobflag = agprintServiceImpl.addPrintJob(printJob);
                if (!isjobflag || StringUtils.isEmpty(printJob.getId())) {
                    ajaxResultMap.put("flag", false);
                    ajaxResultMap.put("msg", "申请单据打印时失败");
                    addJSONObject(ajaxResultMap);
                    return SUCCESS;
                }
                ajaxResultMap.put("printJobId", printJob.getId());
                ajaxResultMap.put("printname", "到货订单打印任务-" + printJob.getId());
            }
            String printlimit = getPrintLimitInfo();
            Map map = new HashMap();
            map.put("idarrs", idarrs);
            map.put("showdetail", "1");

            List<StorageDeliveryEnter> list = distributeRejectService.printDeliveryEnter(map);
            if (list.size() == 0) {
                if ("ajaxhtml".equals(viewtype)) {
                    ajaxResultMap.put("flag", false);
                    ajaxResultMap.put("msg", "未能找到相关打印单据");
                    addJSONObject(ajaxResultMap);
                    return SUCCESS;
                } else {
                    return null;
                }
            }
            JasperReport jreport = null;

            Map parameters = null;
            List<JasperPrint> jrlist = new ArrayList<JasperPrint>();
            List<String> printIdList = new ArrayList<String>();
            //获取打印模板
            Map templetQueryMap = new HashMap();
            for (StorageDeliveryEnter item : list) {
                if (null == item.getPrinttimes()) {
                    item.setPrinttimes(0);
                }
                if (!isview) {
                    item.setPrinttimes(item.getPrinttimes() + 1);
                } else {
                    item.setPrinttimes(item.getPrinttimes() + 1);
                }

                List<StorageDeliveryEnterDetail> detailList = item.getDetailList();

                if (null == detailList || detailList.size() == 0) {
                    continue;
                }


                templetQueryMap.clear();
                templetQueryMap.put("realServerPath", servletContext.getRealPath("/"));
                templetQueryMap.put("code", "storage_delivery_enter");
                if (null != templetid && !"".equals(templetid)) {
                    templetQueryMap.put("templetid", templetid);
                }
                Map templetResultMap = agprintServiceImpl.showPrintTempletByPrintQuery(templetQueryMap);
                if (printTempletSettingFistMap == null || printTempletSettingFistMap.size() == 0) {
                    printTempletSettingFistMap = new HashMap();
                    printTempletSettingFistMap.putAll(templetResultMap);
                }
                //打印模板文件
                String printTempletFile = (String) templetResultMap.get("printTempletFile");
                if (null == printTempletFile || "".equals(printTempletFile.trim())) {
                    continue;
                }
                //打印内容排序策略
                String printDataOrderSeq = (String) templetResultMap.get("printDataOrderSeq");

                //进行打印内容明细排序
                if (null != printDataOrderSeq && !"".equals(printDataOrderSeq.trim())) {
                    Collections.sort(detailList, ListSortLikeSQLComparator.createComparator(printDataOrderSeq.trim()));
                }
                PrintTemplet printTemplet = new PrintTemplet();
                if (templetResultMap.containsKey("printTempletInfo")) {
                    printTemplet = (PrintTemplet) templetResultMap.get("printTempletInfo");
                    if (null == printTemplet) {
                        printTemplet = new PrintTemplet();
                        templetResultMap.put("printTempletInfo", printTemplet);
                    }
                }

                jreport = (JasperReport) JRLoader.loadObject(new File(printTempletFile));
                if (jreport == null) {
                    continue;
                }
                parameters = new HashMap();
                //单据类型  1,针对供应商 2,针对客户
                String billtype = request.getParameter("billtype");
                if ("1".equals(billtype)) {
                    parameters.put("P_Name", "厂家名称");
                    parameters.put("P_Supplierid", item.getSupplierid());
                    parameters.put("P_Suppliername", item.getSuppliername());
                } else if ("2".equals(billtype)) {
                    parameters.put("P_Name", "客户名称");
                    parameters.put("P_Supplierid", item.getCustomerid());
                    parameters.put("P_Suppliername", item.getCustomername());
                }
                parameters.put("P_Totalweight", item.getTotalweight());
                parameters.put("P_Totalvolume", item.getTotalvolume());
                parameters.put("P_Title", "代配送入库单");
                parameters.put("P_PrintDate", new Date());
                parameters.put("P_Businessdate", CommonUtils.getBusinessdateByString(item.getBusinessdate()));
                parameters.put("P_OrderId", item.getId());
                parameters.put("P_Storageid", item.getStorageid());
                parameters.put("P_Storagename", item.getStoragename());
                parameters.put("P_BillRemark", item.getRemark());
                parameters.put("P_PRINTUSER", sysUser.getName());

                /**打印模板参数用的单据信息**/
                StorageDeliveryEnter orderInfo = (StorageDeliveryEnter) CommonUtils.deepCopy(item);
                orderInfo.setDetailList(null);
                parameters.put("P_OrderInfo", orderInfo);
                    /*共用参数*/
                parameters.put("P_TPL_COMPANYNAME", printTemplet.getCompanytitle());
                agprintServiceImpl.setTempletCommonParameter(parameters);

                JasperPrint jrprint = JasperFillManager.fillReport(jreport, parameters, new JRBeanCollectionDataSource(detailList, false));
                if (null != jrprint) {
                    jrprint.setName("代配送入库单-" + item.getId());
                    jrlist.add(jrprint);
                    if (!isview) {
                        Map<String, Object> callbackparamMap = new HashMap<String, Object>();
                        callbackparamMap.put("id", item.getId());
                        callbackparamMap.put("callback", "updateprinttimes");
                        callbackparamMap.put("rand", CommonUtils.getRandomWithTime());    //随机数
                        String callbackparams = JSONUtils.mapToJsonStr(callbackparamMap);
                        jrprint.setProperty("agprint_callback_params", callbackparams);
                        printIdList.add(item.getId());


                        if (StringUtils.isNotEmpty(printJob.getId())) {
                            //打印次数更新回调方法
                            Map<String, Object> datahtmlparamMap = new HashMap<String, Object>();
                            //ajaxhtml 打印时，前台加入到打印时，出错提示用。
                            //实际打印的单据号
                            datahtmlparamMap.put("printOrderId", item.getId());
                            //打印任务编号
                            datahtmlparamMap.put("printJobId", printJob.getId());
                            //页面点击时的单据号
                            datahtmlparamMap.put("printSourceOrderId", "");
                            String datahtmlparams = JSONUtils.mapToJsonStr(datahtmlparamMap);
                            jrprint.setProperty("agprint_params_datahtml", datahtmlparams);
                            //打印回调处理
                            PrintJobCallHandle printJobCallHandle = new PrintJobCallHandle();
                            printJobCallHandle.setJobid(printJob.getId());
                            printJobCallHandle.setClassname("deliveryEnterPrintAction");
                            printJobCallHandle.setMethodname("deliveryEnterPrintReflectCallBackHandle");
                            printJobCallHandle.setMethodparam(callbackparams);
                            printJobCallHandle.setPages(jrprint.getPages().size());
                            printJobCallHandle.setPrintorderid(item.getId());
                            printJobCallHandle.setPrintordername("代配送入库单");
                            printJobCallHandle.setSourceorderid(item.getId());
                            printJobCallHandle.setSourceordername("代配送入库单");
                            printJobCallHandle.setStatus("0");
                            printJobCallHandle.setType("1");//次数更新
                            agprintServiceImpl.getPrintJobService().addPrintJobCallHandle(printJobCallHandle);
                        }
                    }
                }
            }

            if (null == jrlist || jrlist.size() == 0) {
                if ("ajaxhtml".equals(viewtype)) {
                    ajaxResultMap.put("flag", false);
                    ajaxResultMap.put("msg", "抱歉，未能找到相关打印单据");
                    addJSONObject(ajaxResultMap);
                    return SUCCESS;
                } else {
                    return null;
                }
            }
            if (!isview) {
                if (printIdList.size() > 0) {
                    String[] printarr = (String[]) printIdList.toArray(new String[printIdList.size()]);
                    if (null != printarr) {
                        canprintIds = StringUtils.join(printarr, ",");
                    }
                }
                StringBuilder printLogsb = new StringBuilder();
                printLogsb.append("打印申请：");
                printLogsb.append(" 代配送编号： " + canprintIds);
                printLogsb.append(" 。");
                printLogsb.append(" 操作名称： 代配送入库单打印。");
                addPrintLogInfo("PrintHandle-DeliveryEnterOrder", printLogsb.toString(), null);
            }

            //输出打印报表
            if ("ajaxhtml".equals(viewtype)) {
                List<Map<String, Object>> renderResult = JasperReportUtils.renderJasperReportForAjax(jrlist, isview, viewtype, printJob.getId());
                boolean resultFlag = false;
                if (null != renderResult && renderResult.size() > 0) {
                    resultFlag = true;
                }
                ajaxResultMap.put("flag", resultFlag);
                ajaxResultMap.put("printdata", renderResult);
                ajaxResultMap.put("msg", "获取数据成功");
                if (printTempletSettingFistMap != null) {
                    ajaxResultMap.put("showpagesize", true);
                    ajaxResultMap.put("paperwidth", printTempletSettingFistMap.get("paperwidth"));
                    ajaxResultMap.put("paperheight", printTempletSettingFistMap.get("paperheight"));
                    ajaxResultMap.put("paperintwidth", printTempletSettingFistMap.get("paperintwidth"));
                    ajaxResultMap.put("paperintheight", printTempletSettingFistMap.get("paperintheight"));
                    ajaxResultMap.put("papersizename", printTempletSettingFistMap.get("papersizename"));
                    ajaxResultMap.put("lodophtmlmodel", printTempletSettingFistMap.get("lodophtmlmodel"));
                }
                addJSONObject(ajaxResultMap);

                jrlist = null;
                list = null;

                return SUCCESS;
            } else {
                Map<String, Object> reportMap = new HashMap<String, Object>();
                reportMap.put("response", response);
                reportMap.put("jreportList", jrlist);
                reportMap.put("isview", isview);
                reportMap.put("viewtype", viewtype);
                reportMap.put("PDFOWNERPASSWORD", getSysParamValue("PDFOWNERPASSWORD"));
                JasperReportUtils.renderJasperReport(reportMap);
            }

        } catch (Exception ex) {
            StringBuilder printLogsb = new StringBuilder();
            if (!isview) {
                printLogsb.append("打印申请-代配送入库单打印及预览处理异常：");
                printLogsb.append("代配送入库单编号： " + canprintIds);
                printLogsb.append(" 。");
            } else {
                printLogsb.append("打印预览申请-代配送入库单打印及预览处理异常：");
            }
            printLogsb.append("Exception ：DeliveryEnterOrder()>>>>>>>>>>>>>>>>异常信息： " + ex.getMessage());
            addPrintLogInfo("PrintHandle-DeliveryEnterOrder", printLogsb.toString(), null);
            logger.error("代配送入库单打印及预览处理异常", ex);


            if ("ajaxhtml".equals(viewtype)) {
                ajaxResultMap.put("flag", false);
                ajaxResultMap.put("msg", "抱歉，获取打印数据异常");
                addJSONObject(ajaxResultMap);
            }
        }
        if ("ajaxhtml".equals(viewtype)) {
            return SUCCESS;
        } else {
            return null;
        }
    }

    /**
     * 代配送出库打印预览以及打印(out)
     * @param
     * @author huangzhiqian
     * @throws Exception
     * @date 2015年10月12日
     */
    private String deliveryOutPrintHandle(boolean isview) throws Exception {
        String viewtype = request.getParameter("viewtype");
        if (null == viewtype) {
            viewtype = "pdf";
        }
        viewtype = viewtype.trim();
        //返回的格式：
        //{flag:true,printname:'',printdata:[{}],msg:'',totalpages:100}
        //ajax数据
        Map ajaxResultMap = new HashMap();
        ajaxResultMap.put("printname", "代配送出库打印-" + CommonUtils.getDataNumberSeconds());
        String idarrs = request.getParameter("idarrs");
        if (null == idarrs || "".equals(idarrs.trim())) {
            if ("ajaxhtml".equals(viewtype)) {
                ajaxResultMap.put("flag", false);
                ajaxResultMap.put("msg", "未能找到相关打印单据");
                addJSONObject(ajaxResultMap);
                return SUCCESS;
            } else {
                return null;
            }
        }
        Map printTempletSettingFistMap = null;
        String templetid = request.getParameter("templetid");

        SysUser sysUser = getSysUser();
        String canprintIds = "";
        try {
            //打印任务信息
            PrintJob printJob = new PrintJob();
            if ("ajaxhtml".equals(viewtype)) {
                printJob.setAddtime(new Date());
                printJob.setAdduserid(sysUser.getUserid());
                printJob.setAddusername(sysUser.getName());
                printJob.setIp(CommonUtils.getIP(request));
                printJob.setJobname("代配送出库打印");
                printJob.setOrderidarr(idarrs);
                if (request.getQueryString() != null) {
                    printJob.setRequestparam(request.getQueryString());
                }
                
            if(isview){
                //3打印预览
                printJob.setStatus("3");
             }else{
                //0申请
                 printJob.setStatus("0");
             }
                //打印对象添加到数据库
                boolean isjobflag = agprintServiceImpl.addPrintJob(printJob);
                if (!isjobflag || StringUtils.isEmpty(printJob.getId())) {
                    ajaxResultMap.put("flag", false);
                    ajaxResultMap.put("msg", "申请单据打印时失败");
                    addJSONObject(ajaxResultMap);
                    return SUCCESS;
                }
                ajaxResultMap.put("printJobId", printJob.getId());
                ajaxResultMap.put("printname", "代配送出库打印-" + printJob.getId());
            }
            String printlimit = getPrintLimitInfo();
            Map map = new HashMap();
            map.put("idarrs", idarrs);
            map.put("showdetail", "1");

            List<StorageDeliveryOut> list = deliveryOutService.printDeliveryOut(map);
            if (list.size() == 0) {
                if ("ajaxhtml".equals(viewtype)) {
                    ajaxResultMap.put("flag", false);
                    ajaxResultMap.put("msg", "未能找到相关打印单据");
                    addJSONObject(ajaxResultMap);
                    return SUCCESS;
                } else {
                    return null;
                }
            }
            JasperReport jreport = null;

            Map parameters = null;
            List<JasperPrint> jrlist = new ArrayList<JasperPrint>();
            List<String> printIdList = new ArrayList<String>();
            //获取打印模板
            Map templetQueryMap = new HashMap();
            for (StorageDeliveryOut item : list) {
                if (null == item.getPrinttimes()) {
                    item.setPrinttimes(0);
                }
                if (!isview) {
                    item.setPrinttimes(item.getPrinttimes() + 1);
                } else {
                    item.setPrinttimes(item.getPrinttimes() + 1);
                }

                List<StorageDeliveryOutDetail> detailList = item.getDetailList();
                if (null != detailList && detailList.size() > 0) {

                    templetQueryMap.clear();
                    templetQueryMap.put("realServerPath", servletContext.getRealPath("/"));
                    templetQueryMap.put("code", "storage_delivery_enter");
                    if (null != templetid && !"".equals(templetid)) {
                        templetQueryMap.put("templetid", templetid);
                    }
                    Map templetResultMap = agprintServiceImpl.showPrintTempletByPrintQuery(templetQueryMap);
                    if (printTempletSettingFistMap == null || printTempletSettingFistMap.size() == 0) {
                        printTempletSettingFistMap = new HashMap();
                        printTempletSettingFistMap.putAll(templetResultMap);
                    }
                    //打印模板文件
                    String printTempletFile = (String) templetResultMap.get("printTempletFile");
                    if (null == printTempletFile || "".equals(printTempletFile.trim())) {
                        continue;
                    }
                    //打印内容排序策略
                    String printDataOrderSeq = (String) templetResultMap.get("printDataOrderSeq");

                    PrintTemplet printTemplet = new PrintTemplet();
                    if (templetResultMap.containsKey("printTempletInfo")) {
                        printTemplet = (PrintTemplet) templetResultMap.get("printTempletInfo");
                        if (null == printTemplet) {
                            printTemplet = new PrintTemplet();
                            templetResultMap.put("printTempletInfo", printTemplet);
                        }
                    }
                    //进行打印内容明细排序
                    if (null != printDataOrderSeq && !"".equals(printDataOrderSeq.trim())) {
                        Collections.sort(detailList, ListSortLikeSQLComparator.createComparator(printDataOrderSeq.trim()));
                    }

                    jreport = (JasperReport) JRLoader.loadObject(new File(printTempletFile));
                    if (jreport == null) {
                        continue;
                    }
                    parameters = new HashMap();

                    //单据类型  1,针对供应商 2,针对客户
                    String billtype = request.getParameter("billtype");
                    if ("1".equals(billtype)) {
                        parameters.put("P_Name", "厂家名称");
                        parameters.put("P_Supplierid", item.getSupplierid());
                        parameters.put("P_Suppliername", item.getSuppliername());
                    } else if ("2".equals(billtype)) {
                        parameters.put("P_Name", "客户名称");
                        parameters.put("P_Supplierid", item.getCustomerid());
                        parameters.put("P_Suppliername", item.getCustomername());
                    }

                    parameters.put("P_Totalweight", item.getTotalweight());
                    parameters.put("P_Totalvolume", item.getTotalvolume());

                    parameters.put("P_Title", "代配送出库单");
                    parameters.put("P_PrintDate", new Date());
                    parameters.put("P_Businessdate", CommonUtils.getBusinessdateByString(item.getBusinessdate()));
                    parameters.put("P_OrderId", item.getId());

                    parameters.put("P_Storageid", item.getStorageid());
                    parameters.put("P_Storagename", item.getStoragename());
                    parameters.put("P_BillRemark", item.getRemark());
                    parameters.put("P_PRINTUSER", sysUser.getName());
					/*共用参数*/
                    parameters.put("P_TPL_COMPANYNAME", printTemplet.getCompanytitle());
                    agprintServiceImpl.setTempletCommonParameter(parameters);

                    JasperPrint jrprint = JasperFillManager.fillReport(jreport, parameters, new JRBeanCollectionDataSource(detailList, false));
                    if (null != jrprint) {
                        jrprint.setName("代配送出库-" + item.getId());
                        jrlist.add(jrprint);
                        if (!isview) {
                            Map<String, Object> callbackparamMap = new HashMap<String, Object>();
                            callbackparamMap.put("id", item.getId());
                            callbackparamMap.put("callback", "updateprinttimes");
                            callbackparamMap.put("rand", CommonUtils.getRandomWithTime());    //随机数
                            String callbackparams = JSONUtils.mapToJsonStr(callbackparamMap);
                            jrprint.setProperty("agprint_callback_params", callbackparams);
                            printIdList.add(item.getId());


                            if (StringUtils.isNotEmpty(printJob.getId())) {
                                //打印次数更新回调方法
                                Map<String, Object> datahtmlparamMap = new HashMap<String, Object>();
                                //ajaxhtml 打印时，前台加入到打印时，出错提示用。
                                //实际打印的单据号
                                datahtmlparamMap.put("printOrderId", item.getId());
                                //打印任务编号
                                datahtmlparamMap.put("printJobId", printJob.getId());
                                //页面点击时的单据号
                                datahtmlparamMap.put("printSourceOrderId", "");
                                String datahtmlparams = JSONUtils.mapToJsonStr(datahtmlparamMap);
                                jrprint.setProperty("agprint_params_datahtml", datahtmlparams);
                                //打印回调处理
                                PrintJobCallHandle printJobCallHandle = new PrintJobCallHandle();
                                printJobCallHandle.setJobid(printJob.getId());
                                printJobCallHandle.setClassname("deliveryEnterPrintAction");
                                printJobCallHandle.setMethodname("deliveryOutPrintReflectCallBackHandle");
                                printJobCallHandle.setMethodparam(callbackparams);
                                printJobCallHandle.setPages(jrprint.getPages().size());
                                printJobCallHandle.setPrintorderid(item.getId());
                                printJobCallHandle.setPrintordername("代配送出库单");
                                printJobCallHandle.setSourceorderid(item.getId());
                                printJobCallHandle.setSourceordername("代配送出库单");
                                printJobCallHandle.setStatus("0");
                                printJobCallHandle.setType("1");//次数更新
                                agprintServiceImpl.getPrintJobService().addPrintJobCallHandle(printJobCallHandle);
                            }
                        }
                    }
                }
            }

            if (null == jrlist || jrlist.size() == 0) {
                if ("ajaxhtml".equals(viewtype)) {
                    ajaxResultMap.put("flag", false);
                    ajaxResultMap.put("msg", "抱歉，未能找到相关打印单据");
                    addJSONObject(ajaxResultMap);
                    return SUCCESS;
                } else {
                    return null;
                }
            }
            if (!isview) {
                if (printIdList.size() > 0) {
                    String[] printarr = (String[]) printIdList.toArray(new String[printIdList.size()]);
                    if (null != printarr) {
                        canprintIds = StringUtils.join(printarr, ",");
                    }
                }
                StringBuilder printLogsb = new StringBuilder();
                printLogsb.append("打印申请：");
                printLogsb.append(" 代配送编号： " + canprintIds);
                printLogsb.append(" 。");
                printLogsb.append(" 操作名称： 代配送出库单打印。");
                addPrintLogInfo("PrintHandle-DeliveryOutOrder", printLogsb.toString(), null);
            }

            //输出打印报表
            if ("ajaxhtml".equals(viewtype)) {
                List<Map<String, Object>> renderResult = JasperReportUtils.renderJasperReportForAjax(jrlist, isview, viewtype, printJob.getId());
                boolean resultFlag = false;
                if (null != renderResult && renderResult.size() > 0) {
                    resultFlag = true;
                }
                ajaxResultMap.put("flag", resultFlag);
                ajaxResultMap.put("printdata", renderResult);
                ajaxResultMap.put("msg", "获取数据成功");
                if (printTempletSettingFistMap != null) {
                    ajaxResultMap.put("showpagesize", true);
                    ajaxResultMap.put("paperwidth", printTempletSettingFistMap.get("paperwidth"));
                    ajaxResultMap.put("paperheight", printTempletSettingFistMap.get("paperheight"));
                    ajaxResultMap.put("paperintwidth", printTempletSettingFistMap.get("paperintwidth"));
                    ajaxResultMap.put("paperintheight", printTempletSettingFistMap.get("paperintheight"));
                    ajaxResultMap.put("papersizename", printTempletSettingFistMap.get("papersizename"));
                    ajaxResultMap.put("lodophtmlmodel", printTempletSettingFistMap.get("lodophtmlmodel"));
                }
                addJSONObject(ajaxResultMap);

                jrlist = null;
                list = null;

                return SUCCESS;
            } else {
                Map<String, Object> reportMap = new HashMap<String, Object>();
                reportMap.put("response", response);
                reportMap.put("jreportList", jrlist);
                reportMap.put("isview", isview);
                reportMap.put("viewtype", viewtype);
                reportMap.put("PDFOWNERPASSWORD", getSysParamValue("PDFOWNERPASSWORD"));
                JasperReportUtils.renderJasperReport(reportMap);
            }

        } catch (Exception ex) {
            StringBuilder printLogsb = new StringBuilder();
            if (!isview) {
                printLogsb.append("打印申请-代配送出库单打印：");
                printLogsb.append("代配送入库单编号： " + canprintIds);
                printLogsb.append(" 。");
            } else {
                printLogsb.append("打印预览申请-代配送出库单预览：");
            }
            printLogsb.append("Exception ：DeliveryEnterOrder()>>>>>>>>>>>>>>>>异常信息： " + ex.getMessage());
            addPrintLogInfo("PrintHandle-DeliveryEnterOrder", printLogsb.toString(), null);
            logger.error("代配送出库单打印及预览处理异常", ex);


            if ("ajaxhtml".equals(viewtype)) {
                ajaxResultMap.put("flag", false);
                ajaxResultMap.put("msg", "抱歉，获取打印数据异常");
                addJSONObject(ajaxResultMap);
            }
        }
        if ("ajaxhtml".equals(viewtype)) {
            return SUCCESS;
        } else {
            return null;
        }
    }


    /**
     * 代配送入库打印打印回调（更新打印次数）
     * @param printcallback
     * @return void
     * @throws
     * @author zhanghonghui
     * @date Nov 08, 2016
     */
    private void deliveryEnterPrintCallBackHandle(String printcallback) throws Exception {
        String idarrs = request.getParameter("idarrs");
        if (null == idarrs) {
            idarrs = "";
        }
        StringBuilder printLogsb = new StringBuilder();
        printLogsb.append("更新打印次数：");
        if (null == printcallback || "".equals(printcallback)) {
            printLogsb.append("更新打印次数失败：回调参数为空");
            printLogsb.append(" 。");
            addPrintLogInfo("PrintCallBackHandle-DeliveryOut", printLogsb.toString(), null);
            response.reset();
            response.setCharacterEncoding("utf-8");
            response.getWriter().write("failure");
            return;
        }
        Map map = JSONUtils.jsonStrToMap(printcallback);
        if (null == map) {
            printLogsb.append("更新打印次数失败：回调参数转成Map时为空");
            printLogsb.append(" 。");
            addPrintLogInfo("DeliveryCallBackHandle-Delivery", printLogsb.toString(), null);
            response.reset();
            response.setCharacterEncoding("utf-8");
            response.getWriter().write("failure");
            return;
        }
        String id = (String) map.get("id");
        if (null != id && !"".equals(id.trim())) {
            printLogsb.append("申请打印的代配送入库单编号：" + idarrs);
            printLogsb.append(" 。");
            printLogsb.append("代配送入库单编号： " + id);
            try {
                StorageDeliveryEnter enter = distributeRejectService.getDistributeRejectEnterById(id);
                if (null != enter) {
                    distributeRejectService.updateOrderPrinttimes(enter.getId());
                    printLogsb.append(" 更新打印次数成功");
                } else {
                    printLogsb.append(" 更新打印次数失败");
                }
            } catch (Exception ex) {
                printLogsb.append(" 更新打印次数失败。");
                printLogsb.append(" 异常信息：" + ex.getMessage());
            }
        } else {
            printLogsb.append(" 。");
            printLogsb.append("回调参数中无代配送入库单编号信息");
        }
        printLogsb.append(" 。");
        printLogsb.append(" 更新响应来源于： 代配送入库单打印。");
        printLogsb.append(" 打印数据来源(代配送入库单编号)：");
        printLogsb.append(idarrs);
        printLogsb.append(" 。");
        addPrintLogInfo("PrintCallBackHandle-DeliveryOut", printLogsb.toString(), null);
        response.reset();
        response.setCharacterEncoding("utf-8");
        response.getWriter().write("ok");
    }

    /**
     * 代配送入库打印反射形式打印回调（更新打印次数）
     * @param printcallback
     * @return void
     * @throws
     * @author zhanghonghui
     * @date Nov 08, 2016
     */
    public boolean deliveryEnterPrintReflectCallBackHandle(String printcallback) throws Exception {
        boolean isok = false;
        StringBuilder printLogsb = new StringBuilder();
        printLogsb.append("更新打印次数：");
        if (null == printcallback || "".equals(printcallback)) {
            printLogsb.append("更新打印次数失败：回调参数为空");
            printLogsb.append(" 。");
            addPrintLogInfo("PrintCallBackHandle-DeliveryOut", printLogsb.toString(), null);
            return isok;
        }
        Map map = JSONUtils.jsonStrToMap(printcallback);
        if (null == map) {
            printLogsb.append("更新打印次数失败：回调参数转成Map时为空");
            printLogsb.append(" 。");
            addPrintLogInfo("DeliveryCallBackHandle-Delivery", printLogsb.toString(), null);
            return isok;
        }
        String id = (String) map.get("id");
        if (null != id && !"".equals(id.trim())) {
            printLogsb.append("代配送入库单编号： " + id);
            try {
                StorageDeliveryEnter enter = distributeRejectService.getDistributeRejectEnterById(id);
                if (null != enter) {
                    distributeRejectService.updateOrderPrinttimes(enter.getId());
                    printLogsb.append(" 更新打印次数成功");
                    isok = true;
                } else {
                    printLogsb.append(" 更新打印次数失败");
                }
            } catch (Exception ex) {
                printLogsb.append(" 更新打印次数失败。");
                printLogsb.append(" 异常信息：" + ex.getMessage());
                isok = false;
            }
        } else {
            printLogsb.append(" 。");
            printLogsb.append("回调参数中无代配送入库单编号信息");
        }
        printLogsb.append(" 。");
        addPrintLogInfo("PrintCallBackHandle-DeliveryOut", printLogsb.toString(), null);
        return isok;
    }

    /**
     * 代配送出库打印打印回调（更新打印次数）
     * @param printcallback
     * @return void
     * @throws
     * @author zhanghonghui
     * @date Nov 08, 2016
     */
    public void deliveryOutPrintCallBackHandle(String printcallback) throws Exception {
        String idarrs = request.getParameter("idarrs");
        if (null == idarrs) {
            idarrs = "";
        }
        StringBuilder printLogsb = new StringBuilder();
        printLogsb.append("更新打印次数：");
        if (null == printcallback || "".equals(printcallback)) {
            printLogsb.append("更新打印次数失败：回调参数为空");
            printLogsb.append(" 。");
            addPrintLogInfo("PrintCallBackHandle-buyOrder", printLogsb.toString(), null);
            response.reset();
            response.setCharacterEncoding("utf-8");
            response.getWriter().write("failure");
            return;
        }
        Map map = JSONUtils.jsonStrToMap(printcallback);
        if (null == map) {
            printLogsb.append("更新打印次数失败：回调参数转成Map时为空");
            printLogsb.append(" 。");
            addPrintLogInfo("DeliveryCallBackHandle-Delivery", printLogsb.toString(), null);
            response.reset();
            response.setCharacterEncoding("utf-8");
            response.getWriter().write("failure");
            return;
        }
        String id = (String) map.get("id");
        if (null != id && !"".equals(id.trim())) {
            printLogsb.append("申请打印的代配送出库单编号：" + idarrs);
            printLogsb.append(" 。");
            printLogsb.append("代配送出库单编号： " + id);
            try {
                StorageDeliveryOut out = deliveryOutService.getStorageDeliveryOutById(id);
                if (null != out) {
                    deliveryOutService.updateOrderPrinttimes(out.getId());
                    printLogsb.append(" 更新打印次数成功");
                } else {
                    printLogsb.append(" 更新打印次数失败");
                }
            } catch (Exception ex) {
                printLogsb.append(" 更新打印次数失败。");
                printLogsb.append(" 异常信息：" + ex.getMessage());
            }
        } else {
            printLogsb.append(" 。");
            printLogsb.append("回调参数中无代配送编号信息");
        }
        printLogsb.append(" 。");
        printLogsb.append(" 更新响应来源于： 代配送出库打印。");
        printLogsb.append(" 打印数据来源(代配送出库单编号)：");
        printLogsb.append(idarrs);
        printLogsb.append(" 。");
        addPrintLogInfo("PrintCallBackHandle-DeliveryOut", printLogsb.toString(), null);
        response.reset();
        response.setCharacterEncoding("utf-8");
        response.getWriter().write("ok");

    }


    /**
     * 代配送出库打印形式打印回调（更新打印次数）
     * @param printcallback
     * @return void
     * @throws
     * @author zhanghonghui
     * @date Nov 08, 2016
     */
    public boolean deliveryOutPrintReflectCallBackHandle(String printcallback) throws Exception {
        boolean isok = false;
        StringBuilder printLogsb = new StringBuilder();
        printLogsb.append("更新打印次数：");
        if (null == printcallback || "".equals(printcallback)) {
            printLogsb.append("更新打印次数失败：回调参数为空");
            printLogsb.append(" 。");
            addPrintLogInfo("PrintCallBackHandle-buyOrder", printLogsb.toString(), null);
            return isok;
        }
        Map map = JSONUtils.jsonStrToMap(printcallback);
        if (null == map) {
            printLogsb.append("更新打印次数失败：回调参数转成Map时为空");
            printLogsb.append(" 。");
            addPrintLogInfo("DeliveryCallBackHandle-Delivery", printLogsb.toString(), null);
            return isok;
        }
        String id = (String) map.get("id");
        if (null != id && !"".equals(id.trim())) {
            printLogsb.append("代配送出库单编号： " + id);
            try {
                StorageDeliveryOut out = deliveryOutService.getStorageDeliveryOutById(id);
                if (null != out) {
                    deliveryOutService.updateOrderPrinttimes(out.getId());
                    printLogsb.append(" 更新打印次数成功");
                    isok = true;
                } else {
                    printLogsb.append(" 更新打印次数失败");
                }
            } catch (Exception ex) {
                printLogsb.append(" 更新打印次数失败。");
                printLogsb.append(" 异常信息：" + ex.getMessage());
            }
        } else {
            printLogsb.append(" 。");
            printLogsb.append("回调参数中无代配送编号信息");
        }
        printLogsb.append(" 。");
        addPrintLogInfo("PrintCallBackHandle-DeliveryOut", printLogsb.toString(), null);
        return isok;
    }

}

