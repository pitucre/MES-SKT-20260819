using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class MaterialHistoryInfo
    {
        private Int64 materialHistoryId;
        private Int32 prodOrderId;
        private Int32 linePlanId;
        private Int64 materialUnitId;
        private Int32 lineId;
        private Int32 equipmentId;
        private String equipmentCode;
        private String equipmentName;
        private Int32 sequenceNo;
        private Int32 loadingListId;
        private String loadingListName;
        private String smtTable;
        private String area;
        private String position;
        private String point;
        private Boolean isMain;
        private String mainItemCode;
        private String mainItemName;
        private Int32 smtNum;
        private Boolean isBindFeeder;
        private String feederSN;
        private String feederType;
        private String bindPerson;
        private string bindTime;
        private String unBindPerson;
        private string unBindTime;
        private Decimal loadingQty;
        private String loadingPerson;
        private string loadingTime;
        private Decimal unLoadingQty;
        private String unLoadingPerson;
        private string unLoadingTime;
        private Decimal useQty;
        private Int32 status;
        private String lastOperate;

        public string OrderNO { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string ItemSpec { get; set; }
        public string Actual_Start_Date { get; set; }
        public string Actual_Completed_Date { get; set; }
        public string FBILLNO { get; set; }
        public decimal FQty { get; set; }
        public string FPlanCommitDate { get; set; }
        public string FPlanFinishDate { get; set; }
        public string SerialNumber { get; set; }
        public string MatItemCode { get; set; }
        public string MatItemName { get; set; }
        public string MatItemSpec { get; set; }
        public string VendorCode { get; set; }
        public string VendorName { get; set; }
        public string DateCode { get; set; }
        public string Batch { get; set; }
        public string MPN { get; set; }
        public string LineName { get; set; }
        public string TableName { get; set; }
       
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialHistoryInfo 类的新实例。
        /// </summary>
        public MaterialHistoryInfo()
        {
        }
         
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 MaterialHistoryId
        {
            get { return this.materialHistoryId; }
            set { this.materialHistoryId = value; }
        }

        /// <summary>
        /// 获取或设置工单ID
        /// </summary>
        public Int32 ProdOrderId
        {
            get { return this.prodOrderId; }
            set { this.prodOrderId = value; }
        }

        /// <summary>
        /// 获取或设置排产工单ID
        /// </summary>
        public Int32 LinePlanId
        {
            get { return this.linePlanId; }
            set { this.linePlanId = value; }
        }

        /// <summary>
        /// 获取或设置物料GRN ID
        /// </summary>
        public Int64 MaterialUnitId
        {
            get { return this.materialUnitId; }
            set { this.materialUnitId = value; }
        }

        /// <summary>
        /// 获取或设置产线ID
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置设备ID
        /// </summary>
        public Int32 EquipmentId
        {
            get { return this.equipmentId; }
            set { this.equipmentId = value; }
        }

        /// <summary>
        /// 获取或设置机台编码
        /// </summary>
        public String EquipmentCode
        {
            get { return this.equipmentCode; }
            set { this.equipmentCode = value; }
        }

        /// <summary>
        /// 获取或设置机台名称
        /// </summary>
        public String EquipmentName
        {
            get { return this.equipmentName; }
            set { this.equipmentName = value; }
        }

        /// <summary>
        /// 获取或设置机台序号
        /// </summary>
        public Int32 SequenceNo
        {
            get { return this.sequenceNo; }
            set { this.sequenceNo = value; }
        }

        /// <summary>
        /// 获取或设置上料清单ID
        /// </summary>
        public Int32 LoadingListId
        {
            get { return this.loadingListId; }
            set { this.loadingListId = value; }
        }

        /// <summary>
        /// 获取或设置上料清单名称
        /// </summary>
        public String LoadingListName
        {
            get { return this.loadingListName; }
            set { this.loadingListName = value; }
        }

        /// <summary>
        /// 获取或设置面别
        /// </summary>
        public String SmtTable
        {
            get { return this.smtTable; }
            set { this.smtTable = value; }
        }

        /// <summary>
        /// 获取或设置上料区
        /// </summary>
        public String Area
        {
            get { return this.area; }
            set { this.area = value; }
        }

        /// <summary>
        /// 获取或设置站位
        /// </summary>
        public String Position
        {
            get { return this.position; }
            set { this.position = value; }
        }

        /// <summary>
        /// 获取或设置点位
        /// </summary>
        public String Point
        {
            get { return this.point; }
            set { this.point = value; }
        }

        /// <summary>
        /// 获取或设置是否主料
        /// </summary>
        public Boolean IsMain
        {
            get { return this.isMain; }
            set { this.isMain = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MainItemCode
        {
            get { return this.mainItemCode; }
            set { this.mainItemCode = value; }
        }

        /// <summary>
        /// 获取或设置主料物料名称
        /// </summary>
        public String MainItemName
        {
            get { return this.mainItemName; }
            set { this.mainItemName = value; }
        }

        /// <summary>
        /// 获取或设置物料用量
        /// </summary>
        public Int32 SmtNum
        {
            get { return this.smtNum; }
            set { this.smtNum = value; }
        }

        /// <summary>
        /// 获取或设置是否绑定飞达
        /// </summary>
        public Boolean IsBindFeeder
        {
            get { return this.isBindFeeder; }
            set { this.isBindFeeder = value; }
        }

        /// <summary>
        /// 获取或设置飞达号码
        /// </summary>
        public String FeederSN
        {
            get { return this.feederSN; }
            set { this.feederSN = value; }
        }

        /// <summary>
        /// 获取或设置飞达类型
        /// </summary>
        public String FeederType
        {
            get { return this.feederType; }
            set { this.feederType = value; }
        }

        /// <summary>
        /// 获取或设置绑定人
        /// </summary>
        public String BindPerson
        {
            get { return this.bindPerson; }
            set { this.bindPerson = value; }
        }

        /// <summary>
        /// 获取或设置绑定时间
        /// </summary>
        public string BindTime
        {
            get { return this.bindTime; }
            set { this.bindTime = value; }
        }

        /// <summary>
        /// 获取或设置绑定人
        /// </summary>
        public String UnBindPerson
        {
            get { return this.unBindPerson; }
            set { this.unBindPerson = value; }
        }

        /// <summary>
        /// 获取或设置绑定时间
        /// </summary>
        public string UnBindTime
        {
            get { return this.unBindTime; }
            set { this.unBindTime = value; }
        }

        /// <summary>
        /// 获取或设置上料时物料数量
        /// </summary>
        public Decimal LoadingQty
        {
            get { return this.loadingQty; }
            set { this.loadingQty = value; }
        }

        /// <summary>
        /// 获取或设置上料人
        /// </summary>
        public String LoadingPerson
        {
            get { return this.loadingPerson; }
            set { this.loadingPerson = value; }
        }

        /// <summary>
        /// 获取或设置上料时间
        /// </summary>
        public string LoadingTime
        {
            get { return this.loadingTime; }
            set { this.loadingTime = value; }
        }

        /// <summary>
        /// 获取或设置上料时物料数量
        /// </summary>
        public Decimal UnLoadingQty
        {
            get { return this.unLoadingQty; }
            set { this.unLoadingQty = value; }
        }

        /// <summary>
        /// 获取或设置上料人
        /// </summary>
        public String UnLoadingPerson
        {
            get { return this.unLoadingPerson; }
            set { this.unLoadingPerson = value; }
        }

        /// <summary>
        /// 获取或设置上料时间
        /// </summary>
        public string UnLoadingTime
        {
            get { return this.unLoadingTime; }
            set { this.unLoadingTime = value; }
        }

        /// <summary>
        /// 获取或设置使用数量
        /// </summary>
        public Decimal UseQty
        {
            get { return this.useQty; }
            set { this.useQty = value; }
        }

        /// <summary>
        /// 获取或设置GRN当前生产状态： 0、上料生产中  1、已卸料
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置最后操作步骤: 上料验证、清除上料记录、开拉、工单完成、卸料
        /// </summary>
        public String LastOperate
        {
            get { return this.lastOperate; }
            set { this.lastOperate = value; }
        }
    }
}
