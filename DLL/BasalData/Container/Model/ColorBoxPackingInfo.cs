using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Container.Model
{
    public class ColorBoxPackingInfo
    {
        private Int64 materialUnitId;
        private Int32 pID;
        private Int32 cID;
        private String serialNumber;
        private Int32 partId;
        private Int32 stationId;
        private DateTime creationTime;
        private DateTime finishTime;
        private Int32 lineId;
        private DateTime lastUpdate;
        private Int32 status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private Int32 flag;
        private DateTime packDateTime;
        private String itemName;
        private String cartonSn;
        private String packDataTimeStr;


        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ColorBoxPackingInfo 类的新实例。
        /// </summary>
        public ColorBoxPackingInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ColorBoxPackingInfo 类的新实例。
        /// </summary>
        /// <param name="materialUnitId"></param>
        /// <param name="pID">父级GRN ID</param>
        /// <param name="cID">卡板父级ID</param>
        /// <param name="serialNumber"></param>
        /// <param name="partId"></param>
        /// <param name="stationId"></param>
        /// <param name="creationTime"></param>
        /// <param name="finishTime"></param>
        /// <param name="lineId"></param>
        /// <param name="lastUpdate"></param>
        /// <param name="status"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="flag">用于标识GRN包装箱卡板状态，1 - 打开，0 - 关闭，-1 - GRN，2-卡板打开，3-卡板关闭</param>
        /// <param name="packDateTime"></param>
        public ColorBoxPackingInfo(Int64 materialUnitId, Int32 pID, Int32 cID, String serialNumber,
            Int32 partId, Int32 stationId, DateTime creationTime, DateTime finishTime, Int32 lineId,
            DateTime lastUpdate, Int32 status, String createBy, DateTime createDateTime, String modifyBy,
            DateTime modifyDateTime, Int32 flag, DateTime packDateTime)
        {
            this.materialUnitId = materialUnitId;
            this.pID = pID;
            this.cID = cID;
            this.serialNumber = serialNumber;
            this.partId = partId;
            this.stationId = stationId;
            this.creationTime = creationTime;
            this.finishTime = finishTime;
            this.lineId = lineId;
            this.lastUpdate = lastUpdate;
            this.status = status;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.flag = flag;
            this.packDateTime = packDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 MaterialUnitId
        {
            get { return this.materialUnitId; }
            set { this.materialUnitId = value; }
        }

        /// <summary>
        /// 获取或设置父级GRN ID
        /// </summary>
        public Int32 PID
        {
            get { return this.pID; }
            set { this.pID = value; }
        }

        /// <summary>
        /// 获取或设置卡板父级ID
        /// </summary>
        public Int32 CID
        {
            get { return this.cID; }
            set { this.cID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SerialNumber
        {
            get { return this.serialNumber; }
            set { this.serialNumber = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PartId
        {
            get { return this.partId; }
            set { this.partId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreationTime
        {
            get { return this.creationTime; }
            set { this.creationTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime FinishTime
        {
            get { return this.finishTime; }
            set { this.finishTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime LastUpdate
        {
            get { return this.lastUpdate; }
            set { this.lastUpdate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
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
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
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
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置用于标识GRN包装箱卡板状态，1 - 打开，0 - 关闭，-1 - GRN，2-卡板打开，3-卡板关闭
        /// </summary>
        public Int32 Flag
        {
            get { return this.flag; }
            set { this.flag = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime PackDateTime
        {
            get { return this.packDateTime; }
            set { this.packDateTime = value; }
        }
        /// <summary>
        /// 物料名称
        /// </summary>
        public String ItemName
        {
            get { return itemName; }
            set { itemName = value; }
        }
        /// <summary>
        /// 箱号
        /// </summary>
        public String CartonSn
        {
            get { return cartonSn; }
            set { cartonSn = value; }
        }
        public String PackDataTimeStr
        {
            get { return packDataTimeStr; }
            set { packDataTimeStr = value; }
        }
    }
}
