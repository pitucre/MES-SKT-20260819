using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProdUnit.Model
{
    [Serializable]
    public class ProdUnitInfo
    {
        private Int64 uID;
        private Int32 opeID;
        private Boolean isPass;
        private Int32 statusID;
        private Int32 r_ID;
        private Int64 panelID;
        private Int32 lineID;
        private Int32 prodOrderID;
        private Int32 rMAID;
        private Int32 bomID;
        private Int32 itemID;
        private Int32 userID;
        private Int32 resID;
        private DateTime createTime;
        private DateTime lastUpdate;

        public String Station { get; set; }
        public String SerialNumber { get; set; }
        public String FatherSerialNumber { get; set; } //主序列号

        public String OrderNo { get; set; }
        public String ItemCode { get; set; }
        public String ItemSpec { get; set; }
        public int Qty { get; set; }
        public String Units { get; set; }
        public String RouterName { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public ProdUnitInfo()
        {
        }

        /// <summary>
        /// </summary>
        /// <param name="uID"></param>
        /// <param name="opeID">工位ID</param>
        /// <param name="isPass">操作结果</param>
        /// <param name="statusID">状态</param>
        /// <param name="r_ID">路由ID</param>
        /// <param name="panelID">连板ID</param>
        /// <param name="lineID">线别ID</param>
        /// <param name="wOID">工单ID</param>
        /// <param name="rMAID">返工单ID</param>
        /// <param name="itemID">产品ID</param>
        /// <param name="userID">操作员工</param>
        /// <param name="createTime">创建时间</param>
        /// <param name="lastUpdate">最后更新时间</param>
        public ProdUnitInfo(Int64 uID, Int32 opeID, Boolean isPass, Int32 statusID,
            Int32 r_ID, Int32 panelID, Int32 lineID, Int32 prodOrderID, Int32 rMAID, Int32 bomID, Int32 resID,
            Int32 itemID, Int32 userID, DateTime createTime, DateTime lastUpdate)
        {
            this.uID = uID;
            this.opeID = opeID;
            this.isPass = isPass;
            this.statusID = statusID;
            this.r_ID = r_ID;
            this.panelID = panelID;
            this.lineID = lineID;
            this.prodOrderID = prodOrderID;
            this.rMAID = rMAID;
            this.bomID = bomID;
            this.resID = resID;
            this.itemID = itemID;
            this.userID = userID;
            this.createTime = createTime;
            this.lastUpdate = lastUpdate;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 UnitId
        {
            get { return this.uID; }
            set { this.uID = value; }
        }

        /// <summary>
        /// 获取或设置工位ID
        /// </summary>
        public Int32 StationId
        {
            get { return this.opeID; }
            set { this.opeID = value; }
        }

        /// <summary>
        /// 获取或设置操作结果
        /// </summary>
        public Boolean IsPass
        {
            get { return this.isPass; }
            set { this.isPass = value; }
        }

        /// <summary>
        /// 获取或设置状态
        /// </summary>
        public Int32 StatusId
        {
            get { return this.statusID; }
            set { this.statusID = value; }
        }

        /// <summary>
        /// 获取或设置路由ID
        /// </summary>
        public Int32 RouterId
        {
            get { return this.r_ID; }
            set { this.r_ID = value; }
        }

        /// <summary>
        /// 获取或设置连板ID
        /// </summary>
        public Int64 PanelId
        {
            get { return this.panelID; }
            set { this.panelID = value; }
        }

        /// <summary>
        /// 获取或设置线别ID
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineID; }
            set { this.lineID = value; }
        }

        /// <summary>
        /// 获取或设置工单ID
        /// </summary>
        public Int32 ProdOrderId
        {
            get { return this.prodOrderID; }
            set { this.prodOrderID = value; }
        }

        /// <summary>
        /// 获取或设置返工单ID
        /// </summary>
        public Int32 RmaId
        {
            get { return this.rMAID; }
            set { this.rMAID = value; }
        }

        /// <summary>
        /// 获取或设置返物料清单ID
        /// </summary>
        public Int32 BomId
        {
            get { return this.bomID; }
            set { this.bomID = value; }
        }

        /// <summary>
        /// 获取或设置返物料清单ID
        /// </summary>
        public Int32 ResourceId
        {
            get { return this.resID; }
            set { this.resID = value; }
        }

        /// <summary>
        /// 获取或设置产品ID
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置操作员工
        /// </summary>
        public Int32 UserId
        {
            get { return this.userID; }
            set { this.userID = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置最后更新时间
        /// </summary>
        public DateTime LastUpdate
        {
            get { return this.lastUpdate; }
            set { this.lastUpdate = value; }
        }
    }
}
