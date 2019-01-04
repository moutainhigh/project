package com.hd.agent.journalsheet.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import org.apache.struts2.json.annotations.JSON;

public class CapitalInput implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 编码
     */
    private String id;

    /**
     * 业务日期
     */
    private String businessdate;

    /**
     * 备注
     */
    private String remark;

    /**
     * 供应商编码
     */
    private String supplierid;

    /**
     * 供应商名称
     */
    private String suppliername;

    /**
     * 供应商所属部门编码
     */
    private String supplierdeptid;
    
    /**
     * 供应商所属部门名称
     */
    private String supplierdeptName;

    /**
     * 科目编码
     */
    private String subjectid;

    /**
     * 科目名称
     */
    private String subjectname;

    /**
     * 科目费用
     */
    private BigDecimal subjectexpenses;

    /**
     * 制单人编码
     */
    private String adduserid;

    /**
     * 制单人
     */
    private String addusername;

    /**
     * 制单日期
     */
    private Date addtime;
    
    /**
     * 预付金额
     */
    private BigDecimal advanceprice;
    
    /**
     * 库存金额
     */
    private BigDecimal stockprice;
    
    /**
     * 应收金额
     */
    private BigDecimal receiveprice;
    
    /**
     * 代垫金额
     */
    private BigDecimal actingprice;
    
    /**
     * 应付金额
     */
    private BigDecimal payprice;

    /**
     * @return 编码
     */
    public String getId() {
        return id;
    }

    /**
     * @param id 
	 *            编码
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
     * @return 备注
     */
    public String getRemark() {
        return remark;
    }

    /**
     * @param remark 
	 *            备注
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /**
     * @return 供应商编码
     */
    public String getSupplierid() {
        return supplierid;
    }

    /**
     * @param supplierid 
	 *            供应商编码
     */
    public void setSupplierid(String supplierid) {
        this.supplierid = supplierid == null ? null : supplierid.trim();
    }

    /**
     * @return 供应商名称
     */
    public String getSuppliername() {
        return suppliername;
    }

    /**
     * @param suppliername 
	 *            供应商名称
     */
    public void setSuppliername(String suppliername) {
        this.suppliername = suppliername == null ? null : suppliername.trim();
    }

    /**
     * @return 供应商所属部门编码
     */
    public String getSupplierdeptid() {
        return supplierdeptid;
    }

    /**
     * @param supplierdeptid 
	 *            供应商所属部门编码
     */
    public void setSupplierdeptid(String supplierdeptid) {
        this.supplierdeptid = supplierdeptid == null ? null : supplierdeptid.trim();
    }

    /**
     * @return 科目编码
     */
    public String getSubjectid() {
        return subjectid;
    }

    /**
     * @param subjectid 
	 *            科目编码
     */
    public void setSubjectid(String subjectid) {
        this.subjectid = subjectid == null ? null : subjectid.trim();
    }

    /**
     * @return 科目名称
     */
    public String getSubjectname() {
        return subjectname;
    }

    /**
     * @param subjectname 
	 *            科目名称
     */
    public void setSubjectname(String subjectname) {
        this.subjectname = subjectname == null ? null : subjectname.trim();
    }

    /**
     * @return 科目费用
     */
    public BigDecimal getSubjectexpenses() {
        return subjectexpenses;
    }

    /**
     * @param subjectexpenses 
	 *            科目费用
     */
    public void setSubjectexpenses(BigDecimal subjectexpenses) {
        this.subjectexpenses = subjectexpenses;
    }

    /**
     * @return 制单人编码
     */
    @JSON(format="yyyy-MM-dd HH:mm:ss")
    public String getAdduserid() {
        return adduserid;
    }

    /**
     * @param adduserid 
	 *            制单人编码
     */
    public void setAdduserid(String adduserid) {
        this.adduserid = adduserid == null ? null : adduserid.trim();
    }

    /**
     * @return 制单人
     */
    public String getAddusername() {
        return addusername;
    }

    /**
     * @param addusername 
	 *            制单人
     */
    public void setAddusername(String addusername) {
        this.addusername = addusername == null ? null : addusername.trim();
    }

    /**
     * @return 制单日期
     */
    public Date getAddtime() {
        return addtime;
    }

    /**
     * @param addtime 
	 *            制单日期
     */
    public void setAddtime(Date addtime) {
        this.addtime = addtime;
    }

	public BigDecimal getAdvanceprice() {
		return advanceprice;
	}

	public void setAdvanceprice(BigDecimal advanceprice) {
		this.advanceprice = advanceprice;
	}

	public BigDecimal getStockprice() {
		return stockprice;
	}

	public void setStockprice(BigDecimal stockprice) {
		this.stockprice = stockprice;
	}

	public BigDecimal getReceiveprice() {
		return receiveprice;
	}

	public void setReceiveprice(BigDecimal receiveprice) {
		this.receiveprice = receiveprice;
	}

	public BigDecimal getActingprice() {
		return actingprice;
	}

	public void setActingprice(BigDecimal actingprice) {
		this.actingprice = actingprice;
	}

	public BigDecimal getPayprice() {
		return payprice;
	}

	public void setPayprice(BigDecimal payprice) {
		this.payprice = payprice;
	}

	public String getSupplierdeptName() {
		return supplierdeptName;
	}

	public void setSupplierdeptName(String supplierdeptName) {
		this.supplierdeptName = supplierdeptName;
	}
    
    
}