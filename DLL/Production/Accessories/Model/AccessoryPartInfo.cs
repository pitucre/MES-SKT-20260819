using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Accessories.Model
{
    [Serializable]

    public class AccessoryPartInfo
    {
        private Int32 iD;
        private String itemName;
        private Int32 leedFree;
        private DateTime createDateTime;
        private Int32 createBy;
        private String userName;

        public String SupplierCode { get; set; }
        public Int32 SupplierId { get; set; }
        public String FactoryTime { get; set; }
        public String BatchNO { get; set; }
        public Decimal Weight { get; set; }
        public String Spec { get; set; }

        /// <summary>
        /// 初始化 SKT.MES.Model.PARTInfo 类的新实例。
        /// </summary>
        public AccessoryPartInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.PARTInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="itemName">物料</param>
        /// <param name="leedFree">保留字段</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>

        public AccessoryPartInfo(Int32 iD, String itemName, Int32 leedFree, DateTime createDateTime,
            Int32 createBy, String userName)
        {
            this.iD = iD;
            this.itemName = itemName;
            this.leedFree = leedFree;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.userName = userName;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置物料
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        /// <summary>
        /// 获取或设置保留字段
        /// </summary>
        public Int32 LeedFree
        {
            get { return this.leedFree; }
            set { this.leedFree = value; }
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
        public Int32 CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        public String UserName
        {
            get { return this.userName; }
            set { this.userName = value; }
        }

    }

}
