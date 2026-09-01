using System;

namespace SKT.LeanMES.Jig.Model
{
    [Serializable]
    public class JigHistoryInfo
    {
        private Int32 jigHistoryId;
        private Int32 jigId;
        private Int32 lineId;
        private Int32 operateType;
        private Int32 jigType;
        private Int32 operators;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        public String JigCode { get; set; }
        public String JigName { get; set; }
        public String LineName { get; set; }
        public String JigCategory { get; set; }
        public String CName { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.JigHistoryInfo 类的新实例。
        /// </summary>
        public JigHistoryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.JigHistoryInfo 类的新实例。
        /// </summary>
        /// <param name="jigHistoryId">主键id</param>
        /// <param name="jigId">工装夹具编号</param>
        /// <param name="lineId">产线id</param>
        /// <param name="operateType">操作类型，1为入库，2为出库</param>
        /// <param name="jigType">出入库类型，1为采购入库，2为借用归还，3为闲置入库，4为不良入库，5为维修领用，6为保养领用，7为借用出库，8为报废，9为退货,10为产线退库,11为产线领用</param>
        /// <param name="operator">操作人</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public JigHistoryInfo(Int32 jigHistoryId, Int32 jigId, Int32 lineId, Int32 operateType,
            Int32 jigType, Int32 operators, String createBy, DateTime createDateTime, String modifyBy,
            DateTime modifyDateTime, String remark)
        {
            this.jigHistoryId = jigHistoryId;
            this.jigId = jigId;
            this.lineId = lineId;
            this.operateType = operateType;
            this.jigType = jigType;
            this.operators = operators;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.JigHistoryInfo 类的新实例。
        /// </summary>
        /// <param name="jigHistoryId">主键id</param>
        /// <param name="Jigcode">夹具编号</param>
        /// <param name="Jigname">夹具名</param>
        /// <param name="JigCategory">夹具种类</param>
        /// <param name="linename">产线名</param>
        /// <param name="operateType">出入库类型，1为入库，2为出库</param>
        /// <param name="JigType">出入库类型，1为采购入库，2为借用归还，3为闲置入库，4为不良入库，5为维修领用，6为保养领用，7为借用出库，8为报废，9为退货</param>
        /// <param name="CName">申请人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="remark">备注</param>
        public JigHistoryInfo(Int32 jigHistoryId, String Jigcode, String Jigname, String JigCategory, String linename, Int32 operateType,
            Int32 JigType, String CName, DateTime createDateTime, String remark)
        {
            this.jigHistoryId = jigHistoryId;
            this.JigCode = Jigcode;
            this.JigName = Jigname;
            this.JigCategory = JigCategory;
            this.operateType = operateType;
            this.LineName = linename;
            this.JigType = JigType;
            this.CName = CName;
            this.createDateTime = createDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置主键id
        /// </summary>
        public Int32 JigHistoryId
        {
            get { return this.jigHistoryId; }
            set { this.jigHistoryId = value; }
        }

        /// <summary>
        /// 获取或设置工装夹具编号
        /// </summary>
        public Int32 JigId
        {
            get { return this.jigId; }
            set { this.jigId = value; }
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
        /// 获取或设置操作类型，1为入库，2为出库
        /// </summary>
        public Int32 OperateType
        {
            get { return this.operateType; }
            set { this.operateType = value; }
        }

        /// <summary>
        /// 获取或设置出入库类型，1为采购入库，2为借用归还，3为闲置入库，4为不良入库，5为维修领用，6为保养领用，7为借用出库，8为报废，9为退货,10为产线退库,11为产线领用
        /// </summary>
        public Int32 JigType
        {
            get { return this.jigType; }
            set { this.jigType = value; }
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