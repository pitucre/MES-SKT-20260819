using System;

namespace SKT.LeanMES.ESOP.Model
{
    [Serializable]
    public class ESOPLineInfo
    {
        private Int32 eSOPLineId;
        private Int32 lineId;
        private Int32 prodOrderId;
        private Boolean isDefault;
        private String createBy;
        private DateTime createDate;
        private String modifyBy;
        private DateTime modifyDate;

        public string LineName { get; set; }
        public string OrderNo { get; set; }
        public string ItemName { get; set; }
        public string ItemCode { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ESOPLineInfo 类的新实例。
        /// </summary>
        public ESOPLineInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ESOPLineInfo 类的新实例。
        /// </summary>
        /// <param name="eSOPLineId"></param>
        /// <param name="lineId">线别</param>
        /// <param name="prodOrderId">工单ID</param>
        /// <param name="isDefault">是否默认ESOP： 0、否   1、是</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDate">修改时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDate">修改时间</param>
        public ESOPLineInfo(Int32 eSOPLineId, Int32 lineId, Int32 prodOrderId, Boolean isDefault,
            String createBy, DateTime createDate, String modifyBy, DateTime modifyDate)
        {
            this.eSOPLineId = eSOPLineId;
            this.lineId = lineId;
            this.prodOrderId = prodOrderId;
            this.isDefault = isDefault;
            this.createBy = createBy;
            this.createDate = createDate;
            this.modifyBy = modifyBy;
            this.modifyDate = modifyDate;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ESOPLineId
        {
            get { return this.eSOPLineId; }
            set { this.eSOPLineId = value; }
        }

        /// <summary>
        /// 获取或设置线别
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
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
        /// 获取或设置是否默认ESOP： 0、否   1、是
        /// </summary>
        public Boolean IsDefault
        {
            get { return this.isDefault; }
            set { this.isDefault = value; }
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
        /// 获取或设置修改时间
        /// </summary>
        public DateTime CreateDate
        {
            get { return this.createDate; }
            set { this.createDate = value; }
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
        public DateTime ModifyDate
        {
            get { return this.modifyDate; }
            set { this.modifyDate = value; }
        }
    }
}
