using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class CustomerInfo
    {
        private Int32 customerID;
        private String customerName;
        private String address1;
        private String address2;
        private String city;
        private String stateProvince;
        private String country;
        private String postal;
        private String emailAddress;
        private String remark;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.CustomerInfo 类的新实例。
        /// </summary>
        public CustomerInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.CustomerInfo 类的新实例。
        /// </summary>
        /// <param name="customerID">客户ID</param>
        /// <param name="customerName">客户名称</param>
        /// <param name="address1">客户地址1</param>
        /// <param name="address2">客户地址2</param>
        /// <param name="city">所在城市</param>
        /// <param name="stateProvince">所在省或者州</param>
        /// <param name="country">国籍</param>
        /// <param name="postal">邮编</param>
        /// <param name="emailAddress">电子邮箱</param>
        /// <param name="remark">备注</param>
        /// <param name="modifyDateTime">最后一次修改时间</param>
        /// <param name="modifyBy">最后修改者</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        public CustomerInfo(Int32 customerID, String customerName, String address1, String address2, 
            String city, String stateProvince, String country, String postal, String emailAddress, 
            String remark, DateTime modifyDateTime, String modifyBy, DateTime createDateTime, String createBy)
        {
            this.customerID = customerID;
            this.customerName = customerName;
            this.address1 = address1;
            this.address2 = address2;
            this.city = city;
            this.stateProvince = stateProvince;
            this.country = country;
            this.postal = postal;
            this.emailAddress = emailAddress;
            this.remark = remark;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
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
        /// 获取或设置客户名称
        /// </summary>
        public String CustomerName
        {
            get { return this.customerName; }
            set { this.customerName = value; }
        }

        /// <summary>
        /// 获取或设置客户地址1
        /// </summary>
        public String Address1
        {
            get { return this.address1; }
            set { this.address1 = value; }
        }

        /// <summary>
        /// 获取或设置客户地址2
        /// </summary>
        public String Address2
        {
            get { return this.address2; }
            set { this.address2 = value; }
        }

        /// <summary>
        /// 获取或设置所在城市
        /// </summary>
        public String City
        {
            get { return this.city; }
            set { this.city = value; }
        }

        /// <summary>
        /// 获取或设置所在省或者州
        /// </summary>
        public String StateProvince
        {
            get { return this.stateProvince; }
            set { this.stateProvince = value; }
        }

        /// <summary>
        /// 获取或设置国籍
        /// </summary>
        public String Country
        {
            get { return this.country; }
            set { this.country = value; }
        }

        /// <summary>
        /// 获取或设置邮编
        /// </summary>
        public String Postal
        {
            get { return this.postal; }
            set { this.postal = value; }
        }

        /// <summary>
        /// 获取或设置电子邮箱
        /// </summary>
        public String EmailAddress
        {
            get { return this.emailAddress; }
            set { this.emailAddress = value; }
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
        /// 获取或设置最后一次修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置最后修改者
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置创建者
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }
    }
}