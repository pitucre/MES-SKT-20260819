using System;

namespace SKT.LeanMES.Allowance.Model
{
    [Serializable]
    public class AllowanceInfo
    {
        private Int32 allowanceId;
        private Int32 userID;
        private Decimal wages;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        public String UserName { get; set; }
        public decimal OutputAllowance { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.AllowanceInfo 类的新实例。
        /// </summary>
        public AllowanceInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.AllowanceInfo 类的新实例。
        /// </summary>
        /// <param name="allowanceId"></param>
        /// <param name="userID"></param>
        /// <param name="wages"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public AllowanceInfo(Int32 allowanceId, Int32 userID, Decimal wages, String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.allowanceId = allowanceId;
            this.userID = userID;
            this.wages = wages;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AllowanceId
        {
            get { return this.allowanceId; }
            set { this.allowanceId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 UserID
        {
            get { return this.userID; }
            set { this.userID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal Wages
        {
            get { return this.wages; }
            set { this.wages = value; }
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
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}