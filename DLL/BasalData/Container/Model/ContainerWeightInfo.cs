using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Container.Model
{
    [Serializable]
    public class ContainerWeightInfo
    {
        private Int32 containerWeightId;
        private String itemCode;
        private Int32 itemId;
        private String packingType;
        private Decimal minWeight;
        private Decimal maxWeight;
        private String unitId;
        private String unitName;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        public string OrderNO { get; set; }
        public int ProdOrderId { get; set; }
        public int TypeId { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Container.Model.ContainerWeightInfo 类的新实例。
        /// </summary>
        public ContainerWeightInfo()
        {
        }

        public ContainerWeightInfo(Int32 containerWeightId, String itemCode, Int32 itemId, String packingType,
           Decimal minWeight, Decimal maxWeight, String unitId, String unitName, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.containerWeightId = containerWeightId;
            this.itemCode = itemCode;
            this.itemId = itemId;
            this.packingType = packingType;
            this.minWeight = minWeight;
            this.maxWeight = maxWeight;
            this.unitId = unitId;
            this.unitName = unitName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;


        }

        /// <summary>
        /// 包装重量Id
        /// </summary>
        public Int32 ContainerWeightId
        {
            get { return this.containerWeightId; }
            set { this.containerWeightId = value; }
        }

        /// <summary>
        /// 产品编码
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// 产品名称
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 
        /// </summary>
        public String PackingType
        {
            get { return this.packingType; }
            set { this.packingType = value; }
        }

        /// <summary>
        /// 最小重量
        /// </summary>
        public Decimal MinWeight
        {
            get { return this.minWeight; }
            set { this.minWeight = value; }
        }

        /// <summary>
        /// 最大重量
        /// </summary>
        public Decimal MaxWeight
        {
            get { return this.maxWeight; }
            set { this.maxWeight = value; }
        }

        /// <summary>
        /// 设置单位id
        /// </summary>
        public String UnitId
        {
            get { return this.unitId; }
            set { this.unitId = value; }
        }

        /// <summary>
        /// 设置单位名称
        /// </summary>
        public String UnitName
        {
            get { return this.unitName; }
            set { this.unitName = value; }
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

        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }
    }
}
