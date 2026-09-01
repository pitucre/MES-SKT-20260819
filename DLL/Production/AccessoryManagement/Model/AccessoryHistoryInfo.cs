using System;

namespace SKT.LeanMES.AccessoryManagement.Model
{
    [Serializable]
    public class AccessoryHistoryInfo
    {
        private Int32 accessoryId;
        private String accessoryCodoe;
        private String accessoryName;
        private String serialNumber;
        private Int32 opType;
        private String createBy;
        private DateTime createTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.AccessoryManagement.Model.AccessoryHistoryInfo 类的新实例。
        /// </summary>
        public AccessoryHistoryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.AccessoryManagement.Model.AccessoryHistoryInfo 类的新实例。
        /// </summary>
        /// <param name="accessoryId"></param>
        /// <param name="accessoryCodoe"></param>
        /// <param name="accessoryName"></param>
        /// <param name="serialNumber"></param>
        /// <param name="opType"></param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        public AccessoryHistoryInfo(Int32 accessoryId, String accessoryCodoe, String accessoryName, String serialNumber, 
            Int32 opType, String createBy, DateTime createTime)
        {
            this.accessoryId = accessoryId;
            this.accessoryCodoe = accessoryCodoe;
            this.accessoryName = accessoryName;
            this.serialNumber = serialNumber;
            this.opType = opType;
            this.createBy = createBy;
            this.createTime = createTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AccessoryId
        {
            get { return this.accessoryId; }
            set { this.accessoryId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AccessoryCodoe
        {
            get { return this.accessoryCodoe; }
            set { this.accessoryCodoe = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AccessoryName
        {
            get { return this.accessoryName; }
            set { this.accessoryName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SerialNumber
        {
            get { return this.serialNumber; }
            set { this.serialNumber = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 OpType
        {
            get { return this.opType; }
            set { this.opType = value; }
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
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }
        public string OpTypeName { get; set; }
    }
}