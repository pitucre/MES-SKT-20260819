using System;

namespace SKT.LeanMES.Turnover.Model
{
    [Serializable]
    public class TurnoverGroupInfo
    {
        private Int32 turnoverGroupId;
        private String turnoverGroupName;
        private Int32 turnoverTypeId;
        private String turnoverTypeName;
        private Int32 itemId;
        private String itemName;
        private Int32 minQty;
        private Int32 maxQty;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;

        private Int32 validTurnoverQty;

        private String turnoverStatusDesc;

        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINERInfo 类的新实例。
        /// </summary>
        public TurnoverGroupInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINERInfo 类的新实例。
        /// </summary>
        /// <param name="cCID"></param>
        /// <param name="circulationContainer">周转箱分组名</param>
        /// <param name="cCTypeId">周转箱种类ID</param>
        /// <param name="itemId">项ID</param>
        /// <param name="minQty">最小容纳</param>
        /// <param name="maxQty">最大容纳</param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        public TurnoverGroupInfo(Int32 cCID, String circulationContainer, Int32 cCTypeId, Int32 itemId, 
            Int32 minQty, Int32 maxQty, DateTime createDateTime, String createBy, DateTime modifyDateTime, 
            String modifyBy)
        {
            this.turnoverGroupId = cCID;
            this.turnoverGroupName = circulationContainer;
            this.turnoverTypeId = cCTypeId;
            this.itemId = itemId;
            this.minQty = minQty;
            this.maxQty = maxQty;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
        }


        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINERInfo 类的新实例。
        /// </summary>
        /// <param name="cCID"></param>
        /// <param name="circulationContainer">周转箱分组名</param>
        /// <param name="cCTypeId">周转箱种类ID</param>
        /// <param name="itemId">项ID</param>
        /// <param name="minQty">最小容纳</param>
        /// <param name="maxQty">最大容纳</param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="cCTypeIdStr">周转箱种类描述</param>
        /// <param name="itemIdStr">项描述</param>
        /// <param name="validCirContainerQty">该分组包含多少个有效的周转箱</param>
        public TurnoverGroupInfo(Int32 cCID, String circulationContainer, Int32 cCTypeId, Int32 itemId,
            Int32 minQty, Int32 maxQty, DateTime createDateTime, String createBy, DateTime modifyDateTime,
            String modifyBy, String cCTypeIdStr, String itemIdStr, Int32 validCirContainerQty)
        {
            this.turnoverGroupId = cCID;
            this.turnoverGroupName = circulationContainer;
            this.turnoverTypeId = cCTypeId;
            this.itemId = itemId;
            this.minQty = minQty;
            this.maxQty = maxQty;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;

            this.turnoverTypeName = cCTypeIdStr;
            this.itemName = itemIdStr;
            this.validTurnoverQty = validCirContainerQty;
        }


        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINERInfo 类的新实例。
        /// </summary>
        /// <param name="cCID"></param>
        /// <param name="circulationContainer">周转箱分组名</param>
        /// <param name="cCTypeId">周转箱种类ID</param>
        /// <param name="itemId">项ID</param>
        /// <param name="minQty">最小容纳</param>
        /// <param name="maxQty">最大容纳</param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="cCTypeIdStr">周转箱种类描述</param>
        /// <param name="itemIdStr">项描述</param>
        public TurnoverGroupInfo(Int32 cCID, String circulationContainer, Int32 cCTypeId, Int32 itemId,
            Int32 minQty, Int32 maxQty, DateTime createDateTime, String createBy, DateTime modifyDateTime,
            String modifyBy, String cCTypeIdStr, String itemIdStr)
        {
            this.turnoverGroupId = cCID;
            this.turnoverGroupName = circulationContainer;
            this.turnoverTypeId = cCTypeId;
            this.itemId = itemId;
            this.minQty = minQty;
            this.maxQty = maxQty;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;

            this.turnoverTypeName = cCTypeIdStr;
            this.itemName = itemIdStr;
        }

        /// <summary>
        /// 获取或设置 周转工具分组Id
        /// </summary>
        public Int32 TurnoverGroupId
        {
            get { return this.turnoverGroupId; }
            set { this.turnoverGroupId = value; }
        }


        /// <summary>
        /// 获取或设置 周转工具种类Id
        /// </summary>
        public Int32 TurnoverTypeId
        {
            get { return this.turnoverTypeId; }
            set { this.turnoverTypeId = value; }
        }

        /// <summary>
        /// 获取或设置 周转工具分组名
        /// </summary>
        public String TurnoverGroupName
        {
            get { return this.turnoverGroupName; }
            set { this.turnoverGroupName = value; }
        }

        /// <summary>
        /// 获取或设置 产品Id
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置 产品名称
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }
        /// <summary>
        /// 获取或设置 产品编码
        /// </summary>
        public String ItemCode { get; set; }
       
        /// <summary>
        /// 获取或设置 最小包装数量
        /// </summary>
        public Int32 MinQty
        {
            get { return this.minQty; }
            set { this.minQty = value; }
        }

        /// <summary>
        /// 获取或设置 最大包装数量
        /// </summary>
        public Int32 MaxQty
        {
            get { return this.maxQty; }
            set { this.maxQty = value; }
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
        /// 获取或设置该分组包含多少个有效的周转箱
        /// </summary>
        public Int32 ValidTurnoverQty
        {
            get { return this.validTurnoverQty; }
            set { this.validTurnoverQty = value; }
        }

        /// <summary>
        /// 获取周转工具状态
        /// </summary>
        public String TurnoverStatusDesc
        {
            get { return turnoverStatusDesc; }
            set { turnoverStatusDesc = value; }
        }

        /// <summary>
        /// 获取周转工具种类描述
        /// </summary>
        public String TurnoverTypeName
        {
            get { return turnoverTypeName; }
            set { turnoverTypeName = value; }
        }
    }
}