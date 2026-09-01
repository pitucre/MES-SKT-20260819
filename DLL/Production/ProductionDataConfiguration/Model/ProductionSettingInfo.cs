using System;

namespace SKT.LeanMES.ProductionDataConfiguration.Model
{
    [Serializable]
    public class ProductionSettingInfo
    {
        private Int32 iD;
        private Int32 configTypeId;
        private String configType;
        private string configResult;
        private String configDesc;
        private Boolean isGlobal;
        private String remark;

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置全局配置类型id
        /// </summary>
        public Int32 ConfigTypeId
        {
            get { return this.configTypeId; }
            set { this.configTypeId = value; }
        }

        /// <summary>
        /// 获取或设置全局配置类型
        /// </summary>
        public String ConfigType
        {
            get { return this.configType; }
            set { this.configType = value; }
        }

        /// <summary>
        /// 获取或设置记录结果
        /// </summary>
        public string ConfigResult
        {
            get { return this.configResult; }
            set { this.configResult = value; }
        }

        /// <summary>
        /// 获取或设置结果描述
        /// </summary>
        public String ConfigDesc
        {
            get { return this.configDesc; }
            set { this.configDesc = value; }
        }

        /// <summary>
        /// 获取或设置是否全局变量
        /// </summary>
        public Boolean IsGlobal
        {
            get { return this.isGlobal; }
            set { this.isGlobal = value; }
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
        /// 初始化 SKT.LeanMES.Model.ProductionSettingImfo 类的新实例。
        /// </summary>
        public ProductionSettingInfo()
        {
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="configTypeId">全局配置类型id</param>
        /// <param name="configType">全局配置类型</param>
        /// <param name="configResult">记录结果</param>
        /// <param name="configDesc">结果描述</param>
        /// <param name="isGlobal">是否全局</param>
        /// <param name="remark">备注</param>
        public ProductionSettingInfo(Int32 iD, Int32 configTypeId, String configType,
           string configResult, String configDesc, Boolean isGlobal, String remark)
        {
            this.ID = iD;
            this.ConfigTypeId = configTypeId;
            this.configType = configType;
            this.ConfigResult = configResult;
            this.ConfigDesc = configDesc;
            this.IsGlobal = isGlobal;
            this.Remark = remark;
        }


    }
}
