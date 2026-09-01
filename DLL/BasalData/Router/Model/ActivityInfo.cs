using System;

namespace SKT.LeanMES.Router.Model
{
    [Serializable]
    public class ActivityInfo
    {
        private Int32 aC_ID;
        private String aC_Name;
        private String aC_Description;
        private String aC_FunctionName;
        private String aC_FunctionCode;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String aC_Attributes;

        private String ac_param_name;
        private Int32 roaoid;
        private String ac_param_value;
        private String ac_param_remark;

        //add by weixia on 2015/5/9 
        private Int32 seq;

        /// <summary>
        /// 初始化 SKT.LeanMES.Router.Model.ActivityInfo 类的新实例。
        /// </summary>
        public ActivityInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Router.Model.ActivityInfo 类的新实例。
        /// </summary>
        /// <param name="aC_ID"></param>
        /// <param name="aC_Name">Activity名称</param>
        /// <param name="aC_Description">Activity描述</param>
        /// <param name="aC_FunctionName">Activity函数名</param>
        /// <param name="aC_FunctionCode">Activity函数代码</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="aC_Attributes"></param>
        public ActivityInfo(Int32 aC_ID, String aC_Name, String aC_Description, String aC_FunctionName, 
            String aC_FunctionCode, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, 
            String aC_Attributes)
        {
            this.aC_ID = aC_ID;
            this.aC_Name = aC_Name;
            this.aC_Description = aC_Description;
            this.aC_FunctionName = aC_FunctionName;
            this.aC_FunctionCode = aC_FunctionCode;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.aC_Attributes = aC_Attributes;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AC_ID
        {
            get { return this.aC_ID; }
            set { this.aC_ID = value; }
        }

        /// <summary>
        /// 获取或设置Activity名称
        /// </summary>
        public String AC_Name
        {
            get { return this.aC_Name; }
            set { this.aC_Name = value; }
        }

        /// <summary>
        /// 获取或设置Activity描述
        /// </summary>
        public String AC_Description
        {
            get { return this.aC_Description; }
            set { this.aC_Description = value; }
        }

        /// <summary>
        /// 获取或设置Activity函数名
        /// </summary>
        public String AC_FunctionName
        {
            get { return this.aC_FunctionName; }
            set { this.aC_FunctionName = value; }
        }

        /// <summary>
        /// 获取或设置Activity函数代码
        /// </summary>
        public String AC_FunctionCode
        {
            get { return this.aC_FunctionCode; }
            set { this.aC_FunctionCode = value; }
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
        public String AC_Attributes
        {
            get { return this.aC_Attributes; }
            set { this.aC_Attributes = value; }
        }
        public String AC_Param_Name
        {
            get { return this.ac_param_name; }
            set { this.ac_param_name = value; }
        }
        public Int32 ROAOID
        {
            get { return this.roaoid; }
            set { this.roaoid = value; }
        }
        public String AC_Param_Value
        {
            get { return this.ac_param_value; }
            set { this.ac_param_value = value; }
        }
        public String AC_Param_Remark
        {
            get { return this.ac_param_remark; }
            set { this.ac_param_remark = value; }
        }
        public Int32 Seq
        {
            get { return this.seq; }
            set { this.seq = value; }
        }
    }
}