using System;

namespace SKT.LeanMES.Manufacture.Model
{
    [Serializable]
    public class ContainerInfo
    {
        private Int32 containerID;
        private String name;
        private String description;
        private String dataTypeName;
        private Int32 dataType;
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


        private String cDstatus;
        private String oPeration;
        private String userName;

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.CONTAINERInfo 类的新实例。
        /// </summary>
        public ContainerInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.CONTAINERInfo 类的新实例。
        /// </summary>
        /// <param name="containerID"></param>
        /// <param name="name"></param>
        /// <param name="description"></param>
        /// <param name="dataTypeName"></param>
        /// <param name="dataType"></param>
        /// <param name="height"></param>
        /// <param name="width"></param>
        /// <param name="depth"></param>
        /// <param name="weight"></param>
        /// <param name="maxFillWeight"></param>
        /// <param name="status"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="mixShopOrders"></param>
        public ContainerInfo(Int32 containerID, String name, String description, 
            Int32 dataType, Decimal height, Decimal width, Decimal depth, Decimal weight, 
            Decimal maxFillWeight, String status, DateTime modifyDateTime, String modifyBy, DateTime createDateTime, 
            String createBy, Boolean mixShopOrders)
        {
            this.containerID = containerID;
            this.name = name;
            this.description = description;
            this.dataType = dataType;
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
        /// 获取或设置
        /// </summary>
        public Int32 ContainerID
        {
            get { return this.containerID; }
            set { this.containerID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Name
        {
            get { return this.name; }
            set { this.name = value; }
        }

        /// <summary>
        /// 获取或设置
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
        /// 获取或设置
        /// </summary>
        public Int32 DataType
        {
            get { return this.dataType; }
            set { this.dataType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal Height
        {
            get { return this.height; }
            set { this.height = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal Width
        {
            get { return this.width; }
            set { this.width = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal Depth
        {
            get { return this.depth; }
            set { this.depth = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal Weight
        {
            get { return this.weight; }
            set { this.weight = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal MaxFillWeight
        {
            get { return this.maxFillWeight; }
            set { this.maxFillWeight = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
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
        public Boolean MixShopOrders
        {
            get { return this.mixShopOrders; }
            set { this.mixShopOrders = value; }
        }


        public String CDstatus
        {
            get { return this.cDstatus; }
            set { this.cDstatus = value; }
        }

        public String OPeration
        {
            get { return this.oPeration; }
            set { this.oPeration = value; }
        }

        public String UserName
        {
            get { return this.userName; }
            set { this.userName = value; }
        }
    }
}