using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Supplier.Model
{
    /// <summary>
    /// 供应商和物料ID的关系
    /// </summary>
    [Serializable]
    public class SupplierItemsInfo
    {
        /// <summary>
        /// 供应商ItemId的关系
        /// </summary>
        private int supplierItemId;

        public int SupplierItemId
        {
            get { return supplierItemId; }
            set { supplierItemId = value; }
        }
        /// <summary>
        /// 供应商ID
        /// </summary>
        private int suplyId;

        public int SuplyId
        {
            get { return suplyId; }
            set { suplyId = value; }
        }
        /// <summary>
        /// ItemID
        /// </summary>
        private int itemId;

        public int ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }
        /// <summary>
        /// 修改时间
        /// </summary>
        private DateTime modifyDateTime;

        public DateTime ModifyDateTime
        {
            get { return modifyDateTime; }
            set { modifyDateTime = value; }
        }
        /// <summary>
        /// 修改人
        /// </summary>
        private string modifyBy;

        public string ModifyBy
        {
            get { return modifyBy; }
            set { modifyBy = value; }
        }
        /// <summary>
        /// 创建时间
        /// </summary>
        private DateTime createDateTime;

        public DateTime CreateDateTime
        {
            get { return createDateTime; }
            set { createDateTime = value; }
        }
        /// <summary>
        /// 创建人
        /// </summary>
        private string createBy;

        public string CreateBy
        {
            get { return createBy; }
            set { createBy = value; }
        }
        /// <summary>
        /// 备注
        /// </summary>
        private string remark;

        public string Remark
        {
            get { return remark; }
            set { remark = value; }
        }

        //以下是供应商下的物料(供右边查看)

        /// <summary>
        /// 物料编码
        /// </summary>
        private string itemCode;

        public string ItemCode
        {
            get { return itemCode; }
            set { itemCode = value; }
        }
        /// <summary>
        /// 物料名称
        /// </summary>
        private string itemName;

        public string ItemName
        {
            get { return itemName; }
            set { itemName = value; }
        }
    }
}
