using System;

namespace SKT.LeanMES.SteelMesh.Model
{
    [Serializable]
    public class SteelHistoryInfo
    {
        private Int32 steelHistoryId;
        private Int32 steelId;
        private Int32 lineId;
        private Int32 operateType;
        private Int32 steelType;
        private Int32 operators;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        public String SteelCode { get; set; }
        public String SteelName { get; set; }
        public String LineName { get; set; }
        public Int32 SteelCategory { get; set; }
        public String CName { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.SteelHistoryInfo 类的新实例。
        /// </summary>
        public SteelHistoryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.SteelHistoryInfo 类的新实例。
        /// </summary>
        /// <param name="steelHistoryId">主键id</param>
        /// <param name="steelId">钢网id</param>
        /// <param name="lineId">产线id</param>
        /// <param name="operateType">出入库类型，1为入库，2为出库</param>
        /// <param name="steelType">出入库类型，1为采购入库，2为借用归还，3为闲置入库，4为不良入库，5为维修领用，6为保养领用，7为借用出库，8为报废，9为退货</param>
        /// <param name="operator">操作人</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public SteelHistoryInfo(Int32 steelHistoryId, Int32 steelId, Int32 lineId, Int32 operateType,
            Int32 steelType, Int32 operators, String createBy, DateTime createDateTime, String modifyBy,
            DateTime modifyDateTime, String remark)
        {
            this.steelHistoryId = steelHistoryId;
            this.steelId = steelId;
            this.lineId = lineId;
            this.operateType = operateType;
            this.steelType = steelType;
            this.operators = operators;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }


        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.SteelHistoryInfo 类的新实例。
        /// </summary>
        /// <param name="steelHistoryId">主键id</param>
        /// <param name="steelcode">钢网编号</param>
        /// <param name="steelname">钢网名</param>
        /// <param name="steelCategory">钢网种类</param>
        /// <param name="linename">产线名</param>
        /// <param name="operateType">出入库类型，1为入库，2为出库</param>
        /// <param name="steelType">出入库类型，1为采购入库，2为借用归还，3为闲置入库，4为不良入库，5为维修领用，6为保养领用，7为借用出库，8为报废，9为退货</param>
        /// <param name="CName">申请人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="remark">备注</param>
        public SteelHistoryInfo(Int32 steelHistoryId, String steelcode, String steelname, Int32 steelCategory, String linename, Int32 operateType,
            Int32 steelType, String CName, DateTime createDateTime, String remark)
        {
            this.steelHistoryId = steelHistoryId;
            this.SteelCode = steelcode;
            this.SteelName = steelname;
            this.SteelCategory = steelCategory;
            this.LineName = linename;
            this.operateType = operateType;
            this.steelType = steelType;
            this.CName = CName;
            this.createDateTime = createDateTime;
            this.remark = remark;
        }


        /// <summary>
        /// 获取或设置主键id
        /// </summary>
        public Int32 SteelHistoryId
        {
            get { return this.steelHistoryId; }
            set { this.steelHistoryId = value; }
        }

        /// <summary>
        /// 获取或设置钢网id
        /// </summary>
        public Int32 SteelId
        {
            get { return this.steelId; }
            set { this.steelId = value; }
        }

        /// <summary>
        /// 获取或设置产线id
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置出入库类型，1为入库，2为出库
        /// </summary>
        public Int32 OperateType
        {
            get { return this.operateType; }
            set { this.operateType = value; }
        }

        /// <summary>
        /// 获取或设置出入库类型，1为采购入库，2为借用归还，3为闲置入库，4为不良入库，5为维修领用，6为保养领用，7为借用出库，8为报废，9为退货
        /// </summary>
        public Int32 SteelType
        {
            get { return this.steelType; }
            set { this.steelType = value; }
        }

        /// <summary>
        /// 获取或设置操作人
        /// </summary>
        public Int32 Operator
        {
            get { return this.operators; }
            set { this.operators = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}