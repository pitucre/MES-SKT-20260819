using System;

namespace SKT.LeanMES.CommonDataSource.Model
{
    [Serializable]
    public class SAPAPIInfo
    {
        private Int32 iD;
        private String businessName;
        private String funcName;
        private String sapParam;
        private String sapParamDesc;
        private String sapTabName;
        private String sapFields;
        private String targetTabName;
        private String targetTabFields;
        private Int32 autoHZ;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.APIInfo 类的新实例。
        /// </summary>
        public SAPAPIInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.APIInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="businessName"></param>
        /// <param name="funcName"></param>
        /// <param name="sapParam"></param>
        /// <param name="sapParamDesc"></param>
        /// <param name="sapTabName"></param>
        /// <param name="sapFields"></param>
        /// <param name="targetTabName"></param>
        /// <param name="targetTabFields"></param>
        /// <param name="autoHZ"></param>
        /// <param name="remark">备注</param>
        public SAPAPIInfo(Int32 iD, String businessName, String funcName, String sapParam, 
            String sapParamDesc, String sapTabName, String sapFields, String targetTabName, String targetTabFields, 
            Int32 autoHZ, String remark)
        {
            this.iD = iD;
            this.businessName = businessName;
            this.funcName = funcName;
            this.sapParam = sapParam;
            this.sapParamDesc = sapParamDesc;
            this.sapTabName = sapTabName;
            this.sapFields = sapFields;
            this.targetTabName = targetTabName;
            this.targetTabFields = targetTabFields;
            this.autoHZ = autoHZ;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String BusinessName
        {
            get { return this.businessName; }
            set { this.businessName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FuncName
        {
            get { return this.funcName; }
            set { this.funcName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SapParam
        {
            get { return this.sapParam; }
            set { this.sapParam = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SapParamDesc
        {
            get { return this.sapParamDesc; }
            set { this.sapParamDesc = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SapTabName
        {
            get { return this.sapTabName; }
            set { this.sapTabName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SapFields
        {
            get { return this.sapFields; }
            set { this.sapFields = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String TargetTabName
        {
            get { return this.targetTabName; }
            set { this.targetTabName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String TargetTabFields
        {
            get { return this.targetTabFields; }
            set { this.targetTabFields = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AutoHZ
        {
            get { return this.autoHZ; }
            set { this.autoHZ = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}