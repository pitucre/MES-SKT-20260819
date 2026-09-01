using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class ExpirationDateDtlInfo
    {
        private Int32 expirationDateDtlId;
        private Int32 pid;
        private Int32 number;
        private Int32 dayNumber;
        private String remark;
        private String createBy;
        private DateTime createDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.ExpirationDateDtlInfo 类的新实例。
        /// </summary>
        public ExpirationDateDtlInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.ExpirationDateDtlInfo 类的新实例。
        /// </summary>
        /// <param name="expirationDateDtlId"></param>
        /// <param name="pid"></param>
        /// <param name="number"></param>
        /// <param name="dayNumber"></param>
        /// <param name="remark"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        public ExpirationDateDtlInfo(Int32 expirationDateDtlId, Int32 pid, Int32 number, Int32 dayNumber, 
            String remark, String createBy, DateTime createDateTime)
        {
            this.expirationDateDtlId = expirationDateDtlId;
            this.pid = pid;
            this.number = number;
            this.dayNumber = dayNumber;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ExpirationDateDtlId
        {
            get { return this.expirationDateDtlId; }
            set { this.expirationDateDtlId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Pid
        {
            get { return this.pid; }
            set { this.pid = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Number
        {
            get { return this.number; }
            set { this.number = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 DayNumber
        {
            get { return this.dayNumber; }
            set { this.dayNumber = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
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
    }
}