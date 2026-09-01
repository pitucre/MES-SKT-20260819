using System;

namespace SKT.LeanMES.Synchronization.Model
{
    [Serializable]
    public class APIInfo
    {
        private Int32 iD;
        private String businessName;
        private String funcName;
        private String sapParam;
        private String sapParamDesc;
        private String sapFields;
        private String targetTabName;
        private String targetTabFields;
        private Int32 autoHZ;
        private String remark;

        private String sapTabName;

        public String SapTabName
        {
            get { return sapTabName; }
            set { sapTabName = value; }
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Synchronization.Model.APIInfo 类的新实例。
        /// </summary>
        public APIInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Synchronization.Model.APIInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="businessName"></param>
        /// <param name="funcName"></param>
        /// <param name="sapParam"></param>
        /// <param name="sapParamDesc"></param>
        /// <param name="sapFields"></param>
        /// <param name="targetTabName"></param>
        /// <param name="targetTabFields"></param>
        /// <param name="autoHZ"></param>
        /// <param name="remark"></param>
        public APIInfo(Int32 iD, String businessName, String funcName, String sapParam,
            String sapParamDesc, String sapTabName, String sapFields, String targetTabName, String targetTabFields, Int32 autoHZ, 
            String remark)
        {
            this.iD = iD;
            this.businessName = businessName;
            this.funcName = funcName;
            this.sapParam = sapParam;
            this.sapParamDesc = sapParamDesc;
            this.sapFields = sapFields;
            this.targetTabName = targetTabName;
            this.targetTabFields = targetTabFields;
            this.sapTabName = sapTabName;
            this.remark = remark;
            this.autoHZ = autoHZ;
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
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}