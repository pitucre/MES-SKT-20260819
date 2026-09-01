using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
   public class ERPMOBOMInfo
    {
       private string moCode;//工单号
       private int rowno;//单身项次
       private decimal busType;//工单类型
       private int allocateId;// 生产订单子件明细
       private int moId;//工单Id
       private string mDeptCode;//生产部门编码
       private string mDeptName;//生产部门名称  
       private string invCode;//物料编码
       private string invName;//物料名称
       private string comUnitCode;//单
       private string whCode;//仓库编码
       private string whName;//仓库名称
       private string vouchCode;//货位编码
       private string vouchName;//货位名称
       private decimal qty;//工单应发数量
       private decimal requisitionIssQty;//申请已领量
       private decimal issQty;//已领量
       private decimal compScrap;//损耗率
       private string batch;//批号
       private string rSortSeq;//工段号
       private string sortSeq;//工序号
       private DateTime createDate;//创建日期
       private DateTime modifyDate;//修改日期
       private DateTime pubufts;//时间戳
       private int state;//状态(0新增、1修改、2删除 9已传MES、)
       private string state_cn;
       private string workSeq;
       private int mOBomId;//用料明细Id
       private double bomInputAuxQty;
       private double auxQtyPick;
       private double auxQtyMust;
       private int itemId;
       private int status;


       public ERPMOBOMInfo()
       {

       }

       /// <summary>
       /// 工单号
       /// </summary>
       public string MoCode
       {
           get { return this.moCode; }
           set { this.moCode = value; }
       }

       /// <summary>
       /// 单身项次
       /// </summary>
       public int Rowno
       {
           get { return this.rowno; }
           set { this.rowno = value; }
       }


       /// <summary>
       /// 工单类型
       /// </summary>
       public decimal BusType
       {
           get { return this.busType; }
           set { this.busType = value; }
       }

       /// <summary>
       /// 生产订单子件明细
       /// </summary>
       public int AllocateId
       {
           get { return this.allocateId; }
           set { this.allocateId = value; }
       }

       /// <summary>
       /// 工单Id
       /// </summary>
       public int MoId
       {
           get { return this.moId; }
           set { this.moId = value; }
       }


       /// <summary>
       /// 生产部门编码
       /// </summary>
       public string MDeptCode
       {
           get { return this.mDeptCode; }
           set { this.mDeptCode = value; }
       }

       /// <summary>
       /// 生产部门名称
       /// </summary>
       public string MDeptName
       {
           get { return this.mDeptName; }
           set { this.mDeptName = value; }
       }
       /// <summary>
       /// 物料编码
       /// </summary>
       public string InvCode
       {
           get { return this.invCode; }
           set { this.invCode = value; }
       }

       /// <summary>
       /// 物料名称
       /// </summary>
       public string InvName
       {
           get { return this.invName; }
           set { this.invName = value; }
       }

       /// <summary>
       /// 单
       /// </summary>
       public string ComUnitCode
       {
           get { return this.comUnitCode; }
           set { this.comUnitCode = value; }
       }
       /// <summary>
       ///仓库编码
       /// </summary>
       public string WhCode
       {
           get { return this.whCode; }
           set { this.whCode = value; }
       }
       /// <summary>
       /// 仓库名称
       /// </summary>
       public string WhName
       {
           get { return this.whName; }
           set { this.whName = value; }
       }

       /// <summary>
       /// 货位编码
       /// </summary>
       public string VouchCode
       {
           get { return this.vouchCode; }
           set { this.vouchCode = value; }
       }
       /// <summary>
       /// 货位名称
       /// </summary>
       public string VouchName
       {
           get { return this.vouchName; }
           set { this.vouchName = value; }
       }

       /// <summary>
       /// 工单应发数量
       /// </summary>
       public decimal Qty
       {
           get { return this.qty; }
           set { this.qty = value; }
       }

       /// <summary>
       /// 申请已领量
       /// </summary>
       public decimal RequisitionIssQty
       {
           get { return this.requisitionIssQty; }
           set { this.requisitionIssQty = value; }
       }

       /// <summary>
       /// 已领量
       /// </summary>
       public decimal IssQty
       {
           get { return this.issQty; }
           set { this.issQty = value; }
       }
       /// <summary>
       /// 损耗率
       /// </summary>
       public decimal CompScrap
       {
           get { return this.compScrap; }
           set { this.compScrap = value; }
       }

       /// <summary>
       /// 批号
       /// </summary>
       public string Batch
       {
           get { return this.batch; }
           set { this.batch = value; }
       }


       /// <summary>
       /// 工段号
       /// </summary>
       public string RSortSeq
       {
           get { return this.rSortSeq; }
           set { this.rSortSeq = value; }
       }

       /// <summary>
       /// 货位名称
       /// </summary>
       public string SortSeq
       {
           get { return this.sortSeq; }
           set { this.sortSeq = value; }
       }

       /// <summary>
       /// 创建日期
       /// </summary>
       public DateTime CreateDate
       {
           get { return this.createDate; }
           set { this.createDate = value; }
       }

       /// <summary>
       /// 修改日期
       /// </summary>
       public DateTime ModifyDate
       {
           get { return this.modifyDate; }
           set { this.modifyDate = value; }
       }

       /// <summary>
       /// 时间戳
       /// </summary>
       public DateTime Pubufts
       {
           get { return this.pubufts; }
           set { this.pubufts = value; }
       }

       /// <summary>
       /// //状态(0新增、1修改、2删除 9已传MES、)
       /// </summary>
       public int State
       {
           get { return this.state; }
           set { this.state = value; }
       }

       
       /// <summary>
       /// 状态
       /// </summary>
       public string State_cn
       {
           get { return this.state_cn; }
           set { this.state_cn = value; }
       }

      

       /// <summary>
       /// WorkSeq
       /// </summary>
       public string WorkSeq
       {
           get { return this.workSeq; }
           set { this.workSeq = value; }
       }


       /// <summary>
       /// 用料明细Id
       /// </summary>
       public int MOBomId
       {
           get { return this.mOBomId; }
           set { this.mOBomId = value; }
       }

       /// <summary>
       /// 用料明细Id
       /// </summary>
       public double BomInputAuxQty
       {
           get { return this.bomInputAuxQty; }
           set { this.bomInputAuxQty = value; }
       }

       /// <summary>
       /// 
       /// </summary>
       public double AuxQtyPick
       {
           get {  return this.auxQtyPick; }
           set { this.auxQtyPick = value; }
       }
       /// <summary>
       /// 
       /// </summary>
       public double AuxQtyMust
       {
           get { return this.auxQtyMust; }
           set { this.auxQtyMust = value; }
       }

       /// <summary>
       /// ItemId
       /// </summary>
       public int ItemId
       {
           get { return this.itemId; }
           set { this.itemId = value; }
       }

       /// <summary>
       /// status
       /// </summary>
       public int Status
       {
           get { return this.status; }
           set { this.status = value; }
       }

    }
}
