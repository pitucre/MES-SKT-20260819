using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class RMAUnitInfo
    {
        private Int64 rMAUnitID;
        private Int32 rMAID;
        private Int64 unitID;
        private Int32 status;
        private Int32 failCode;
        private String cwhCode;
        private String cbarCode;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.RMAUnitInfo 类的新实例。
        /// </summary>
        public RMAUnitInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.RMAUnitInfo 类的新实例。
        /// </summary>
        /// <param name="rMAUnitID"></param>
        /// <param name="rMAID"></param>
        /// <param name="unitID"></param>
        /// <param name="status"></param>
        /// <param name="failCode"></param>
        /// <param name="cWhCode"></param>
        /// <param name="cBarCode"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public RMAUnitInfo(Int64 rMAUnitID, Int32 rMAID, Int64 unitID, Int32 status, 
            Int32 failCode, String cWhCode, String cBarCode, String createBy, DateTime createDateTime, 
            String modifyBy, DateTime modifyDateTime)
        {
            this.rMAUnitID = rMAUnitID;
            this.rMAID = rMAID;
            this.unitID = unitID;
            this.status = status;
            this.failCode = failCode;
            this.cwhCode = cWhCode;
            this.cbarCode = cBarCode;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        public string RmaNo { set; get; }

        public string ItemCode { set; get; }

        public string ItemName { set; get; }

        public string ItemSpec { set; get; }

        public string SN { set; get; }

        public string CWhName { set; get; }

        public string StatusName { set; get; }

        public string SerialNumber { set; get; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 RMAUnitID
        {
            get { return this.rMAUnitID; }
            set { this.rMAUnitID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 RMAID
        {
            get { return this.rMAID; }
            set { this.rMAID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 UnitID
        {
            get { return this.unitID; }
            set { this.unitID = value; }
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
        public Int32 FailCode
        {
            get { return this.failCode; }
            set { this.failCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String cWhCode
        {
            get { return this.cwhCode; }
            set { this.cwhCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String cBarCode
        {
            get { return this.cbarCode; }
            set { this.cbarCode = value; }
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
    }
}