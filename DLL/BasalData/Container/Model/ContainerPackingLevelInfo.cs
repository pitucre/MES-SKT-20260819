using System;

namespace SKT.LeanMES.Container.Model
{
    [Serializable]
    public class ContainerPackingLevelInfo
    {
        private Int32 containerPackingLevelId;
        private Int32 containerId;
        private Int32 sequence;
        private String packingLevel;
        private String packingLevelValue;
        private String revision;
        private Int32 prodOrderID;
        private Decimal minQty;
        private Decimal maxQty;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        private String prodOrderName;

        /// <summary>
        /// 初始化 SKT.LeanMES.Container.Model.ContainerPackingLevelInfo 类的新实例。
        /// </summary>
        public ContainerPackingLevelInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Container.Model.ContainerPackingLevelInfo 类的新实例。
        /// </summary>
        /// <param name="containerPackingLevelId">Unique Identifier</param>
        /// <param name="containerId">Container.ContainerID</param>
        /// <param name="sequence">顺序号</param>
        /// <param name="packingLevel">包装的层次名称，通常是Item或者Container</param>
        /// <param name="packingLevelValue"></param>
        /// <param name="revision">如果选定产品，可以指定产品的版本号码</param>
        /// <param name="prodOrderID">工单编号，对应Prod_Order.ProdOrderID</param>
        /// <param name="minQty">最小的包装数量</param>
        /// <param name="maxQty">最大包装数量</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建人</param>
        public ContainerPackingLevelInfo(Int32 containerPackingLevelId, Int32 containerId, Int32 sequence, String packingLevel, 
            String packingLevelValue, String revision, Int32 prodOrderID, Decimal minQty, Decimal maxQty,
            DateTime modifyDateTime, String modifyBy, DateTime createDateTime, String createBy, string prodOrderName)
        {
            this.containerPackingLevelId = containerPackingLevelId;
            this.containerId = containerId;
            this.sequence = sequence;
            this.packingLevel = packingLevel;
            this.packingLevelValue = packingLevelValue;
            this.revision = revision;
            this.prodOrderID = prodOrderID;
            this.minQty = minQty;
            this.maxQty = maxQty;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.prodOrderName = prodOrderName;
        }

        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 ContainerPackingLevelId
        {
            get { return this.containerPackingLevelId; }
            set { this.containerPackingLevelId = value; }
        }

        /// <summary>
        /// 获取或设置Container.ContainerID
        /// </summary>
        public Int32 ContainerId
        {
            get { return this.containerId; }
            set { this.containerId = value; }
        }

        /// <summary>
        /// 获取或设置顺序号
        /// </summary>
        public Int32 Sequence
        {
            get { return this.sequence; }
            set { this.sequence = value; }
        }

        /// <summary>
        /// 获取或设置包装的层次名称，通常是Item或者Container
        /// </summary>
        public String PackingLevel
        {
            get { return this.packingLevel; }
            set { this.packingLevel = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PackingLevelValue
        {
            get { return this.packingLevelValue; }
            set { this.packingLevelValue = value; }
        }

        /// <summary>
        /// 获取或设置如果选定产品，可以指定产品的版本号码
        /// </summary>
        public String Revision
        {
            get { return this.revision; }
            set { this.revision = value; }
        }

        /// <summary>
        /// 获取或设置工单编号，对应Prod_Order.ProdOrderID
        /// </summary>
        public Int32 ProdOrderID
        {
            get { return this.prodOrderID; }
            set { this.prodOrderID = value; }
        }

        /// <summary>
        /// 获取或设置最小的包装数量
        /// </summary>
        public Decimal MinQty
        {
            get { return this.minQty; }
            set { this.minQty = value; }
        }

        /// <summary>
        /// 获取或设置最大包装数量
        /// </summary>
        public Decimal MaxQty
        {
            get { return this.maxQty; }
            set { this.maxQty = value; }
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
        /// 获取或设置
        /// </summary>
        public String ProdOrderName
        {
            get { return this.prodOrderName; }
            set { this.prodOrderName = value; }
        }
    }
}