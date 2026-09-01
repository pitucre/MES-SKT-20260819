using System;

namespace SKT.LeanMES.AccessoryManagement.Model
{
    [Serializable]
    public class AccessoryItemRelationDtlInfo
    {
        private Int32 id;
        private Int32 pid;
        private String accessoryCode;
        private Decimal value;
        private String unitName;
        private String createBy;
        private DateTime createTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.AccessoryManagement.Model.AccessoryItemRelationDtlInfo 类的新实例。
        /// </summary>
        public AccessoryItemRelationDtlInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.AccessoryManagement.Model.AccessoryItemRelationDtlInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="pid"></param>
        /// <param name="accessoryCode"></param>
        /// <param name="value"></param>
        /// <param name="unitName"></param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        public AccessoryItemRelationDtlInfo(Int32 id, Int32 pid, String accessoryCode, Decimal value, 
            String unitName, String createBy, DateTime createTime)
        {
            this.id = id;
            this.pid = pid;
            this.accessoryCode = accessoryCode;
            this.value = value;
            this.unitName = unitName;
            this.createBy = createBy;
            this.createTime = createTime;
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
        public Int32 Pid
        {
            get { return this.pid; }
            set { this.pid = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AccessoryCode
        {
            get { return this.accessoryCode; }
            set { this.accessoryCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal Value
        {
            get { return this.value; }
            set { this.value = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String UnitName
        {
            get { return this.unitName; }
            set { this.unitName = value; }
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
        public string ItemName { get; set; }
        public string ItemSpec { get; set; }
    }
}