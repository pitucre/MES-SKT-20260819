using System;

namespace SKT.LeanMES.TestManagement.Model
{
    [Serializable]
    public class StaffAssessInfo
    {
        private Int32 userId;
        private String userName;
        private String employeeNo;
        private String departName;
        private String qtyAet;
        private String aetGrade;
        private String sex;
        private Int32 phone;
        private String email;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;


        /// <summary>
        /// 初始化 SKT.LeanMES.TestManagement.Model.StaffAssessInfo 类的新实例。
        /// </summary>
        public StaffAssessInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.TestManagement.Model.StaffAssessInfo 类的新实例。
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="userName">员工名称</param>
        /// <param name="employeeNo">员工编号</param>
        /// <param name="departName">部门</param>
        /// <param name="qtyAet">考核季度</param>
        /// <param name="aetGrade">考核等级</param>
        /// <param name="sex">性别</param>
        /// <param name="phone">电话</param>
        /// <param name="email">邮箱</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="createDateTime">审核时间</param>
        /// <param name="createBy">审核人</param>
        public StaffAssessInfo(Int32 userId, String userName, String employeeNo, String departName, String qtyAet, String aetGrade,
            String sex, Int32 phone, String email, DateTime modifyDateTime, String modifyBy, DateTime createDateTime, String createBy,String remark)
        {
            this.userId = userId;
            this.userName = userName;
            this.employeeNo = employeeNo;
            this.departName = departName;
            this.qtyAet = qtyAet;
            this.aetGrade = aetGrade;
            this.sex = sex;
            this.phone = phone;
            this.email = email;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.remark = remark;
        }


        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 UserId
        {
            get { return this.userId; }
            set { this.userId = value; }
        }

        /// <summary>
        /// 获取或设置员工姓名
        /// </summary>
        public String UserName
        {
            get { return this.userName; }
            set { this.userName = value; }
        }

        /// <summary>
        /// 获取或设置员工编号
        /// </summary>
        public String EmployeeNo
        {
            get { return this.employeeNo; }
            set { this.employeeNo = value; }
        }

        /// <summary>
        /// 获取或设置部门
        /// </summary>
        public String DepartName
        {
            get { return this.departName; }
            set { this.departName = value; }
        }

        /// <summary>
        /// 获取或设置考核季度
        /// </summary>
        public String QtyAet
        {
            get { return this.qtyAet; }
            set { this.qtyAet = value; }
        }

        /// <summary>
        /// 获取或设置考核等级
        /// </summary>
        public String AetGrade
        {
            get { return this.aetGrade; }
            set { this.aetGrade = value; }
        }

        /// <summary>
        /// 获取或设置性别
        /// </summary>
        public String Sex
        {
            get { return this.sex; }
            set { this.sex = value; }
        }

        /// <summary>
        /// 获取或设置电话
        /// </summary>
        public Int32 Phone
        {
            get { return this.phone; }
            set { this.phone = value; }
        }

        /// <summary>
        /// 获取或设置邮箱
        /// </summary>
        public String Email
        {
            get { return this.email; }
            set { this.email = value; }
        }

        /// <summary>
        /// 获取或设置最后修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
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
        /// 获取或设置审核时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置审核人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
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
