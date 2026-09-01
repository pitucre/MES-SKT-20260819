using System;

namespace SKT.LeanMES.ProductionShift.Model
{
    [Serializable]
    public class Shift_MemberInfo
    {
        private Int32 memberId;
        private Int32 shiftId;
        private String productionShift;
        private String description;
        //private String startShift;
        //private String endShift;
        private String startTime;
        private String endTime;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;
        public int Sequence { get; set; }
        public bool IsInterday { get; set; }
        /// <summary>
        /// 初始化 SKT.MES.BLL.SYS.SHIFT_MEMBERInfo 类的新实例。
        /// </summary>
        public Shift_MemberInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.BLL.SYS.SHIFT_MEMBERInfo 类的新实例。
        /// </summary>
        /// <param name="mPID">子表ID</param>
        /// <param name="pID">主表ID</param>
        /// <param name="productionShift">生产班次</param>
        /// <param name="description">班次说明</param>
        /// <param name="startTime">开始时间</param>
        /// <param name="endTime">结束时间</param>
        /// <param name="modifyDateTime">最后一次修改时间</param>
        /// <param name="modifyBy">最后修改者</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        public Shift_MemberInfo(Int32 memberId, Int32 shiftId, String productionShift, String description,
            String startTime, String endTime, DateTime modifyDateTime, String modifyBy, DateTime createDateTime, 
            String createBy)
        {
            this.memberId = memberId;
            this.shiftId = shiftId;
            this.productionShift = productionShift;
            this.description = description;
            this.startTime = startTime;
            this.endTime = endTime;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置子表ID
        /// </summary>
        public Int32 MemberId
        {
            get { return this.memberId; }
            set { this.memberId = value; }
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
        /// 获取或设置生产班次
        /// </summary>
        public String ProductionShift
        {
            get { return this.productionShift; }
            set { this.productionShift = value; }
        }

        /// <summary>
        /// 获取或设置班次说明
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置开始时间
        /// </summary>
        public String StartTime
        {
            get { return this.startTime; }
            set { this.startTime = value; }
        }

        /// <summary>
        /// 获取或设置结束时间
        /// </summary>
        public String EndTime
        {
            get { return this.endTime; }
            set { this.endTime = value; }
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

        ///// <summary>
        ///// 字符型开始时间
        ///// </summary>
        //public String StartShift
        //{
        //    get { return this.startShift; }
        //    set { this.startShift = value; }
        //}

        ///// <summary>
        ///// 字符型结束时间
        ///// </summary>
        //public String EndShift
        //{
        //    get { return this.endShift; }
        //    set { this.endShift = value; }
        //}

        public int Cid { get; set; }
        public bool StartTimeIsterday { get; set; }
    }
}