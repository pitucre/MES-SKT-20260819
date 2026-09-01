using System;

namespace SKT.LeanMES.Material.Model
{
    /// <summary>
    /// add by peter.wang 2016-1-20
    /// 临时类 为显示DEMO 用后可删除 完工申报单
    /// </summary> 
    [Serializable]
    public class CompleteOrderInfo
    {
       private Int32 iD;
       private Int64 dispatchId;      //派工单ID
       private String completeOrder;  //完工申报单号
       private String dispatchNo;     //派工单Name

       private DateTime actualStartDate; 
       private DateTime actualEndDate;

       private DateTime planStartDate;
       private DateTime planEndDate;

       private String operation;       //工序
       private String goalOperation;   //目的工序
       private String operatinDesc;     //工序描述

       private Decimal dispatchQty; //派工数量
       private Decimal completeQty; //完工数量

       private String createBy;
       private DateTime createDateTime;

       private Int32 workHouse;

       /// <summary>
       /// ID
       /// </summary>
       public Int32 ID
       {
           get { return this.iD; }
           set { this.iD = value; }
       }
       /// <summary>
       /// 派工单ID
       /// </summary>
       public Int64 DispatchId
       {
           get { return this.dispatchId; }
           set { this.dispatchId = value; }
       }
       /// <summary>
       /// 完工申报单号
       /// </summary>
       public String CompleteOrder
       {
           get { return this.completeOrder; }
           set { this.completeOrder = value; }
       }

       /// <summary>
       /// 派工单Name
       /// </summary>
       public String DispatchNo
       {
           get { return this.dispatchNo; }
           set { this.dispatchNo = value; }
       }

       /// <summary>
       /// 获取或设置
       /// </summary>
       public DateTime ActualStartDate
       {
           get { return this.actualStartDate; }
           set { this.actualStartDate = value; }
       }

       public string ActualStartDateStr
       {
           get { return this.ActualStartDate.ToShortDateString(); }
       }


       /// <summary>
       /// 获取或设置
       /// </summary>
       public DateTime ActualEndDate
       {
           get { return this.actualEndDate; }
           set { this.actualEndDate = value; }
       }

       public string ActualEndDateStr
       {
           get { return this.ActualEndDate.ToShortDateString(); }
       }

       /// <summary>
       /// 获取或设置
       /// </summary>
       public DateTime PlanStartDate
       {
           get { return this.planStartDate; }
           set { this.planStartDate = value; }
       }

       public string PlanStartDateStr
       {
           get { return this.PlanStartDate.ToShortDateString(); }
       }

       /// <summary>
       /// 获取或设置
       /// </summary>
       public DateTime PlanEndDate
       {
           get { return this.planEndDate; }
           set { this.planEndDate = value; }
       }

       public string PlanEndDateStr
       {
           get { return this.planEndDate.ToShortDateString(); }
       }

       /// <summary>
       /// 工序
       /// </summary>
       public String Operation
       {
           get { return this.operation; }
           set { this.operation = value; }
       }
       /// <summary>
       /// 工序描述
       /// </summary>
       public String OperatinDesc
       {
           get { return this.operatinDesc; }
           set { this.operatinDesc = value; }
       }
        

       /// <summary>
       /// 工序
       /// </summary>
       public String GoalOperation
       {
           get { return this.goalOperation; }
           set { this.goalOperation = value; }
       }

       /// <summary>
       /// 派工数量
       /// </summary>
       public Decimal DispatchQty
       {
           get { return this.dispatchQty; }
           set { this.dispatchQty = value; }
       }

       /// <summary>
       /// 派工数量
       /// </summary>
       public Decimal CompleteQty
       {
           get { return this.completeQty; }
           set { this.completeQty = value; }
       }

       /// <summary>
       /// 获取或设置
       /// </summary>
       public String CreateBy
       {
           get { return this.createBy; }
           set { this.createBy = value; }
       }

       /// <summary>
       /// 获取或设置
       /// </summary>
       public DateTime CreateDateTime
       {
           get { return this.createDateTime; }
           set { this.createDateTime = value; }
       }
       public string CreateDateTimeStr
       {
           get { return this.CreateDateTime.ToShortDateString(); }
       }

       public Int32 WorkHouse
       {
           get { return this.workHouse; }
           set { this.workHouse = value; }
       }
    }
}
