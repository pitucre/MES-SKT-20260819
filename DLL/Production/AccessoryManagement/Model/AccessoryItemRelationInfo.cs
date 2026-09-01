using System;

namespace SKT.LeanMES.AccessoryManagement.Model
{
    [Serializable]
    public class AccessoryItemRelationInfo:AccessoryItemRelationDtlInfo
    {
        private Int32 id;
        private String itemCode;
        private String accessoryCode;
        private string machineTypeId;
        private Decimal value;
        private String unitName;
        private String createBy;
        private DateTime createTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.AccessoryManagement.Model.AccessoryItemRelationInfo 类的新实例。
        /// </summary>
        public AccessoryItemRelationInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.AccessoryManagement.Model.AccessoryItemRelationInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="itemCode"></param>
        /// <param name="accessoryCode"></param>
        /// <param name="machineTypeId"></param>
        /// <param name="value"></param>
        /// <param name="unitName"></param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        public AccessoryItemRelationInfo(Int32 id, String itemCode, String accessoryCode, string machineTypeId, 
            Decimal value, String unitName, String createBy, DateTime createTime)
        {
            this.id = id;
            this.itemCode = itemCode;
            this.accessoryCode = accessoryCode;
            this.machineTypeId = machineTypeId;
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
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
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
        public string MachineTypeId
        {
            get { return this.machineTypeId; }
            set { this.machineTypeId = value; }
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