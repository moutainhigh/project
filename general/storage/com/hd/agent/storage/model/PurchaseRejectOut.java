package com.hd.agent.storage.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.apache.struts2.json.annotations.JSON;

import com.hd.agent.basefiles.model.BuySupplier;
/**
 * 采购退货出库单
 * @author chenwei
 */
public class PurchaseRejectOut implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 编号
     */
    private String id;

    /**
     * 业务日期
     */
    private String businessdate;

    /**
     * 状态:0新增1暂存2保存3审核4关闭5中止
     */
    private String status;
    
    /**
     * 状态名称
     */
    private String statusname;

    /**
     * 备注(表头)
     */
    private String remark;

    /**
     * 制单人用户编号
     */
    private String adduserid;

    /**
     * 制单人用户名称
     */
    private String addusername;

    /**
     * 制单人部门编号
     */
    private String adddeptid;

    /**
     * 制单人部门名称
     */
    private String adddeptname;

    /**
     * 制单时间
     */
    private Date addtime;

    /**
     * 修改人用户编号
     */
    private String modifyuserid;

    /**
     * 修改人姓名
     */
    private String modifyusername;

    /**
     * 修改时间
     */
    private Date modifytime;

    /**
     * 审核人用户编号
     */
    private String audituserid;

    /**
     * 审核人用户名称
     */
    private String auditusername;

    /**
     * 审核时间
     */
    private Date audittime;

    /**
     * 中止人用户编号
     */
    private String stopuserid;

    /**
     * 中止人用户姓名
     */
    private String stopusername;

    /**
     * 中止时间
     */
    private Date stoptime;

    /**
     * 关闭时间
     */
    private Date closetime;

    /**
     * 打印次数
     */
    private Integer printtimes;

    /**
     * 供应商编号
     */
    private String supplierid;
    /**
     * 供应商名称
     */
    private String suppliername;
    /**
     * 供应商
     */
    private BuySupplier buySupplierInfo;
    /**
     * 对方经手人
     */
    private String handlerid;
    /**
     * 对方经手人名称
     */
    private String handlername;
    /**
     * 采购部门编号
     */
    private String buydeptid;
    /**
     * 采购部门名称
     */
    private String buydeptname;
    /**
     * 采购人员编号
     */
    private String buyuserid;
    /**
     * 采购人员名称
     */
    private String buyusername;
    /**
     * 结算方式
     */
    private String settletype;

    /**
     * 支付方式
     */
    private String paytype;

    /**
     * 退货仓库
     */
    private String storageid;
    /**
     * 仓库名称
     */
    private String storagename;
    /**
     * 来源类型,1采购退货通知单，0无
     */
    private String sourcetype;
    
    /**
     * 来源类型名称
     */
    private String sourcetypename;

    /**
     * 来源单据编号
     */
    private String sourceid;

    /**
     * 表头自定义项1
     */
    private String field01;

    /**
     * 表头自定义项2
     */
    private String field02;

    /**
     * 表头自定义项3
     */
    private String field03;

    /**
     * 表头自定义项4
     */
    private String field04;

    /**
     * 表头自定义项5
     */
    private String field05;

    /**
     * 表头自定义项6
     */
    private String field06;

    /**
     * 表头自定义项7
     */
    private String field07;

    /**
     * 表头自定义项8
     */
    private String field08;

    /**
     * 是否被参照0未参照1已参照
     */
    private String isrefer;
    /**
     * 含税金额
     */
    private BigDecimal taxamount;
    /**
     * 未税金额
     */
    private BigDecimal notaxamount;

    /**
     * 明细列表
     */
    List<PurchaseRejectOutDetail> billDetailList ;
    
    /**
     * 打印提示
     */
    private String printtip;
    /**
     * 是否验收1是0否
     */
    private String ischeck;

    /**
     * 验收人编号
     */
    private String checkuserid;
    /**
     * 验收人姓名
     */
    private String checkusername;
    /**
     * 回单验收日期
     */
    private String checkdate;
    /**
     * 生成凭证次数
     */
    private Integer vouchertimes;

    /**
     * @return 编号
     */
    public String getId() {
        return id;
    }

    /**
     * @param id 
	 *            编号
     */
    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    /**
     * @return 业务日期
     */
    public String getBusinessdate() {
        return businessdate;
    }

    /**
     * @param businessdate 
	 *            业务日期
     */
    public void setBusinessdate(String businessdate) {
        this.businessdate = businessdate == null ? null : businessdate.trim();
    }

    /**
     * @return 状态:0新增1暂存2保存3审核4关闭5中止
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status 
	 *            状态:0新增1暂存2保存3审核4关闭5中止
     */
    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    /**
     * @return 备注(表头)
     */
    public String getRemark() {
        return remark;
    }

    /**
     * @param remark 
	 *            备注(表头)
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /**
     * @return 制单人用户编号
     */
    public String getAdduserid() {
        return adduserid;
    }

    /**
     * @param adduserid 
	 *            制单人用户编号
     */
    public void setAdduserid(String adduserid) {
        this.adduserid = adduserid == null ? null : adduserid.trim();
    }

    /**
     * @return 制单人用户名称
     */
    public String getAddusername() {
        return addusername;
    }

    /**
     * @param addusername 
	 *            制单人用户名称
     */
    public void setAddusername(String addusername) {
        this.addusername = addusername == null ? null : addusername.trim();
    }

    /**
     * @return 制单人部门编号
     */
    public String getAdddeptid() {
        return adddeptid;
    }

    /**
     * @param adddeptid 
	 *            制单人部门编号
     */
    public void setAdddeptid(String adddeptid) {
        this.adddeptid = adddeptid == null ? null : adddeptid.trim();
    }

    /**
     * @return 制单人部门名称
     */
    public String getAdddeptname() {
        return adddeptname;
    }

    /**
     * @param adddeptname 
	 *            制单人部门名称
     */
    public void setAdddeptname(String adddeptname) {
        this.adddeptname = adddeptname == null ? null : adddeptname.trim();
    }

    /**
     * @return 制单时间
     */
    @JSON(format="yyyy-MM-dd HH:mm:ss")
    public Date getAddtime() {
        return addtime;
    }

    /**
     * @param addtime 
	 *            制单时间
     */
    public void setAddtime(Date addtime) {
        this.addtime = addtime;
    }

    /**
     * @return 修改人用户编号
     */
    public String getModifyuserid() {
        return modifyuserid;
    }

    /**
     * @param modifyuserid 
	 *            修改人用户编号
     */
    public void setModifyuserid(String modifyuserid) {
        this.modifyuserid = modifyuserid == null ? null : modifyuserid.trim();
    }

    /**
     * @return 修改人姓名
     */
    public String getModifyusername() {
        return modifyusername;
    }

    /**
     * @param modifyusername 
	 *            修改人姓名
     */
    public void setModifyusername(String modifyusername) {
        this.modifyusername = modifyusername == null ? null : modifyusername.trim();
    }

    /**
     * @return 修改时间
     */
    @JSON(format="yyyy-MM-dd HH:mm:ss")
    public Date getModifytime() {
        return modifytime;
    }

    /**
     * @param modifytime 
	 *            修改时间
     */
    public void setModifytime(Date modifytime) {
        this.modifytime = modifytime;
    }

    /**
     * @return 审核人用户编号
     */
    public String getAudituserid() {
        return audituserid;
    }

    /**
     * @param audituserid 
	 *            审核人用户编号
     */
    public void setAudituserid(String audituserid) {
        this.audituserid = audituserid == null ? null : audituserid.trim();
    }

    /**
     * @return 审核人用户名称
     */
    public String getAuditusername() {
        return auditusername;
    }

    /**
     * @param auditusername 
	 *            审核人用户名称
     */
    public void setAuditusername(String auditusername) {
        this.auditusername = auditusername == null ? null : auditusername.trim();
    }

    /**
     * @return 审核时间
     */
    @JSON(format="yyyy-MM-dd HH:mm:ss")
    public Date getAudittime() {
        return audittime;
    }

    /**
     * @param audittime 
	 *            审核时间
     */
    public void setAudittime(Date audittime) {
        this.audittime = audittime;
    }

    /**
     * @return 中止人用户编号
     */
    public String getStopuserid() {
        return stopuserid;
    }

    /**
     * @param stopuserid 
	 *            中止人用户编号
     */
    public void setStopuserid(String stopuserid) {
        this.stopuserid = stopuserid == null ? null : stopuserid.trim();
    }

    /**
     * @return 中止人用户姓名
     */
    public String getStopusername() {
        return stopusername;
    }

    /**
     * @param stopusername 
	 *            中止人用户姓名
     */
    public void setStopusername(String stopusername) {
        this.stopusername = stopusername == null ? null : stopusername.trim();
    }

    /**
     * @return 中止时间
     */
    @JSON(format="yyyy-MM-dd HH:mm:ss")
    public Date getStoptime() {
        return stoptime;
    }

    /**
     * @param stoptime 
	 *            中止时间
     */
    public void setStoptime(Date stoptime) {
        this.stoptime = stoptime;
    }

    /**
     * @return 关闭时间
     */
    @JSON(format="yyyy-MM-dd HH:mm:ss")
    public Date getClosetime() {
        return closetime;
    }

    /**
     * @param closetime 
	 *            关闭时间
     */
    public void setClosetime(Date closetime) {
        this.closetime = closetime;
    }

    /**
     * @return 打印次数
     */
    public Integer getPrinttimes() {
        return printtimes;
    }

    /**
     * @param printtimes 
	 *            打印次数
     */
    public void setPrinttimes(Integer printtimes) {
        this.printtimes = printtimes;
    }

    /**
     * @return 供应商编号
     */
    public String getSupplierid() {
        return supplierid;
    }

    /**
     * @param supplierid 
	 *            供应商编号
     */
    public void setSupplierid(String supplierid) {
        this.supplierid = supplierid == null ? null : supplierid.trim();
    }

    /**
     * @return 对方经手人
     */
    public String getHandlerid() {
        return handlerid;
    }

    /**
     * @param handlerid 
	 *            对方经手人
     */
    public void setHandlerid(String handlerid) {
        this.handlerid = handlerid == null ? null : handlerid.trim();
    }

    /**
     * @return 采购部门编号
     */
    public String getBuydeptid() {
        return buydeptid;
    }

    /**
     * @param buydeptid 
	 *            采购部门编号
     */
    public void setBuydeptid(String buydeptid) {
        this.buydeptid = buydeptid == null ? null : buydeptid.trim();
    }

    /**
     * @return 采购人员编号
     */
    public String getBuyuserid() {
        return buyuserid;
    }

    /**
     * @param buyuserid 
	 *            采购人员编号
     */
    public void setBuyuserid(String buyuserid) {
        this.buyuserid = buyuserid == null ? null : buyuserid.trim();
    }

    /**
     * @return 结算方式
     */
    public String getSettletype() {
        return settletype;
    }

    /**
     * @param settletype 
	 *            结算方式
     */
    public void setSettletype(String settletype) {
        this.settletype = settletype == null ? null : settletype.trim();
    }

    /**
     * @return 支付方式
     */
    public String getPaytype() {
        return paytype;
    }

    /**
     * @param paytype 
	 *            支付方式
     */
    public void setPaytype(String paytype) {
        this.paytype = paytype == null ? null : paytype.trim();
    }

    /**
     * @return 退货仓库
     */
    public String getStorageid() {
        return storageid;
    }

    /**
     * @param storageid 
	 *            退货仓库
     */
    public void setStorageid(String storageid) {
        this.storageid = storageid == null ? null : storageid.trim();
    }

    /**
     * @return 来源类型,1采购退货通知单，0无
     */
    public String getSourcetype() {
        return sourcetype;
    }

    /**
     * @param sourcetype 
	 *            来源类型,1采购退货通知单，0无
     */
    public void setSourcetype(String sourcetype) {
        this.sourcetype = sourcetype == null ? null : sourcetype.trim();
    }

    /**
     * @return 来源单据编号
     */
    public String getSourceid() {
        return sourceid;
    }

    /**
     * @param sourceid 
	 *            来源单据编号
     */
    public void setSourceid(String sourceid) {
        this.sourceid = sourceid == null ? null : sourceid.trim();
    }

    /**
     * @return 表头自定义项1
     */
    public String getField01() {
        return field01;
    }

    /**
     * @param field01 
	 *            表头自定义项1
     */
    public void setField01(String field01) {
        this.field01 = field01 == null ? null : field01.trim();
    }

    /**
     * @return 表头自定义项2
     */
    public String getField02() {
        return field02;
    }

    /**
     * @param field02 
	 *            表头自定义项2
     */
    public void setField02(String field02) {
        this.field02 = field02 == null ? null : field02.trim();
    }

    /**
     * @return 表头自定义项3
     */
    public String getField03() {
        return field03;
    }

    /**
     * @param field03 
	 *            表头自定义项3
     */
    public void setField03(String field03) {
        this.field03 = field03 == null ? null : field03.trim();
    }

    /**
     * @return 表头自定义项4
     */
    public String getField04() {
        return field04;
    }

    /**
     * @param field04 
	 *            表头自定义项4
     */
    public void setField04(String field04) {
        this.field04 = field04 == null ? null : field04.trim();
    }

    /**
     * @return 表头自定义项5
     */
    public String getField05() {
        return field05;
    }

    /**
     * @param field05 
	 *            表头自定义项5
     */
    public void setField05(String field05) {
        this.field05 = field05 == null ? null : field05.trim();
    }

    /**
     * @return 表头自定义项6
     */
    public String getField06() {
        return field06;
    }

    /**
     * @param field06 
	 *            表头自定义项6
     */
    public void setField06(String field06) {
        this.field06 = field06 == null ? null : field06.trim();
    }

    /**
     * @return 表头自定义项7
     */
    public String getField07() {
        return field07;
    }

    /**
     * @param field07 
	 *            表头自定义项7
     */
    public void setField07(String field07) {
        this.field07 = field07 == null ? null : field07.trim();
    }

    /**
     * @return 表头自定义项8
     */
    public String getField08() {
        return field08;
    }

    /**
     * @param field08 
	 *            表头自定义项8
     */
    public void setField08(String field08) {
        this.field08 = field08 == null ? null : field08.trim();
    }

    /**
     * @return 是否被参照0未参照1已参照
     */
    public String getIsrefer() {
        return isrefer;
    }

    /**
     * @param isrefer 
	 *            是否被参照0未参照1已参照
     */
    public void setIsrefer(String isrefer) {
        this.isrefer = isrefer == null ? null : isrefer.trim();
    }

	public String getSuppliername() {
		return suppliername;
	}

	public void setSuppliername(String suppliername) {
		this.suppliername = suppliername == null ? null : suppliername.trim();
	}

	public String getHandlername() {
		return handlername;
	}

	public void setHandlername(String handlername) {
		this.handlername = handlername == null ? null : handlername.trim();
	}

	public String getBuydeptname() {
		return buydeptname;
	}

	public void setBuydeptname(String buydeptname) {
		this.buydeptname = buydeptname == null ? null : buydeptname.trim();
	}

	public String getBuyusername() {
		return buyusername;
	}

	public void setBuyusername(String buyusername) {
		this.buyusername = buyusername == null ? null : buyusername.trim();
	}

	public String getStoragename() {
		return storagename;
	}

	public void setStoragename(String storagename) {
		this.storagename = storagename == null ? null : storagename.trim();
	}

	public List<PurchaseRejectOutDetail> getBillDetailList() {
		return billDetailList;
	}

	public void setBillDetailList(List<PurchaseRejectOutDetail> billDetailList) {
		this.billDetailList = billDetailList;
	}

	public BuySupplier getBuySupplierInfo() {
		return buySupplierInfo;
	}

	public void setBuySupplierInfo(BuySupplier buySupplierInfo) {
		this.buySupplierInfo = buySupplierInfo;
	}

	public BigDecimal getTaxamount() {
		return taxamount;
	}

	public void setTaxamount(BigDecimal taxamount) {
		this.taxamount = taxamount;
	}

	public BigDecimal getNotaxamount() {
		return notaxamount;
	}

	public void setNotaxamount(BigDecimal notaxamount) {
		this.notaxamount = notaxamount;
	}

	public String getStatusname() {
		return statusname;
	}

	public void setStatusname(String statusname) {
		this.statusname = statusname == null ? null : statusname.trim();
	}

	public String getSourcetypename() {
		return sourcetypename;
	}

	public void setSourcetypename(String sourcetypename) {
		this.sourcetypename = sourcetypename == null ? null : sourcetypename.trim();
	}

	public String getPrinttip() {
		return printtip;
	}

	public void setPrinttip(String printtip) {
		this.printtip = printtip == null ? null : printtip.trim();
	}

	public String getIscheck() {
		return ischeck;
	}

	public void setIscheck(String ischeck) {
		this.ischeck = ischeck == null ? null : ischeck.trim();
	}

	public String getCheckuserid() {
		return checkuserid;
	}

	public void setCheckuserid(String checkuserid) {
		this.checkuserid = checkuserid == null ? null : checkuserid.trim();
	}

	public String getCheckusername() {
		return checkusername;
	}

	public void setCheckusername(String checkusername) {
		this.checkusername = checkusername == null ? null : checkusername.trim();
	}

	public String getCheckdate() {
		return checkdate;
	}

	public void setCheckdate(String checkdate) {
		this.checkdate = checkdate == null ? null : checkdate.trim();
	}

    public Integer getVouchertimes() {
        return vouchertimes;
    }

    public void setVouchertimes(Integer vouchertimes) {
        this.vouchertimes = vouchertimes;
    }
}