using System;

namespace SKT.LeanMES.UserAttendance.Model
{
    [Serializable]
    public class UserAttendanceInfo
    {
        private Int32 userAttendanceId;
        private String userName;
        private DateTime? date;
        private String category;
        private String department;
        private String duty;
        private DateTime? entryDate;
        private Int32 isBecome;
        private String shift;
        private Decimal workDay;
        private Decimal workTime;
        private Decimal usualTime;
        private Decimal usualOverTime;
        private Decimal weekendOverTime;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        public String BecomeName { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.UserAttendanceInfo 类的新实例。
        /// </summary>
        public UserAttendanceInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.UserAttendanceInfo 类的新实例。
        /// </summary>
        /// <param name="userAttendanceId"></param>
        /// <param name="userName">用户</param>
        /// <param name="date">日期(以月为主)</param>
        /// <param name="category">部门中心类别</param>
        /// <param name="department">部门</param>
        /// <param name="duty">职务</param>
        /// <param name="entryDate">入职日期</param>
        /// <param name="isBecome">是否转正</param>
        /// <param name="shift">班次</param>
        /// <param name="workDay">上班天数</param>
        /// <param name="workTime">上班时间</param>
        /// <param name="usualTime">平常时间</param>
        /// <param name="usualOverTime">平常加班</param>
        /// <param name="weekendOverTime">周末加班</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public UserAttendanceInfo(Int32 userAttendanceId, String userName, DateTime? date, String category,
            String department, String duty, DateTime? entryDate, Int32 isBecome, String shift,
            Decimal workDay, Decimal workTime, Decimal usualTime, Decimal usualOverTime, Decimal weekendOverTime,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.userAttendanceId = userAttendanceId;
            this.userName = userName;
            this.date = date;
            this.category = category;
            this.department = department;
            this.duty = duty;
            this.entryDate = entryDate;
            this.isBecome = isBecome;
            this.shift = shift;
            this.workDay = workDay;
            this.workTime = workTime;
            this.usualTime = usualTime;
            this.usualOverTime = usualOverTime;
            this.weekendOverTime = weekendOverTime;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 UserAttendanceId
        {
            get { return this.userAttendanceId; }
            set { this.userAttendanceId = value; }
        }

        /// <summary>
        /// 获取或设置用户
        /// </summary>
        public String UserName
        {
            get { return this.userName; }
            set { this.userName = value; }
        }

        /// <summary>
        /// 获取或设置日期(以月为主)
        /// </summary>
        public DateTime? Date
        {
            get { return this.date; }
            set { this.date = value; }
        }

        /// <summary>
        /// 获取或设置部门中心类别
        /// </summary>
        public String Category
        {
            get { return this.category; }
            set { this.category = value; }
        }

        /// <summary>
        /// 获取或设置部门
        /// </summary>
        public String Department
        {
            get { return this.department; }
            set { this.department = value; }
        }

        /// <summary>
        /// 获取或设置职务
        /// </summary>
        public String Duty
        {
            get { return this.duty; }
            set { this.duty = value; }
        }

        /// <summary>
        /// 获取或设置入职日期
        /// </summary>
        public DateTime? EntryDate
        {
            get { return this.entryDate; }
            set { this.entryDate = value; }
        }

        /// <summary>
        /// 获取或设置是否转正
        /// </summary>
        public Int32 IsBecome
        {
            get { return this.isBecome; }
            set { this.isBecome = value; }
        }

        /// <summary>
        /// 获取或设置班次
        /// </summary>
        public String Shift
        {
            get { return this.shift; }
            set { this.shift = value; }
        }

        /// <summary>
        /// 获取或设置上班天数
        /// </summary>
        public Decimal WorkDay
        {
            get { return this.workDay; }
            set { this.workDay = value; }
        }

        /// <summary>
        /// 获取或设置上班时间
        /// </summary>
        public Decimal WorkTime
        {
            get { return this.workTime; }
            set { this.workTime = value; }
        }

        /// <summary>
        /// 获取或设置平常时间
        /// </summary>
        public Decimal UsualTime
        {
            get { return this.usualTime; }
            set { this.usualTime = value; }
        }

        /// <summary>
        /// 获取或设置平常加班
        /// </summary>
        public Decimal UsualOverTime
        {
            get { return this.usualOverTime; }
            set { this.usualOverTime = value; }
        }

        /// <summary>
        /// 获取或设置周末加班
        /// </summary>
        public Decimal WeekendOverTime
        {
            get { return this.weekendOverTime; }
            set { this.weekendOverTime = value; }
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
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
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