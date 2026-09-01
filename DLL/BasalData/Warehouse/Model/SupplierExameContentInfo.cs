using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class SupplierExameContentInfo
    {
        public Int32 SupplierExameContentId { get; set; }
        public Int32 ParentId { get; set; }
        private String supplierExameName;
        public Int32 SupplierExameType { get; set; }
        public String SupplierExameCompute { get; set; }
        public String Creater { get; set; }
        public DateTime CreateTime { get; set; }
        public String Description { get; set; }
        public Boolean IsEnable { get; set; }
        public Boolean isParent { get; set; }
        public Int32 Sorting { get; set; }

        public string ParentName { get; set; }

        public string name { get { return supplierExameName; } }

        /// <summary>
        /// 获取或设置名
        /// </summary>
        public String SupplierExameName
        {
            get { return this.supplierExameName; }
            set { this.supplierExameName = value; }
        }

    }
}
