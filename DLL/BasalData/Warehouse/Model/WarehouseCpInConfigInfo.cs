using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class WarehouseCpInConfigInfo
    {
        private Int32 id;
        private Int32 configId;
        private String configName;
        private Int32 configType;
        private String configDesc;
        private String remark;
        public String CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public String ModifyBy { get; set; }
        public DateTime ModifyDateTime { get; set; }
        public String UserName { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.SKT.LeanMES.Web.Warehouse.Model.WarehouseCpInConfigInfo 类的新实例。
        /// </summary>
        public WarehouseCpInConfigInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.SKT.LeanMES.Web.Warehouse.Model.WarehouseCpInConfigInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="configId"></param>
        /// <param name="configName"></param>
        /// <param name="configType"></param>
        /// <param name="configDesc"></param>
        /// <param name="remark"></param>
        public WarehouseCpInConfigInfo(Int32 id, Int32 configId, String configName, Int32 configType, 
            String configDesc, String remark)
        {
            this.id = id;
            this.configId = configId;
            this.configName = configName;
            this.configType = configType;
            this.configDesc = configDesc;
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
        public Int32 ConfigId
        {
            get { return this.configId; }
            set { this.configId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ConfigName
        {
            get { return this.configName; }
            set { this.configName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ConfigType
        {
            get { return this.configType; }
            set { this.configType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ConfigDesc
        {
            get { return this.configDesc; }
            set { this.configDesc = value; }
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