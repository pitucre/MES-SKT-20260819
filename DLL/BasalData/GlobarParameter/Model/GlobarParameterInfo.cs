using System;

namespace SKT.LeanMES.GlobarParameter.Model
{
    [Serializable]
    public class GlobarParameterInfo
    {
        private Int32 iD;
        private Int32 paraType;
        private String paraName;
        private String paraValue;
        private String paraDescription;

        /// <summary>
        /// 初始化 SKT.MES.Model.GlobarParameterInfo 类的新实例。
        /// </summary>
        public GlobarParameterInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.GlobarParameterInfo 类的新实例。
        /// </summary>
        /// <param name="iD">参数编号</param>
        /// <param name="paraType">参数类型</param>
        /// <param name="paraName">参数名</param>
        /// <param name="paraValue">参数值</param>
        /// <param name="paraDescription">参数说明</param>
        public GlobarParameterInfo(Int32 iD, Int32 paraType, String paraName, String paraValue,
            String paraDescription)
        {
            this.iD = iD;
            this.paraType = paraType;
            this.paraName = paraName;
            this.paraValue = paraValue;
            this.paraDescription = paraDescription;
        }

        /// <summary>
        /// 获取或设置参数编号
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置参数类型
        /// </summary>
        public Int32 ParaType
        {
            get { return this.paraType; }
            set { this.paraType = value; }
        }

        /// <summary>
        /// 获取或设置参数名
        /// </summary>
        public String ParaName
        {
            get { return this.paraName; }
            set { this.paraName = value; }
        }

        /// <summary>
        /// 获取或设置参数值
        /// </summary>
        public String ParaValue
        {
            get { return this.paraValue; }
            set { this.paraValue = value; }
        }

        /// <summary>
        /// 获取或设置参数说明
        /// </summary>
        public String ParaDescription
        {
            get { return this.paraDescription; }
            set { this.paraDescription = value; }
        }
    }
}