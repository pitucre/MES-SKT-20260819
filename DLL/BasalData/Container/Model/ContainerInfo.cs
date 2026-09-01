using System;

namespace SKT.LeanMES.Container.Model
{
    [Serializable]
    public class ContainerInfo
    {
        private Int32 containerId;
        private String name;
        private String description;
        private String dataTypeName;
        private Int32 dataTypeId;
        private Decimal height;
        private Decimal width;
        private Decimal depth;
        private Decimal weight;
        private Decimal maxFillWeight;
        private String status;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;
        private Boolean mixShopOrders;

        //Add By Alen Liu 2016-06-27
        private Boolean mixItems;
        public Boolean Sequence { get; set; }//
        
        /// <summary>
        /// 包装箱内容
        /// </summary>
        public string PackingValue { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Container.Model.ContainerInfo 类的新实例。
        /// </summary>
        public ContainerInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Container.Model.ContainerInfo 类的新实例。
        /// </summary>
        /// <param name="containerId">Container Unique Identifier</param>
        /// <param name="name">Container的名称</param>
        /// <param name="description">描述</param>
        /// <param name="dataTypeId">这个字段也是对应Basal_DataType表中的DataTypeId，类型是PACK SFC</param>
        /// <param name="height">包装的高度</param>
        /// <param name="width">包装的宽度</param>
        /// <param name="depth">包装的长度</param>
        /// <param name="weight">包装的重量</param>
        /// <param name="maxFillWeight">重量上限</param>
        /// <param name="status">包装的状态，Open或者Closed</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建人</param>
        /// <param name="mixShopOrders">是否可以混工单，0：false 1：true</param>
        public ContainerInfo(Int32 containerId, String name, String description, Int32 dataTypeId, 
            Decimal height, Decimal width, Decimal depth, Decimal weight, Decimal maxFillWeight, 
            String status, DateTime modifyDateTime, String modifyBy, DateTime createDateTime, String createBy, 
            Boolean mixShopOrders)
        {
            this.containerId = containerId;
            this.name = name;
            this.description = description;
            this.dataTypeId = dataTypeId;
            this.height = height;
            this.width = width;
            this.depth = depth;
            this.weight = weight;
            this.maxFillWeight = maxFillWeight;
            this.status = status;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.mixShopOrders = mixShopOrders;
        }

        /// <summary>
        /// 获取或设置Container Unique Identifier
        /// </summary>
        public Int32 ContainerId
        {
            get { return this.containerId; }
            set { this.containerId = value; }
        }

        /// <summary>
        /// 获取或设置Container的名称
        /// </summary>
        public String Name
        {
            get { return this.name; }
            set { this.name = value; }
        }

        /// <summary>
        /// 获取或设置描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String DataTypeName
        {
            get { return this.dataTypeName; }
            set { this.dataTypeName = value; }
        }

        /// <summary>
        /// 获取或设置这个字段也是对应Basal_DataType表中的DataTypeId，类型是PACK SFC
        /// </summary>
        public Int32 DataTypeId
        {
            get { return this.dataTypeId; }
            set { this.dataTypeId = value; }
        }

        /// <summary>
        /// 获取或设置包装的高度
        /// </summary>
        public Decimal Height
        {
            get { return this.height; }
            set { this.height = value; }
        }

        /// <summary>
        /// 获取或设置包装的宽度
        /// </summary>
        public Decimal Width
        {
            get { return this.width; }
            set { this.width = value; }
        }

        /// <summary>
        /// 获取或设置包装的长度
        /// </summary>
        public Decimal Depth
        {
            get { return this.depth; }
            set { this.depth = value; }
        }

        /// <summary>
        /// 获取或设置包装的重量
        /// </summary>
        public Decimal Weight
        {
            get { return this.weight; }
            set { this.weight = value; }
        }

        /// <summary>
        /// 获取或设置重量上限
        /// </summary>
        public Decimal MaxFillWeight
        {
            get { return this.maxFillWeight; }
            set { this.maxFillWeight = value; }
        }

        /// <summary>
        /// 获取或设置包装的状态，Open或者Closed
        /// </summary>
        public String Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置是否可以混工单，0：false 1：true
        /// </summary>
        public Boolean MixShopOrders
        {
            get { return this.mixShopOrders; }
            set { this.mixShopOrders = value; }
        }

        /// <summary>
        /// 获取或设置是否可以混工单，0：false 1：true
        /// </summary>
        public Boolean MixItems
        {
            get { return this.mixItems; }
            set { this.mixItems = value; }
        }
    }
}