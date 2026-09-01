using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class MaterialBucketInfo
    {
        public int BucketId { get; set; }

        /// <summary>
        /// 料桶编码
        /// </summary>
        public string MaterialBucketCode { get; set; }

        /// <summary>
        /// 关联产品字符串
        /// </summary>
        public string ItemAttr { get; set; }

        /// <summary>
        /// 获取或设置创建人。
        /// </summary>
        public string CreateBy{ get; set; }

        /// <summary>
        /// 获取或设置创建时间。
        /// </summary>
        public DateTime CreateDateTime{ get; set; }

        /// <summary>
        /// 获取或设置修改人。
        /// </summary>
        public String ModifyBy{ get; set; }

        /// <summary>
        /// 获取或设置修改时间。
        /// </summary>
        public DateTime ModifyDateTime{ get; set; }

        /// <summary>
        /// 获取或设置备注。
        /// </summary>
        public String Remark { get; set; }

    }


    public class MaterialBucketRelationItemInfo
    {
        public string ItemCode { get; set; }
        public string ItemName { get; set; }

        public int ItemId { get; set; }

        public int BucketId { get; set; }

        public string MaterialBucketCode { get; set; }
    }

}