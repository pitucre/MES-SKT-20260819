using System;

namespace SKT.LeanMES.Turnover.Model
{
    [Serializable]
    public class TurnoverDataInfo
    {
        private Int32 turnoverDataId;
        private String turnoverNumber;
        private Int32 turnoverGroupId;
        private Int32 turnoverStatusId;
        private String turnoverStatusDesc;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;

        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINER_DATAInfo 类的新实例。
        /// </summary>
        public TurnoverDataInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINER_DATAInfo 类的新实例。
        /// </summary>
        /// <param name="cCDataId"></param>
        /// <param name="containerNumber">周转箱序列号</param>
        /// <param name="cCID">周转箱小类id</param>
        /// <param name="statusId">周转箱状态id</param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        public TurnoverDataInfo(Int32 cCDataId, String containerNumber, Int32 cCID, Int32 statusId, 
            DateTime createDateTime, String createBy, DateTime modifyDateTime, String modifyBy)
        {
            this.turnoverDataId = cCDataId;
            this.turnoverNumber = containerNumber;
            this.turnoverGroupId = cCID;
            this.turnoverStatusId = statusId;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
        }


        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINER_DATAInfo 类的新实例。
        /// </summary>
        /// <param name="cCDataId"></param>
        /// <param name="containerNumber">周转箱序列号</param>
        /// <param name="cCID">周转箱小类id</param>
        /// <param name="statusId">周转箱状态id</param>
        /// <param name="statusIdStr">状态描述</param>
        public TurnoverDataInfo(Int32 cCDataId, String containerNumber, Int32 cCID, Int32 statusId,String statusIdStr)
        {
            this.turnoverDataId = cCDataId;
            this.turnoverNumber = containerNumber;
            this.turnoverGroupId = cCID;
            this.turnoverStatusId = statusId;
            this.turnoverStatusDesc = statusIdStr;
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINER_DATAInfo 类的新实例。 用于某分组下面所包含的工具条码列表
        /// </summary>
        /// <param name="cCDataId"></param>
        /// <param name="containerNumber">周转箱序列号</param>
        /// <param name="statusIdStr">状态描述</param>
        public TurnoverDataInfo(Int32 cCDataId, String containerNumber, String statusIdStr)
        {
            this.turnoverDataId = cCDataId;
            this.turnoverNumber = containerNumber;
            this.turnoverStatusDesc = statusIdStr;
        }

        /// <summary>
        /// 获取或设置 周转工具ID
        /// </summary>
        public Int32 TurnoverDataId
        {
            get { return this.turnoverDataId; }
            set { this.turnoverDataId = value; }
        }

        /// <summary>
        /// 获取或设置 周转工具编号
        /// </summary>
        public String TurnoverNumber
        {
            get { return this.turnoverNumber; }
            set { this.turnoverNumber = value; }
        }

        /// <summary>
        /// 获取或设置 周转工具分组Id
        /// </summary>
        public Int32 TurnoverGroupId
        {
            get { return this.turnoverGroupId; }
            set { this.turnoverGroupId = value; }
        }

        /// <summary>
        /// 获取或设置 周转工具状态Id
        /// </summary>
        public Int32 TurnoverStatusId
        {
            get { return this.turnoverStatusId; }
            set { this.turnoverStatusId = value; }
        }

        /// <summary>
        /// 获取或设置 周转工具状态描述
        /// </summary>
        public String TurnoverStatusDesc
        {
            get { return this.turnoverStatusDesc; }
            set { this.turnoverStatusDesc = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
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
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }
    }
}