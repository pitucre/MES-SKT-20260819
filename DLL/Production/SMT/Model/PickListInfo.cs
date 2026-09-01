using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SMT.Model
{

    [Serializable]
    public class PickListInfo
    {
        private Int32 listID;
        private String listName;
        private Int32 itemID;
        private Int32 stationID;
        private Int32 lineID;
        private Int32 customerID;
        private Int32 statusID;
        private Boolean isFullSet;
        private String revision;
        private String remark;
        private String createBy;
        private DateTime creationTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String itemName;
        private String station;
        private String lineName;
        private String customerName;
        private String statusStr;
        private String resName;
        private Int32 resId;
        private String itemCode;
        private String locationStr;
        private Decimal balanceQty;
        private Int32 prodOrderID;
        private String orderNo;
        private String grnStr;
        private Decimal alreadyQty;
        private Decimal notQty;
        private Decimal needQty;

        /// <summary>
        /// 初始化 SKT.MES.Model.PickListInfo 类的新实例。
        /// </summary>
        public PickListInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.PickListInfo 类的新实例。
        /// </summary>
        /// <param name="listID"></param>
        /// <param name="listName">PickListName</param>
        /// <param name="itemID"></param>
        /// <param name="stationID">工序id</param>
        /// <param name="lineID">线别id</param>
        /// <param name="customerID">客户id</param>
        /// <param name="statusID">状态id</param>
        /// <param name="isFullSet">是否全套</param>
        /// <param name="revision">版本控制</param>
        /// <param name="remark">备注</param>
        /// <param name="createBy">创建人</param>
        /// <param name="creationTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public PickListInfo(Int32 listID, String listName, Int32 itemID, Int32 stationID,
            Int32 lineID, Int32 customerID, Int32 statusID, Boolean isFullSet, String revision,
            String remark, String createBy, DateTime creationTime, String modifyBy, DateTime modifyDateTime)
        {
            this.listID = listID;
            this.listName = listName;
            this.itemID = itemID;
            this.stationID = stationID;
            this.lineID = lineID;
            this.customerID = customerID;
            this.statusID = statusID;
            this.isFullSet = isFullSet;
            this.revision = revision;
            this.remark = remark;
            this.createBy = createBy;
            this.creationTime = creationTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }


        public String GrnStr
        {
            get { return this.grnStr; }
            set { this.grnStr = value; }
        }

        public Decimal AlreadyQty
        {
            get { return this.alreadyQty; }
            set { this.alreadyQty = value; }
        }

        public Decimal NotQty
        {
            get { return this.notQty; }
            set { this.notQty = value; }
        }

        public Decimal NeedQty
        {
            get { return this.needQty; }
            set { this.needQty = value; }
        }

        public String  OrderNo
        {
            get { return this.orderNo; }
            set { this.orderNo = value; }
        }

        public Int32 ProdOrderID
        {
            get { return this.prodOrderID; }
            set { this.prodOrderID = value; }
        }

        public Decimal BalanceQty
        {
            get { return this.balanceQty; }
            set { this.balanceQty = value; }
        }

        public String LocationStr
        {
            get { return this.locationStr; }
            set { this.locationStr = value; }
        }

        public Int32 ResId
        {
            get { return this.resId; }
            set { this.resId = value; }
        }

        public String ResName
        {
            get { return this.resName; }
            set { this.resName = value; }
        }

        public String StatusStr
        {
            get { return this.statusStr; }
            set { this.statusStr = value; }
        }

        public String CustomerName
        {
            get { return this.customerName; }
            set { this.customerName = value; }
        }

        public String Station
        {
            get { return this.station; }
            set { this.station = value; }
        }

        public String LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
        }

        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ListID
        {
            get { return this.listID; }
            set { this.listID = value; }
        }

        /// <summary>
        /// 获取或设置PickListName
        /// </summary>
        public String ListName
        {
            get { return this.listName; }
            set { this.listName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置工序id
        /// </summary>
        public Int32 StationID
        {
            get { return this.stationID; }
            set { this.stationID = value; }
        }

        /// <summary>
        /// 获取或设置线别id
        /// </summary>
        public Int32 LineID
        {
            get { return this.lineID; }
            set { this.lineID = value; }
        }

        /// <summary>
        /// 获取或设置客户id
        /// </summary>
        public Int32 CustomerID
        {
            get { return this.customerID; }
            set { this.customerID = value; }
        }

        /// <summary>
        /// 获取或设置状态id
        /// </summary>
        public Int32 StatusID
        {
            get { return this.statusID; }
            set { this.statusID = value; }
        }

        /// <summary>
        /// 获取或设置是否全套
        /// </summary>
        public Boolean IsFullSet
        {
            get { return this.isFullSet; }
            set { this.isFullSet = value; }
        }

        /// <summary>
        /// 获取或设置版本控制
        /// </summary>
        public String Revision
        {
            get { return this.revision; }
            set { this.revision = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
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
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreationTime
        {
            get { return this.creationTime; }
            set { this.creationTime = value; }
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
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }
    }
}