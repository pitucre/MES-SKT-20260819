using System;

namespace SKT.LeanMES.PieceWage.Model
{
    [Serializable]
    public class PieceworkCompensationInfo
    {
        private Int32 pieceworkCompensationID;
        private DateTime pieceCountingTime;
        private Int32 userID;
        private Decimal wage;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String username;
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PieceworkCompensationInfo 类的新实例。
        /// </summary>
        public PieceworkCompensationInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PieceworkCompensationInfo 类的新实例。
        /// </summary>
        /// <param name="pieceworkCompensationID"></param>
        /// <param name="pieceCountingTime">计件日期</param>
        /// <param name="userID">用户ID</param>
        /// <param name="wage">工资</param>
        /// <param name="remark">备注</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        public PieceworkCompensationInfo(Int32 pieceworkCompensationID, DateTime pieceCountingTime, Int32 userID, Decimal wage, 
            String remark, String createBy, DateTime createDateTime)
        {
            this.pieceworkCompensationID = pieceworkCompensationID;
            this.pieceCountingTime = pieceCountingTime;
            this.userID = userID;
            this.wage = wage;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Username
        {
            get { return this.username; }
            set { this.username = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PieceworkCompensationID
        {
            get { return this.pieceworkCompensationID; }
            set { this.pieceworkCompensationID = value; }
        }

        /// <summary>
        /// 获取或设置计件日期
        /// </summary>
        public DateTime PieceCountingTime
        {
            get { return this.pieceCountingTime; }
            set { this.pieceCountingTime = value; }
        }

        /// <summary>
        /// 获取或设置用户ID
        /// </summary>
        public Int32 UserID
        {
            get { return this.userID; }
            set { this.userID = value; }
        }

        /// <summary>
        /// 获取或设置工资
        /// </summary>
        public Decimal Wage
        {
            get { return this.wage; }
            set { this.wage = value; }
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
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }
    }
}