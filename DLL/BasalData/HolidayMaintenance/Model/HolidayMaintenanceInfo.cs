using System;
 
namespace SKT.LeanMES.HolidayMaintenance.Model
{
    [Serializable]
    public class HolidayMaintenanceInfo
    {
        private Int32 id;
        private DateTime date;
        private Int32 multiple;
        private Int32 isHoliday;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;
        private String remark;
        public String Holiday { get; set; }
        public String MultipleName { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.HolidayMaintenanceInfo 类的新实例。
        /// </summary>
        public HolidayMaintenanceInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.HolidayMaintenanceInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="date"></param>
        /// <param name="multiple"></param>
        /// <param name="isHoliday"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="remark"></param>
        public HolidayMaintenanceInfo(Int32 id, DateTime date, Int32 multiple, Int32 isHoliday, 
            DateTime createDateTime, String createBy, DateTime modifyDateTime, String modifyBy, String remark)
        {
            this.id = id;
            this.date = date;
            this.multiple = multiple;
            this.isHoliday = isHoliday;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime Date
        {
            get { return this.date; }
            set { this.date = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Multiple
        {
            get { return this.multiple; }
            set { this.multiple = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 IsHoliday
        {
            get { return this.isHoliday; }
            set { this.isHoliday = value; }
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

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}