using System;

namespace SKT.LeanMES.MaterialConfig.Model
{
    [Serializable]
    public class MaterialSysConfigInfo
    {
        private Int32 iD;
        private Int32 configTypeId;
        private String configType;
        //private Int32 configResult;
        private string configResult;
        private String configDesc;
        private Boolean isGlobal;
        private String remark;
        public String CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public String ModifyBy { get; set; }
        public DateTime ModifyDateTime { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialSysConfigInfo 类的新实例。
        /// </summary>
        public MaterialSysConfigInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialSysConfigInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="configTypeId">全局配置类型id(1.物料条码打印   2.仓库收料 3.是否备料确认    4.发料是否交接确认 )</param>
        /// <param name="configType">1.物料条码打印   2.仓库收料 3.是否备料确认    4.发料是否交接确认 </param>
        /// <param name="configResult">记录结果</param>
        /// <param name="configDesc">结果描述</param>
        /// <param name="isGlobal">是否全局变量</param>
        /// <param name="remark">备注</param>
        public MaterialSysConfigInfo(Int32 iD, Int32 configTypeId, String configType, string configResult,
            String configDesc, Boolean isGlobal, String remark)
        {
            this.iD = iD;
            this.configTypeId = configTypeId;
            this.configType = configType;
            this.configResult = configResult;
            this.configDesc = configDesc;
            this.isGlobal = isGlobal;
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
        /// 获取或设置全局配置类型id(1.物料条码打印   2.仓库收料 3.是否备料确认    4.发料是否交接确认 )
        /// </summary>
        public Int32 ConfigTypeId
        {
            get { return this.configTypeId; }
            set { this.configTypeId = value; }
        }

        /// <summary>
        /// 获取或设置1.物料条码打印   2.仓库收料 3.是否备料确认    4.发料是否交接确认 
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
        /// 操作人姓名
        /// </summary>
        public string UserName { get; set; }

        /// <summary>
        /// 操作模块 主要为了记录操作日志（0：仓库管理>仓库数据配置>仓库配置列表  1：生产管理>生产数据配置>生产数据设置）
        /// </summary>
        public int Moudle { get; set; }
    }
}