using System;

namespace SKT.LeanMES.Router.Model
{
    [Serializable]
    public class ActivityOptionsInfo
    {
        private Int32 aOID;
        private Int32 aC_ID;
        private Int32 aC_Param_Sequence;
        private String aC_Param_Name;
        private String aC_Param_Value;
        private String aC_Param_Remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Router.Model.ActivityOptionsInfo 类的新实例。
        /// </summary>
        public ActivityOptionsInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Router.Model.ActivityOptionsInfo 类的新实例。
        /// </summary>
        /// <param name="aOID"></param>
        /// <param name="aC_ID">Activity ID</param>
        /// <param name="aC_Param_Sequence">function中参数的顺序</param>
        /// <param name="aC_Param_Name">参数名称,描述</param>
        /// <param name="aC_Param_Value">参数值</param>
        /// <param name="aC_Param_Remark">备注说明</param>
        public ActivityOptionsInfo(Int32 aOID, Int32 aC_ID, Int32 aC_Param_Sequence, String aC_Param_Name, 
            String aC_Param_Value, String aC_Param_Remark)
        {
            this.aOID = aOID;
            this.aC_ID = aC_ID;
            this.aC_Param_Sequence = aC_Param_Sequence;
            this.aC_Param_Name = aC_Param_Name;
            this.aC_Param_Value = aC_Param_Value;
            this.aC_Param_Remark = aC_Param_Remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AOID
        {
            get { return this.aOID; }
            set { this.aOID = value; }
        }

        /// <summary>
        /// 获取或设置Activity ID
        /// </summary>
        public Int32 AC_ID
        {
            get { return this.aC_ID; }
            set { this.aC_ID = value; }
        }

        /// <summary>
        /// 获取或设置function中参数的顺序
        /// </summary>
        public Int32 AC_Param_Sequence
        {
            get { return this.aC_Param_Sequence; }
            set { this.aC_Param_Sequence = value; }
        }

        /// <summary>
        /// 获取或设置参数名称,描述
        /// </summary>
        public String AC_Param_Name
        {
            get { return this.aC_Param_Name; }
            set { this.aC_Param_Name = value; }
        }

        /// <summary>
        /// 获取或设置参数值
        /// </summary>
        public String AC_Param_Value
        {
            get { return this.aC_Param_Value; }
            set { this.aC_Param_Value = value; }
        }

        /// <summary>
        /// 获取或设置备注说明
        /// </summary>
        public String AC_Param_Remark
        {
            get { return this.aC_Param_Remark; }
            set { this.aC_Param_Remark = value; }
        }
    }
}