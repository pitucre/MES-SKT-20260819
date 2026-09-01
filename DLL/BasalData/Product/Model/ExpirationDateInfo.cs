using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class ExpirationDateInfo
    {
        private Int32 expirationDateId;
        private String expirationDateName;
        private Int32 checkCount;
        private String remark;
        private String createBy;
        private DateTime createDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.ExpirationDateInfo 类的新实例。
        /// </summary>
        public ExpirationDateInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.ExpirationDateInfo 类的新实例。
        /// </summary>
        /// <param name="expirationDateId"></param>
        /// <param name="expirationDateName"></param>
        /// <param name="checkCount"></param>
        /// <param name="remark"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        public ExpirationDateInfo(Int32 expirationDateId, String expirationDateName, Int32 checkCount, String remark, 
            String createBy, DateTime createDateTime)
        {
            this.expirationDateId = expirationDateId;
            this.expirationDateName = expirationDateName;
            this.checkCount = checkCount;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ExpirationDateId
        {
            get { return this.expirationDateId; }
            set { this.expirationDateId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ExpirationDateName
        {
            get { return this.expirationDateName; }
            set { this.expirationDateName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 CheckCount
        {
            get { return this.checkCount; }
            set { this.checkCount = value; }
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

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}