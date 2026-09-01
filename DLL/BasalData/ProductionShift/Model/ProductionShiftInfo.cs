using System;

namespace SKT.LeanMES.ProductionShift.Model
{
    [Serializable]
    public class ProductionShiftInfo
    {
        private Int32 shiftId;
        private String shiftName;
        private String remark;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        /// <summary>
        /// 初始化 SKT.MES.BLL.SYS.SHIFTInfo 类的新实例。
        /// </summary>
        public ProductionShiftInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.BLL.SYS.SHIFTInfo 类的新实例。
        /// </summary>
        /// <param name="shiftId">主表ID</param>
        /// <param name="shiftName">班次名称</param>
        /// <param name="remark">班次备注</param>
        /// <param name="modifyDateTime">最后一次修改时间</param>
        /// <param name="modifyBy">最后修改者</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        public ProductionShiftInfo(Int32 shiftId, String shiftName, String remark, DateTime modifyDateTime, 
            String modifyBy, DateTime createDateTime, String createBy)
        {
            this.shiftId = shiftId;
            this.shiftName = shiftName;
            this.remark = remark;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置主表ID
        /// </summary>
        public Int32 ShiftId
        {
            get { return this.shiftId; }
            set { this.shiftId = value; }
        }

        /// <summary>
        /// 获取或设置班次名称
        /// </summary>
        public String ShiftName
        {
            get { return this.shiftName; }
            set { this.shiftName = value; }
        }

        /// <summary>
        /// 获取或设置班次备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置最后一次修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置最后修改者
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
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
        /// 获取或设置创建者
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }
    }
}