using System;

namespace SKT.LeanMES.AccessoryManagement.Model
{
    [Serializable]
    public class AccessoryListInfo
    {
        private Int32 id;
        private String accessoryCode;
        private String accessoryName;
        private String accessoryType;
        private String wLType;
        private String unitName;
        private String createBy;
        private DateTime createTime;
        private String isFreeze;

        /// <summary>
        /// 初始化 SKT.LeanMES.AccessoryManagement.Model.AccessoryListInfo 类的新实例。
        /// </summary>
        public AccessoryListInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.AccessoryManagement.Model.AccessoryListInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="accessoryCode"></param>
        /// <param name="accessoryName"></param>
        /// <param name="accessoryType"></param>
        /// <param name="wLTpye"></param>
        /// <param name="unitName"></param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        public AccessoryListInfo(Int32 id, String accessoryCode, String accessoryName, String accessoryType, 
            String wLType, String unitName, String createBy, DateTime createTime,String isFreeze)
        {
            this.id = id;
            this.accessoryCode = accessoryCode;
            this.accessoryName = accessoryName;
            this.accessoryType = accessoryType;
            this.wLType = wLType;
            this.unitName = unitName;
            this.createBy = createBy;
            this.createTime = createTime;
            this.isFreeze = isFreeze;
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
        public String AccessoryCode
        {
            get { return this.accessoryCode; }
            set { this.accessoryCode = value; }
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
        public String AccessoryType
        {
            get { return this.accessoryType; }
            set { this.accessoryType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String WLType
        {
            get { return this.wLType; }
            set { this.wLType = value; }
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
        public string AccessoryTypeName { get; set; }
        /// <summary>
        /// 规格
        /// </summary>
        public string ItemSpec { get; set; }

        /// <summary>
        /// 物料Id
        /// </summary>
        public int ItemId { get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String IsFreeze
        {
            get { return this.isFreeze; }
            set { this.isFreeze = value; }
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