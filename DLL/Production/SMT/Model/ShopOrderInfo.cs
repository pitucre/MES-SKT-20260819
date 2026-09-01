using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
 
namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class ShopOrderInfo
    {
        private Int32 prodOrderID;
        private String orderNO;
        private Int32 orderType;
        private Int32 status;
        private Int32 priority;
        private Int32 itemId;
        private Int32 bOMId;
        private Int32 routerId;
        private Int32 customerID;
        private String customerOrder;
        private Int32 customerOrderQty;
        private Int32 qty_to_Build;
        private Int32 qty_Released;
        private Int32 qty_Done;
        private Int32 qty_Scrapped;
        private DateTime release_date;
        private DateTime planned_Start_Time;
        private DateTime planned_Completed_Date;
        private DateTime scheduled_Start_Date;
        private DateTime scheduled_Completed_Time;
        private DateTime actual_Start_Date;
        private DateTime actual_Completed_Date;
        private String createBy;
        private DateTime createTime;
        private String modifyBy;
        private DateTime modifyTime;

        private String itemName;
        private String itemVer;
        private String bOMName;
        private String bOMVer;
        private String routerName;
        private String customerName;

        private String itemName2;

        /// <summary>
        /// 初始化 SKT.MES.User.Model.ORDERInfo 类的新实例。
        /// </summary>
        public ShopOrderInfo()
        {
        }
        /// <summary>
        /// 初始化 SKT.MES.User.Model.ORDERInfo 类的新实例。
        /// </summary>
        public ShopOrderInfo(Int32 prodOrderId, String orderNo,Int32 ItemId)
        {
            this.prodOrderID = prodOrderId;
            this.orderNO = orderNo;
            this.itemId = ItemId;
        }
        /// <summary>
        /// ProdOrderID, OrderNO, ItemId,OrderType,Status,CustomerOrder
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="orderNo"></param>
        /// <param name="ItemId"></param>
        public ShopOrderInfo(Int32 prodOrderId, String orderNo, Int32 ItemId,Int32 orderType,int status,String customerOrder)
        {
            this.prodOrderID = prodOrderId;
            this.orderNO = orderNo;
            this.itemId = ItemId;
            this.orderType = orderType;
            this.status = status;
            this.customerOrder = customerOrder;
        }
        /// <summary>
        /// 初始化 SKT.MES.User.Model.ORDERInfo 类的新实例。
        /// </summary>
        /// <param name="prodOrderID">工单ID</param>
        /// <param name="orderNO"></param>
        /// <param name="orderType">工单类型</param>
        /// <param name="status">工单状态</param>
        /// <param name="priority">工单优先级</param>
        /// <param name="itemId">产品ID</param>
        /// <param name="bOMId">BOMID</param>
        /// <param name="routerId">路由ID</param>
        /// <param name="customerID">客户ID</param>
        /// <param name="customerOrder">客户订单号码</param>
        /// <param name="qty_to_Build">工单数量</param>
        /// <param name="qty_Released">已经释放数量</param>
        /// <param name="qty_Done">已经完成数量</param>
        /// <param name="qty_Scrapped">报废数量</param>
        /// <param name="release_date">工单最新释放时间</param>
        /// <param name="planned_Start_Time">工单计划开始时间</param>
        /// <param name="planned_Completed_Date">工单计划结束时间</param>
        /// <param name="scheduled_Start_Date">工单排产开始时间</param>
        /// <param name="scheduled_Completed_Time">工单排产完成时间</param>
        /// <param name="actual_Start_Date">工单时间(开始键，扫描第一个站位开始)</param>
        /// <param name="actual_Completed_Date">工单实际完成时间(END)</param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyTime"></param>
        public ShopOrderInfo(Int32 prodOrderID, String orderNO, Int32 orderType, Int32 status, 
            Int32 priority, Int32 itemId, Int32 bOMId, Int32 routerId, Int32 customerID,
            String customerOrder, Int32 customerOrderQty, Int32 qty_to_Build, Int32 qty_Released, Int32 qty_Done, Int32 qty_Scrapped, 
            DateTime release_date, DateTime planned_Start_Time, DateTime planned_Completed_Date, DateTime scheduled_Start_Date, DateTime scheduled_Completed_Time, 
            DateTime actual_Start_Date, DateTime actual_Completed_Date, String createBy, DateTime createTime, String modifyBy, 
            DateTime modifyTime)
        {
            this.prodOrderID = prodOrderID;
            this.orderNO = orderNO;
            this.orderType = orderType;
            this.status = status;
            this.priority = priority;
            this.itemId = itemId;
            this.bOMId = bOMId;
            this.routerId = routerId;
            this.customerID = customerID;
            this.customerOrder = customerOrder;
            this.customerOrderQty = customerOrderQty;
            this.qty_to_Build = qty_to_Build;
            this.qty_Released = qty_Released;
            this.qty_Done = qty_Done;
            this.qty_Scrapped = qty_Scrapped;
            this.release_date = release_date;
            this.planned_Start_Time = planned_Start_Time;
            this.planned_Completed_Date = planned_Completed_Date;
            this.scheduled_Start_Date = scheduled_Start_Date;
            this.scheduled_Completed_Time = scheduled_Completed_Time;
            this.actual_Start_Date = actual_Start_Date;
            this.actual_Completed_Date = actual_Completed_Date;
            this.createBy = createBy;
            this.createTime = createTime;
            this.modifyBy = modifyBy;
            this.modifyTime = modifyTime;
        }

        /// <summary>
        /// 获取或设置工单ID
        /// </summary>
        public Int32 ProdOrderID
        {
            get { return this.prodOrderID; }
            set { this.prodOrderID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String OrderNO
        {
            get { return this.orderNO; }
            set { this.orderNO = value; }
        }

        /// <summary>
        /// 获取或设置工单类型
        /// </summary>
        public Int32 OrderType
        {
            get { return this.orderType; }
            set { this.orderType = value; }
        }

        /// <summary>
        /// 获取或设置工单状态
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置工单优先级
        /// </summary>
        public Int32 Priority
        {
            get { return this.priority; }
            set { this.priority = value; }
        }

        /// <summary>
        /// 获取或设置产品ID
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置BOMID
        /// </summary>
        public Int32 BOMId
        {
            get { return this.bOMId; }
            set { this.bOMId = value; }
        }

        /// <summary>
        /// 获取或设置路由ID
        /// </summary>
        public Int32 RouterId
        {
            get { return this.routerId; }
            set { this.routerId = value; }
        }

        /// <summary>
        /// 获取或设置客户ID
        /// </summary>
        public Int32 CustomerID
        {
            get { return this.customerID; }
            set { this.customerID = value; }
        }

        /// <summary>
        /// 获取或设置客户订单号码
        /// </summary>
        public String CustomerOrder
        {
            get { return this.customerOrder; }
            set { this.customerOrder = value; }
        }

        public Int32 CustomerOrderQty
        {
            get { return this.customerOrderQty; }
            set { this.customerOrderQty = value; }
        }

        /// <summary>
        /// 获取或设置工单数量
        /// </summary>
        public Int32 Qty_to_Build
        {
            get { return this.qty_to_Build; }
            set { this.qty_to_Build = value; }
        }

        /// <summary>
        /// 获取或设置已经释放数量
        /// </summary>
        public Int32 Qty_Released
        {
            get { return this.qty_Released; }
            set { this.qty_Released = value; }
        }

        /// <summary>
        /// 获取或设置已经完成数量
        /// </summary>
        public Int32 Qty_Done
        {
            get { return this.qty_Done; }
            set { this.qty_Done = value; }
        }

        /// <summary>
        /// 获取或设置报废数量
        /// </summary>
        public Int32 Qty_Scrapped
        {
            get { return this.qty_Scrapped; }
            set { this.qty_Scrapped = value; }
        }

        /// <summary>
        /// 获取或设置工单最新释放时间
        /// </summary>
        public DateTime Release_date
        {
            get { return this.release_date; }
            set { this.release_date = value; }
        }

        /// <summary>
        /// 获取或设置工单计划开始时间
        /// </summary>
        public DateTime Planned_Start_Time
        {
            get { return this.planned_Start_Time; }
            set { this.planned_Start_Time = value; }
        }

        /// <summary>
        /// 获取或设置工单计划结束时间
        /// </summary>
        public DateTime Planned_Completed_Date
        {
            get { return this.planned_Completed_Date; }
            set { this.planned_Completed_Date = value; }
        }

        /// <summary>
        /// 获取或设置工单排产开始时间
        /// </summary>
        public DateTime Scheduled_Start_Date
        {
            get { return this.scheduled_Start_Date; }
            set { this.scheduled_Start_Date = value; }
        }

        /// <summary>
        /// 获取或设置工单排产完成时间
        /// </summary>
        public DateTime Scheduled_Completed_Time
        {
            get { return this.scheduled_Completed_Time; }
            set { this.scheduled_Completed_Time = value; }
        }

        /// <summary>
        /// 获取或设置工单时间(开始键，扫描第一个站位开始)
        /// </summary>
        public DateTime Actual_Start_Date
        {
            get { return this.actual_Start_Date; }
            set { this.actual_Start_Date = value; }
        }

        /// <summary>
        /// 获取或设置工单实际完成时间(END)
        /// </summary>
        public DateTime Actual_Completed_Date
        {
            get { return this.actual_Completed_Date; }
            set { this.actual_Completed_Date = value; }
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
        public DateTime ModifyTime
        {
            get { return this.modifyTime; }
            set { this.modifyTime = value; }
        }

        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        public String ItemVer
        {
            get { return this.itemVer; }
            set { this.itemVer = value; }
        }

        public String BOMName
        {
            get { return this.bOMName; }
            set { this.bOMName = value; }
        }

        public String BOMVer
        {
            get { return this.bOMVer; }
            set { this.bOMVer = value; }
        }

        public String RouterName
        {
            get { return this.routerName; }
            set { this.routerName = value; }
        }

        public String CustomerName
        {
            get { return this.customerName; }
            set { this.customerName = value; }
        }

        public String ItemName2
        {
            get { return itemName2; }
            set { itemName2 = value; }
        }
    }
}