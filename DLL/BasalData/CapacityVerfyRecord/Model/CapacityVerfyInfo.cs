using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.CapacityVerfyRecord.Model
{
    [Serializable]
    public class CapacityVerfyInfo
    {
        private Int32 stationID;
        private String stationName;
        private Int32 equipmentID;
        private String equipmentCode;
        private Int32 itemID;
        private String itemCode;
        private Decimal qty;
        private Decimal ngQty;
        public String createTime;
        public String userCode;
        public String userName;
        public Int32 userId;
        public String price;
        public String salary;
        public Int32 PieceWageID { get; set; }


        /// <summary>
        /// 初始化 SKT.LeanMES.Model.IPQCVerfyRecordInfo 类的新实例。
        /// </summary>
        public CapacityVerfyInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.IPQCVerfyRecordInfo 类的新实例。
        /// </summary>
        public CapacityVerfyInfo(Int32 stationId, Int32 equipmentId, Int32 itemId, String stationName, String equipmentCode,
             String itemCode, String price, decimal qty, String salary, String userCode, String userName)
        {
            this.StationID = stationId;
            this.EquipmentID = equipmentId;
            this.ItemID = itemId;
            this.StationName = stationName;
            this.EquipmentCode = equipmentCode;
            this.ItemCode = itemCode;
            this.Price = price;
            this.Qty = qty;
            this.Salary = salary;
            this.UserName = userName;
            this.UserCode = userCode;
        }


        public CapacityVerfyInfo(Int32 stationId, Int32 equipmentId, Int32 itemId, String stationName, String equipmentCode,
            String itemCode, decimal qty, decimal ngQty, String createTime, String userCode)
        {
            this.StationID = stationId;
            this.EquipmentID = equipmentId;
            this.ItemID = itemId;
            this.StationName = stationName;
            this.EquipmentCode = equipmentCode;
            this.ItemCode = itemCode;
            this.Price = price;
            this.Qty = qty;
            this.NGQty = ngQty;
            this.CreateTime = createTime;
            this.UserCode = userCode;
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationID
        {
            get { return this.stationID; }
            set { this.stationID = value; }
        }

        /// <summary>
        /// 获取或设置SN编号
        /// </summary>
        public String StationName
        {
            get { return this.stationName; }
            set { this.stationName = value; }
        }

        /// <summary>
        /// 获取或设置SN数量
        /// </summary>
        public Int32 EquipmentID
        {
            get { return this.equipmentID; }
            set { this.equipmentID = value; }
        }

        /// <summary>
        /// 获取或设置状态 0:正常，2:不良
        /// </summary>
        public String EquipmentCode
        {
            get { return this.equipmentCode; }
            set { this.equipmentCode = value; }
        }

        /// <summary>
        /// 获取或设置SN数量
        /// </summary>
        public Int32 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }


        /// <summary>
        /// 获取或设置SN数量
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }



        /// <summary>
        /// 获取或设置SN数量
        /// </summary>
        public Decimal Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 获取或设置不良数量
        /// </summary>
        public Decimal NGQty
        {
            get { return this.ngQty; }
            set { this.ngQty = value; }
        }

        /// <summary>
        /// 获取或设置价格标准
        /// </summary>
        public String Price
        {
            get { return this.price; }
            set { this.price = value; }
        }

        /// <summary>
        /// 获取或设置确认时间
        /// </summary>
        public String CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置确认人
        /// </summary>
        public String UserCode
        {
            get { return this.userCode; }
            set { this.userCode = value; }
        }


        /// <summary>
        /// 获取或设置确认人
        /// </summary>
        public String UserName
        {
            get { return this.userName; }
            set { this.userName = value; }
        }

        /// <summary>
        /// 获取或设置确认人
        /// </summary>
        public Int32 UserId
        {
            get { return this.userId; }
            set { this.userId = value; }
        }

        /// <summary>
        /// 获取或设置SN数量
        /// </summary>
        public String Salary
        {
            get { return this.salary; }
            set { this.salary = value; }
        }

    }
}
